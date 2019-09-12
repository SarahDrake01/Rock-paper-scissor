require_relative '../../config/environment'
require 'tty-prompt'
require "pry"
class Cli

	@@user = ''


    def welcome 
        puts "Welcome, select from the following options"
        @prompt = TTY::Prompt.new
        @choose = @prompt.select("Choose an option", ["New User", "Login", "Exit", "View Player Highscore", "Delete User"])
        #TTY::Prompt is an open-source gem that provides "a beautiful" and powerful interdcatice command line prompt. 
    
        if @choose == "New User" 
            new_user 
        elsif @choose == "Login"
            login 
		elsif @choose == "Exit"
            puts "Goodbye" 
			sleep(0.1)
			exit
            ##Sleep(*args) public Suspends the current thread 
			#for duration seconds (which may be any number, including a Float with Fractional seconds).
		elsif @choose == "View Player Highscore"
			user_high_score
		elsif @choose == "Delete User"
			delete_user
        end
	end 

	def user_high_score
		all_users = User.all.map{|user| user.name}
		#Here I found all users and saved then in a variable by name.
		if all_users == []
			#All the users got displayed in prompt, and the chosen user was saved in a variable
			puts "There are no users in the highscore table!"
			welcome
		else
			user = @prompt.select("Which user would you like to view?", all_users)
			user_high_score = User.find_by(name: user)
			#using the variable that saved a chosen user, I fond his scores
			points = user_high_score.game.sum {|user| user.score}
			#Using sum I added up
			puts " Your current high score is #{points}, #{user}"
			#I displayed the total sum of scores of that user
			welcome
			#return to the welcome screen
		end
	end
	

	def new_user
		@prompt = TTY::Prompt.new
		@username = @prompt.ask("Whats your name?")
		user = User.create(name: @username)
		welcome
	end


	def login
	@prompt = TTY::Prompt.new
	response = @prompt.ask("Enter your username(type back to go back)")
	user = User.find_by(name: response)
	#Here I set up my variable = User.find_by so everytime someone who already played the game puts theyr username, the computer 
	#already know.
		if user != nil
			#Here if the user doen't = nil so they can start the game
			puts "Welcome back #{user.name}"
			sleep(0.2)
			# questions_interface
			@@user = user
			player
		elsif response == "back"
			puts "back"
			sleep(0.2)
			welcome
		#else
			#puts "New-user", "Login", "Exit"
		else 
			puts "This user does not exist"
			login
		end 
	end


		def intro
			puts "Welcome to Rock, Paper, Scissors!"
			sleep(0.2)
			puts "Please enter your name"
			@player_name = gets.chomp
			sleep(0.2)
			User.create(name: @player_name)
			puts "Welcome #{@player_name}!"	
		end
		
		def	player
			sleep(0.2) 
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
			sleep(0.5)
			@weapon_computer = ["rock", "paper", "scissors"].sample
			#(1).join(", ")
			#.sample choose a random element.
			puts "Computer has chosen #{@weapon_computer}"
		end

		def run_game
			#binding.pry
			sleep(0.2)
			#binding.pry
			if @weapon_player.capitalize == @weapon_computer.capitalize
				result = 0
				#Upcase. Upcase is used to capitalize every letter of a string.
				puts "It's a draw!"
				game = Game.create(user_id: @@user.id, score: 1)
				#binding.pry
				#If draw the user get 1 pont
				Result_High_Score.create(high_score: game.score, game_id: game.id)
				#here I set up the score for the @user, each time the user win, will get 3 points.
			elsif @weapon_player == "rock".capitalize && @weapon_computer == "scissors".capitalize
				puts "Rock beats scissors - you won #{@player_name}!"
				game = Game.create(user_id: @@user.id, score: 3)
				user = Game.find_by(id: @@user.id)
				Result_High_Score.create(high_score: game.score, game_id: game.id)
			elsif @weapon_player.capitalize == "scissors".capitalize && @weapon_computer.capitalize == "paper".capitalize
				puts "Scissors beats paper - you won #{@player_name}!"
				game = Game.create(user_id: @@user.id, score: 3)
				Result_High_Score.create(high_score: game.score, game_id: game.id)
			elsif @weapon_player.capitalize == "paper".capitalize && @weapon_computer.capitalize == "rock".capitalize
				puts "Paper beats rock - you won #{@player_name}!"
				game = Game.create(user_id: @@user.id, score: 3)
				Result_High_Score.create(high_score: game.score, game_id: game.id)
			else 
				puts "Unlucky #{@player_name}! You lost!"	
				game = Game.create(user_id: @@user.id, score: 0)
				Result_High_Score.create(high_score: game.score, game_id: game.id)
			end
		end

		def play_again?
			sleep(0.3)
			puts "Would you like to play again?"
			answer = gets.chomp.downcase
			#gets.chomp is used to take string input from users.
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
		welcome
		login
		#puts "Choose your weapon! Rock, paper or scissors?"
		self.player	
		self.play_again?
	end
	
	def delete_user
		username = @prompt.ask("Enter the user you would like to delete?")
		user = User.find_by(name: username)
		user.destroy
		puts "The user has been deleted"
		welcome
	end
end
