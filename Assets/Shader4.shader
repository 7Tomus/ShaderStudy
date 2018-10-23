// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unlit/Shader4"
{

	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_SecondTex("Texture", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,1)
		_Slider("Slider", Range(0,1)) = 0
	}

	SubShader
	{
		Tags{
			"Queue" = "AlphaTest"
		}
		
		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha

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
			sampler2D _SecondTex;
			fixed4 _Color;
			fixed _Slider;


			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 tex1 = tex2D(_MainTex, i.uv);
				fixed4 tex2 = tex2D(_SecondTex, i.uv);
				
				fixed4 color = ((1 - _Slider)*tex1 + (_Slider)*tex2);
				return color;
			}
			ENDCG
		}
	}
}
