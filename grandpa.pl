% grandpa.pl - Implementation of "I'm My Own Grandpa" relationships
% CSE 259 - Logic in Computer Science - Project 4
% Fall 2024
% Team Members:
%  - Heston Hamilton
%  - Vaughn Hoffler

% =============================================================================
% FACTS
% =============================================================================
% Facts should be minimized and represent only the essential relationships
% from the song that cannot be derived from rules.
% Examples:
% - Initial marriage of narrator to widow
% - Marriage of father to widow's daughter
% - Birth of the baby
% - Birth of widow's daughter's son
% =============================================================================
% Spousal relationships
married(i, widow).       % Narrator and Widow are married
married(dad, redhair).   % Dad and Redhair are married

% Gender information
female(widow).
female(redhair).
male(i).
male(dad).
male(onrun).
male(baby).

% Parent-child relationships
child(redhair, widow).   % Redhair is Widow's daughter
child(i, dad).           % Narrator is Dad's son
child(onrun, dad).       % Onrun is Dad's son
child(onrun, redhair).   % Onrun is Redhair's son
child(baby, i).          % Baby is Narrator's son
child(baby, widow).      % Baby is Widow's son

% =============================================================================
% BASE RELATIONSHIP RULES
% =============================================================================
% Basic family relationships that other rules will build upon

spouse(X, Y) :- married(X, Y).
spouse(X, Y) :- married(Y, X).

% - Parent relationships
parent(X, Y) :- child(Y, X).
parent(X, Y) :- related_via_spouse(X, Z), child(Y, Z).
parent(X, Y) :- related_via_spouse(Y, Z), child(Z, X).
father(X, Y) :- parent(X, Y), male(X).
mother(X, Y) :- parent(X, Y), female(X).

% - Child relationships
offspring(X, Y) :- parent(Y, X).
son(X, Y) :- offspring(X, Y), male(X).
daughter(X, Y) :- offspring(X, Y), female(X).

% - Sibling relationships
sibling(X, Y) :- parent(P, X), parent(P, Y).
brother(X, Y) :- sibling(X, Y), male(X).
sister(X, Y) :- sibling(X, Y), female(X).

% =============================================================================
% EXTENDED FAMILY RULES
% =============================================================================
% Complex relationships derived from base relationships

% - grandparent relationships
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).
grandfather(X, Y) :- grandparent(X, Y), male(X).
grandmother(X, Y) :- grandparent(X, Y), female(X).

% - grandchild relationships
grandchild(X, Y) :- grandparent(Y, X).

% - uncle/aunt relationships
uncle(X, Y) :- parent(Z, Y), sibling(X, Z), male(X).
aunt(X, Y) :- parent(Z, Y), sibling(X, Z), female(X).

% - in-law relationships
parent_in_law(X, Y) :- related_via_spouse(X, Z), parent(Z, Y).
child_in_law(X, Y) :- related_via_spouse(Y, Z), child(Z, X).
child_in_law(X, Y) :- offspring(Z, Y), related_via_spouse(X, Z).
sibling_in_law(X, Y) :- related_via_spouse(X, Z), sibling(Z, Y).
son_in_law(X, Y) :- child_in_law(X, Y), male(X).

% - step-relationships
step_parent(X, Y) :- related_via_spouse(X, Z), parent(Z, Y), \+ parent(X, Y).
step_child(X, Y) :- related_via_spouse(Y, Z), child(X, Z), \+ child(X, Y).
step_sibling(X, Y) :- parent(Z, X), step_parent(Z, Y).

% =============================================================================
% QUERIES
% =============================================================================
% Main query to verify all relationships from the song

runIt :-
    daughter(redhair,i),
    mother(redhair,i),
    son_in_law(dad,i),
    brother(baby, dad),
    uncle(baby,i),
    brother(baby,redhair),
    grandchild(onrun,i),
    mother(widow,redhair),
    grandmother(widow,i),
    grandchild(i,widow),
    grandfather(i,i).
