require 'bundler/setup'
Bundler.require(:default)

require_relative 'lib/simulation'

def run
  simulation = Simulation.new(grid: Grid.new(height: 5, width: 5))

  loop do
    print "Enter text (type 'exit' to quit): "
    input = gets.chomp

    break if input == 'exit'

    simulation.process_command(input)
  end
end

run
