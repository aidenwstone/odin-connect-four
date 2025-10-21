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

  def draw
    puts '| 1 2 3 4 5 6 7 |'
    @grid.each { |row| print_row(row) }
  end

  def drop_token(token, column_index)
    row_index = 5

    until @grid.dig(row_index, column_index).nil?
      row_index -= 1
      return nil if row_index.negative?
    end

    @grid[row_index][column_index] = token
    [row_index, column_index]
  end

  private

  def print_row(row)
    print '| '
    row.each do |color|
      symbol = color.nil? ? EMPTY_SYMBOL : TOKEN_SYMBOL.colorize(color)
      print "#{symbol} "
    end
    puts '|'
  end
end
