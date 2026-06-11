require 'grid'
require 'pose'

RSpec.describe Grid do
  let(:grid) { described_class.new(width: 5, height: 5) }

  describe '#placeable?' do
    context 'when within the bounds of the grid' do
      let(:pose) { Pose.new(x: 5, y: 5, f: 'NORTH') }

      it { expect(grid.placeable?(pose)).to be true }
    end

    context 'when not within the bounds of the grid (x)' do
      let(:pose) { Pose.new(x: 6, y: 5, f: 'NORTH') }

      it { expect(grid.placeable?(pose)).to be false }
    end

    context 'when not within the bounds of the grid (y)' do
      let(:pose) { Pose.new(x: 5, y: 6, f: 'NORTH') }

      it { expect(grid.placeable?(pose)).to be false }
    end
  end
end
