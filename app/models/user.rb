require_relative './computer.rb'

class User < ActiveRecord::Base
#User has many game
  

  def make_move(move = nil)
    @move = move if @name != 'Computer'
    @move = Computer.new.move if @name == 'Computer'
  end
end



    
