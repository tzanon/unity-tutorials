﻿
Shader "Unlit/TextureDetailed"
{
	Properties
	{
		_Tint("Tint", Color) = (1,1,1,1)
		_MainTex("Texture", 2D) = "white" {}
		_DetailTex("Detail Texture", 2D) = "gray" {}
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
				float2 uvDetail : TEXCOORD1;
			};
			
			struct VertexData
			{
				float4 position : POSITION;
				float2 uv : TEXCOORD0;
			};
			
			float4 _Tint;
			sampler2D _MainTex, _DetailTex;
			float4 _MainTex_ST, _DetailTex_ST;
			
			Interpolators VertProg1(VertexData v)
			{
				Interpolators i;
				i.position = UnityObjectToClipPos(v.position);
				//i.uv = v.uv * _MainTex_ST.xy + _MainTex_ST.wz;
				i.uv = TRANSFORM_TEX(v.uv, _MainTex);
				i.uvDetail = TRANSFORM_TEX(v.uv, _DetailTex);
				return i;
			}
			
			float4 FragProg1(Interpolators i) : SV_TARGET
			{
				float4 color = tex2D(_MainTex, i.uv) * _Tint;
				color *= tex2D(_MainTex, i.uvDetail) * 2;
				return color;
			}
			
			ENDCG
		}
	}
}
