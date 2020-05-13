import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../quiz.dart';

class Data {
  Map<String, String> app_strings = {
    'app_name': 'Liceu cu Brio',
    'insta_label': 'Have a question? \nDM us on Instagram',
    'instagram_username': 'bac_cu_brio',
  };
  Map<String, dynamic> course1 = {
    'name': 'Romana - Real',
    'id': 1,
    'lesson1': 'C1 Lesson 1',
    'lesson1_time': '10min',
    'lesson1_icon': Icons.library_books,
    'lesson2': 'Make sure that the parent widget limits your',
    'lesson2_time': '4min',
    'lesson2_icon': Icons.library_books,
    'lesson3': 'C1 Lesson 3',
    'lesson3_time': '11min',
    'lesson3_icon': Icons.library_books,
    'lesson4': 'C1 Lesson 4',
    'lesson4_time': '4min',
    'lesson4_icon': Icons.lightbulb_outline,
  };
  Map<String, dynamic> course2 = {
    'name': 'Romana - Uman',
    'id': 2,
    'lesson1': 'C2 Lesson 1',
    'lesson1_time': '10min',
    'lesson1_icon': Icons.library_books,
    'lesson2': 'Make sure that the parent widget limits your',
    'lesson2_time': '4min',
    'lesson2_icon': Icons.library_books,
    'lesson3': 'C2 Lesson 3',
    'lesson3_time': '11min',
    'lesson3_icon': Icons.library_books,
    'lesson4': 'C2 Lesson 4',
    'lesson4_time': '4min',
    'lesson4_icon': Icons.lightbulb_outline,
  };

  // Course 1 (ONE) Lessons

