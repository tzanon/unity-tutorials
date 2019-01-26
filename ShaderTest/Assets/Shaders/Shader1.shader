
Shader "Unlit/Shader1"
{
	Properties
	{
		_Tint("Tint", Color) = (1,1,1,1)
		_MainTex("Texture", 2D) = "Gray" {}
	}
	
	SubShader
	{
		Pass
		{
			CGPROGRAM
			
			#pragma vertex VertProg1
			#pragma fragment FragProg1
			
			#include "UnityCG.cginc"
			
			struct Interpolators
			{
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
			};
			
			struct VertexData
			{
				float4 position : POSITION;
				float2 uv : TEXCOORD0;
			};
			
			float4 _Tint;
			sampler2D _MainTex;
			
			Interpolators VertProg1(VertexData v)
			{
				Interpolators i;
				i.position = UnityObjectToClipPos(v.position);
				i.uv = v.uv;
				return i;
			}
			
			float4 FragProg1(Interpolators i) : SV_TARGET
			{
				return tex2D(_MainTex, i.uv) * _Tint;
			}
			
			ENDCG
		}
	}
}
