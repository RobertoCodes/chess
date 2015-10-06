require_relative 'chess_piece.rb'
require 'byebug'

class Board

  attr_reader :board
  attr_accessor :black_pieces, :white_pieces

  def initialize
    @board = Array.new(8){Array.new(8)}

    @black_pieces = []
    @white_pieces = []

    @board[0].length.times do |i|
      @board[0][i] = Pawn.new(:black, [0,i], @board)
      @black_pieces << @board[0][i]
    end
    @board[1].length.times do |i|
      @board[1][i] = Pawn.new(:black, [1,i], @board)
      @black_pieces << @board[1][i]
    end
    @board[6].length.times do |i|
      @board[6][i] = Pawn.new(:white, [6,i], @board)
      @white_pieces << @board[6][i]
    end
    @board[7].length.times do |i|
      @board[7][i] = Pawn.new(:white, [7,i], @board)
      @white_pieces << @board[7][i]
    end
  end

  def move(start,end_pos)
    piece = @board[start]
    if piece.nil?
      raise "No piece brah"
    elsif !piece.valid_moves.include?(end_pos)
      raise "Can't go there brah"
    else
      @board[end_pos] = piece
      @board[start] = nil
    end
  end


  def in_check?(check_color)

    if check_color == :white
      king_pos = (white_pieces.select { |white_piece| piece.name == "K" }).first.pos
      black_pieces.each do |black_piece|
        return true if black_piece.moves.include?(king_pos)
      end
    else
      king_pos = (black_pieces.select { |black_piece| piece.name == "K" }).first.pos
      white_pieces.each do |white_piece|
        return true if white_piece.moves.include?(king_pos)
      end
    end

  end

  def checkmate?

    black_pieces.all? {|piece| piece.valid_moves.empty?} ||
    white_pieces.all? {|piece| piece.valid_moves.empty?}

  end


  def [](array)
    row = array[0]
    col = array[1]
    self[row][col]
  end

end
