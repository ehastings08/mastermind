require 'colorize'

guesses = ['R','Y','G','B']

def display_board(guesses)
		puts "+====+".colorize(:yellow)
		12.times do |num|
			if true
				print "+"
				guesses.each do |peg|
					print peg.colorize(:yellow)
				end
				print "+"
			else
				print "+----+".colorize(:yellow)
			end
			print "\n"
		end
		puts "+====+".colorize(:yellow)
	end

display_board(guesses)