film(invictus,2009,eastwood,biographie,134).
film(gran_torino,2008,eastwood,drame,116).
film(interstellar,2015,nolan,science_fiction,169).
film(will_hunting,1997,van_sant,drame,121).
film(l_inspecteur_harry,1972,siegel,policier,102).
film(blue_velvet,1986,lynch,policier,120).
film(twin_peaks_fire_walk_with_me,1992,lynch,policier,135).
film(dune,1984,science_fiction,130).

acteur(eastwood,clint,1930,m,75).
acteur(damon,matt,1970,m,65).
acteur(freeman,morgan,1937,m,91).
acteur(hooper,dennis,1936,m,151).
acteur(mac_lachlan,kyle,1959,m,37).
acteur(rossellini,isabella,1952,f,45).

vedette(invictus,freeman,mandela).
vedette(invictus,damon,piennar).
vedette(gran_torino,eastwood,kowalski).
vedette(interstellar,damon,dr_mann).
vedette(l_inspecteur_harry,eastwood,harry).
vedette(will_hunting,damon,hunting).
vedette(dune,mac_lachlan,atreides).
vedette(blue_velvet,mac_lachlan,beaumont).
vedette(blue_velvet,rossellini,vallens).
vedette(blue_velvet,hooper,booth).
vedette(twin_peaks_fire_walk_with_me,mac_lachlan,cooper).
% Q1.1

real_acteur(N,P,T) :-
	film(T,_,N,_,_),
	acteur(N,P,_),
	vedette(T,N,_).

% Q1.2
trois_vedettes(T,A) :-
	film(T,A,_,_,_),
	vedette(T,N1,_),
	vedette(T,N2,_),
	vedette(T,N3,_),
	N1 \== N2,
	N2 \== N3,
	N1 \== N3.

% Q1.3
pas_eastwoord(T) :-
	film(T,_,N,_,_),
	N \== eastwood,
	not(vedette(T,eastwood,_)).

% Q1.4
tous_policiers_lynch(N,P) :-
	acteur(N,P,_,m,_),
	not((film(T,_,lynch,policier,_),not(vedette(T,N,_)))).

% Eclipse prolog est un peu bê-bête, donc : 
tous_policiers_lynch2(N,P) :-
	acteur(N,P,_,m,_),
	not(sub(N)).

sub(N) :-
	film(T,_,lynch,policier,_),
	not(vedette(T,N,_)).

% Q1.5
genre_stable(N) :-
	film(_,_,N,G,_),
	not((film(_,_,N,G2,_),
		G2 \== G)).

% Q2.1
search(_,[]).
search(X,[Y|L]) :-
	X \== Y,
	search(X,L).
pas_de_double([]).
pas_de_double([X|L]) :-
	search(X,L),
	pas_de_double(L).

% Q2.2
toutes_lignes_ok([]).
toutes_lignes_ok([X|L]) :-
	pas_de_double(X),
	toutes_lignes_ok(L).

% Q2.3
construire([],[]).
construire([[X|_]|L],[X|Lres]) :-
	construire(L,Lres).

% Q2.4
verif_premiere_col(L) :-
	construire(L,Col),
	pas_de_double(Col).

% Q2.5
oter_premiere_col([],[]).
oter_premiere_col([[_|L1]|L2],[L1|LRes]) :-
	oter_premiere_col(L2,LRes).

% Q2.6
une_seule_col([]).
une_seule_col([[_]|L]) :-
	une_seule_col(L).

% Q2.7
toutes_colones_ok(L) :-
	une_seule_col(L),
	verif_premiere_col(L).
toutes_colones_ok(L) :-
	verif_premiere_col(L),
	oter_premiere_col(L,L2),
	toutes_colones_ok(L2).

% Q2.8
grille_magique(L) :-
	toutes_colones_ok(L),
	toutes_lignes_ok(L).
