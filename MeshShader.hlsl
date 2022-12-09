// A constant buffer that stores the three basic column-major matrices for composing geometry.
cbuffer ModelViewProjectionConstantBuffer : register(b0)
{
	matrix model;
	matrix view;
	matrix projection;
};

// Per-vertex data used as input to the vertex shader.
struct MSvert
{
	float4 pos : SV_POSITION;
	float3 color : COLOR0;
};

[outputtopology("triangle")]
[numthreads(1, 1, 1)]
void MSMain(
	in uint3 groupID : SV_GroupID,
	in uint3 threadInGroup : SV_GroupThreadID,
	out vertices MSvert verts[8],
	out indices uint3 idx[12]) // Three indices per primitive
{
	float4 v;
	const uint numVertices = 8;
	const uint numPrimitives = 12;

	SetMeshOutputCounts(numVertices, numPrimitives);

	float4 cubeVertexPositions[] =
	{
		-0.5f, -0.5f, -0.5f, 1.0f,
		-0.5f, -0.5f, 0.5f, 1.0f,
		-0.5f, 0.5f, -0.5f, 1.0f,
		-0.5f, 0.5f, 0.5f, 1.0f,
		0.5f, -0.5f, -0.5f, 1.0f,
		0.5f, -0.5f, 0.5f, 1.0f,
		0.5f, 0.5f, -0.5f, 1.0f,
		0.5f, 0.5f, 0.5f, 1.0f
	};

	float3 cubeVertexColors[] =
	{
		0.0f, 0.0f, 0.0f,
		0.0f, 0.0f, 1.0f,
		0.0f, 1.0f, 0.0f,
		0.0f, 1.0f, 1.0f,
		1.0f, 0.0f, 0.0f,
		1.0f, 0.0f, 1.0f,
		1.0f, 1.0f, 0.0f,
		1.0f, 1.0f, 1.0f
	};

	for (int i = 0; i < 8; ++i)
	{
		float4 v = cubeVertexPositions[i];
		v = mul(v, model);
		v = mul(v, view);
		v = mul(v, projection);
		verts[i].pos = v;
		verts[i].color = cubeVertexColors[i];
	}

	uint cubeIndices[] =
	{
		0, 2, 1, // -x
		1, 2, 3,

		4, 5, 6, // +x
		5, 7, 6,

		0, 1, 5, // -y
		0, 5, 4,

		2, 6, 7, // +y
		2, 7, 3,

		0, 4, 6, // -z
		0, 6, 2,

		1, 3, 7, // +z
		1, 7, 5,
	};

	uint cubeIdx = 0;

	for (i = 0; i < numPrimitives; ++i)
	{
		uint3 primIndices;

		primIndices.x = cubeIndices[cubeIdx];
		cubeIdx++;

		primIndices.y = cubeIndices[cubeIdx];
		cubeIdx++;

		primIndices.z = cubeIndices[cubeIdx];
		cubeIdx++;

		idx[i] = primIndices;
	}
}