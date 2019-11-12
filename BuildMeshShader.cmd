@echo off
setlocal

:: This script is necessary because the required shader model is not available through Visual Studio project tools yet.

dxc -Od -Zi -Tms_6_5 -EMSMain -FhMSMain.h MeshShader.hlsl

