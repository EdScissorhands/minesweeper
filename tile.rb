class Tile

  attr_accessor :value
  attr_reader :bomb, :revealed, :flagged

  def initialize(bomb = false)
    @bomb = bomb
    @flagged = false
    @revealed = false
  end

  def self.generate_tiles(size, bombs)
    tiles = []
    (size ** 2).times do |i|
      bomb = (i < bombs ? true : false)
      tiles << Tile.new(bomb)
    end
    tiles.shuffle
  end

  def flag
    if revealed
      puts "Can't flag a revealed tile."
      return
    end
    @flagged = !@flagged
  end

  def reveal
    @revealed = true
  end

end
