#= Mastermind

require "colorize"

class Game
	def initialize
		# Create a new board
		@board = Board.new
		@turn = 0
	end

	def run_game
	end
end

class Board
	def initialize
		@guesses = {}
		@feedbacks = {}
		# DELETE
		puts "Created a new board!"
		puts display_board
	end

	def display_board
		puts "+====+".colorize(:yellow)
		12.times do |num|
			if @guesses.key?(num)
				@guesses[num].each do |peg|
					print "+#{peg}+".colorize(:yellow)
				end
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

class Player
end

class Peg
end

game = Game.new