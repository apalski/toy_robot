require "spec_helper"
require "./lib/game_controller"
require "./lib/robot"

describe "robot" do

  let(:robot) { Robot.new([1,2,"SOUTH"]) }

  it "it can be instantiated with a current position" do
    expect(robot).to be_a Robot
  end

  describe "move_robot_forward" do

    it "can move the robot forward one position" do
      expect(GameController).to receive(:gets).and_return("EXIT")
      robot.move_robot_forward

      expect(robot.current_position).to eq([1,1,"SOUTH"])
    end
  end

  describe "turn_robot_left" do
    it "can turn the robot to the left" do
      expect(GameController).to receive(:gets).and_return("EXIT")
      robot.turn_robot_left
      expect(robot.current_position).to eq([1,2,"EAST"])
    end
  end

  describe "turn_robot_right" do
    it "can turn the robot to the right" do
      expect(GameController).to receive(:gets).and_return("EXIT")
      robot.turn_robot_right
      expect(robot.current_position).to eq([1,2,"WEST"])
    end
  end

  describe "report_position" do
    it "reports the robots current position" do
      expect(GameController).to receive(:gets).and_return("EXIT")
      robot.report_position
      expect(GameController).to receive(:gets).and_return("EXIT")
      expect { robot.report_position }.to output( a_string_including("1,2,SOUTH")).to_stdout
    end
  end
end
