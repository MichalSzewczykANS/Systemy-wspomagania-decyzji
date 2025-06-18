import graphviz
from opyenxes.data_in.XUniversalParser import XUniversalParser
from collections import defaultdict
from functools import reduce

# Konfiguracja
LOG_FILE_PATH = 'repairexample.xes'
OUTPUT_HEURISTIC_BASE = 'heuristic_net'
ACTIVITY_FREQUENCY_THRESHOLD = 0
TRANSITION_FREQUENCY_THRESHOLD = 0

# Wczytywanie logu
try:
    with open(LOG_FILE_PATH) as log_file:
        log = XUniversalParser().parse(log_file)[0]
except FileNotFoundError:
    print(f"Błąd: Plik logu '{LOG_FILE_PATH}' nie został znaleziony.")
    exit()
except Exception as e:
    print(f"Błąd podczas parsowania pliku XES: {e}")
    exit()

print(f"Log '{LOG_FILE_PATH}' wczytany pomyślnie.")

# Parsowanie logu
workflow_log = []
for trace in log:
    workflow_trace = []
    for event in trace:
        try:
            attributes = event.get_attributes()
            if 'Activity' in attributes:
                event_name = attributes['Activity'].get_value()
                workflow_trace.append(event_name)
            elif 'concept:name' in attributes:
                event_name = attributes['concept:name'].get_value()
                workflow_trace.append(event_name)
        except Exception as e:
            print(f"Ostrzeżenie: Problem z odczytem atrybutu zdarzenia: {e}")
    if workflow_trace:
        workflow_log.append(workflow_trace)

if not workflow_log:
    print("Błąd: Nie udało się wyekstrahować żadnych śladów z logu.")
    exit()

print(f"Wyekstrahowano {len(workflow_log)} śladów.")

# Liczenie aktywności i przejść
activity_counter = defaultdict(int)
transition_counter = defaultdict(int)
direct_succession_rel = defaultdict(set)

for w_trace in workflow_log:
    for activity in w_trace:
        activity_counter[activity] += 1
    for i in range(len(w_trace) - 1):
        source, target = w_trace[i], w_trace[i+1]
        transition = (source, target)
        transition_counter[transition] += 1
        direct_succession_rel[source].add(target)

all_activities = set(activity_counter.keys())
if not all_activities:
    print("Błąd: Brak aktywności w logu.")
    exit()

print(f"Znaleziono {len(all_activities)} unikalnych aktywności.")

# Generowanie grafu heurystycznego
def generate_heuristic_graph(activity_counts, transition_counts, direct_succession, act_threshold, trans_threshold, filename_base):
    filtered_activities = {act for act, count in activity_counts.items() if count >= act_threshold}
    filtered_transitions = {trans: count for trans, count in transition_counts.items()
                            if count >= trans_threshold and
                            trans[0] in filtered_activities and
                            trans[1] in filtered_activities}

    G = graphviz.Digraph(comment='Heuristic Net')
    G.graph_attr['rankdir'] = 'LR'
    G.node_attr['shape'] = 'box'
    G.node_attr['style'] = 'rounded,filled'
    G.node_attr['fillcolor'] = '#FFFFCC'

    min_act_freq = min(activity_counts.values(), default=1)
    max_act_freq = max(activity_counts.values(), default=1)
    min_trans_freq = min(filtered_transitions.values(), default=1)
    max_trans_freq = max(filtered_transitions.values(), default=1)

    for activity in filtered_activities:
        count = activity_counts[activity]
        label = f"{activity}\n({count})"
        intensity = 99 - int((count - min_act_freq) / max(1, max_act_freq - min_act_freq) * 99)
        hex_intensity = hex(intensity)[2:].zfill(2)
        color = f"#FF9933{hex_intensity}"
        G.node(activity, label=label, fillcolor=color)

    for (source, target), count in filtered_transitions.items():
        width = 1 + ((count - min_trans_freq) / max(1, max_trans_freq - min_trans_freq)) * 5
        G.edge(source, target, label=str(count), penwidth=str(width))

    source_nodes = {src for src, _ in filtered_transitions}
    target_nodes = {tgt for _, tgt in filtered_transitions}
    start_activities = filtered_activities - target_nodes
    end_activities = filtered_activities - source_nodes

    if start_activities:
        G.node("start", shape="circle", label="", fillcolor="#90EE90", width="0.3", fixedsize="true")
        for activity in start_activities:
            G.edge("start", activity)

    if end_activities:
        G.node("end", shape="doublecircle", label="", fillcolor="#FFB6C1", width="0.3", fixedsize="true")
        for activity in end_activities:
            G.edge(activity, "end")

    try:
        output_gv = f"{filename_base}_filtered_act{act_threshold}_trans{trans_threshold}.gv"
        output_png = f"{filename_base}_filtered_act{act_threshold}_trans{trans_threshold}.png"
        G.render(output_gv, format='png', outfile=output_png, view=False)
        print(f"Wygenerowano graf: {output_png}")
        return G
    except Exception as e:
        print(f"Błąd podczas renderowania: {e}")
        return None

# Uruchomienie generowania grafu
print("\n--- Generowanie grafu heurystycznego ---")
heuristic_graph = generate_heuristic_graph(
    activity_counter,
    transition_counter,
    direct_succession_rel,
    ACTIVITY_FREQUENCY_THRESHOLD,
    TRANSITION_FREQUENCY_THRESHOLD,
    OUTPUT_HEURISTIC_BASE
)

print("\n--- Zakończono ---")
