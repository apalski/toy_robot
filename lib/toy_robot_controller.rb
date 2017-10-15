require "./lib/robot"
class ToyRobotController

  private

  def self.start
    puts "Please enter 'PLACE X,Y,F' to start the game"
    placed = gets.strip
    validate_start(placed)
  end

  def self.validate_start(placed)
    until placed.match(/PLACE\s[01234]\,[01234]\,(NORTH|SOUTH|EAST|WEST)/)
      puts "You must enter 'PLACE X,Y,F' to start the game"
      placed = gets.strip
    end
    create(placed)
  end

  def self.create(placed)
    position_info = placed.split(" ")[1]
    position_info = position_info.split(",")
    @robot = Robot.new([position_info[0].to_i, position_info[1].to_i, position_info[2]])
    instructions
  end

  def self.instructions
    puts "What would you like your robot to do?"
    puts "Enter 'MOVE' to move your robot forward one square"
    puts "Enter 'LEFT' to turn your robot to the left by 90 degrees in place"
    puts "Enter 'RIGHT' to turn your robot to the right by 90 degrees in place"
    puts "Enter 'REPORT' to find out where your robot is standing"
    puts "Enter 'EXIT' to leave the simulation"
    move = gets.chomp
    act_on_instructions(move)
  end

  def self.act_on_instructions(move)
    case
    when move.match(/MOVE/) then Robot.move_robot_forward(@robot)
    when move.match(/PLACE\s\d\,\d\,(NORTH|SOUTH|EAST|WEST)/)
      position_info = move.split(" ")[1]
      position_info = position_info.split(",")
      @robot.current_position = [position_info[0].to_i, position_info[1].to_i, position_info[2]]
      instructions
    when move.match(/REPORT/) then Robot.report_position(@robot)
    when move.match(/EXIT/) then return
    else Robot.turn_robot(move, @robot)
    end
  end
end
