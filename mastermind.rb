# Next step: make guess, update board

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
		#@player_name = get_player_name
		puts "Welcome to Mastermind: Console Edition!" #, #{@player_name}!"
		@code = create_code
		puts "The computer has chosen a 4-color code."
		puts "While debugging, here it is: #{@code}"

		until self.game_over?
			take_turn
		end

		if won_game?
			puts "Congratulations! You won the game."
		else
			puts "Sorry, you're all out of turns. Game over."
		end
	end

	# Checks to ensure all elements in the user's guess are valid peg options and the guess contains 4 pegs
	def valid_guess?(guess, peg_options)
		(guess - peg_options).empty? && guess.length == 4
	end

	def take_turn
		@turn += 1
		puts "Please make a guess, typing in 4 color characters. Remember, your options are: Red (R), Green (G), Blue (B), Magenta (M), Cyan (C), and Yellow (Y):"
		guess = gets.chomp.split("")
		valid = valid_guess?(guess, @peg_options)
		until valid
			puts "Please enter 4 valid color characters. Remember, your options are: Red (R), Green (G), Blue (B), Magenta (M), Cyan (C), and Yellow (Y):"
			guess = gets.chomp.split("")
			valid = valid_guess?(guess, @peg_options)
		end

		# Test against and update board
		@board.make_guess(@turn, guess, @code)
		puts "Your guess has been added to the board. Here's what the computer provided you as feedback:"
		@board.display_board
	end

	def get_player_name
		print "Please enter your name: "
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

	# The game is over if EITHER the player has made 12 unsuccessful guesses OR the player has guessed the code
	def game_over?
		(@board.guesses.key?(12) || @board.guesses.value?(@code)) ? true : false
	end

	def won_game?
		@board.guesses.value?(@code) ? true : false
	end
end



class Board
	attr_accessor :guesses

	def initialize
		@guesses = {}
		@feedbacks = {}
	end

	def display_board
		# Update to include feedback on the right hand side
		color_mapping = {'R' => :red , 'G' => :green, 'B' => :blue, 'M' => :magenta, 'C' => :cyan, 'Y' => :light_yellow, 'W' => :white, 'K' => :light_black, '-' => :yellow}

		puts "+====++====+".colorize(:yellow)
		12.times do |num|
			if @guesses.key?(num+1)
				print "+".colorize(:yellow)
				@guesses[num+1].each do |peg|
					print peg.colorize(color_mapping[peg])
				end
				print "++".colorize(:yellow)
				@feedbacks[num+1].each do |feedback_peg|
					print feedback_peg.colorize(color_mapping[feedback_peg])
				end
				print "+".colorize(:yellow)
			else
				print "+----++----+".colorize(:yellow)
			end
			print "\n"
		end
		puts "+====++====+".colorize(:yellow)
	end

	def make_guess(turn, guess, code)
		@guesses[turn] = guess

		# Feedback logic
		unsorted_feedbacks = []

		# Feedback logic - here comes the fun part!!!
		guess.each do |peg|
			if code.include? peg
				if guess.index(peg) == code.index(peg)
					unsorted_feedbacks.push('K')
				else
					unsorted_feedbacks.push('W')
				end
			else
				unsorted_feedbacks.push('-')
			end
		end

		sorted_feedback = unsorted_feedbacks.sort {|a,b| b <=> a}
		@feedbacks[turn] = sorted_feedback
	end
end


game = Game.new