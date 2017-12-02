require 'colorize'

guesses = {1 => ['R','Y','G','B']}
feedback = {1 => ['W','W','K','-']}

def display_board(guesses, feedback)
		# Update to include feedback on the right hand side
		color_mapping = {'R' => :red , 'G' => :green, 'B' => :blue, 'M' => :magenta, 'C' => :cyan, 'Y' => :light_yellow, 'W' => :white, 'K' => :light_black, '-' => :yellow}

		puts "+====++====+".colorize(:yellow)
		12.times do |num|
			if guesses.key?(num+1)
				print "+".colorize(:yellow)
				guesses[num+1].each do |peg|
					print peg.colorize(color_mapping[peg])
				end
				print "++".colorize(:yellow)
				feedback[num+1].each do |feedback_peg|
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

display_board(guesses, feedback)