class SpiralMaker
  def initialize
    @directions = {
      :right => [0, 1],
      :down => [1, 0],
      :left => [0, -1],
      :up => [-1, 0]
    }

    @counters = {
      :x_counter => 0,
      :y_counter => 0
    }

    @max_length = 1
    @current_direction = :right
    @current_counter = :x_counter
  end

  def make_spiral(input)
    matrix_size = determine_matrix_size(input)
    matrix = populate_matrix(matrix_size)

    #finds the center coordinates
    if matrix_size % 2 == 0
      x = (matrix_size / 2) - 1 
      y = (matrix_size / 2) - 1
    else
      x = (matrix_size / 2)
      y = (matrix_size / 2)
    end

    matrix[y][x] = 0

    1.upto(input) do |number|
      x += @directions[@current_direction][1]
      y += @directions[@current_direction][0]

      matrix[y][x] = number

      @counters[@current_counter] += 1

      if @counters[@current_counter] == @max_length
        change_direction
        switch_counter
      end

      if @counters[:y_counter] == @max_length
        @max_length += 1 
        @counters[:x_counter] = 0
        @counters[:y_counter] = 0
      end
    end
    print_spiral(matrix)
  end

  def determine_matrix_size(input)
    matrix_size = 0
    until matrix_size ** 2 > input + 1 do
      matrix_size += 1
    end
    matrix_size
  end

  def populate_matrix(matrix_size)
    matrix = []
    matrix_size.times do
      row = []
      matrix_size.times do 
        row << -1
      end
      matrix << row
    end
    matrix
  end

  def change_direction
    case @current_direction
    when :right
      @current_direction = :down
    when :down
      @current_direction = :left
    when :left
      @current_direction = :up
    when :up
      @current_direction = :right
    end
  end

  def switch_counter
    if @current_counter == :x_counter
      @current_counter = :y_counter
    elsif @current_counter == :y_counter
      @current_counter = :x_counter
    end
  end

  def print_spiral(matrix)
    matrix.each do |row|
      new_string = ""
      row.each do |val|
        if val == -1
          new_string << ".".rjust(4)
        else
          new_string << val.to_s.rjust(4)
        end 
      end
      p new_string
    end
  end
end

apple = SpiralMaker.new
apple.make_spiral(32)

