require 'grid'
require 'pose'
require 'simulation'

RSpec.describe Simulation do
  let(:simulation) { Simulation.new(grid:) }

  describe 'full simulation' do
    let(:grid) { Grid.new(width: 5, height: 5) }

    it 'places, moves, rotates and reports' do
      simulation.process_command('PLACE 0,0,NORTH')
      simulation.process_command('MOVE')
      expect { simulation.process_command('REPORT').to output('0,1,NORTH').to_stdout }
      simulation.process_command('PLACE 0,0,NORTH')
      simulation.process_command('LEFT')
      expect { simulation.process_command('REPORT').to output('0,0,WEST').to_stdout }
      simulation.process_command('PLACE 1,2,EAST')
      simulation.process_command('MOVE')
      simulation.process_command('MOVE')
      simulation.process_command('LEFT')
      simulation.process_command('MOVE')
      expect { simulation.process_command('REPORT').to output('3,3,NORTH').to_stdout }
    end
  end

  describe 'instance methods' do
    let(:grid) { instance_double Grid }

    before { allow(grid).to receive(:placeable?).and_return(true) }

    describe '#report' do
      context 'for an empty simulation' do
        it { expect(simulation.report).to eq(nil) }
      end

      context 'with a placed robot' do
        before { simulation.place(x: 3, y: 4, f: 'NORTH') }

        it 'reports the current pose' do
          expect(simulation.report).to eq('3,4,NORTH')
        end
      end
    end

    describe '#place' do
      let(:x) { 5 }
      let(:y) { 5 }
      let(:f) { 'NORTH' }

      context 'when within the bounds of the grid' do
        let(:grid) { instance_double Grid }

        before { allow(grid).to receive(:placeable?).and_return(true) }

        it 'places the pose' do
          simulation.place(x:, y:, f:)
          expect(simulation.current_pose).to eq(Pose.new(x:, y:, f:))
        end

        context 'with an existing pose' do
          before { simulation.place(x: 0, y: 0, f: 'SOUTH') }

          it 'replaces the pose' do
            simulation.place(x:, y:, f:)
            expect(simulation.current_pose).to eq(Pose.new(x:, y:, f:))
          end
        end
      end

      context 'when out of the bounds of the grid' do
        before do
          allow(grid).to receive(:placeable?).and_return(false)
        end

        it 'does not place the pose' do
          simulation.place(x:, y:, f:)
          expect(simulation.current_pose).to eq(nil)
        end

        context 'with an existing pose' do
          before do
            allow(grid).to receive(:placeable?).and_return(true, false)
            simulation.place(x: 0, y: 0, f: 'SOUTH')
          end

          it 'does not replace the pose' do
            simulation.place(x:, y:, f:)
            expect(simulation.current_pose).to eq(Pose.new(x: 0, y: 0, f: 'SOUTH'))
          end
        end
      end

      context 'with invalid args' do
        let(:x) { 5 }
        let(:y) { 5 }
        let(:f) { 'WOW' }

        it 'does not place the pose' do
          simulation.place(x:, y:, f:)
          expect(simulation.current_pose).to eq(nil)
        end
      end
    end

    describe '#move' do
      context 'without an existing pose' do
        it 'does not change the current pose' do
          simulation.move
          expect(simulation.current_pose).to eq(nil)
        end
      end

      context 'with an existing pose' do
        before do
          allow(Pose).to receive(:next_pose).and_return(next_pose)
          simulation.place(x: 0, y: 0, f: 'NORTH')
        end

        let(:next_pose) { Pose.new(x: 0, y: 1, f: 'NORTH') }

        it 'does replace the current pose' do
          simulation.move
          expect(simulation.current_pose).to eq(next_pose)
        end
      end
    end

    describe '#left' do
      context 'without an existing pose' do
        it 'does not change the current pose' do
          simulation.left
          expect(simulation.current_pose).to eq(nil)
        end
      end

      context 'with an existing pose' do
        before do
          allow(Pose).to receive(:rotated_left).and_return(rotated_pose)
          simulation.place(x: 0, y: 0, f: 'NORTH')
        end

        let(:rotated_pose) { Pose.new(x: 0, y: 1, f: 'NORTH') }

        it 'does replace the current pose' do
          simulation.move
          expect(simulation.current_pose).to eq(rotated_pose)
        end
      end
    end

    describe '#right' do
      context 'without an existing pose' do
        it 'does not change the current pose' do
          simulation.right
          expect(simulation.current_pose).to eq(nil)
        end
      end

      context 'with an existing pose' do
        before do
          allow(Pose).to receive(:rotated_right).and_return(rotated_pose)
          simulation.place(x: 0, y: 0, f: 'NORTH')
        end

        let(:rotated_pose) { Pose.new(x: 0, y: 1, f: 'NORTH') }

        it 'does replace the current pose' do
          simulation.move
          expect(simulation.current_pose).to eq(rotated_pose)
        end
      end
    end
  end
end
