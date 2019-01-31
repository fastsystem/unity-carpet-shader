Shader "Custom/FlagShader" {
	Properties{
		_MainTex("Albedo (RGB)", 2D) = "white" {}
	}
		SubShader{
			Tags { "RenderType" = "Opaque" }
			LOD 200

			CGPROGRAM
			#pragma surface surf Lambert vertex:vert
			#pragma target 3.0

			sampler2D _MainTex;

			struct Input {
				float2 uv_MainTex;
			};

			void vert(inout appdata_full v, out Input o)
			{
				UNITY_INITIALIZE_OUTPUT(Input, o);
				float distance = -sqrt((v.vertex.x * v.vertex.x) + (v.vertex.z * v.vertex.z));
				float amp = 0.5*sin(_Time * 100 + distance);
				v.vertex.xyz = float3(v.vertex.x, v.vertex.y + amp, v.vertex.z);
				//v.normal = normalize(float3(v.normal.x+offset_, v.normal.y, v.normal.z));
			}

			void surf(Input IN, inout SurfaceOutput o) {
				fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
				o.Albedo = c.rgb;
				o.Alpha = c.a;
			}
			ENDCG
	}
		FallBack "Diffuse"
}
