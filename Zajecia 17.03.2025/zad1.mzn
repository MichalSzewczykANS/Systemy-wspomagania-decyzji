int: owoce_cena = 215;
int: frytki_cena = 275;
int: salatka_cena = 335;
int: skrzydelka_cena = 355;
int: paluszki_cena = 420;
int: zestaw_cena = 580;

var 0..10: owoce;
var 0..10: frytki;
var 0..10: salatka;
var 0..10: skrzydelka;
var 0..10: paluszki;
var 0..10: zestaw;

constraint
    owoce * owoce_cena +
    frytki * frytki_cena +
    salatka * salatka_cena +
    skrzydelka * skrzydelka_cena +
    paluszki * paluszki_cena +
    zestaw * zestaw_cena == 1505;

solve satisfy;

output [
  "Owoce: \(owoce)\n",
  "Frytki: \(frytki)\n",
  "Sałatka: \(salatka)\n",
  "Skrzydełka: \(skrzydelka)\n",
  "Paluszki: \(paluszki)\n",
  "Zestaw próbny: \(zestaw)\n"
];
