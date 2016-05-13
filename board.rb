require_relative 'tile'
require 'colorize'

class Board

  attr_accessor :grid

  def initialize(size)
    @grid = generate_grid(size)
    assign_values
  end

  def generate_grid(size)
    tiles = Tile.generate_tiles(size)
    Array.new(size) { Array.new(size) { tiles.pop } }
  end

  def assign_values
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |tile, tile_idx|
        next if tile.bomb
        neighbors = neighbor_positions([row_idx, tile_idx]).map { |pos| self[pos] }
        tile.value = neighbors.count { |x| x.bomb }
      end
    end
  end

  def neighbor_positions(pos)
    x, y = pos
    neighbors = []
    (-1..1).each do |dx|
      (-1..1).each do |dy|
        next if dx == 0 && dy == 0
        x2 = x + dx
        y2 = y + dy
        unless x2 < 0 || y2 < 0 ||
          x2 >= size || y2 >= size
          neighbors << [x2, y2]
        end
      end
    end
    neighbors
  end

  def size
    grid.length
  end

  def render
    puts "  #{(0...size).to_a.join(" ")}".light_blue
    grid.each_with_index do |row, idx|
      print "#{idx} ".light_blue
      row.each do |tile|
        print tile.flagged ? "f" : !tile.revealed ? "#" : tile.value > 0 ? tile.value : " "
        print " "
      end
      puts
    end
  end

  def flag(pos)
    self[pos].flag
  end

  def reveal(pos)
    p pos
    # return if self[pos].flagged
    current_tile = self[pos]
    current_tile.reveal
    if current_tile.value == 0
      neighbor_positions(pos).each { |new_pos| reveal(new_pos) unless self[new_pos].revealed }
    end
  end

  def [](pos)
    a, b = pos
    grid[a][b]
  end

  def []=(pos, val)
    a, b = pos
    grid[a][b] = val
  end

end
