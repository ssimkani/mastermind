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

def correct_num_and_spot(guess, code)
  correct_num_spot = 0
  index_correct_num_spot = []
  guess.each_with_index do |number, index|
    if code[index] == number
      correct_num_spot += 1
      index_correct_num_spot << index
    end
  end
  [correct_num_spot, index_correct_num_spot]
end

def multiple_count(num_str)
  multiple_count_hash = {}
  num_str.each { |num| multiple_count_hash[num] = num_str.count(num) }
  multiple_count_hash
end

attr_reader :code
