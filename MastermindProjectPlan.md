# Mastermind Project Plan

## Game Rules

- Game board
   * 12 rows, each of which has 4 holes next to them

- Pegs
   * One set of pegs a codebreaker can choose as their guesses. These have six colors.
   * One set of pegs the codemaker can use to indicate the success of the codebreaker's turn. These have two colors.

- Initiating the game
   * The codemaker chooses a pattern of four code pegs. Duplication is allowed.

- Turns
   * For 12 turns, the codebreaker tries to guess the pattern (order AND color)
   * A guess is made by placing colored pegs on the four slots of the board
   * Once placed, feedback is provided by placing signaling pegs to indicate how close the guess was

- Edge case turn logic
   * If a guess contains duplicate colors, only one signal peg is produced

## Setup

- Game class
   * Initialize game 
   * Ask for player name 
   * Randomly create the code and store it 
   * Take turn method
   * Run game: Keep running turns until game is over or player guesses correctly
   * Game over method to check if game is over based on board
   * Terminate or ask to play again

- Board class
   * Initializes an empty board 
   * Stores guesses as a hash? {turn => guess_array} 
   * Stores feedback as a hash? {turn => feedback_array} 
   * Updates guesses on a turn and returns feedback
   * Display method to show current board. 
   		If that turn exists, show the guesses
   		Otherwise show ----
   * Update method to update the board with a guess

- Peg class
   * Can create instances of pegs to display on the console
   * Produces colorized output to display pegs (6 colors for guesses, 2 for signals)
   * Should override puts/print classes to display colorized output?

## Cleanup

- Remove cached files from before .gitignore

## Implementation Rules

Build the game assuming the computer randomly selects the secret colors and the human player must guess them. 

## Feedback Logic

- Assuming you have variables turn, guess, and code
   * Turn = integer indicating the turn number. Serves as key to the board class variable hashes of guesses and feedbacks.
   * Guess = a four-character array with the player's guesses within
   * Code = a four-character array with the computer's code

- For each guess, check to see if that guess is 1) in the code at all (right color) and if so 2) in the right position (right place)
	* If in code but not right place: W
	* If in code and in right place: K
	* If neither: -

- Add all feedbacks and then sort the array so there is no indication of position given (maybe factor this out)



# Refactor

## Human Player Chooses

- Now refactor your code to allow the human player to choose whether she wants to be the creator of the secret code or the guesser.

- Build it out so that the computer will guess if you decide to choose your own secret colors. Start by having the computer guess randomly (but keeping the ones that match exactly).

- Next, add a little bit more intelligence to the computer player so that, if the computer has guessed the right color but the wrong position, its next guess will need to include that color somewhere. Feel free to make the AI even smarter.


## Steps

- 