  // testing
  // end testing
  Map<String, dynamic> c1_lessons = {
    'l1_title': 'Alexandru Lăpuşneanul',
    'l1_p1':
        'Scriitor pașoptist, Costache Negruzzi, este ctitorul nuvelei istorice românești. Nuvela romantică “Alexandru Lăpușneanul“ apare în primul număr al “Daciei Literare“ şi aduce în prim-plan un personaj istoric surprins în a doua sa domnie.',
    'l1_p2':
        'Acţiunea se concentrează în jurul personajului principal, iar conflictele în centrul cărora se află protagonistul sunt puternice. Nuvela aparține prozei romantice prin abordarea temei istoriei. Structura este clasică: patru capitole echilibrate cu un motto care sintetizează acțiunea. '
            'În centrul fiecărui capitol se află Alexandru Lăpușneanul, aflat în conflict cu celelalte personaje.',
    'l1_p3':
        'Fixează locul şi timpul: Moldavia, a doua domnie a lui Alexandru Lăpuşneanul. Aduce în prim-plan conflictul exterior al nuvelei: dintre Lăpuşneanul şi boierii care doresc să-l alunge. Dintre boieri se distinge Moțoc, care îi comunică domnitorului că norodul nu-l “vre“ şi “nu-l iubește“;'
            'Prin replica domnitorului: “Dacă voi nu mă vreți, eu vă vreu“, este configurată psihologia acestuia: domn autoritar, care îşi impune cu orice preț voința şi care are un statut mesianic.',
    'l1_p4':
        'Conflictul dintre ei pornește de la cuvintele soției unui boier ucis, motto-ul capitolului: “Ai să dai samă, Doamnă“, o determină pe domniță să îl roage pe Lăpuşneanul să înceteze cu răzbunarea împotriva boierilor.'
            'Antiteză romantică: Ruxanda → angelicul, iar Lăpuşneanul → demonicul. Caracterizarea domniței Ruxanda se realizează în manieră directă: portretul fizic şi moral este realizat de narator printr-o pauză descriptivă: “frumoasă“, “tristă şi tânjitoare“, şi indirectă: prin retrospectivă în trecutul domniței sunt înfățișate calitățile sufletești ale acesteia: “blândețe“ şi “bunătate“.',
    'l1_p5': 'Scena din biserică cuprinde trei atitudini ce îl vor caracteriza indirect şi vor evidenția monstruozitatea morală a personajului: îmbracă toată pompa domnească deşi știe că se află înaintea unei vărsări de sânge, nu poartă armă, în discursul său în faţa boierilor se preface umil, îşi cere iertare, promite că nu va mai ucide, citând din cele zece porunci. Nu doar arta disimulării, ci şi cinismul şi cruzimea sunt evidențiate.'
        'Punctul culminant (ospățul) debutează cu un pasaj descriptiv care surprinde ceremonia mesei domnești, urmează o descriere narativizată a măcelului. Ultimul aspect al scenei este realizat prin procedeul privitorului din tablou: priveliștea măcelului şi dialogul cu un Moțoc lingușitor → izvor de inspirație: Grigore Ureche.'
        'Apariția primului personaj colectiv: masele, care reacționează la un impuls, revoltându-se. Sacrificarea lui Moțoc încheie seria omorurilor. Leacul de frică promis Ruxandei este piramida cu capetele boierilor, scena ce l-a determinat pe criticul George Călinescu să îl numească pe domnitor “monstru moral“.',
    'l1_p6':
        'Urmează un pasaj narativ, în care sunt redate întâmplările din cei patru ani: Lăpuşneanul nu mai omora boieri, dar îi schingiuia pentru a-şi satisface dorința de cruzime. Personajul se îmbolnăvește, se pocăiește şi se călugărește. Domnul se însănătoșește şi amenință cu moartea Ruxandei şi a fiilor săi: “de mă voi scula, pre mulți am să proptesc şi eu“. În dialogul dintre Ruxanda, Mitropolit, Spancioc şi Stroici se hotărăște uciderea (otrăvirea) domnitorului. Procedeul privitorului din tablou la scena morții domnului: “învață a muri, tu care știai numai a omorî“. Naratorul nu se păstrează impersonal: “sfârșitul lui Lăpuşneanul, care a lăsat o pată de sânge în istorie“.',
    'l1_p7':
        'Alexandru Lăpuşneanul este un personaj romantic şi prin urmare excepțional datorită cruzimii sale exagerate, acțiunilor sale spectaculoase, replicilor sale.'
            'Nuvela istorică “Alexandru Lăpuşneanul“ de Costache Negruzzi se remarcă prin obiectivitate şi ilustrează programul romantismului pașoptist. George Călinescu aprecia că nu poate exista “o mai perfectă sinteză de observație psihologică acută, de atitudini romantice şi intuiție realistă“.',
    'l1_p8': 'Course 1 Lesson 1 part 8',
    'l1_p9': 'Course 1 Lesson 1 part 9',
    'l1_p10': 'Course 1 Lesson 1 part 10',
    'l1_p11': 'Course 1 Lesson 1 part 11',
    'l1_p12': 'Course 1 Lesson 1 part 12',
    'l1_p13': 'Course 1 Lesson 1 part 13',
    'l1_img13': 'assets/course1/lesson1-2.jpg',
    'l1_p14': 'Course 1 Lesson 1 part 14',
    // LESSON 2
    'l2_title': 'Lesson 2 title',
    'l2_p1': 'Course 1 Lesson 2 part 1',
    'l2_p2': 'Course 1 Lesson 2 part 2',
    'l2_p3': 'Course 1 Lesson 2 part 3',
    'l2_img3': 'assets/course1/lesson1-3.jpg',
    'l2_p4': 'Course 1 Lesson 2 part 4',
    'l2_p5': 'Course 1 Lesson 2 part 5',
//    'l2_p6': 'Course 1 Lesson 2 part 6',
//    'l2_p7': 'Course 1 Lesson 2 part 7',
//    'l2_p8': 'Course 1 Lesson 2 part 8',
//    'l2_p9': 'Course 1 Lesson 2 part 9',
//    'l2_p10': 'Course 1 Lesson 2 part 10',
    // LESSON 3
    'l3_title': 'Lesson 3 title',
    'l3_p1': 'Course 1 Lesson 3 part 1',
    'l3_p2': 'Course 1 Lesson 3 part 2',
    'l3_p3': 'Course 1 Lesson 3 part 3',
    'l3_p4': 'Course 1 Lesson 3 part 4',
    'l3_p5': 'Course 1 Lesson 3 part 5',
    'l3_p6': 'Course 1 Lesson 3 part 6',
    'l3_p7': 'Course 1 Lesson 3 part 7',
    'l4_title': 'Lesson 4 title',
    'l4_p1': 'Course 1 Lesson 4 part 1',
    'l4_p2': 'Course 1 Lesson 4 part 2',
  };
  // course 2 lesson
  Map<String, dynamic> c2_lessons = {
    'l1_title': 'Lesson 1 title',
    'l1_p1': 'Course 2 Lesson 1 part 1',
    'l1_p2': 'Course 2 Lesson 1 part 2',
    'l1_p3': 'Course 2 Lesson 1 part 3',
    'l1_p4': 'Course 2 Lesson 1 part 4',
    'l1_p5': 'Course 2 Lesson 1 part 5',
    'l1_p6': 'Course 2 Lesson 1 part 6',
    'l1_p7': 'Course 2 Lesson 1 part 7',
    'l1_p8': 'Course 2 Lesson 1 part 8',
    // LESSON 2
    'l2_title': 'Lesson 2 title',
    'l2_p1': 'Course 2 Lesson 2 part 1',
    'l2_p2': 'Course 2 Lesson 2 part 2',
    'l2_p3': 'Course 2 Lesson 2 part 3',
    'l2_p4': 'Course 2 Lesson 2 part 4',
    'l2_p5': 'Course 2 Lesson 2 part 5',
    'l2_p6': 'Course 2 Lesson 2 part 6',
    // LESSON 3
    'l3_title': 'Lesson 3 title',
    'l3_p1': 'Course 2 Lesson 3 part 1',
    'l3_p2': 'Course 2 Lesson 3 part 2',
    'l3_p3': 'Course 2 Lesson 3 part 3',
    // LESSON 4
    'l4_title': 'Lesson 4 title',
    'l4_p1': 'Course 2 Lesson 4 part 1',
  };

