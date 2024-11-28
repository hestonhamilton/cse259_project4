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
spouse(i, widow).             % Narrator and Widow are married
spouse(dad, redhair).         % Dad and Redhair are married

% Gender information
female(widow).
female(redhair).
male(i).
male(dad).
male(onrun).
male(baby).

% Parent-child relationships
biological(redhair, widow).   % The widow had a grown-up daughter
biological(i, dad).           % The narrator's father
biological(baby, i).          % Narrator's son
biological(onrun, redhair).   % The son of Redhair

% =============================================================================
% BASE RELATIONSHIP RULES
% =============================================================================
% Basic family relationships that other rules will build upon

% Spouse relationship (symmetric)
related_via_spouse(X, Y) :- spouse(X, Y).
related_via_spouse(X, Y) :- spouse(Y, X).

% Parent relationships
parent(X, Y) :- biological(Y, X).                                   % Direct parent
parent(X, Y) :- biological(Z, X), related_via_spouse(Y, Z).         % Parent through marriage
parent(X, Y) :- related_via_spouse(X, P), parent(P, Y).             % Parent through spousal link

% Specific parent relationships
father(X, Y) :- parent(X, Y), male(X).
mother(X, Y) :- parent(X, Y), female(X).

% Child relationships
child(X, Y) :- parent(Y, X).

% Specific child relationships
son(X, Y) :- child(X, Y), male(X).
daughter(X, Y) :- child(X, Y), female(X).

% Sibling relationships
sibling(X, Y) :- parent(P, X), parent(P, Y), X \= Y.                % X and Y share at least one parent

% Specific sibling relationships
brother(X, Y) :- sibling(X, Y), male(X).
sister(X, Y) :- sibling(X, Y), female(X).

% =============================================================================
% EXTENDED FAMILY RULES
% =============================================================================
% Complex relationships derived from base relationships

% Grandparent relationships
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).
grandfather(X, Y) :- grandparent(X, Y), male(X).
grandmother(X, Y) :- grandparent(X, Y), female(X).

% Grandchild relationships
grandchild(X, Y) :- grandparent(Y, X).
grandchild(X, Y) :- related_via_spouse(Y, Z), grandparent(Z, X).

% Uncle relationship
uncle(X, Y) :- parent(Z, Y), sibling(X, Z), male(X).

% In-law relationships
son_in_law(X, Y) :- 
    male(X),                                    % X is male
    spouse(X, Z),                               % X is married to Z
    child(Z, Y).                                % Z is a child of Y

% =============================================================================
% QUERIES
% =============================================================================
% Main query to verify all relationships from the song

runIt :-
    write('Is redhair the daughter of i? '),
    (daughter(redhair, i) -> write('true') ; write('false')), nl,

    write('Is redhair the mother of i? '),
    (mother(redhair, i) -> write('true') ; write('false')), nl,

    write('Is dad the son-in-law of i? '),
    (son_in_law(dad, i) -> write('true') ; write('false')), nl,

    write('Is baby the brother of dad? '),
    (brother(baby, dad) -> write('true') ; write('false')), nl,

    write('Is baby the uncle of i? '),
    (uncle(baby, i) -> write('true') ; write('false')), nl,

    write('Is baby the brother of redhair? '),
    (brother(baby, redhair) -> write('true') ; write('false')), nl,

    write('Is onrun the grandchild of i? '),
    (grandchild(onrun, i) -> write('true') ; write('false')), nl,

    write('Is widow the mother of redhair? '),
    (mother(widow, redhair) -> write('true') ; write('false')), nl,

    write('Is widow the grandmother of i? '),
    (grandmother(widow, i) -> write('true') ; write('false')), nl,

    write('Is i the grandchild of widow? '),
    (grandchild(i, widow) -> write('true') ; write('false')), nl,

    write('Is i the grandfather of i? '),
    (grandfather(i, i) -> write('true') ; write('false')), nl.

