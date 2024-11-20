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
spouse(i, widow).       % Narrator and Widow are married
spouse(dad, redhair).   % Dad and Redhair are married

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



% =============================================================================
% BASE RELATIONSHIP RULES
% =============================================================================
% Basic family relationships that other rules will build upon
% - spouse relationship (symmetric)
% - parent/child relationships
% - sibling relationships
% Rule use should be maximized



% =============================================================================
% EXTENDED FAMILY RULES
% =============================================================================
% Complex relationships derived from base relationships
% - grandparent relationships
% - uncle/aunt relationships
% - in-law relationships
% - step-relationships
% Rule use should be maximized



% =============================================================================
% QUERIES
% =============================================================================
% Main query to verify all relationships from the song
% Additional queries to test individual relationships?



