module Reversi

  class Board

  DELTA = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]


    attr_accessor :board

    def initialize
      @board = Array.new(8) { Array.new(8) }
      populate_board
    end

    def on_board?(coords)
      (0..7).include?(coords[0]) && (0..7).include?(coords[1])
    end

    def populate_board
      @board[3][3] = Piece.new([3, 3], :white)
      @board[3][4] = Piece.new([3, 4], :black)
      @board[4][3] = Piece.new([4, 3], :black)
      @board[4][4] = Piece.new([4, 4], :white)
    end

    def valid_moves(enemy_neighbor_coords, color)
      enemy_color = opposite_color(color)
      valid_moves = []
      deltas = []

      enemy_neighbor_coords.each do |coord|
        row, col = coord
        DELTA.each do |delta|
          unless row + delta[0] < 0 || row + delta[0] > 7 ||
            col + delta[1] < 0 || col + delta[1] > 7
            if !@board[row + delta[0]][col + delta[1]].nil? && @board[row + delta[0]][col + delta[1]].color == enemy_color
              deltas << delta
            end
          end

        deltas.each do |delta|
          if crawl_delta(coord, delta, color).count >= 1
            valid_moves << coord
          end
        end

        end
      end
      valid_moves
    end

    def crawl_delta(coord, delta, color)
      enemy_color = opposite_color(color)
      row, col = coord
      coords_to_flip = []

      row += delta[0]
      col += delta[1]

      until @board[row][col].color == color || !on_board?([row, col])
        if @board[row][col].nil?
          coords_to_flip = []
          break
        elsif @board[row][col].color == enemy_color
          coords_to_flip << [row][col]
        end
        row += delta[0]
        col += delta[1]
      end

      coords_to_flip
    end


    def enemy_coords(color)
      enemy_color = opposite_color(color)
      enemy_coords = []
      @board.each_with_index do |row, ri|
        row.each_with_index do |col, ci|
          enemy_coords << [ri, ci] if !col.nil? && (col.color == enemy_color)
       end
      end
      enemy_coords
    end

    def enemy_neighbor_coords(enemy_coords)

      enemy_neighbor_coords = []

      enemy_coords.each do |coord|
        row, col = coord
        DELTA.each do |delta|
          unless row + delta[0] < 0 || row + delta[0] > 7 ||
            col + delta[1] < 0 || col + delta[1] > 7
            if @board[row + delta[0]][col + delta[1]].nil?
              enemy_neighbor_coords << [row + delta[0], col + delta[1]]
            end
          end
        end
      end
      enemy_neighbor_coords
    end

    def opposite_color(color)
      color == :black ? :white : :black
    end


  end

  class Piece

    attr_accessor :color, :coords

    def initialize(coords, color)
      @color, @coords = color, coords
    end

  end

  class Player

    attr_accessor :name, :color

    def initialize(name, color)
      @name = name
      @color = color
    end

  end
end