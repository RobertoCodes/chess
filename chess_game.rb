require_relative 'chess_board.rb'
require_relative 'chess_piece.rb'
require_relative 'chess_display.rb'

class Game

  attr_accessor :board, :display, :current_player
  attr_reader :white_player, :black_player

  def initialize(white_player, black_player)
    @board = Board.new
    @white_player = white_player
    @black_player = black_player
    @current_player = @white_player
    @display = Display.new(@board)
  end

  def play
    # Game.new
    until board.checkmate?
      take_turn
      @display.render
      next_player
    end

    puts "GAME OVER"

  end

  def take_turn
    print "White player, " if current_player == white_player
    print "Black player, " if current_player == black_player
    print "use the cursor to select a start position and hit enter."
    puts
    @display.render

    begin_sq = nil
    until begin_sq
      system("clear")
      @display.render
      begin_sq = @display.get_input
    end

    print "White player, " if current_player == white_player
    print "Black player, " if current_player == black_player
    print "use the cursor to select an end position and hit enter."
    puts

    end_sq = nil
    until end_sq
      system("clear")
      @display.render
      end_sq = @display.get_input
    end

    puts "#begin: {begin_sq} and end:#{end_sq}"
    board.move(begin_sq, end_sq)
  end

  def next_player
    current_player == black_player ? current_player = white_player : current_player = white_player
  end


end

if __FILE__ == $PROGRAM_NAME
  Game.new("White", "Black").play
end
