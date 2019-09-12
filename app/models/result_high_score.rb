class Result_High_Score < ActiveRecord::Base
    has_many :games
    has_many :users
    def check(user1_move, user2_move)
        @winner = "user1" if user1_move == 'Rock' && user2_move == 'Scissor'
        @winner = "user1" if user1_move == 'Scissor' && user2_move == 'Paper'
        @winner = "user1" if user1_move == 'Paper' && user2_move == 'Rock'
        @winner = "user2" if user2_move == 'Rock' && user1_move == 'Scissor'
        @winner = "user2" if user2_move == 'Scissor' && user1_move == 'Paper'
        @winner = "user2" if user2_move == 'Paper' && user1_move == 'Rock'
        @winner = "Nobody" if user1_move == 'Rock' && user2_move == 'Rock'
        @winner = "Nobody" if user1_move == 'Scissor' && player2_move == 'Scissor'
        @winner = "Nobody" if user1_move == 'Paper' && user2_move == 'Paper'
        @winner
            end
        end

    
