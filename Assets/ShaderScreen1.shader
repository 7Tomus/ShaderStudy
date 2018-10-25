// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unlit/ShaderScreen1"
{

	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_DisplacementMap("DisplacementMap", 2D) = "black" {}
		_Magnitude("Magnitude", Range(-0.1,0.1)) = 0
	}

	SubShader
	{		
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;
			sampler2D _DisplacementMap;
			float _Magnitude;

			fixed4 frag (v2f i) : SV_Target
			{
				float2 displacement = tex2D(_DisplacementMap, i.uv).xy;
				displacement = ((displacement * 2) - 1) * _Magnitude;
				float4 color = tex2D(_MainTex, i.uv + displacement);
				return color;
			}
			ENDCG
		}
	}
}
