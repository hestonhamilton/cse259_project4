# I'm My Own Grandpa - Prolog Kinship Relations
CSE 259 - Logic in Computer Science  
Project 4 - Fall 2024

## Team Information

**Team Members:**
- Heston Hamilton
- Vaughn Hoffler

## Project Overview

This project implements a Prolog program modeled from the relationships described in the song "I'm My Own Grandpa" by Dwight Latham and Moe Jaffe. The program uses logical rules and facts to model kinship relations and prove that the narrator becomes his own grandfather through a series of marriages.

## Contribution Breakdown

- TODO

## Implementation Details

The program is implemented in GNU Prolog and consists of:

1. Base facts derived from the song lyrics
2. Kinship rules defining relationships such as:
   - Parent/child relations
   - Sibling relationships
   - Marriage/spouse relations
   - Extended family relations (grandparent, uncle, etc.)

## Running the Program

1. Ensure GNU Prolog is installed on your system
2. Load the program:
   ```prolog
   $ gprolog
   ?- [grandpa].
   ```
3. Run the main query:
   ```prolog
   ?- runIt.
   ```

## Testing

The program can be verified using the provided test case:

```prolog
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
```

