Shader "Unlit/Lensing"
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
            
            // shadertoy code starts
            #define MAGNIFICATION 44.99999999
            static float MAX_RAYMARCH_DISTANCE = 100.;
            static int MAX_RAYMARCH_STEPS = 100;
            static float EPSILON = 0.01;
            static float VERTICAL_FOV = 45.;
            
            float circle(float2 UV, float2 position, float radius) {
                return (distance(position, UV) - radius);
            }
            
            float sphere(float3 UV, float3 position, float radius){
                return (distance(position, UV) - radius);
            }
            
            // Defines the surfaces 
            // returns the nearest distance from the provided position to the scene's surfaces
            float sceneSDF(float3 position){
                float mySphere = sphere(position, float3(0.,0.,0.), .5);
                return mySphere;
            }
            
            float rayMarch(float3 cameraPoint, float3 cameraRay){
                float3 samplePoint = cameraPoint;
                float depth = 0.;
            
                for (int i = 0; i < MAX_RAYMARCH_STEPS; i++){
                    float closestDistance = sceneSDF(samplePoint);
                    // If we are close enough
                    if (closestDistance < EPSILON){
                        break;
                    }
                    depth += closestDistance;
                    // If we have exhausted the raymarching
                    if (depth > MAX_RAYMARCH_DISTANCE) {
                        depth = 0.;
                        break;
                    }
                    // March the Sample Point forward by the closestDistance
                    samplePoint += mul(closestDistance,cameraRay);  
                }
                        
                // 0. cameraPoint INSIDE the SDF
                // +f distance to the surface
                return depth; // pointOnShape
            }
            
            float3 getNormal(float3 position){
                float3 normal = 0.;
                
                float3 x1Sample = position+float3(EPSILON, 0.,0.);
                float3 x2Sample = position-float3(EPSILON, 0.,0.);
                float x1SampleDistance = sceneSDF(x1Sample);
                float x2SampleDistance = sceneSDF(x2Sample);
                normal.x = x1SampleDistance-x2SampleDistance;
                
                float3 y1Sample = position+float3(0.,EPSILON,0.);
                float3 y2Sample = position-float3(0.,EPSILON,0.);
                float y1SampleDistance = sceneSDF(y1Sample);
                float y2SampleDistance = sceneSDF(y2Sample);
                normal.y = y1SampleDistance-y2SampleDistance;
                
                float3 z1Sample = position+float3(0.,0.,EPSILON);
                float3 z2Sample = position-float3(0.,0.,EPSILON);
                float z1SampleDistance = sceneSDF(z1Sample);
                float z2SampleDistance = sceneSDF(z2Sample);
                normal.z = z1SampleDistance-z2SampleDistance;
                
                return normalize(normal);
            }
            
            float3 cameraRayFromFrag(float vFoVDegrees, float2 fragCoord, float2 UV){
                
                // Remap coordinate (0,0) to center of screen
                
                float z = UV.y / tan(radians(vFoVDegrees) / 2.);
            
                float2 mouseUV = 0;
                
                if(circle(UV, mouseUV, 0.4)<0.)
                {
                    float circleFOVFactor = mul(mul(1./.4,circle(UV, mouseUV, 0.4)),MAGNIFICATION);
                    z = UV.y / tan(radians(vFoVDegrees+circleFOVFactor) / 2.);
                }
                
                float3 cameraRay = float3(fragCoord.x, fragCoord.y, -z);
                return normalize(cameraRay);
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                // Normalized pixel coordinates (from 0 to 1)
                float2 UV = i.uv;
            
                // Gray Background
                float3 col = 0.2;
                
                // Grey Circle
                float2 mouseUV = 0;
                float myCircle = circle(UV,mouseUV, 0.4);
                col = lerp(col, .3, step(0., -myCircle));
                
                float3 cameraPoint = float3(0.,0.,5.);
                float3 cameraRay = cameraRayFromFrag(VERTICAL_FOV, fragCoord, UV);
                float rayMarchDistance = rayMarch(cameraPoint, cameraRay);
                float3 pointOnSurface = mul(cameraPoint+cameraRay,rayMarchDistance);
                float3 normal = getNormal(pointOnSurface);
                float3 lightPoint = float3(-2.,2.,2.); 
                
                col = lerp(col, normal, clamp(rayMarchDistance, 0., 1.));
                
                //phong(pointOnSurface, normal, cameraPoint, lightPoint);
                
                
                // Output to screen
                return float4(col, 1.0);
            }
            ENDCG
        }
    }
}
