
class Pawn < Piece

  attr_accessor :first_move

  def initialize(color, pos, board, first_move = true)
    if color == :black
      name = ["265F".hex].pack("U")
    else
      name = ["2659".hex].pack("U")
    end

    super(color, pos, board, name)
    @first_move = first_move
  end



  def moves
    possible_moves = []

      if self.color == :black
        x = self.pos[0]
        y = self.pos[1]

        if first_move && board[[x+2,y]].nil?
          possible_moves << [x+2,y]
        end

        if board[[x+1,y]].nil?
          possible_moves << [x+1,y]
        end

        if !board[[x+1,y-1]].nil? && board[[x+1,y-1]].color == :white
          possible_moves << [x+1,y-1]
        end

        if !board[[x+1,y+1]].nil? && board[[x+1,y+1]].color == :white
            possible_moves << [x+1,y-1]
        end

      end

      if self.color == :white
        x = self.pos[0]
        y = self.pos[1]
        if first_move && board[[x-2,y]].nil?
          possible_moves << [x-2,y]
        end

        if board[[x-1,y]].nil?
          possible_moves << [x-1,y]
        end

        if !board[[x-1,y-1]].nil? && board[[x-1,y-1]].color == :black
          possible_moves << [x-1,y-1]
        end

        if !board[[x-1,y+1]].nil? && board[[x-1,y+1]].color == :black
            possible_moves << [x-1,y-1]
        end

      end
      possible_moves

  end
end
