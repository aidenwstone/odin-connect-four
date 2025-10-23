# frozen_string_literal: true

require_relative 'board'

# This class manages a game of Connect Four.
class Game
  attr_reader :player1, :player2

  def initialize
    @player1 = :red
    @player2 = :yellow
    @curr_player = @player1.capitalize
    @board = Board.new
    @prev_move = []
  end
end
