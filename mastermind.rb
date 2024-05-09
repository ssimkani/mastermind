# frozen_string_literal: false

require 'set'

class MasterMind
  attr_reader :codemaker, :codebreaker, :winner

  def initialize
    @codemaker = 'Player'
    @codebreaker = 'Computer'
    @winner = nil
    @code = []
    @first_call_computer_code = false
  end
end

protected

def computer_code
  unless @first_call_computer_code
    @first_call_computer_code = true
    arr = (1..6).to_a
    4.times { code << arr.sample.to_s }
    code
  end
  code
end

def player_guess(counter)
  print "Enter guess number #{counter + 1}: "
  guess = gets.chomp
  if guess.chars.all? { |char| char.to_i <= 6 && char.to_i.positive? } && guess.length == 4
    guess
  else
    puts "Please enter a valid guess.\n\n"
    player_guess(counter)
  end
end

attr_reader :code