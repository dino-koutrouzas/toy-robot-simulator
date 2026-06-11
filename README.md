# Toy Robot Simulator
The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.
## Getting Started

* **Ruby:** `4.0.3` (Specified in `.ruby-version` and `Gemfile`)

This project uses a `.ruby-version` file. If you use a Ruby version manager like `rbenv`, `rvm`, or `asdf`, your terminal will automatically switch to the correct version when you enter the project directory.

- Install the dependencies: `bundle install`
- Run the application: `ruby app.rb`
- Run the tests: `bin/rspec --format documentation`

## Using the application
Valid commands:

```
PLACE X,Y,F
MOVE
LEFT
RIGHT
REPORT
```

PLACE will put the toy robot on the table in position X,Y and facing NORTH, SOUTH,
EAST or WEST. e.g. `PLACE 0,0,NORTH`. The origin (0,0) is the SOUTH WEST most corner.

MOVE will move the toy robot one unit forward in the direction it is currently facing.

LEFT AND RIGHT rotate the robot 90 degrees in the specified direction.

REPORT prints the current pose of the robot.

## Approach

`Simulation` is the top level class which processes commands from the user. Based on the command input, it calls relevant instance methods, which are individually unit tested.

`Simulation` is initialised with a `Grid` which holds configuration for the dimensions of the table.

`Pose` holds the x, y co-ordinates and facing position, and knows how to create new poses relative to its own state.

`Simulation` works by tracking the `@current_pose`, which starts as `nil`. When a valid command is received, `Simulation` updates the current pose. When receiving the `PLACE` command, it creates a new `Pose` with the given parameters. When receving `MOVE`, `LEFT`, and `RIGHT`, it uses `Pose` to generate the next pose and replace the current pose. These are called as class methods on `Pose` to help signal that a new objects are being returned, with the benefit of being easily stubbed in the unit tests. `REPORT` prints the string representation of the current pose.

Before placing a `Pose`, `Simulation` asks `Grid` whether the pose is placeable, and returns if not. `Grid` uses it's dimensions to understand if the pose is within its own bounds.

If the parameters provided to `place` are invalid, or a `pose` is not placeable, the current pose is not updated.

## Further Development

Given more time, the main changes I would make would be to track a history of (valid and invalid) commands and poses rather than just updating the current pose, and to add detail about the success or failure (with reasons) of the commands. Although not part of the current requirements, this would aid developers in understanding and debuging behaviour, and also could conceivably be useful to the end user in the future.

Furthermore, I would likely separate the text based command processing from the `Simulation` class itself, as it is a standalone class that can be used independently from the specified format. I would also spend a bit more time on formalising and testing user input and `Pose` validation.
