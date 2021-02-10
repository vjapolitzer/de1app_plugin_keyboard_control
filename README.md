# de1app plugin - keyboard_control
Control your non-GHC DE1 with a keyboard!

## Usage
When enabled and used in conjunction with a keyboard:  
- Press `e` to start espresso.
    - Press `e` (or `s`) to stop. ~~Press `w` or `f` to move to next step in advanced profile.~~ (Not yet working in de1app)
- Press `s` to start steaming
    - Press `s` (or `e`, `w`, or `f`) to stop.
- Press `w` to start hot water
    - Press `w` (or `e`, `s`, or `f`) to stop.
- Press `f` to start flushing
    - Press `f` (or `e`, `s`, or `w`) to stop.  
    
The functions can be configured to different letter keys in the extension settings page.

NOTE: The function that keeps the navbar hidden may also block keypresses. If this is the case for you, using the `ctrl` modifier may work as a hack to get the keypress through. i.e. `ctrl+e` to start (or stop) an espresso. This may not work with non-letter keys, so the plugin currently only supports letter keys.

## Installation
Requires de1app V1.34 or newer!  
1. Exit the de1app on your tablet
1. Plug your tablet into your computer
1. Download and place the `keyboard_control` folder and its contents into `de1plus/plugins/` on your tablet
1. Launch the de1app on your tablet
1. Go to Settings --> App --> Extensions --> Select the keyboard_control plugin
1. Exit and restart the de1app
1. With a keyboard connected, try the commands outlined in the section above!
