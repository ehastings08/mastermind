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
		puts "Welcome to Mastermind: Console Edition!"

		# Select player or computer
		@choice = choose_codemaker

		if @choice == 'codemaker'
			@code = record_player_code
			puts "Thanks! Your code has been stored."
			until self.game_over?
				computer_take_turn
			end
		else 
			@code = create_code
			puts "The computer has chosen a 4-color code."
			puts "While debugging, here is the code: #{@code}"
			until self.game_over?
				player_take_turn
			end
		end

		if won_game?
			puts "Congratulations! You won the game."
		else
			puts "Sorry, all out of turns. Game over."
		end
	end

	def choose_codemaker
		puts "Please choose to be codemaker or codebreaker. The codemaker selects a secret code and gives feedback on the codebreaker's guesses. The codebreaker makes guesses to try and identify the codemaker's secret code."
		puts "Enter our choice as 'codemaker' or 'codebreaker'."
		choice = gets.chomp
	end

	# Checks to ensure person has entered a valid choice for codemaker/breaker
	def valid_role?(choice)
		choice == "codemaker" || choice == "codebreaker" ? true : false
	end

	# Checks to ensure all elements in the user's guess are valid peg options and the guess contains 4 pegs
	def valid_code?(code, peg_options)
		(code - peg_options).empty? && code.length == 4
	end

	def validate_input_loop
		input = gets.chomp.split("")
		valid = valid_code?(input, @peg_options)
		until valid
			puts "Please enter 4 valid color characters. Remember, your options are: Red (R), Green (G), Blue (B), Magenta (M), Cyan (C), and Yellow (Y): "
			input = gets.chomp.split("")
			valid = valid_code?(input, @peg_options)
		end
		code
	end

	# Allows player to record their secret code
	def record_player_code
		# Refactor validation to make this + take_turn method DRY
		puts "Please enter the secret code you have chosen, typing in 4 color characters. Remember, your options are: Red (R), Green (G), Blue (B), Magenta (M), Cyan (C), and Yellow (Y): "
		code = validate_input_loop
	end

	def player_take_turn
		@turn += 1
		puts "Please enter 4 valid color characters. Remember, your options are: Red (R), Green (G), Blue (B), Magenta (M), Cyan (C), and Yellow (Y):"
		guess = validate_input_loop

		# Test against and update board
		@board.make_guess(@turn, guess, @code)
		puts "Your guess has been added to the board. Here's what the computer provided you as feedback:"
		@board.display_board
	end

	def computer_take_turn
		@turn += 1
		puts "The computer is guessing!"
		# The computer makes a guess, using the create_code function
		computer_guess = create_code
		puts "Debug: computer_guess = #{computer_guess}"
		puts "Debug: current code is #@code"
		# The board updates with feedback
		@board.make_guess(@turn, computer_guess, @code)
		puts "The computer has placed its guess on the board. Based on your code, we've updated the feedback pegs on the board as well."
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