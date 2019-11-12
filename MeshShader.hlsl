
// Per-vertex data used as input to the vertex shader.
struct MSvert
{
	float3 pos : POSITION;
	float3 color : COLOR0;
};

[outputtopology("triangle")]
[numthreads(1, 1, 1)]
void MSMain(
	in uint3 groupID : SV_GroupID,
	in uint3 threadInGroup : SV_GroupThreadID,
	out vertices MSvert verts[8],
	out indices uint3 idx[36])
{
}