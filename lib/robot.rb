class Robot

  attr_accessor :current_position

  def initialize(current_position)
    @current_position = current_position
  end

  private

  def self.move_robot_forward(robot)
    table_edges(robot)
    case
    when robot.current_position[2] == "NORTH"
      robot.current_position[1] = robot.current_position[1] + 1
    when robot.current_position[2] == "SOUTH"
      robot.current_position[1] = robot.current_position[1] - 1
    when robot.current_position[2] == "EAST"
      robot.current_position[0] = robot.current_position[0] + 1
    when robot.current_position[2] == "WEST"
      robot.current_position[0] = robot.current_position[0] - 1
    end
    ToyRobotController.instructions
  end

  def self.turn_robot(direction, robot)
    if direction.match(/LEFT/)
      turn_robot_left(robot)
    else
      turn_robot_right(robot)
    end
  end

  def self.turn_robot_left(robot)
    case
    when robot.current_position[2] == "NORTH"
      robot.current_position[2] = "WEST"
    when robot.current_position[2] == "SOUTH"
      robot.current_position[2] = "EAST"
    when robot.current_position[2] == "EAST"
      robot.current_position[2] = "NORTH"
    when robot.current_position[2] == "WEST"
      robot.current_position[2] = "SOUTH"
    end
    ToyRobotController.instructions
  end

  def self.turn_robot_right(robot)
    case
    when robot.current_position[2] == "NORTH"
      robot.current_position[2] = "EAST"
    when robot.current_position[2] == "SOUTH"
      robot.current_position[2] = "WEST"
    when robot.current_position[2] == "EAST"
      robot.current_position[2] = "SOUTH"
    when robot.current_position[2] == "WEST"
      robot.current_position[2] = "NORTH"
    end
    ToyRobotController.instructions
  end

  def self.report_position(robot)
    puts "#{robot.current_position[0]},#{robot.current_position[1]},#{robot.current_position[2]}"
    ToyRobotController.instructions
  end

  def self.table_edges(robot)
    table_edge_north = (robot.current_position[1] == 4 && robot.current_position[2] == "NORTH")
    table_edge_south = (robot.current_position[1] == 0 && robot.current_position[2] == "SOUTH")
    table_edge_east = (robot.current_position[0] == 4 && robot.current_position[2] == "EAST")
    table_edge_west = (robot.current_position[0] == 0 && robot.current_position[2] == "WEST")

    if (table_edge_north || table_edge_south || table_edge_east || table_edge_west)
      puts "You can't move the toy robot off the table"
      ToyRobotController.instructions
    end
  end
end
