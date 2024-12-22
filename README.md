# ios-poc

## Config

DEVELOPMENT_TEAM: 
- Add DEVELOPMENT_TEAM in (Xcode menu → Preferences… → Locations → Custom Paths)

Source : https://stackoverflow.com/a/40424891

## Screenshots

### RootViewController

![Root](/readme/img/root.png?raw=true "Root")

### GUI

![GUI 1](/readme/img/gui_1.png?raw=true "GUI 1")
![GUI 2](/readme/img/gui_2.png?raw=true "GUI 2")
![GUI 3](/readme/img/gui_3.png?raw=true "GUI 3")

### Trigo cricle

![Trigo 1](/readme/img/trigovc_1.png?raw=true "Trigo 1")
![Trigo 2](/readme/img/trigovc_2.png?raw=true "Trigo 2")
![Trigo 3](/readme/img/trigovc_3.png?raw=true "Trigo 3")

### Examples

#### Calculator

![Calculator](/readme/img/calculator.png?raw=true "Calculator")

#### Clock

![Clock](/readme/img/clock.png?raw=true "Clock")

#### Music Player

![Music Player](/readme/img/music_player.png?raw=true "Music Player")

## Fix Previews

Path to previews resources directory :
`/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/DeviceKit/Chrome/phone11.devicechrome/Contents/Resources`

- Keep xcode updated
- Change the Device Used for Previews
- Kill PreviewShell in Activity Monitor or in CLI `xcrun simctl - set previews shutdown all`
- Delete All Preview Caches `xcrun simctl - set previews delete all`
- Enable Legacy Preview Mechanism : in Xcode, go to Editor > Canvas > Use Legacy Previews Execution
- Use PreviewProvider
