# Device Tree for Lenovo A3300
Basic		| Spec Sheet
---------------:|:-------------------------
CPU		| 4x Cortex-A7, 1.3GHz
GPU		| Mali-400 MP2
RAM		| 1GB LPDDR2
Release Version	| 4.2.2
Storage		| 8GB
Battery		| 3500 mAh
Display		| 7" 1024 x 600 px
Rear Camera	| 2 MP
Front Camera	| 0.3 MP

# What works:
- Wi-Fi
- GPS
    - AGPS currently doesn't work due to RIL being broken.
- Brightness
- Hardware video encoding/decoding
    - scrcpy shows a gray screen when the device is in portrait mode. Landscape works perfectly fine.
- OpenGL
- Touch
- Sensors
    - The (fake) light sensor is detected, but doesn't report any values.
- Vibration
- Suspend
    - May glitch out on non-hotplug governors.
- Offline charging

# What doesn't:
- Audio
  - Broken on A13.
  - The speaker channels are reversed.
- Bluetooth
  - Broken on A13.
- RIL
    - ccci_mdinit causes the system to crash without error logs somehow.
- Microphone
- Headset
- FM Radio
- Camera

Note: This will be migrated to the [issues page](https://github.com/gamblingaddict/android_device_lenovo_a3300/issues) soon™.
