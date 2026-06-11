require_relative 'grid'
require_relative 'pose'

class Simulation
  attr_reader :current_pose, :grid

  def initialize(grid:)
    @grid = grid
    @current_pose = nil
  end

  def process_command(input)
    command, args = input.split(' ')

    case command
    when 'MOVE', 'LEFT', 'RIGHT'
      send(command.downcase)
    when 'PLACE'
      return unless args

      place_args = args.split(',')

      x = place_args[0].to_i
      y = place_args[1].to_i
      f = place_args[2]
      place(x:, y:, f:)
    when 'REPORT'
      result = send(command.downcase)
      puts result if result
    end
  end

  def place(x:, y:, f:)
    pose = Pose.new(x:, y:, f:)
    return unless pose.valid?

    set_current_pose(pose)
  end

  def move
    return unless placed?

    pose = Pose.next_pose(current_pose)
    set_current_pose(pose)
  end

  def left
    return unless placed?

    pose = Pose.rotated_left(current_pose)
    set_current_pose(pose)
  end

  def right
    return unless placed?

    pose = Pose.rotated_right(current_pose)
    set_current_pose(pose)
  end

  def report
    return unless placed?

    current_pose.to_s
  end

  private

  def set_current_pose(pose)
    return unless placeable?(pose)

    @current_pose = pose
  end

  def placeable?(pose)
    grid.placeable?(pose)
  end

  def placed?
    !!current_pose
  end
end
