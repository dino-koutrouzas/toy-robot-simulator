class Pose
  CARDINAL_AXES = {
    'NORTH' => %i[y +],
    'EAST' => %i[x +],
    'SOUTH' => %i[y -],
    'WEST' => %i[x -]
  }

  CARDINALS = CARDINAL_AXES.keys

  attr_reader :x, :y, :f

  def self.next_pose(pose) = pose.next_pose
  def self.rotated_left(pose) = pose.rotated_left
  def self.rotated_right(pose) = pose.rotated_right

  def initialize(x:, y:, f:)
    @x = x
    @y = y
    @f = f
  end

  def ==(other)
    x == other.x &&
      y == other.y &&
      f == other.f
  end

  def to_s
    "#{x},#{y},#{f}"
  end

  def valid?
    CARDINALS.include?(f) &&
      [x, y].all? { |axis| axis.is_a?(Integer) && axis >= 0 }
  end

  def next_pose
    axis, variation = CARDINAL_AXES[f]
    new_axis_value = send(axis).send(variation, 1)
    next_attrs = attrs.merge(axis => new_axis_value)
    self.class.new(**next_attrs)
  end

  def rotated_left
    rotated(:-)
  end

  def rotated_right
    rotated(:+)
  end

  private

  def attrs
    { x:, y:, f: }
  end

  def rotated(variation)
    current_index = CARDINALS.index(f)
    new_index = current_index.send(variation, 1) % CARDINALS.size
    new_cardinal_value = CARDINALS[new_index]
    rotated_attrs = attrs.merge(f: new_cardinal_value)
    self.class.new(**rotated_attrs)
  end
end
