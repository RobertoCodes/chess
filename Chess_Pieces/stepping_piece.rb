class SteppingPiece < Piece

  def moves
    possible_moves = []
    self.class::MOVES.each do |move|
      x = self.pos[0]
      y = self.pos[1]
      x += move[0]
      y +=  move[1]
      test_pos = [x,y]
      possible_moves << [x,y] if x.between?(0,7) && y.between?(0,7)
    end

    possible_moves.select { |move| board[move].nil? ||
      board[move].color != self.color }
  end

end
