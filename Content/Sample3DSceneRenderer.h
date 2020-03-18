﻿#pragma once

#include "..\Common\DeviceResources.h"
#include "ShaderStructures.h"
#include "..\Common\StepTimer.h"

using namespace Microsoft::WRL;

namespace SpinningCube
{
	// This sample renderer instantiates a basic rendering pipeline.
	class Sample3DSceneRenderer
	{
	public:
		Sample3DSceneRenderer(const std::shared_ptr<DX::DeviceResources>& deviceResources);
		~Sample3DSceneRenderer();
		void CreateDeviceDependentResources();
		void CreateWindowSizeDependentResources();
		void Update(DX::StepTimer const& timer);
		bool Render();

	private:
		void Rotate(float radians);

		struct LoadedImageData
		{
			UINT ImageWidth;
			UINT ImageHeight;
			std::vector<UINT> Buffer;
		};
		LoadedImageData LoadImageDataFromPngFile(std::wstring fileName);
		void LoadTextureFromPngFile(std::vector<std::wstring> const& mipImageFileNames);

	private:
		// Constant buffers must be 256-byte aligned.
		static const UINT c_alignedConstantBufferSize = (sizeof(ModelViewProjectionConstantBuffer) + 255) & ~255;

		// Cached pointer to device resources.
		std::shared_ptr<DX::DeviceResources> m_deviceResources;

		// Direct3D resources for cube geometry.
		ComPtr<ID3D12GraphicsCommandList>	m_commandList;
		ComPtr<ID3D12RootSignature>			m_rootSignature;
		ComPtr<ID3D12PipelineState>			m_pipelineState;
		ComPtr<ID3D12DescriptorHeap>		m_cbv_srv_Heap;
		ComPtr<ID3D12Resource>				m_vertexBuffer;
		ComPtr<ID3D12Resource>				m_indexBuffer;
		ComPtr<ID3D12Resource>				m_constantBuffer;
		ModelViewProjectionConstantBuffer	m_constantBufferData;
		UINT8*								m_mappedConstantBuffer;
		UINT								m_cbvDescriptorSize;
		D3D12_RECT							m_scissorRect;
		std::vector<byte>					m_vertexShader;
		std::vector<byte>					m_pixelShader;
		D3D12_VERTEX_BUFFER_VIEW			m_vertexBufferView;
		D3D12_INDEX_BUFFER_VIEW				m_indexBufferView;
		ComPtr<ID3D12Resource>				m_texture;
	    std::vector<ComPtr<ID3D12Resource>> m_uploads;
		UINT								m_indexCount;

		ComPtr<IWICImagingFactory>          m_wicImagingFactory;

		// Variables used with the rendering loop.
		bool	m_loadingComplete;
		float	m_radiansPerSecond;
		float	m_angle;
		bool	m_tracking;
	};
}

