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
	not(film(T,_,lynch,policier,_),not(vedette(T,N,_))).

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
