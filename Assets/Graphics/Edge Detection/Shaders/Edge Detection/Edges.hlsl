#ifndef SHADERGRAPH_PREVIEW
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/RenderPass/CustomPass/CustomPassCommon.hlsl"
#endif

void Edges_float(float2 screenPosition, float2 EdgeRadius, out float3 Color, out float3 VertexColor, out float Edges)
{
    Edges = 1;
    EdgeRadius = EdgeRadius * _ScreenParams.y / 1080; // screen size scaling

    Color = 1;
    VertexColor = 1;

    #ifndef SHADERGRAPH_PREVIEW
 
        #define MAX_SAMPLES 8

        // Neighbour pixel positions
        static float2 samplingPositions[MAX_SAMPLES] =
        {
            float2( 0,  1),
            float2(-1,  0),
            float2( 0, -1),
            float2( 1,  0),
            float2( 1,  1),
            float2(-1,  1),
            float2(-1, -1),
            float2( 1, -1),
        };

        Color =  CustomPassSampleCameraColor(screenPosition, 0);
        VertexColor =  SampleCustomColor(screenPosition);
        float colorDifference = 0;

        Edges = VertexColor.r;

        for (int i = 0; i < MAX_SAMPLES; i++)
        {
            colorDifference = colorDifference + distance(VertexColor, SampleCustomColor(screenPosition + samplingPositions[i] * EdgeRadius * _ScreenSize.zw));
        }        

        // color sensitivity
        //colorDifference = colorDifference * ColorMultiplier; 
        //colorDifference = colorDifference * 10;
        //colorDifference = saturate(colorDifference);
        //colorDifference = pow(colorDifference, ColorBias);
        //colorDifference = pow(colorDifference, 1);
        Edges = step(colorDifference, .0001);

    #endif
}