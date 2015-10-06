require_relative 'chess_piece.rb'
require 'byebug'

class Board

  attr_reader :board

  def initialize
    @board = Array.new(8){Array.new(8)}
    @board[0].length.times do |i|
      @board[0][i] = Pawn.new(:black, [0,i], @board)
    end
    @board[1].length.times do |i|
      @board[1][i] = Pawn.new(:black, [1,i], @board)
    end
    @board[6].length.times do |i|
      @board[6][i] = Pawn.new(:white, [6,i], @board)
    end
    @board[7].length.times do |i|
      @board[7][i] = Pawn.new(:white, [7,i], @board)
    end
  end

  def move(start,end_pos)
    piece = @board[start]
    if piece.nil?
      raise "No piece brah"
    elsif !piece.valid_move?(end_pos)
      raise "Can't go there brah"
    else
      @board[end_pos] = piece
      @board[start] = nil
    end
  end


  def [](array)
    row = array[0]
    col = array[1]
    self[row][col]
  end

end
