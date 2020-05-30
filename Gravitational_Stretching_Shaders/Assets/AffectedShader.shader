Shader "Unlit/NewUnlitShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
<<<<<<< HEAD:Gravitational_Stretching_Shaders/Assets/NewUnlitShader.shader
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
=======
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
>>>>>>> Max:Gravitational_Stretching_Shaders/Assets/AffectedShader.shader
			
            ENDCG
        }
    }
}
