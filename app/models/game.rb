class Game < ActiveRecord::Base
    #Game belongs to the user
    #game belongs to the result_high_score

    class Game

        attr_reader :user1, :user2, :instance
        #My attr_reader so it will not be able to change anything, only read
      
        def initialize(user1, user2 = nil)
          @user1 = user.new(user1)
          @user2 = user.new(user2)
        end
      
        def self.instance #self.instance variable
          @game_instance
        end
      
        def self.start_game(user1, user2 = 'Computer')
          #Here I set up the user2 = Computer, so user 1 will be playing agaist the Computer.
          @game_instance ||= Game.new(user1, user2)
        end
      end
    end
    
