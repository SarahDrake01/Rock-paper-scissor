class Result_High_Score < ActiveRecord::Base
    #High score belongs to the game.
    def check(user1_move, user2_move)
        @winner = "user 1" if user1_move == 'Rock' && user2_move == 'Scissor'
        @winner = "user 1" if user1_move == 'Scissor' && user2_move == 'Paper'
    end 
    
end
    
