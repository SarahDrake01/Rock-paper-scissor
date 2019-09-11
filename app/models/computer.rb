class Computer < ActiveRecord::Base
        def move
          weapons = ["Rock", "Paper", "Scissors"]
          weapons.sample
        end
    end
    
