# frozen_string_literal: true

require_relative 'board'

# This class manages a game of Connect Four.
class Game
  attr_reader :player1, :player2

  def initialize
    @player1 = :red
    @player2 = :yellow
    @curr_player = @player1
    @board = Board.new
    @prev_move = []
  end

  def player_input
    puts "#{@curr_player.capitalize}, select a column to drop your token in:"

    loop do
      user_input = gets.chomp
      verified_input = process_input(user_input)
      return verified_input if verified_input

      puts 'Input error! Please enter a number from 1 to 7:'
    end
  end

  def process_input(user_input)
    user_input.to_i - 1 if user_input.match(/^[1-7]$/)
  end

  def win_state
    if @board.win?(@prev_move)
      :win
    elsif @board.full?
      :tie
    end
  end
end