  Map<String, String> help_page = {
    'title': 'Help Page',
    'instagram_username': 'bac_cu_brio',
    'insta_label': 'Have a question? \nDM us on Instagram',
    'p1':
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque ',
    'p2': 'This is dummy text for part 2',
    'p3': 'This is dummy text for part 3',
    'p4': 'This is dummy text for part 4',
    'p5': 'This is dummy text for part 5',
  };

  String premiumToggleText = """
■  în fiecare an alcătuim statistici în legătură cu ce poate pica la bac.
■  nu recomandăm să te bazezi exclusiv pe aceste statistici și să înveți doar opera pe care o desemnăm noi ca fiind cea mai probabilă! Însă mulți elevi au recunoscut că aceste statistici i-au ajutat să își scruteaze semnificativ listă de opere 'de învățat' eliminând anumite opere.
■  acest feature se bucură de un deosebit succes datorită preciziei foarte bune și numărul mare de elevi surprinși într-un mod plăcut de acuratețea acestora.
■  începând cu anul școlar 2020, aceste statistici se vor updata constant (în mod special pe măsură ce se apropie dată bacalaureatului) fără nevoia de update al aplicației.
■  începând cu anul școlar 2019-2020, elevii care vor cumpăra această facilitate pot beneficia de informații via push-notifications în dimineața examenului.
■  dacă achiziționezi acest upgrade, nu uita să permiți aplicației să trimită notificări! În eventualitatea în care ceva deosebit se schimbă în dimineața examenului, poți fi notificat prin chiar și cu 30 de minute înainte de intrarea în săli!
■  “Cum funcționează? Plătesc și apoi?”
Întrebarea care ne-a umplut DM-urile din Instagram are un răspuns simplu. După ce plătești prin AppStore (Vezi butonul de mai jos), vei avea instant acces la statisticile oferite de noi. Vei vedea sub secțiunea "Rezultate anii trecuți" o listă cu absolut toate operele (indiferent de modul de formulare a cerinței de la Bac) și șansele acestora să se regăsească în foaia ta de examen! Din start vei putea elimina majoritatea operelor, rămânând să te concentrezi doar pe câteva! Pe măsură ce se apropie bacalaureatul, numărul acestora se va scurta și el.
■ “ Cum pot știi dacă e sigur?”
Aceasta este cea de-a doua întrebare care ne-a umplut DM-urile din Instagrăm. Aici nu vom răspunde dar vom include un citat.

“Cred că unul din cele mai mari riscuri în viață este să nu ai niciodată curajul să riști.“
          - Oprah Winfrey
                """;
  String test = 'sss';
}
