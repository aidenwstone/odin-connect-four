# frozen_string_literal: true

require 'colorize'

# This class manages a game board to be used in Connect Four.
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

  def win?(start_coordinates)
    row_index, column_index = *start_coordinates
    player_token = @grid.dig(row_index, column_index)
    return false if player_token.nil?

    true if win_horizontal?(row_index, player_token) ||
            win_vertical?(column_index, player_token) ||
            win_diagonal?(row_index, column_index, player_token)
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

  def win_horizontal?(row_index, player_token)
    row = @grid[row_index]

    valid_row?(row, player_token)
  end

  def win_vertical?(column_index, player_token)
    column = @grid.collect { |row| row[column_index] }

    valid_row?(column, player_token)
  end

  def win_diagonal?(row_index, column_index, player_token)
    forward_anchor = find_anchor(row_index, column_index, -1, -1)
    backward_anchor = find_anchor(row_index, column_index, -1, 1)

    forward_diagonal = collect_diagonal(*forward_anchor, 1, 1)
    backward_diagonal = collect_diagonal(*backward_anchor, 1, -1)

    valid_row?(forward_diagonal, player_token) || valid_row?(backward_diagonal, player_token)
  end

  def find_anchor(row_index, column_index, row_step, column_step)
    while valid_coordinates?(row_index + row_step, column_index + column_step)
      row_index += row_step
      column_index += column_step
    end

    [row_index, column_index]
  end

  def collect_diagonal(row_index, column_index, row_step, column_step)
    values = []

    while valid_coordinates?(row_index, column_index)
      values.push(@grid[row_index][column_index])
      row_index += row_step
      column_index += column_step
    end

    values
  end

  def valid_coordinates?(row_index, column_index)
    row_index.between?(0, 5) && column_index.between?(0, 6)
  end

  def valid_row?(token_values, player_token)
    token_values.each_cons(4) do |group|
      return true if group.all?(player_token)
    end

    false
  end
end
