# mastermind

## Description and How to Play

This project is a re-creation of the game Mastermind where one player creates a code and the other player tries to guess it. The code is a sequence of 4 numbers between 1 and 6. The code breaker enters their guess and the code maker gives feedback in the form of "solid pegs" and "empty pegs". A "solid peg" represents a number in the guess that is present in the code and in the correct position. An "empty peg" represents a number in the guess that is present in the code but not in the correct position. The solid pegs always take precedence. 

solid pegs: "●"<br/>
empty pegs: "○"<br/>
not in code: "-"

The player has the opportunity to be both the code maker or code breaker. The player plays against the computer.
The game ends when the code breaker correctly guesses the code or after 12 guesses. If the code breaker doesn't guess the correct code in 12 or less guesses, then the code maker is the winner.

The game is played in the command line. To play, run `ruby mastermind.rb`.

## Computer Algorithm For Guessing the Players Code
The algorithm is as follows: 
The computer starts with guessing 1111. Based on the number of pegs solid and empty, the computer generates a new guess. This new guess keeps the same number of ones as the feedback (number of pegs) and replaces the other ones with twos. For the next guess, if the feedback is greater than the previous number of pegs, the difference is the amount of twos that are kept. the rest of the twos are replaced with threes. The computer repeats this process until the feedback is equal to four. Then, the computer generates all the possible permutations of the guess that yields four total pegs and appends them to an array. The computer randomly guesses a permutation and if it is not the correct code, it deletes that permutation from the array of possible permutations. This process is repeated until four solid pegs or the maximum number of guesses is reached. This algorithm doesn't guarantee that the computer will guess the correct code each time.

Credit for this algorithm goes to: https://puzzling.stackexchange.com/questions/546/clever-ways-to-solve-mastermind

## What I Learned

The game is written in the Ruby programming language and is part of the Odin Project Curriculum.
I have demonstrated the following core programming skills:

* Object Oriented Programming (OOP) concepts such as classes, objects, and module mixins
* Knowledge of how to use methods to break up code into smaller, more manageable pieces
* Understanding of how to use loops and conditional statements to control the flow of a program
* Basic understanding of data types and how to work with them (e.g. strings, integers, arrays, etc.)
