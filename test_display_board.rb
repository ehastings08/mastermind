guesses = ['R','Y','G','B']

def display_board(guesses)
	print "+====+"
	for 12.times do |num|
		puts num
	end
end

puts display_board(guesses)

# if guesses.keys?(num)
# 			guesses[num].each do |peg|
# 				print peg
# 			end
# 		else
# 			print "-"
# 		end