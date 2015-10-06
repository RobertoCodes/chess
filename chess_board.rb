require_relative 'chess_piece.rb'
require 'byebug'

class Board

  # attr_reader :board
  attr_accessor :black_pieces, :white_pieces, :board

  def initialize
    @board = Array.new(8){Array.new(8)}

    @black_pieces = []
    @white_pieces = []

    @board[0].length.times do |i|
      @board[0][i] = King.new(:black, [0,i], self)
      @black_pieces << @board[0][i]
    end
    @board[1].length.times do |i|
      @board[1][i] = King.new(:black, [1,i], self)
      @black_pieces << @board[1][i]
    end
    @board[6].length.times do |i|
      @board[6][i] = King.new(:white, [6,i], self)
      @white_pieces << @board[6][i]
    end
    @board[7].length.times do |i|
      @board[7][i] = King.new(:white, [7,i], self)
      @white_pieces << @board[7][i]
    end
  end

  def move(start,end_pos)
    piece = board[start[0]][start[1]]
    if piece.nil?
      raise "No piece brah"
    elsif !piece.valid_moves.include?(end_pos)
      raise "Can't go there brah"
    else
      board[end_pos[0]][end_pos[1]] = piece
      board[start[0]][start[1]] = nil
    end
  end

  def test_move(start,end_pos)
    piece = board[start[0]][start[1]]
    if piece.nil?
      raise "No piece brah"
    else
      board[end_pos[0]][end_pos[1]] = piece
      board[start[0]][start[1]] = nil
    end
  end

  def deep_dup
    board_dup = Board.new
    board_dup.board =
      board.map do |row|
        row.map do |el|
          if el.nil?
            nil
          else
            el.dup
          end
      end
    end
    board_dup
  end


  def in_check?(check_color)

    if check_color == :white
      king_pos = (white_pieces.select { |white_piece| white_piece.name == "K" }).first.pos
      black_pieces.each do |black_piece|
        return true if black_piece.moves.include?(king_pos)
      end
    else
      king_pos = (black_pieces.select { |black_piece| black_piece.name == "K" }).first.pos
      white_pieces.each do |white_piece|
        return true if white_piece.moves.include?(king_pos)
      end
    end

    false
  end

  def checkmate?

    black_pieces.all? {|piece| piece.valid_moves.empty?} ||
    white_pieces.all? {|piece| piece.valid_moves.empty?}

  end


  # def [](array)
  #   row, col = array
  #   board[row][col]
  # end
  #
  # def []=(array, val)
  #   row, col = array
  #   board[row][col] = val
  # end

end
