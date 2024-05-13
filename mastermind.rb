# frozen_string_literal: false

require 'set'

module Algorithm
  protected

  def main_loop
    counter = 1
    guess = '1111'
    previous_pegs = 0
    total_pegs = 0
    while counter <= 6 || total_pegs != 4
      total_pegs = feedback(guess)[1]
      computer_guess = initial_guesses(guess, total_feedback, previous_pegs, counter)
      previous_pegs = total_pegs
      guess = computer_guess
      counter += 1
    end
    guesses_after_four_pegs(guess, feedback(guess)[0])
  end

  def initial_guesses(guess, total_pegs, previous_pegs, counter)
    if total_pegs - previous_pegs >= 1
      new_guess = replace_first_n_occurrences(guess, counter.to_s, (counter + 1).to_s, 4 - total_pegs)
    elsif total_pegs == previous_pegs
      new_guess = guess.gsub(counter.to_s, (counter + 1).to_s)
    end
    new_guess
  end

  def guesses_after_four_pegs(guess, solid_pegs)
    until solid_pegs == 4
      permutations = guess.split('').permutation.to_a.delete(guess.split(''))
      guess = permutations.sample
      feedback(guess)
      solid_pegs = feedback(guess)[0]
    end
  end

  def feedback(guess)
    puts "The computers guess was #{guess}.\n"
    print 'Enter Correct Numbers in the Correct Spot: '
    solid_pegs = gets.chomp.to_i
    print "\nEnter Correct Numbers Only: "
    empty_pegs = gets.chomp.to_i
    [solid_pegs, solid_pegs + empty_pegs]
  end

  def replace_first_n_occurrences(string, char_to_replace, replacement, number_of_occurrences)
    count = 0
    string.gsub!(char_to_replace) do |match|
      count += 1
      if count <= number_of_occurrences
        replacement
      else
        match
      end
    end
    string
  end
end

class MasterMind
  include Algorithm

  attr_reader :winner, :code_maker, :code_breaker

  def initialize
    @winner = nil
    @code_maker = ''
    @code_breaker = ''
    @code = []
    @first_call_computer_code = false
  end

  def computer_guess_play
    @code_maker = 'Player'
    @code_breaker = 'Computer'
    print "\nEnter 4 numbers between 1 and 6: "
    player_code = gets.chomp
    puts "Your code: #{player_code}"
    if main_loop == 4
      puts 'The computer guessed the code correctly'
    else
      main_loop
    end
  end

  def player_guess_play
    @code_maker = 'Computer'
    @code_breaker = 'Player'
    counter = 0
    while counter < 12 && winner.nil?
      display_feedback(player_guess(counter), computer_code)
      counter += 1
    end
    puts 'You guessed the code correctly!' if winner == 'Player'

    puts "You didn't guess the code correctly. The correct code was #{code.join}." if winner.nil?
    @winner = 'Computer'
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

  def display_feedback(guess, code)
    feedback = "\n- -\n- -\n\n"
    comparison_result = compare(guess, code)

    comparison_result[0][0].times { feedback.sub!('-', '●') }
    comparison_result[1].times { feedback.sub!('-', '○') }

    @winner = 'Player' if comparison_result[0][0] == 4

    puts feedback
  end

  def compare(guess, code)
    guess = guess.split('')
    correct_number_and_spot = correct_num_and_spot(guess, code)

    guess = guess.each_with_index.reject { |_, index| correct_number_and_spot[1].include?(index) }.map(&:first)

    code = code.each_with_index.reject { |_, index| correct_number_and_spot[1].include?(index) }.map(&:first)

    correct_number_only = correct_num_only(guess, code)
    [correct_number_and_spot, correct_number_only]
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

  def correct_num_only(guess, code)
    multiple_count_hash_code = multiple_count(code)
    multiple_count_hash_guess = multiple_count(guess)
    correct_num = 0
    guess.each { |number| correct_num += 1 if code.include?(number) }
    guess.to_set.each do |number|
      if code.include?(number) && multiple_count_hash_guess[number] > multiple_count_hash_code[number]
        correct_num -= (multiple_count_hash_guess[number] - multiple_count_hash_code[number])
      end
    end
    correct_num
  end

  def multiple_count(num_str)
    multiple_count_hash = {}
    num_str.each { |num| multiple_count_hash[num] = num_str.count(num) }
    multiple_count_hash
  end

  attr_reader :code
end

class Game
  def play
    print 'Enter 0 to be the code maker or 1 to be the code breaker: '
    select = gets.chomp.to_i
    MasterMind.new.computer_guess_play if select.zero?
    MasterMind.new.player_guess_play if select == 1
  end
end

Game.new.play
