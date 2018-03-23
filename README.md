# NCAA

Author: Daniel V. Olson

Calculate the probabilities of a bracket winning its pool starting at the Sweet 16. 

Input: 
  - Bracket names
  - Scores at the beginning of Sweet 16
  - Predictions for each bracket
      - 1: Win Sweet 16
      - 2: Win Elite 8
      - 3: Win Final 4
      - 4: Win Championship
      
Output: Table of predictions

Notes: 
  - Assumes all outcomes are equally likely
  - Exhaustive search compares every possible outcome to bracket's prediction
  - Tie for first count as win
  
