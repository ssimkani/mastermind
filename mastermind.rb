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