require_relative '../../config/environment'
require 'tty-prompt'
class Cli

    def welcome 
        puts "Welcome, select from the following options"
        prompt = TTY::Prompt.new
        choice = prompt.select("Choose an option", ["New User", "Login", "Exit"])
        #TTY::Prompt is an open-source gem that provides "a beautiful" and powerful interdcatice command line prompt. 
    
        if choice == "New User" 
            new_user 
        elsif choice == "Login"
            login 
        else 
            puts "Goodbye" 
            sleep(1)
            ##Sleep(*args) public Suspends the current thread 
            #for duration seconds (which may be any number, including a Float with Fractional seconds).
        end 
    end 

	def new_user
		prompt = TTY::Prompt.new
		username = prompt.ask("Whats your name?")
		user = User.create(name: username)
	end

	def login
	prompt = TTY::Prompt.new
	response = prompt.ask("Enter your username")
	user = User.all.find{|user| user.name == response}
		if user 
			user = user
			puts "Welcome back #{user.name}"
			sleep(1)
			# questions_interface
			player
		else 
			puts "That user doesn't exist"
			sleep(2)
			welcome
		end 
	end
		def intro
			puts "Welcome to Rock, Paper, Scissors!"
			sleep(0.5)
			puts "Please enter your name"
			@player_name = gets.chomp
			sleep(0.5)
			User.create(name: @player_name)
			puts "Welcome #{@player_name}!"	
		end
		
		def	player
			sleep(0.5) 
			prompt = TTY::Prompt.new
			#binding.pry
			@weapon_player = prompt.ask("Choose your weapon! Rock, Paper or scissors!")
			#binding.pry
			if (@weapon_player.capitalize != "rock".capitalize && @weapon_player.capitalize != "paper".capitalize && @weapon_player.capitalize != "scissors".capitalize)
				puts "That's not rock, paper or scissors! Try again..."
				player
			else
				puts "You have chosen #{@weapon_player}"
				computer
				run_game
			end
		end

		def computer
			sleep(1)
			@weapon_computer = ["rock", "paper", "scissors"].sample
			#(1).join(", ")
			#.sample choose a random element.
			#.join returns a string created by converting each element of the array to a string.
			puts "Computer has chosen #{@weapon_computer}"
		end

		def run_game
			sleep(0.5)
			#binding.pry
			if @weapon_player.capitalize == @weapon_computer.capitalize
				#Upcase. Upcase is used to capitalize every letter of a string.
				puts "It's a draw!"
			elsif @weapon_player == "rock".capitalize && @weapon_computer == "scissors".capitalize
				puts "Rock beats scissors - you won #{@player_name}!"
			elsif @weapon_player.capitalize == "scissors".capitalize && @weapon_computer.capitalize == "paper".capitalize
				puts "Scissors beats paper - you won #{@player_name}!"
			elsif @weapon_player.capitalize == "paper".capitalize && @weapon_computer.capitalize == "rock".capitalize
				puts "Paper beats rock - you won #{@player_name}!"
			else 
				puts "Unlucky #{@player_name}! You lost!"	
			end
		end

		def play_again?
			sleep(1)
			puts "Would you like to play again?"
			answer = gets.chomp.downcase
			if answer == "yes"
				start
			elsif answer == "no"
				puts "Thanks for playing #{@player_name}!"
			else
				puts "YES or NO?"
				play_again?
			end
		end

	def start
		login
		#puts "Choose your weapon! Rock, paper or scissors?"
		self.player	
		self.play_again?
    end
end
