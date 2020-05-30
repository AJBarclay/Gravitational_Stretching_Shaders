// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Unlit/Gravitational_Stretching_Shader"
{
    Properties
    {
		_Color ("Color", Color) = (0,0,0,1)
        _MainTex ("Texture", 2D) = "white" {}
		_Vector ("GravitatorPos", Vector) = (0.0,0.0,0.0,1.0)
		_Strength("Strength", Range(0,2)) = 1.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

			fixed4 _Color;
			float _Strength;
			Vector _Vector;
			float3 _Source;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                float4 oldWorldPos = mul(unity_ObjectToWorld, v.vertex);

				float4 worldPos = mul(unity_ObjectToWorld, v.vertex);

				float4 objectOrigin = mul(unity_ObjectToWorld, float4(0.0, 0.0, 0.0, 1.0));	//https://forum.unity.com/threads/get-object-center-in-a-shader.180516/

				float3 pullDirection = normalize (float3(_Vector.x - worldPos.x, _Vector.y - worldPos.y, _Vector.z - worldPos.z));
				//float3 pullDirection = float3(_Vector.x - objectOrigin.x, _Vector.y - objectOrigin.y, _Vector.z - objectOrigin.z);
				
				float difference = distance(_Vector.xyz, worldPos.xyz);
				//float difference = distance(_Vector.xyz, objectOrigin.xyz);

				float3 displacement = (pullDirection / (difference *(1/_Strength)) );
				
				worldPos.xyz += displacement;
                
                // if mirrored, clamp at black hole origin
				if(worldPos.x * oldWorldPos.x <0)
				{
				    worldPos.x = 0.0;
				}
				if(worldPos.y * oldWorldPos.y <0)
				{
				    worldPos.y = 0.0;
				}
				if(worldPos.z * oldWorldPos.z <0)
				{
				    worldPos.z = 0.0;
				}

				//worldPos = ((worldPos.xyz + ((pullDirection.x/difference, pullDirection.y / difference, pullDirection.z / difference))), worldPos.w);

                v2f o;
                //o.vertex = UnityObjectToClipPos(worldPos);
				o.vertex = mul(UNITY_MATRIX_VP, worldPos);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
				col = _Color * col;
                return col;
            }
            ENDCG
        }
    }
}
