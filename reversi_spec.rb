require 'rspec'
require_relative 'reversi'

include Reversi

describe Board do

  let(:board) { Board.new }

  it "should have two white pieces, two black pieces at the center" do
    board.board[3][3].color.should == :white
    board.board[3][4].color.should == :black
    board.board[4][3].color.should == :black
    board.board[4][4].color.should == :white
  end

  it "should determine the location of enemy pieces" do
    board.enemy_coords(:black).should == [[3, 3], [4, 4]]
  end

  let(:enemy_coords) { [[3, 3], [4, 4]] }

  it "should determine location of enemy neighbor coords" do
    board.enemy_neighbor_coords(enemy_coords).should =~ [[2, 2], [2, 3], [2, 4], [3, 2],
      [4, 2], [5, 3], [5, 4], [5, 5], [4, 5], [3, 5]]
  end

  it "should determine valid moves given a player color" do
    enemy_neighbor_coords = board.enemy_neighbor_coords(enemy_coords)
    board.valid_moves(enemy_neighbor_coords, :black).should == [[2, 3], [3, 2], [4, 5], [5, 4]]
  end


end


describe Piece do






end

describe Player do

  let(:player1) { Player.new("Kush", :white) }
  let(:player2) { Player.new("Ned", :black) }

  it "should set the player's color" do
    player1.color.should == :white
    player2.color.should == :black
  end



end
