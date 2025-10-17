# frozen_string_literal: true

require 'colorize'

# This class manages a game of Connect Four.
class Board
  EMPTY_SYMBOL = "\u25CC"
  TOKEN_SYMBOL = "\u25C9"

  attr_reader :grid

  def initialize(grid = Array.new(6) { Array.new(7) })
    @grid = grid
  end
end
