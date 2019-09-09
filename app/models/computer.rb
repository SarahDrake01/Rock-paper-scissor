class Computer < ActiveRecord::Base
    class Computer
        def move
          random_num = rand(1..9)
          #Here I set up my random num to be an number between 1..9 to define the result.
          @move = 'Rock' if random_num <= 3
          #Here I'm saying if my number is less than 3 so the result will be 'Rock'.
          @move = 'Paper' if random_num.between?(4,6)
          #Here I'm saying if my number is between 4, 6 so the r4esult will be 'Paper'.
          @move = 'Scissor' if random_num.between?(7,9)
          ##Here I'm saying if my number is between 7,9 so the result will be 'Scissor'.
          @move
        end
      end
    end
    
