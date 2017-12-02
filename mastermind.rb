# Next step: game's next methods

#= Mastermind

require "colorize"

class Game
	def initialize
		# Create a new board and set @turn to nothing, then run game
		@board = Board.new
		@turn = 0
		@peg_options = %w(R G B M C Y)
		run_game
	end

	# run_game method increments turns and runs a turn until the game is over
	def run_game
		# Startup
		@turn += 1
		@player_name = get_player_name
		puts "Welcome to Mastermind: Console Edition, #{@player_name}!"
		@code = create_code
		puts "The computer has chosen a 4-color code. Please make your first guess, typing in 4 color characters. Remember, your options are: Red (R), Green (G), Blue (B), Magenta (M), Cyan (C), and Yellow (Y):"

		# Start with a single turn
		guess = gets.chomp.split("")
		valid = valid_guess?(guess, @peg_options)
		until valid
			puts "Please enter 4 valid color characters. Remember, your options are: Red (R), Green (G), Blue (B), Magenta (M), Cyan (C), and Yellow (Y):"
			guess = gets.chomp.split("")
			valid = valid_guess?(guess, @peg_options)
		end
	end

	# Checks to ensure all elements in the user's guess are valid peg options and the guess contains 4 pegs
	def valid_guess?(guess, peg_options)
		(guess - peg_options).empty? && guess.length == 4
	end

	def take_turn
	end

	def get_player_name
		print "Please enter your name:"
		gets.chomp
	end

	def create_code
		code = []
		options = %w(R G B M C Y)
		4.times do |num| 
			code.push(options.sample)
		end
		code
	end

	def game_over?
	end
end

class Board
	def initialize
		@guesses = {}
		@feedbacks = {}
	end

	def display_board
		puts "+====+".colorize(:yellow)
		12.times do |num|
			if @guesses.key?(num+1)
				print "+".colorize(:yellow)
				@guesses[num+1].each do |peg|
					print peg.colorize(:yellow)
				end
				print "+".colorize(:yellow)
			else
				print "+----+".colorize(:yellow)
			end
			print "\n"
		end
		puts "+====+".colorize(:yellow)
	end

	def make_guess(guess)
	end

	def update_board(guess)
	end
end

class Peg
	@@guess_pegs = %w(R, G, B, M, C, Y) # Red Green Blue Magenta Cyan Yellow

	def initialize(color)
		@color = color
	end

end

game = Game.new