require 'pose'

RSpec.describe Pose do
  describe '#next_pose' do
    context 'when facing NORTH' do
      let(:pose) { Pose.new(x: 0, y: 0, f: 'NORTH') }

      it 'returns a new pose incrementing the y axis' do
        expect(pose.next_pose).to eq(Pose.new(x: 0, y: 1, f: 'NORTH'))
      end
    end

    context 'when facing SOUTH' do
      let(:pose) { Pose.new(x: 0, y: 5, f: 'SOUTH') }

      it 'reutrns a new pose decremeneting the y axis' do
        expect(pose.next_pose).to eq(Pose.new(x: 0, y: 4, f: 'SOUTH'))
      end
    end

    context 'when facing EAST' do
      let(:pose) { Pose.new(x: 0, y: 0, f: 'EAST') }

      it 'reutrns a new pose incrementing the x axis' do
        expect(pose.next_pose).to eq(Pose.new(x: 1, y: 0, f: 'EAST'))
      end
    end

    context 'when facing WEST' do
      let(:pose) { Pose.new(x: 5, y: 0, f: 'WEST') }

      it 'reutrns a new pose decrementing the x axis' do
        expect(pose.next_pose).to eq(Pose.new(x: 4, y: 0, f: 'WEST'))
      end
    end
  end

  describe '#rotated_left' do
    context 'when facing NORTH' do
      let(:pose) { Pose.new(x: 0, y: 0, f: 'NORTH') }

      it 'returns a new pose facing WEST' do
        expect(pose.rotated_left).to eq(Pose.new(x: 0, y: 0, f: 'WEST'))
      end
    end

    context 'when facing SOUTH' do
      let(:pose) { Pose.new(x: 0, y: 0, f: 'SOUTH') }

      it 'reutrns a new pose facing EAST' do
        expect(pose.rotated_left).to eq(Pose.new(x: 0, y: 0, f: 'EAST'))
      end
    end

    context 'when facing EAST' do
      let(:pose) { Pose.new(x: 0, y: 0, f: 'EAST') }

      it 'reutrns a new pose facing NORTH' do
        expect(pose.rotated_left).to eq(Pose.new(x: 0, y: 0, f: 'NORTH'))
      end
    end

    context 'when facing WEST' do
      let(:pose) { Pose.new(x: 0, y: 0, f: 'WEST') }

      it 'reutrns a new pose facing SOUTH' do
        expect(pose.rotated_left).to eq(Pose.new(x: 0, y: 0, f: 'SOUTH'))
      end
    end
  end

  describe '#rotated_right' do
    context 'when facing NORTH' do
      let(:pose) { Pose.new(x: 0, y: 0, f: 'NORTH') }

      it 'returns a new pose facing EAST' do
        expect(pose.rotated_right).to eq(Pose.new(x: 0, y: 0, f: 'EAST'))
      end
    end

    context 'when facing SOUTH' do
      let(:pose) { Pose.new(x: 0, y: 0, f: 'SOUTH') }

      it 'reutrns a new pose facing WEST' do
        expect(pose.rotated_right).to eq(Pose.new(x: 0, y: 0, f: 'WEST'))
      end
    end

    context 'when facing EAST' do
      let(:pose) { Pose.new(x: 0, y: 0, f: 'EAST') }

      it 'reutrns a new pose facing SOUTH' do
        expect(pose.rotated_right).to eq(Pose.new(x: 0, y: 0, f: 'SOUTH'))
      end
    end

    context 'when facing WEST' do
      let(:pose) { Pose.new(x: 0, y: 0, f: 'WEST') }

      it 'reutrns a new pose facing NORTH' do
        expect(pose.rotated_right).to eq(Pose.new(x: 0, y: 0, f: 'NORTH'))
      end
    end
  end

  describe '#to_s' do
    let(:pose_a) { Pose.new(x: 0, y: 0, f: 'NORTH') }
    let(:pose_b) { Pose.new(x: 4, y: 5, f: 'SOUTH') }

    it 'shows x, y and f' do
      expect(pose_a.to_s).to eq('0,0,NORTH')
      expect(pose_b.to_s).to eq('4,5,SOUTH')
    end
  end

  describe '#==' do
    let(:pose) { Pose.new(x: 0, y: 0, f: 'NORTH') }

    subject { pose == other_pose }

    context 'when x, y and f match' do
      let(:other_pose) { Pose.new(x: 0, y: 0, f: 'NORTH') }

      it { is_expected.to be true }
    end

    context 'when x does not match' do
      let(:other_pose) { Pose.new(x: 1, y: 0, f: 'NORTH') }

      it { is_expected.to be false }
    end

    context 'when y does not match' do
      let(:other_pose) { Pose.new(x: 0, y: 1, f: 'NORTH') }

      it { is_expected.to be false }
    end

    context 'when f does not match' do
      let(:other_pose) { Pose.new(x: 0, y: 0, f: 'SOUTH') }

      it { is_expected.to be false }
    end
  end
end
