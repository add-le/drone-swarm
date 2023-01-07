
# Drone Swarm

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://github.com/add-le/drone-swarm/blob/main/LICENCE)
[![Language GDScript](https://img.shields.io/badge/Language-GDScript-blue.svg)](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html)
[![Engine Godot](https://img.shields.io/badge/Engine-Godot-red.svg)](https://godotengine.org/en)


Simulation of multi-agent systems using drone swarm behavior.


## Features

- Group training mode
- Disaggregated attraction mode
- Manual objective position
- Behavior inside the swarm


## Installation

1. Download Godot Engine

`https://godotengine.org/download`

2. Download the project
```bash
gh repo clone add-le/drone-swarm
git checkout main
```

3. Open the `project.godot` file in `Godot Engine` with `Import` function
    
## Usage

- `mouse0`: Set the position of the objective in the 3D world. \
- `mouse1`: Control the camera in the world with :
    - `up` `down` `left` `right`: move around in the scene
    - `wheelUp` `wheelDown`: zoom in and zoom out
    - `mouse3`: hold to freely rotate on yourself the camera
- `a`: toggle between the two defaults modes

Click somewhere on the scene to see the swarm begins to look at the right direction and after that they should start to move and slide to the point. \
They will create a circle around the center point, and use behavior inside the swarm to not collide each others. \
If you use the other mode, they will try to not go on the selected point or the new objective, and start their patrol.

## Authors

- [@add-le](https://github.com/add-le)
- [@axlkgs](https://github.com/axlkgs)
- [@wih](#)


## License

[GPL v3](https://github.com/add-le/drone-swarm/blob/main/LICENCE)

