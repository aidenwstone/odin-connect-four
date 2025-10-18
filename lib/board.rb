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
