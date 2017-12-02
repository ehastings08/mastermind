# Next step: game's next methods

#= Mastermind

require "colorize"

class Game
	def initialize
		# Create a new board and set @turn and @code to nothing
		@board = Board.new
		@turn = 0
		@code = []
	end

	def run_game
	end

	def get_player_name
		print "Please enter your name:"
		@player_name = gets.chomp
	end

	def create_code
		options = %w(R, G, B, M, C, Y)
		4.times do |num| 
			@code.push(options.sample)
		end
		@code
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