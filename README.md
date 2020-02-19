# CS:GO Keyframe Smoothing Script
[![ver][]](https://github.com/samisalreadytaken/keyframes)

Create professional smooth cameras live in-game, in mere seconds.

You can manipulate any keyframe at any time. You can save your keyframes, or your compiled paths to come back to them at a later time.

[ver]: https://img.shields.io/badge/keyframes-v1.1.1-informational
[![](https://img.shields.io/badge/Video_demonstration-red?logo=youtube)](https://www.youtube.com/watch?v=pc1wvx5LUog)

## Installation
Merge the `/csgo/` folder with your `/steamapps/common/Counter-Strike Global Offensive/csgo/` folder.

This only adds 8 files to your /csgo/ folder. It does not overwrite any game files, and it does not interfere with the game in any way. It is VAC safe, and you can only use this script on your own server.

### Downloading
**Method 1.**
Manually download the repo by clicking [**HERE**](https://github.com/samisalreadytaken/keyframes/archive/master.zip). Then extract the folder.

**Method 2.**
On Windows 10 17063 or later, run the [`install_keyframes.bat`](https://raw.githubusercontent.com/samisalreadytaken/keyframes/master/install_keyframes.bat) file to automatically download the script into your game files. You can also use it to update the script.

**Method 3.**
Using bash, after changing the directory below to your Steam directory, use the following commands to install the script into your game files.
```
cd "C:/Program Files/Steam/steamapps/common/Counter-Strike Global Offensive/" && 
curl https://codeload.github.com/samisalreadytaken/keyframes/tar.gz/master | tar -xz --strip=1 keyframes-master/csgo
```

## Usage
Use the console commands to load and control the script. You need to load it each time you change the map.

Optionally, bind your keys to improve your workflow. You can find some examples at the bottom of the [keyframes.cfg](csgo/cfg/keyframes.cfg) file. Using the ARROW key binds is _highly_ suggested.

Before uncommenting the key binds in the config file, make sure you have a backup of your own config.

Command                | Description
---------------------- | -------------------
`exec keyframes`       | Load the script
---                    | ---
`kf_add`               | Add new keyframe
`kf_remove`            | Remove the selected key
`kf_remove_undo`       | Undo last remove action
`kf_removefov`         | Remove the FOV data from the selected key
`kf_clear`             | Remove all keyframes
`kf_insert`            | Insert new keyframe after the selected key
`kf_replace`           | Replace the selected key
`kf_replace_undo`      | Undo last replace action
---                    | ---
`kf_compile`           | Compile the keyframe data
`kf_play`              | Play the compiled data
`kf_stop`              | Stop playback
`kf_save`              | Save the compiled data
`kf_savekeys`          | Save the keyframe data
---                    | ---
`kf_mode_angle`        | Toggle stabilised angles algorithm (no camera tilt)
---                    | ---
`kf_edit`              | Toggle edit mode
`kf_select`            | In edit mode, hold the current selection
`kf_see`               | In edit mode, see the current selection. Use the ARROW keys with this
`kf_next`              | While holding a key, select the next one
`kf_prev`              | While holding a key, select the previous one
`kf_showkeys`          | In edit mode, toggle showing keyframes
`kf_showpath`          | In edit mode, toggle showing the path
---                    | ---
`script fov(val)`      | Set FOV data on the selected key
`script tilt(val)`     | Set camera tilt on the selected key
---                    | ---
`script load(input)`   | Load new data from file
---                    | ---
`kf_cmd`               | List all commands

Key Binds                 | Description
------------------------- | -------------------
`RIGHTARROW` / `LEFTARROW`| Set camera tilt
`UPARROW` / `DOWNARROW`   | Set camera FOV
`MOUSE1`                  | `kf_add`
`MOUSE2`                  | `kf_remove`
`Q`                       | `kf_prev`
`E`                       | `kf_next`
`F`                       | `kf_select`
`G`                       | `kf_see`
`X`                       | `kf_insert`
`C`                       | `kf_replace`

### Exported file
You can open the exported file (`.log`) with any text editor. You must replace `L ` with blank, i.e. remove, for the data to work. Once you have cleared the exported file, copy and paste it in the `keyframes_data.nut` file, which you can also open with any text editor. The data name can only contain letters and numbers, it cannot start with a number. You can store as much data as you want, and load any at any time.

### Implementation notes
Position and angle values are interpolated using Catmull-Rom splines between two consecutive keyframes.

FOV values are linearly interpolated between two consecutive _FOV keys_, independent of the pos-ang keys. Thus, FOV keys on the very first (KEY 0) and the very last keys are discarded. The playback starts with FOV set to data on KEY 1. If KEY 1 FOV data is omitted, KEY 1 FOV is set to 90.

Modifying the position or angle data, including camera tilts, of any key requires recompilation before seeing the changes in playback. Whereas for FOV datas, the user can see their changes in playback without having to recompile.

## Changelog
_[Library][vs_library] changes are excluded._

#### 2020-02-17 [v1.1.1]
\- Minor performance improvements  
\- Minor bug fixes

<details><summary>See more</summary>

#### 2020-02-16 [v1.1.0]
\- Added back an old FOV system that lerps between 2 keyframe FOV values  
\- Changed 'roll' to 'tilt'  
\- Decreased edit mode response time  
\- Minor improvements

#### 2020-02-15 [v1.0.1]
\- Fixed an old bug that wouldn't compile the last key  
\- Minor corrections and fixes

#### 2020-02-14 [v1.0.0]
\- Initial release

</details>

## License
You are free to use, modify and share this script under the terms of the GNU GPLv2.0 license. In short, you must keep the copyright notice, and make your modifications public under the same license if you distribute it.

This script uses [vs_library][].

[![](http://hits.dwyl.com/samisalreadytaken/keyframes.svg)](http://hits.dwyl.com/samisalreadytaken/keyframes)

[vs_library]: https://github.com/samisalreadytaken/vs_library
