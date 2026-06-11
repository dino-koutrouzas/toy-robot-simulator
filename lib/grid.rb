class Grid
  attr_reader :width, :height

  def initialize(width:, height:)
    @width = width
    @height = height
  end

  def placeable?(pose)
    pose.x <= @width &&
      pose.y <= @height
  end
end
