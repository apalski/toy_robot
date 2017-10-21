class Robot

  attr_accessor :current_position

  def initialize(current_position)
    @current_position = current_position
  end

  def act_on_instructions(move)
    case
    when move.match(/MOVE/) then move_robot_forward
    when move.match(/PLACE\s\d\,\d\,(NORTH|SOUTH|EAST|WEST)/)
      position_info = move.split(" ")[1]
      position_info = position_info.split(",")
      self.current_position = [position_info[0].to_i, position_info[1].to_i, position_info[2]]
      instructions
    when move.match(/REPORT/) then report_position
    else turn_robot(move)
    end
  end

  def move_robot_forward
    self.table_edges
    case
    when self.current_position[2] == "NORTH"
      self.current_position[1] = self.current_position[1] + 1
    when self.current_position[2] == "SOUTH"
      self.current_position[1] = self.current_position[1] - 1
    when self.current_position[2] == "EAST"
      self.current_position[0] = self.current_position[0] + 1
    when self.current_position[2] == "WEST"
      self.current_position[0] = self.current_position[0] - 1
    end
    GameController.instructions
  end

  def turn_robot(direction)
    if direction.match(/LEFT/)
      self.turn_robot_left
    else
      self.turn_robot_right
    end
  end

  def turn_robot_left
    case
    when self.current_position[2] == "NORTH"
      self.current_position[2] = "WEST"
    when self.current_position[2] == "SOUTH"
      self.current_position[2] = "EAST"
    when self.current_position[2] == "EAST"
      self.current_position[2] = "NORTH"
    when self.current_position[2] == "WEST"
      self.current_position[2] = "SOUTH"
    end
    GameController.instructions
  end

  def turn_robot_right
    case
    when self.current_position[2] == "NORTH"
      self.current_position[2] = "EAST"
    when self.current_position[2] == "SOUTH"
      self.current_position[2] = "WEST"
    when self.current_position[2] == "EAST"
      self.current_position[2] = "SOUTH"
    when self.current_position[2] == "WEST"
      self.current_position[2] = "NORTH"
    end
    GameController.instructions
  end

  def report_position
    puts "#{self.current_position[0]},#{self.current_position[1]},#{self.current_position[2]}"
    GameController.instructions
  end

  def table_edges
    table_edge_north = (self.current_position[1] == 4 && self.current_position[2] == "NORTH")
    table_edge_south = (self.current_position[1] == 0 && self.current_position[2] == "SOUTH")
    table_edge_east = (self.current_position[0] == 4 && self.current_position[2] == "EAST")
    table_edge_west = (self.current_position[0] == 0 && self.current_position[2] == "WEST")

    if (table_edge_north || table_edge_south || table_edge_east || table_edge_west)
      puts "You can't move the toy robot off the table"
      GameController.instructions
    end
  end
end
