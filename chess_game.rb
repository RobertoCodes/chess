require_relative 'chess_board.rb'
require_relative 'chess_piece.rb'
require_relative 'chess_display.rb'
require_relative 'chess_game.rb'

class Game

  attr_accessor :board, :display, :current_player

  def initialize
    @board = Board.new
    @current_player = :white
    @display = Display.new(@board)
  end

  def play
    until board.checkmate?
      take_turn
      next_player
      @display.render
    end

    next_player

    system("clear")
    @display.render

    puts "CHECKMATE. #{current_player} wins!"

  end

  def take_turn

    @display.render

    begin
      begin_sq = nil
      until begin_sq
        system("clear")

        print "White, " if current_player == :white
        print "Black, " if current_player == :black
        print "use the cursor to select a start position and hit enter."
        puts

        @display.render
        begin_sq = @display.get_input
      end

      end_sq = nil
      until end_sq
        system("clear")

        print "White, " if current_player == :white
        print "Black, " if current_player == :black
        print "use the cursor to select an end position and hit enter."
        puts

        @display.render
        end_sq = @display.get_input
      end


      if board[begin_sq].color != self.current_player
        raise "Not your turn."
      else
        board.move(begin_sq, end_sq)
      end
    rescue RuntimeError, ArgumentError => e
      puts "Not a valid move, friend."
      sleep(2)
      retry
    end

  end

  def next_player
    self.current_player == :black ? self.current_player = :white : self.current_player = :black
  end


end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
