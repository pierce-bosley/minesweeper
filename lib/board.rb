require_relative "tile"

module Minesweeper
  class Board
    def initialize(dimensions, mines)
      @grid = build_grid(mines, *dimensions)
      @mines = mines
      @flags = 0
    end

    def toggle_flag(position)
      if self[position].toggle_flag
        @flags += 1
      else
        @flags -= 1
      end
    end

    private

    def [](position)
      row, col = position
      @grid[row][col]
    end

    def build_grid(mines, rows, cols)
      new_grid = Array.new(rows) { Array.new(cols) }
      mine_positions = generate_mine_positions(rows, cols, mines)

      rows.times do |row|
        cols.times do |col|
          if mine_positions.include?([row, col])
            new_grid[row][col] = Tile.new(true)
          else
            new_grid[row][col] = Tile.new(false)
          end
        end
      end

      new_grid
    end

    def generate_mine_positions(rows, cols, mines)
      positions = []

      until positions.length == mines
        new_position = [rand(rows), rand(cols)]
        positions << new_position unless positions.include?(new_position)
      end

      positions
    end
  end
end