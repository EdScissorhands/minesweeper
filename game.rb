require_relative 'board'

class Game

  def initialize(size = 9)
    @board = Board.new(size)
  end

  def play_turn
    system("clear")
    board.render
    pos = get_pos
    val = get_val
    val == "f" ? board.flag(pos) : board.reveal(pos)
  end

  def get_pos
    pos = nil
    until pos && valid_pos?(pos)
      print "Enter co-ordinance: "
      begin
        pos = parse_pos(gets.chomp)
      rescue
        puts "ugh you idiot"
        pos = nil
      end
    end
    pos
  end

  def get_val
    print "Enter 'f' to flag or nothing to reveal: "
    gets.chomp
  end

  def parse_pos(string)
    string.split(" ").map { |c| Integer(c) }
  end

  def run
    play_turn until over?
    # print win or lose
  end

  def over?
    # see if its done
  end

  def valid_pos?(pos)
    return false unless pos.length == 2
    pos.all? { |el| el.between?(0, board.size - 1)}
  end

  attr_reader :board

end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.run
end
