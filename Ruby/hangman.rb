#require 'yaml'
$condition = "ongoing"
class Game 
	def initialize()
		@@current = []
		@@letter = "a"
		@@guessed = []
		@@wrong = "1"
		@@lives = 10
	end
	
	def array(word)
		@@current = Array.new(word.length, " _ ")
	end
	def status(word, letter) #First check of the word
		word.each_index do |i|
			if (@@current[i]==(" _ ")) && (word[i].include? letter)
				@@current[i]= letter
			end	
		end
		@@current.each{|i| print i}
		puts " "
		if !@@current.include? " _ "
			puts "You Win!"
			$condition = "win"
		end
		
	end
	def gameover
		if @@lives ==0
			$condition = "lost"
		end
	end

	def checker(word, letter="a") #Checks if the word contains the letter guessed
		if word.include? letter
			puts "Correct, the word does have the letter #{letter}."
			status(word, letter)
		else 
			puts "Incorrect, the word does not have the letter #{letter}."
			puts (" ")
			@@lives -=1
			gameover
			puts "#{@@lives} guesses remaining"
			status(word, letter)
		end
	end

end


class Player <Game #interactions with the player
		attr_accessor :name
	def initialize()
		@@player = Game.new
		@@guess = 1
		@@blank = " _ "
		@@guessed = []
		@@word ="word"
		@@letter = "letter"

	end
	def begin #Starts the game
		@@player.read
	end
	def guess(word,letter)
		while @@guess<24 
			puts " "
			#puts "Guess number: #{@@guess}"
			puts "Guess a letter."
			if @@guess >1
				puts "You already guessed the following letters #{@@guessed}"
			end
			@@guess +=1
			letter = gets.chomp
			puts "You guessed #{letter}"
			repeat(letter)
			if @@guessed.include? letter && (@@guess !=2)
				puts "Error"
			else
				@@player.checker(word,letter)
			end
			if $condition== "lost"
				@@guess =25
				puts "Out of guesses, game over!"
				puts "The word was #{word.join()}"
			end
			if $condition== "win"
				@@guess =25

			end
		end
	end
	def repeat(letter)
		if @@guessed.include? letter
			puts "You already guessed the following letters #{@@guessed}"
			puts "Try again"
			@@guess -=1
		else
			@@guessed.push(letter)
		end
	end
end

class Random_word
	def initialize()
		@@word ="word"
		@@word1 ="word1"
		@@player = Player.new
		@@game = Game.new
	end

	def read #Reads the file and picks a letter
		file = File.readlines("5desk.txt")
		while (@@word.length<5) || (@@word.length>12)
			@@word= file[rand(0..file.length-1)].downcase.gsub!(/\s+/, '')
		end
		#puts "The word is #{@@word}"
		puts "The word is #{@@word.length} letters long"
		@@word1 = @@word
		@@word =@@word.split("")
		@@game.array(@@word)
		@@player.guess(@@word,letter="a")
	end

end
david = Random_word.new
david.read
