require_relative 'chess_piece.rb'
require 'byebug'

class Board

  # attr_reader :board
  attr_accessor :black_pieces, :white_pieces, :board

  def initialize
    @board = Array.new(8){Array.new(8)}

    black_back_row = [Rook.new(:black, [0,0], self), Knight.new(:black, [0,1], self), Bishop.new(:black, [0,2], self),
    Queen.new(:black, [0,3], self), King.new(:black, [0,4], self), Bishop.new(:black, [0,5], self),
    Knight.new(:black, [0,6], self), Rook.new(:black, [0,7], self)]

    white_back_row = [Rook.new(:white, [7,0], self), Knight.new(:white, [7,1], self), Bishop.new(:white, [7,2], self),
    Queen.new(:white, [7,3], self), King.new(:white, [7,4], self), Bishop.new(:white, [7,5], self),
    Knight.new(:white, [7,6], self), Rook.new(:white, [7,7], self)]

    # @black_pieces = []
    # @white_pieces = []

    @board[0] = black_back_row
    @board[7] = white_back_row

    # @board[0].length.times do |i|
    #   @black_pieces << @board[0][i]
    # end
    @board[1].length.times do |i|
      @board[1][i] = Pawn.new(:black, [1,i], self)
      # @black_pieces << @board[1][i]
    end
    @board[6].length.times do |i|
      @board[6][i] = Pawn.new(:white, [6,i], self)
      # @white_pieces << @board[6][i]
    end
    # @board[7].length.times do |i|
    #   @white_pieces << @board[7][i]
    # end
  end

  def move(start,end_pos)
    piece = self[start]
    if piece.nil?
      raise "No piece brah"
    elsif !piece.valid_moves.include?(end_pos) && self.checkmate?
      raise "YOU'RE IN CHECKMATE LOSER"
    elsif !piece.valid_moves.include?(end_pos)
      raise "Can't go there brah"
    else
      self[end_pos] = piece
      self[start] = nil
      piece.pos = end_pos
        if piece.is_a?(Pawn)
          piece.first_move = false
        end
    end
  end

  def black_pieces
    self.board.flatten.select{|sq| sq && sq.color == :black}
  end

  def white_pieces
    self.board.flatten.select{|sq| sq && sq.color == :white}
  end

  def test_move(start,end_pos)
    piece = self[start]
    if piece.nil?
      raise "No piece brah"
    else
      self[end_pos] = piece
      self[start] = nil
      piece.pos = end_pos
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
    board_dup.board.each_with_index do |row, idx_1|
      row.each_with_index do |sq,idx_2|
        if sq
          sq.pos = [idx_1,idx_2]
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

    if in_check?(:black)
      black_pieces.each do |black_piece|
        return false if !black_piece.valid_moves.empty?
      end
      true
    end

    if in_check?(:white)
      white_pieces.each do |white_piece|
        return false if !white_piece.valid_moves.empty?
      end
      true
    end

    # black_pieces.all? {|piece| piece.valid_moves.empty?} ||
    # white_pieces.all? {|piece| piece.valid_moves.empty?}

  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end


  def [](array)
    row, col = array
    board[row][col]
  end

  def []=(array, val)
    row, col = array
    board[row][col] = val
  end

end
