require "./lib/robot"
class GameController

  def self.start
    puts "Please enter 'PLACE X,Y,F' to start the game"
    placed = gets.chomp
    validate_start(placed)
  end

  def self.validate_start(placed)
    until placed.match(/PLACE\s[01234]\,[01234]\,(NORTH|SOUTH|EAST|WEST)/)
      puts "You must enter 'PLACE X,Y,F' with valid table positions to start the game"
      placed = gets.chomp
    end
    create_position(placed)
  end

  def self.create_position(placed)
    position = placed.split(" ")[1]
    position = position.split(",")
    Robot.create_robot(position)
  end

  def self.instructions(robot)
    puts "What would you like your robot to do?"
    puts "Enter 'MOVE' to move your robot forward one square"
    puts "Enter 'LEFT' to turn your robot to the left by 90 degrees in place"
    puts "Enter 'RIGHT' to turn your robot to the right by 90 degrees in place"
    puts "Enter 'REPORT' to find out where your robot is standing"
    puts "Enter 'EXIT' to leave the simulation"
    move = gets.chomp
    if move == "EXIT"
      return
    end
    robot.act_on_instructions(move)
  end
end
