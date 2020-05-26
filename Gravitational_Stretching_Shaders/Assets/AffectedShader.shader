Shader "GravityStretch"
{
    Properties
    {
        _Strength("Strength", range(0,1)) = 0.0
		_Color("Color", Color) = (0,1,0,1)
	}
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
			//Cull Off
            CGPROGRAM
            #pragma vertex vertexFunc
			#pragma fragment fragmentFunc
			
			float _Strength;
			float4 _Color;
			uniform float4 _GlobalColor;
			
			struct vertexInput {
				float4 vertex : POSITION;
			};
			
			struct vertexOutput {
				float4 pos : SV_POSITION;
			};
			
			vertexOutput vertexFunc(vertexInput IN){
				vertexOutput o;
				float4 worldPos = mul(unity_ObjectToWorld, IN.vertex);
				o.pos = mul(UNITY_MATRIX_VP, worldPos);
				return o;
			}
			
			float4 fragmentFunc(vertexOutput IN) : COLOR{
				return _GlobalColor+_Color;
			}
			
            ENDCG
        }
    }
}
