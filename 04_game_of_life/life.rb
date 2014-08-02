class Board
  attr_reader :matrix

  def initialize(input)
    @matrix = []
    input.split(" ").each do |row|
      @matrix << row.split("").map(&:to_i).map {|val| Cell.new(val)}
    end
  end

  def next_step
    new_matrix = []

    @matrix.each_with_index do |row, y|
      new_matrix << []
      row.each_with_index do |cell, x|
        neighbors = neighbors_living(y, x)

        if neighbors < 2
          new_matrix[y] << Cell.new(0)

        elsif neighbors < 4 && cell.alive 
          new_matrix[y] << Cell.new(1)

        elsif neighbors == 3 && !cell.alive
          new_matrix[y] << Cell.new(1) 

        elsif neighbors > 3 && cell.alive
          new_matrix[y] << Cell.new(0)

        else
          new_matrix[y] << Cell.new(0)
        end 
      end
    end
    @matrix = new_matrix
    print_board
  end

  def neighbors_living(y, x)
    number_of_neighbors = 0
    [[-1, 0], [1, 0], 
     [-1, 1], [0, 1], [1, 1], 
     [-1, -1], [0, -1], [1, -1] 
    ].each do |pos|
      row = y + pos[1]
      col = x + pos[0]
      if valid_coordinate?(row, col)
        number_of_neighbors += 1 if @matrix[row][col].alive
      end
    end
    number_of_neighbors
  end

  def valid_coordinate?(y, x)
    if y >= 0 && y < @matrix.length && x >= 0 && x < @matrix.length
      true
    else
      false
    end
  end

  def print_board
    @matrix.each do |row|
      string = ""
      row.each do |cell|
        cell.alive ? string << "1".rjust(2) : string << "0".rjust(2)
      end
      puts string
    end
    puts "\n"
  end
end

class Cell
  attr_accessor :alive
  def initialize(value)
    value == 1 ? @alive = true : @alive = false 
  end
end

board = Board.new("01000 10011 11001 01000 10001")
puts "first iteration"
board.print_board
puts "second iteration"
board.next_step
