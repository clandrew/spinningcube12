# Spinning Cube Sample (D3D12, Win32)

This is quick-and-dirty sample code based off of the sample "DirectX 12 App (Universal Windows)" which comes built-in with Visual Studio 2017 when the UWP and C++ features are installed. I needed to test some things specific to Win32 so I adapted that sample to be a Win32 program. I'm putting it here in case other people encounter the same situation.

In the interest of simplicity, the following things were removed from the original sample:
* Monitor-rotation-change handling
* DPI-change handling
* Saving and restoring of persistant state

![Example image](https://raw.githubusercontent.com/clandrew/spinningcube12/master/Images/Image.gif "Example image.")

## Build
The source code is organized as a Visual Studio 2019 built for x86-64 architecture. It uses the v142 toolset.

Shaders are compiled at build time as part of the solution against shader model 6_0. This shader model isn't necessary, I set it so that it's a default which is more useful for me. If you want, you can set it to shader model 4 level 9_3.
