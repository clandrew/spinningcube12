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
	int i;
	float4 v;
	const uint numVertices = 8;
	const uint numPrimitives = 12;

	SetMeshOutputCounts(numVertices, numPrimitives);
	
	v = float4(-0.5f, -0.5f, -0.5f, 0.0f);
	v = mul(v, model);
	v = mul(v, view);
	v = mul(v, projection);
	verts[0].pos = v;
	verts[0].color = float3(0.0f, 0.0f, 0.0f);

	v = float4(-0.5f, -0.5f, 0.5f, 0.0f);
	v = mul(v, model);
	v = mul(v, view);
	v = mul(v, projection);
	verts[1].pos = v;
	verts[1].color = float3(0.0f, 0.0f, 1.0f);

	v = float4(-0.5f, 0.5f, -0.5f, 0.0f);
	v = mul(v, model);
	v = mul(v, view);
	v = mul(v, projection);
	verts[2].pos = v;
	verts[2].color = float3(0.0f, 1.0f, 0.0f);

	v = float4(-0.5f, 0.5f, 0.5f, 0.0f);
	v = mul(v, model);
	v = mul(v, view);
	v = mul(v, projection);
	verts[3].pos = v;
	verts[3].color = float3(0.0f, 1.0f, 1.0f);

	v = float4(0.5f, -0.5f, -0.5f, 0.0f);
	v = mul(v, model);
	v = mul(v, view);
	v = mul(v, projection);
	verts[4].pos = v;
	verts[4].color = float3(1.0f, 0.0f, 0.0f);

	v = float4(0.5f, -0.5f, 0.5f, 0.0f);
	v = mul(v, model);
	v = mul(v, view);
	v = mul(v, projection);
	verts[5].pos = v;
	verts[5].color = float3(1.0f, 0.0f, 1.0f);

	v = float4(0.5f, 0.5f, -0.5f, 0.0f);
	v = mul(v, model);
	v = mul(v, view);
	v = mul(v, projection);
	verts[6].pos = v;
	verts[6].color = float3(1.0f, 1.0f, 0.0f);

	v = float4(0.5f, 0.5f, 0.5f, 0.0f);
	v = mul(v, model);
	v = mul(v, view);
	v = mul(v, projection);
	verts[7].pos = v;
	verts[7].color = float3(1.0f, 1.0f, 1.0f);
	
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