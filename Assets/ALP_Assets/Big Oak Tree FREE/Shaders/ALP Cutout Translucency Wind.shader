// Made with Amplify Shader Editor v1.9.3.3
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ALP/Cutout Translucency Wind"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.45
		[HideInInspector][Enum(Front,2,Back,1,Both,0)]_Cull("Render Face", Int) = 2
		[DE_DrawerCategory(ALPHA CLIPPING,true,_GlancingClipMode,0,0)]_CATEGORY_ALPHACLIPPING("CATEGORY_ALPHACLIPPING", Float) = 0
		[DE_DrawerToggleLeft]_GlancingClipMode("Enable Clip Glancing Angle", Float) = 0
		[DE_DrawerSliderSimple(_AlphaRemapMin, _AlphaRemapMax,0, 1)]_AlphaRemap("Alpha Remapping", Vector) = (0,1,0,0)
		[HideInInspector]_AlphaRemapMin("AlphaRemapMin", Float) = 0
		[HideInInspector]_AlphaRemapMax("AlphaRemapMax", Float) = 1
		_AlphaCutoffBias("Alpha Cutoff Bias", Range( 0 , 1)) = 0.5
		[DE_DrawerSpace(10)]_SPACE_ALPHACLIP("SPACE_ALPHACLIP", Float) = 0
		[DE_DrawerCategory(COLOR,true,_BaseColor,0,0)]_CATEGORY_COLOR("CATEGORY_COLOR", Float) = 1
		_BaseColor("Base Color", Color) = (1,1,1,0)
		_Brightness("Brightness", Range( 0 , 2)) = 1
		[DE_DrawerSpace(10)]_SPACE_COLOR("SPACE_COLOR", Float) = 0
		[DE_DrawerCategory(SURFACE INPUTS,true,_MainTex,0,0)]_CATEGORY_SURFACEINPUTS("CATEGORY_SURFACE INPUTS", Float) = 1
		[DE_DrawerTextureSingleLine]_MainTex("Base Map", 2D) = "white" {}
		[DE_DrawerFloatEnum(UV0 _UV1 _UV2 _UV3)]_UVMode("UV Mode", Float) = 0
		[DE_DrawerTilingOffset]_MainUVs("Main UVs", Vector) = (1,1,0,0)
		[DE_DrawerTextureSingleLine][Space(10)]_MetallicGlossMap("Metallic Map", 2D) = "white" {}
		_MetallicStrength("Metallic Strength", Range( 0 , 1)) = 0
		[DE_DrawerFloatEnum(Smoothness _Roughness)][Space(10)]_SmoothnessSource("Smoothness Source", Float) = 1
		[DE_DrawerTextureSingleLine]_SmoothnessMap("Smoothness Map", 2D) = "white" {}
		_SmoothnessStrength("Smoothness Strength", Range( 0 , 1)) = 0
		[DE_DrawerToggleLeft]_SmoothnessFresnelEnable("ENABLE FRESNEL", Float) = 0
		_SmoothnessFresnelScale("Fresnel Scale", Range( 0 , 3)) = 1.1
		_SmoothnessFresnelPower("Fresnel Power", Range( 0 , 20)) = 10
		[DE_DrawerFloatEnum(Texture _Vertex Color)][Space(10)]_OcclusionSource("Occlusion Source", Float) = 0
		[DE_DrawerTextureSingleLine]_OcclusionMap("Occlusion Map", 2D) = "white" {}
		_OcclusionStrengthAO("Occlusion Strength", Range( 0 , 1)) = 0
		[Normal][DE_DrawerTextureSingleLine][Space(10)]_BumpMap("Normal Map", 2D) = "bump" {}
		[DE_DrawerFloatEnum(Flip _Mirror _None)]_DoubleSidedNormalMode("Normal Mode", Float) = 2
		_NormalStrength("Normal Strength", Float) = 1
		[DE_DrawerSpace(10)]_SPACE_SURFACEINPUTS("SPACE_SURFACE INPUTS", Float) = 0
		[DE_DrawerCategory(COLOR SHIFT,true,_ColorShiftEnable,0,0)]_CATEGORY_COLORSHIFT("CATEGORY_COLOR SHIFT", Float) = 0
		[DE_DrawerToggleLeft]_ColorShiftEnable("ENABLE COLOR SHIFT", Float) = 0
		[DE_DrawerFloatEnum(Object Space _World Space _Vertex Color _Vertex Normal)]_ColorShiftSource("Shift Source", Float) = 0
		_ColorShiftVariation("Shift Variation", Range( 0 , 1)) = 0
		_ColorShiftVariationRGB("Shift Variation RGB", Range( -0.5 , 0.5)) = 0.2
		_ColorShiftInfluence("Shift Influence ", Range( 0 , 1)) = 0.75
		_ColorShiftSaturation("Shift Saturation", Range( 0 , 1)) = 0.85
		_ColorShiftNoiseScale("Shift Noise Scale", Range( 0 , 2)) = 1
		[Header(COLOR SHIFT WORLD SPACE)]_ColorShiftWorldSpaceDistance("World Space Distance", Range( 0.01 , 5)) = 5
		_ColorShiftWorldSpaceOffset("World Space Offset", Range( -1 , 1)) = 1
		_ColorShiftWorldSpaceNoiseShift("World Space Noise Shift", Range( 1 , 5)) = 5
		[DE_DrawerToggleLeft][Space(10)]_ColorShiftEnableMask("ENABLE COLOR SHIFT MASK", Float) = 1
		[DE_DrawerToggleNoKeyword]_ColorShiftMaskInverted("Color Shift Mask Inverted", Float) = 0
		[DE_DrawerTextureSingleLine]_ColorShiftMaskMap("Color Shift Mask Map", 2D) = "black" {}
		_ColorShiftMaskFuzziness("Color Shift Mask Fuzziness", Range( 0 , 1)) = 0.25
		[DE_DrawerSpace(10)]_SPACE_COLORSHIFT("SPACE_COLORSHIFT", Float) = 0
		[DE_DrawerCategory(TRANSMISSION,true,_TransmissionEnable,0,0)]_CATEGORY_TRANSMISSION("CATEGORY_TRANSMISSION", Float) = 0
		[DE_DrawerToggleLeft]_TransmissionEnable("ENABLE TRANSMISSION", Float) = 0
		[DE_DrawerFloatEnum(Color Picker Only_Transmission Mask Map)]_TransmissionSource("Transmission Source", Float) = 1
		[DE_DrawerTextureSingleLine]_TransmissionMaskMap("Transmission Mask Map", 2D) = "white" {}
		[DE_DrawerToggleNoKeyword]_TransmissionMaskInverted("Transmission Mask Inverted", Float) = 0
		_TransmissionMaskStrength("Transmission Mask Strength", Range( 0 , 1.5)) = 1.466198
		_TransmissionMaskFeather("Transmission Mask Feather", Range( 0 , 1)) = 1
		[HDR]_TransmissionColor("Transmission Color", Color) = (0.5,0.5,0.5,1)
		_TransmissionStrength("Transmission Strength", Float) = 1
		[DE_DrawerSpace(10)]_SPACE_TRANSMISSION("SPACE_TRANSMISSION", Float) = 0
		[DE_DrawerCategory(TRANSLUCENCY,true,_TranslucencyEnable,0,0)]_CATEGORY_TRANSLUCENCY("CATEGORY_TRANSLUCENCY", Float) = 0
		[DE_DrawerToggleLeft]_TranslucencyEnable("ENABLE TRANSLUCENCY", Float) = 0
		[DE_DrawerFloatEnum(Color Picker Only _Thickness Mask Map)]_TranslucencySource("Translucency Source", Float) = 1
		[DE_DrawerTextureSingleLine]_ThicknessMap("Thickness Mask Map", 2D) = "white" {}
		[DE_DrawerToggleNoKeyword]_ThicknessMapInverted("Thickness Mask Inverted", Float) = 0
		_ThicknessStrength("Thickness Mask Strength", Range( 0 , 1.5)) = 1.466198
		_ThicknessFeather("Thickness Mask Feather", Range( 0 , 1)) = 1
		[HDR]_TranslucencyColor("Translucency Color", Color) = (0.5,0.5,0.5,1)
		_TranslucencyStrength("Translucency Strength", Float) = 1
		[DE_DrawerSpace(10)]_SPACE_TRANSLUCENCY("SPACE_TRANSLUCENCY", Float) = 0
		[DE_DrawerCategory(TRANSLUCENCY ASE,true,_TranslucencyStrength,0,0)]_CATEGORY_TRANSLUCENCYASE("CATEGORY_TRANSLUCENCY ASE", Float) = 0
		[Header(Translucency)]
		_Translucency("Strength", Range( 0 , 50)) = 1
		_TransNormalDistortion("Normal Distortion", Range( 0 , 1)) = 0.1
		_TransScattering("Scaterring Falloff", Range( 1 , 50)) = 2
		_TransDirect("Direct", Range( 0 , 1)) = 1
		_TransAmbient("Ambient", Range( 0 , 1)) = 0.2
		_TransShadow("Shadow", Range( 0 , 1)) = 0.9
		[DE_DrawerSpace(10)]_SPACE_TRANSLUCENCYASE("SPACE_TRANSLUCENCYASE", Float) = 0
		[DE_DrawerCategory(WIND,true,_WindEnable,0,0)]_CATEGORY_WIND("CATEGORY_WIND", Float) = 0
		[DE_DrawerToggleLeft]_WindEnable("ENABLE WIND", Float) = 0
		[DE_DrawerFloatEnum(Global _Local)]_WindEnableMode("Enable Wind Mode", Float) = 0
		[DE_DrawerFloatEnum(Leaf _Palm _Grass _Simple _Ivy)]_WindEnableType("Enable Wind Type", Float) = 0
		[Header(WIND GLOBAL)]_WindGlobalIntensity("Wind Intensity", Float) = 1
		_WindGlobalTurbulence("Wind Turbulence", Float) = 0.35
		[Header(WIND LOCAL)]_WindLocalIntensity("Local Wind Intensity", Float) = 1
		_WindLocalTurbulence("Local Wind Turbulence", Float) = 0.35
		_WindLocalPulseFrequency("Local Wind Pulse Frequency", Float) = 0.1
		_WindLocalRandomOffset("Local Random Offset", Float) = 0.2
		_WindLocalDirection("Local Wind Direction", Range( 0 , 360)) = 0
		[DE_DrawerSpace(10)]_SPACE_WIND("SPACE_WIND", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" }
		LOD 200
		Cull [_Cull]
		ZTest LEqual
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#pragma target 3.5
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#pragma multi_compile_instancing
		#define ASE_USING_SAMPLING_MACROS 1
		#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
		#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
		#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex.SampleBias(samplerTex,coord,bias)
		#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex.SampleGrad(samplerTex,coord,ddx,ddy)
		#else//ASE Sampling Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
		#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
		#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
		#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
		#endif//ASE Sampling Macros

		#pragma surface surf StandardCustom keepalpha addshadow fullforwardshadows exclude_path:deferred dithercrossfade vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 vertexToFrag70_g58525;
			half ASEIsFrontFacing : VFACE;
			float4 vertexColor : COLOR;
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv_texcoord;
		};

		struct SurfaceOutputStandardCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			half3 Transmission;
			half3 Translucency;
		};

		uniform int _Cull;
		uniform float _CATEGORY_TRANSLUCENCYASE;
		uniform float _SPACE_TRANSLUCENCYASE;
		uniform float _SPACE_TRANSLUCENCY;
		uniform float _CATEGORY_TRANSMISSION;
		uniform float _CATEGORY_SURFACEINPUTS;
		uniform float _SPACE_SURFACEINPUTS;
		uniform float _SPACE_COLOR;
		uniform float _CATEGORY_COLOR;
		uniform half _WindEnableType;
		uniform half _WindGlobalIntensity;
		uniform float _GlobalWindIntensity;
		uniform half _WindLocalIntensity;
		uniform half _WindEnableMode;
		uniform float _GlobalWindRandomOffset;
		uniform half _WindLocalRandomOffset;
		uniform float _GlobalWindPulse;
		uniform half _WindLocalPulseFrequency;
		uniform float _GlobalWindDirection;
		uniform half _WindLocalDirection;
		uniform half _WindGlobalTurbulence;
		uniform float _GlobalWindTurbulence;
		uniform half _WindLocalTurbulence;
		uniform half _WindEnable;
		uniform float _CATEGORY_WIND;
		uniform float _SPACE_WIND;
		uniform half _DoubleSidedNormalMode;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_BumpMap);
		uniform float _UVMode;
		uniform float4 _MainUVs;
		SamplerState sampler_BumpMap;
		uniform half _NormalStrength;
		uniform half4 _BaseColor;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainTex);
		SamplerState sampler_MainTex;
		uniform half _Brightness;
		uniform half _ColorShiftSource;
		uniform half _ColorShiftNoiseScale;
		uniform half _ColorShiftWorldSpaceNoiseShift;
		uniform half _ColorShiftWorldSpaceOffset;
		uniform half _ColorShiftWorldSpaceDistance;
		uniform half _ColorShiftVariation;
		uniform half _ColorShiftVariationRGB;
		uniform half _ColorShiftSaturation;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_ColorShiftMaskMap);
		uniform float4 _ColorShiftMaskMap_ST;
		uniform half _ColorShiftMaskFuzziness;
		uniform half _ColorShiftMaskInverted;
		uniform half _ColorShiftEnableMask;
		uniform half _ColorShiftInfluence;
		uniform half _ColorShiftEnable;
		uniform float _CATEGORY_COLORSHIFT;
		uniform float _SPACE_COLORSHIFT;
		uniform float _MetallicStrength;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MetallicGlossMap);
		SamplerState sampler_MetallicGlossMap;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_SmoothnessMap);
		SamplerState sampler_SmoothnessMap;
		uniform half _SmoothnessSource;
		uniform half _SmoothnessStrength;
		uniform half _SmoothnessFresnelScale;
		uniform half _SmoothnessFresnelPower;
		uniform half _SmoothnessFresnelEnable;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_OcclusionMap);
		SamplerState sampler_OcclusionMap;
		uniform half _OcclusionStrengthAO;
		uniform half _OcclusionSource;
		uniform half4 _TransmissionColor;
		uniform half _TransmissionStrength;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_TransmissionMaskMap);
		uniform half _TransmissionMaskFeather;
		uniform half _TransmissionMaskStrength;
		uniform half _TransmissionMaskInverted;
		uniform half _TransmissionSource;
		uniform half _TransmissionEnable;
		uniform float _CATEGORY_TRANSLUCENCY;
		uniform float _SPACE_TRANSMISSION;
		uniform half _Translucency;
		uniform half _TransNormalDistortion;
		uniform half _TransScattering;
		uniform half _TransDirect;
		uniform half _TransAmbient;
		uniform half _TransShadow;
		uniform half4 _TranslucencyColor;
		uniform half _TranslucencyStrength;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_ThicknessMap);
		uniform half _ThicknessFeather;
		uniform half _ThicknessStrength;
		uniform half _ThicknessMapInverted;
		uniform half _TranslucencySource;
		uniform half _TranslucencyEnable;
		uniform float _AlphaRemapMin;
		uniform float4 _AlphaRemap;
		uniform float _AlphaRemapMax;
		uniform half _AlphaCutoffBias;
		uniform half _GlancingClipMode;
		uniform float _CATEGORY_ALPHACLIPPING;
		uniform float _SPACE_ALPHACLIP;
		uniform float _Cutoff = 0.45;


		float4 mod289( float4 x )
		{
			return x - floor(x * (1.0 / 289.0)) * 289.0;
		}


		float4 perm( float4 x )
		{
			return mod289(((x * 34.0) + 1.0) * x);
		}


		float SimpleNoise3D( float3 p )
		{
			 float3 a = floor(p);
			    float3 d = p - a;
			    d = d * d * (3.0 - 2.0 * d);
			 float4 b = a.xxyy + float4(0.0, 1.0, 0.0, 1.0);
			    float4 k1 = perm(b.xyxy);
			 float4 k2 = perm(k1.xyxy + b.zzww);
			    float4 c = k2 + a.zzzz;
			    float4 k3 = perm(c);
			    float4 k4 = perm(c + 1.0);
			    float4 o1 = frac(k3 * (1.0 / 41.0));
			 float4 o2 = frac(k4 * (1.0 / 41.0));
			    float4 o3 = o2 * d.z + o1 * (1.0 - d.z);
			    float2 o4 = o3.yw * d.x + o3.xz * (1.0 - d.x);
			    return o4.y * d.y + o4.x * (1.0 - d.y);
		}


		float2 DirectionalEquation( float _WindDirection )
		{
			float d = _WindDirection * 0.0174532924;
			float xL = cos(d) + 1 / 2;
			float zL = sin(d) + 1 / 2;
			return float2(zL,xL);
		}


		float3 Wind_Typefloat3switch2439_g58224( float m_switch, float3 m_Leaf, float3 m_Palm, float3 m_Grass, float3 m_Simple, float3 m_Ivy )
		{
			if(m_switch ==0)
				return m_Leaf;
			else if(m_switch ==1)
				return m_Palm;
			else if(m_switch ==2)
				return m_Grass;
			else if(m_switch ==3)
				return m_Simple;
			else if(m_switch ==4)
				return m_Ivy;
			else
			return float3(0,0,0);
		}


		float2 float2switchUVMode80_g58525( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
		{
			if(m_switch ==0)
				return m_UV0;
			else if(m_switch ==1)
				return m_UV1;
			else if(m_switch ==2)
				return m_UV2;
			else if(m_switch ==3)
				return m_UV3;
			else
			return float2(0,0);
		}


		float3 _NormalModefloat3switch( float m_switch, float3 m_Flip, float3 m_Mirror, float3 m_None )
		{
			if(m_switch ==0)
				return m_Flip;
			else if(m_switch ==1)
				return m_Mirror;
			else if(m_switch ==2)
				return m_None;
			else
			return float3(0,0,0);
		}


		float3 HSVToRGB( float3 c )
		{
			float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
			float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
			return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
		}


		float ColorShift_Modefloatswitch168_g58298( float m_switch, float m_ObjectSpace, float m_WorldSpace, float m_VertexColor, float m_VertexNormal )
		{
			if(m_switch ==0)
				return m_ObjectSpace;
			else if(m_switch ==1)
				return m_WorldSpace;
			else if(m_switch ==2)
				return m_VertexColor;
			else if(m_switch ==3)
				return m_VertexNormal;
			else
			return float(0);
		}


		float3 RGBToHSV(float3 c)
		{
			float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
			float4 p = lerp( float4( c.bg, K.wz ), float4( c.gb, K.xy ), step( c.b, c.g ) );
			float4 q = lerp( float4( p.xyw, c.r ), float4( c.r, p.yzx ), step( p.x, c.r ) );
			float d = q.x - min( q.w, q.y );
			float e = 1.0e-10;
			return float3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
		}

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float m_switch2439_g58224 = _WindEnableType;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 VERTEX_POSITION_MATRIX2352_g58224 = mul( unity_ObjectToWorld, float4( ase_vertex3Pos , 0.0 ) ).xyz;
			float3 break2265_g58224 = VERTEX_POSITION_MATRIX2352_g58224;
			float GlobalWindIntensity3173_g58224 = _GlobalWindIntensity;
			float WIND_MODE2462_g58224 = _WindEnableMode;
			float lerpResult3147_g58224 = lerp( ( _WindGlobalIntensity * GlobalWindIntensity3173_g58224 ) , _WindLocalIntensity , WIND_MODE2462_g58224);
			float _WIND_STRENGHT2400_g58224 = lerpResult3147_g58224;
			float GlobalWindRandomOffset3174_g58224 = _GlobalWindRandomOffset;
			float lerpResult3149_g58224 = lerp( GlobalWindRandomOffset3174_g58224 , _WindLocalRandomOffset , WIND_MODE2462_g58224);
			float4 transform3073_g58224 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float2 appendResult2307_g58224 = (float2(transform3073_g58224.x , transform3073_g58224.z));
			float dotResult2341_g58224 = dot( appendResult2307_g58224 , float2( 12.9898,78.233 ) );
			float lerpResult2238_g58224 = lerp( 0.8 , ( ( lerpResult3149_g58224 / 2.0 ) + 0.9 ) , frac( ( sin( dotResult2341_g58224 ) * 43758.55 ) ));
			float _WIND_RANDOM_OFFSET2244_g58224 = ( _Time.x * lerpResult2238_g58224 );
			float _WIND_TUBULENCE_RANDOM2274_g58224 = ( sin( ( ( _WIND_RANDOM_OFFSET2244_g58224 * 40.0 ) - ( VERTEX_POSITION_MATRIX2352_g58224.z / 15.0 ) ) ) * 0.5 );
			float GlobalWindPulse3177_g58224 = _GlobalWindPulse;
			float lerpResult3152_g58224 = lerp( GlobalWindPulse3177_g58224 , _WindLocalPulseFrequency , WIND_MODE2462_g58224);
			float _WIND_PULSE2421_g58224 = lerpResult3152_g58224;
			float FUNC_Angle2470_g58224 = ( _WIND_STRENGHT2400_g58224 * ( 1.0 + sin( ( ( ( ( _WIND_RANDOM_OFFSET2244_g58224 * 2.0 ) + _WIND_TUBULENCE_RANDOM2274_g58224 ) - ( VERTEX_POSITION_MATRIX2352_g58224.z / 50.0 ) ) - ( v.color.r / 20.0 ) ) ) ) * sqrt( v.color.r ) * _WIND_PULSE2421_g58224 );
			float FUNC_Angle_SinA2424_g58224 = sin( FUNC_Angle2470_g58224 );
			float FUNC_Angle_CosA2362_g58224 = cos( FUNC_Angle2470_g58224 );
			float GlobalWindDirection3175_g58224 = _GlobalWindDirection;
			float lerpResult3150_g58224 = lerp( GlobalWindDirection3175_g58224 , _WindLocalDirection , WIND_MODE2462_g58224);
			float _WindDirection2249_g58224 = lerpResult3150_g58224;
			float2 localDirectionalEquation2249_g58224 = DirectionalEquation( _WindDirection2249_g58224 );
			float2 break2469_g58224 = localDirectionalEquation2249_g58224;
			float _WIND_DIRECTION_X2418_g58224 = break2469_g58224.x;
			float lerpResult2258_g58224 = lerp( break2265_g58224.x , ( ( break2265_g58224.y * FUNC_Angle_SinA2424_g58224 ) + ( break2265_g58224.x * FUNC_Angle_CosA2362_g58224 ) ) , _WIND_DIRECTION_X2418_g58224);
			float3 break2340_g58224 = VERTEX_POSITION_MATRIX2352_g58224;
			float3 break2233_g58224 = VERTEX_POSITION_MATRIX2352_g58224;
			float _WIND_DIRECTION_Y2416_g58224 = break2469_g58224.y;
			float lerpResult2275_g58224 = lerp( break2233_g58224.z , ( ( break2233_g58224.y * FUNC_Angle_SinA2424_g58224 ) + ( break2233_g58224.z * FUNC_Angle_CosA2362_g58224 ) ) , _WIND_DIRECTION_Y2416_g58224);
			float3 appendResult2235_g58224 = (float3(lerpResult2258_g58224 , ( ( break2340_g58224.y * FUNC_Angle_CosA2362_g58224 ) - ( break2340_g58224.z * FUNC_Angle_SinA2424_g58224 ) ) , lerpResult2275_g58224));
			float3 VERTEX_POSITION2282_g58224 = ( mul( unity_WorldToObject, float4( appendResult2235_g58224 , 0.0 ) ).xyz - ase_vertex3Pos );
			float3 break2518_g58224 = VERTEX_POSITION2282_g58224;
			half FUNC_SinFunction2336_g58224 = sin( ( ( _WIND_RANDOM_OFFSET2244_g58224 * 200.0 * ( 0.2 + v.color.g ) ) + ( v.color.g * 10.0 ) + _WIND_TUBULENCE_RANDOM2274_g58224 + ( VERTEX_POSITION_MATRIX2352_g58224.z / 2.0 ) ) );
			float GlobalWindTurbulence3176_g58224 = _GlobalWindTurbulence;
			float lerpResult3151_g58224 = lerp( ( _WindGlobalTurbulence * GlobalWindTurbulence3176_g58224 ) , _WindLocalTurbulence , WIND_MODE2462_g58224);
			float _WIND_TUBULENCE2442_g58224 = lerpResult3151_g58224;
			float3 appendResult2480_g58224 = (float3(break2518_g58224.x , ( break2518_g58224.y + ( FUNC_SinFunction2336_g58224 * v.color.b * ( FUNC_Angle2470_g58224 + ( _WIND_STRENGHT2400_g58224 / 200.0 ) ) * _WIND_TUBULENCE2442_g58224 ) ) , break2518_g58224.z));
			float3 VERTEX_LEAF2396_g58224 = appendResult2480_g58224;
			float3 m_Leaf2439_g58224 = VERTEX_LEAF2396_g58224;
			float3 VERTEX_PALM2310_g58224 = ( ( FUNC_SinFunction2336_g58224 * v.color.b * ( FUNC_Angle2470_g58224 + ( _WIND_STRENGHT2400_g58224 / 200.0 ) ) * _WIND_TUBULENCE2442_g58224 ) + VERTEX_POSITION2282_g58224 );
			float3 m_Palm2439_g58224 = VERTEX_PALM2310_g58224;
			float3 break2486_g58224 = VERTEX_POSITION2282_g58224;
			float temp_output_2514_0_g58224 = ( FUNC_SinFunction2336_g58224 * v.color.b * ( FUNC_Angle2470_g58224 + ( _WIND_STRENGHT2400_g58224 / 200.0 ) ) );
			float lerpResult2482_g58224 = lerp( 0.0 , temp_output_2514_0_g58224 , _WIND_DIRECTION_X2418_g58224);
			float lerpResult2484_g58224 = lerp( 0.0 , temp_output_2514_0_g58224 , _WIND_DIRECTION_Y2416_g58224);
			float3 appendResult2489_g58224 = (float3(( break2486_g58224.x + lerpResult2482_g58224 ) , break2486_g58224.y , ( break2486_g58224.z + lerpResult2484_g58224 )));
			float3 VERTEX_GRASS2242_g58224 = appendResult2489_g58224;
			float3 m_Grass2439_g58224 = VERTEX_GRASS2242_g58224;
			float3 m_Simple2439_g58224 = VERTEX_POSITION2282_g58224;
			float clampResult2884_g58224 = clamp( ( _WIND_STRENGHT2400_g58224 - 0.95 ) , 0.0 , 1.0 );
			float3 break2708_g58224 = VERTEX_POSITION2282_g58224;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 break2718_g58224 = ase_worldPos;
			float temp_output_2690_0_g58224 = ( _WIND_RANDOM_OFFSET2244_g58224 * 25.0 );
			float clampResult2691_g58224 = clamp( 25.0 , 0.2 , 0.25 );
			float2 appendResult2694_g58224 = (float2(temp_output_2690_0_g58224 , ( temp_output_2690_0_g58224 / clampResult2691_g58224 )));
			float3 appendResult2706_g58224 = (float3(break2708_g58224.x , ( break2708_g58224.y + cos( ( ( ( break2718_g58224.x + break2718_g58224.y + break2718_g58224.z ) * 2.0 ) + appendResult2694_g58224 + FUNC_Angle2470_g58224 + _WIND_TUBULENCE2442_g58224 ) ) ).x , break2708_g58224.z));
			float3 temp_output_2613_0_g58224 = ( clampResult2884_g58224 * appendResult2706_g58224 );
			float3 ase_vertexNormal = v.normal.xyz;
			float4 ase_vertexTangent = v.tangent;
			float3 VERTEX_IVY997_g58224 = ( ( ( cos( temp_output_2613_0_g58224 ) + ( -0.3193 * UNITY_PI ) ) * ase_vertexNormal * 0.2 * ( FUNC_SinFunction2336_g58224 * v.color.b ) ) + ( sin( temp_output_2613_0_g58224 ) * cross( ase_vertexNormal , ase_vertexTangent.xyz ) * 0.2 ) );
			float3 m_Ivy2439_g58224 = VERTEX_IVY997_g58224;
			float3 localWind_Typefloat3switch2439_g58224 = Wind_Typefloat3switch2439_g58224( m_switch2439_g58224 , m_Leaf2439_g58224 , m_Palm2439_g58224 , m_Grass2439_g58224 , m_Simple2439_g58224 , m_Ivy2439_g58224 );
			float3 lerpResult3142_g58224 = lerp( float3(0,0,0) , localWind_Typefloat3switch2439_g58224 , ( _WindEnable + ( ( _CATEGORY_WIND + _SPACE_WIND ) * 0.0 ) ));
			float3 temp_output_1234_0_g58289 = lerpResult3142_g58224;
			v.vertex.xyz += temp_output_1234_0_g58289;
			v.vertex.w = 1;
			float m_switch80_g58525 = _UVMode;
			float2 m_UV080_g58525 = v.texcoord.xy;
			float2 m_UV180_g58525 = v.texcoord1.xy;
			float2 m_UV280_g58525 = v.texcoord2.xy;
			float2 m_UV380_g58525 = v.texcoord3.xy;
			float2 localfloat2switchUVMode80_g58525 = float2switchUVMode80_g58525( m_switch80_g58525 , m_UV080_g58525 , m_UV180_g58525 , m_UV280_g58525 , m_UV380_g58525 );
			float2 temp_output_1955_0_g58289 = (_MainUVs).xy;
			float2 temp_output_1953_0_g58289 = (_MainUVs).zw;
			float2 Offset235_g58525 = temp_output_1953_0_g58289;
			float2 temp_output_41_0_g58525 = ( ( localfloat2switchUVMode80_g58525 * temp_output_1955_0_g58289 ) + Offset235_g58525 );
			o.vertexToFrag70_g58525 = temp_output_41_0_g58525;
		}

		inline half4 LightingStandardCustom(SurfaceOutputStandardCustom s, half3 viewDir, UnityGI gi )
		{
			#if !defined(DIRECTIONAL)
			float3 lightAtten = gi.light.color;
			#else
			float3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, _TransShadow );
			#endif
			half3 lightDir = gi.light.dir + s.Normal * _TransNormalDistortion;
			half transVdotL = pow( saturate( dot( viewDir, -lightDir ) ), _TransScattering );
			half3 translucency = lightAtten * (transVdotL * _TransDirect + gi.indirect.diffuse * _TransAmbient) * s.Translucency;
			half4 c = half4( s.Albedo * translucency * _Translucency, 0 );

			half3 transmission = max(0 , -dot(s.Normal, gi.light.dir)) * gi.light.color * s.Transmission;
			half4 d = half4(s.Albedo * transmission , 0);

			SurfaceOutputStandard r;
			r.Albedo = s.Albedo;
			r.Normal = s.Normal;
			r.Emission = s.Emission;
			r.Metallic = s.Metallic;
			r.Smoothness = s.Smoothness;
			r.Occlusion = s.Occlusion;
			r.Alpha = s.Alpha;
			return LightingStandard (r, viewDir, gi) + c + d;
		}

		inline void LightingStandardCustom_GI(SurfaceOutputStandardCustom s, UnityGIInput data, inout UnityGI gi )
		{
			#if defined(UNITY_PASS_DEFERRED) && UNITY_ENABLE_REFLECTION_BUFFERS
				gi = UnityGlobalIllumination(data, s.Occlusion, s.Normal);
			#else
				UNITY_GLOSSY_ENV_FROM_SURFACE( g, s, data );
				gi = UnityGlobalIllumination( data, s.Occlusion, s.Normal, g );
			#endif
		}

		void surf( Input i , inout SurfaceOutputStandardCustom o )
		{
			float temp_output_50_0_g58305 = _DoubleSidedNormalMode;
			float m_switch65_g58305 = temp_output_50_0_g58305;
			float2 UV213_g58289 = i.vertexToFrag70_g58525;
			float4 NORMAL_RGBA1382_g58289 = SAMPLE_TEXTURE2D( _BumpMap, sampler_BumpMap, UV213_g58289 );
			float3 temp_output_24_0_g58305 = UnpackScaleNormal( NORMAL_RGBA1382_g58289, _NormalStrength );
			float3 m_Flip65_g58305 = ( temp_output_24_0_g58305 * i.ASEIsFrontFacing );
			float3 break33_g58305 = temp_output_24_0_g58305;
			float3 appendResult41_g58305 = (float3(break33_g58305.x , break33_g58305.y , ( break33_g58305.z * i.ASEIsFrontFacing )));
			float3 m_Mirror65_g58305 = appendResult41_g58305;
			float3 m_None65_g58305 = temp_output_24_0_g58305;
			float3 local_NormalModefloat3switch65_g58305 = _NormalModefloat3switch( m_switch65_g58305 , m_Flip65_g58305 , m_Mirror65_g58305 , m_None65_g58305 );
			o.Normal = local_NormalModefloat3switch65_g58305;
			float3 temp_output_1923_0_g58289 = (_BaseColor).rgb;
			float4 tex2DNode2048_g58289 = SAMPLE_TEXTURE2D( _MainTex, sampler_MainTex, UV213_g58289 );
			float3 ALBEDO_RGBA1381_g58289 = (tex2DNode2048_g58289).rgb;
			float3 temp_output_3_0_g58289 = ( temp_output_1923_0_g58289 * ALBEDO_RGBA1381_g58289 * _Brightness );
			float3 temp_output_134_0_g58298 = temp_output_3_0_g58289;
			float m_switch168_g58298 = _ColorShiftSource;
			float m_ObjectSpace168_g58298 = ( _ColorShiftNoiseScale / 3 );
			float3 ase_worldPos = i.worldPos;
			float3 p1_g58299 = ( ase_worldPos * _ColorShiftWorldSpaceNoiseShift );
			float localSimpleNoise3D1_g58299 = SimpleNoise3D( p1_g58299 );
			float4 ase_vertex4Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 transform374_g58298 = mul(unity_ObjectToWorld,ase_vertex4Pos);
			float m_WorldSpace168_g58298 = ( ( localSimpleNoise3D1_g58299 / _ColorShiftNoiseScale ) - ( ( (transform374_g58298).w - _ColorShiftWorldSpaceOffset ) / _ColorShiftWorldSpaceDistance ) );
			float m_VertexColor168_g58298 = ( i.vertexColor.g - 0.5 );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			ase_vertexNormal = normalize( ase_vertexNormal );
			float m_VertexNormal168_g58298 = ( ase_vertexNormal.y - 0.5 );
			float localColorShift_Modefloatswitch168_g58298 = ColorShift_Modefloatswitch168_g58298( m_switch168_g58298 , m_ObjectSpace168_g58298 , m_WorldSpace168_g58298 , m_VertexColor168_g58298 , m_VertexNormal168_g58298 );
			float temp_output_112_0_g58298 = sin( ( _ColorShiftNoiseScale * UNITY_PI ) );
			float3 BaseColor136_g58298 = temp_output_134_0_g58298;
			float2 appendResult120_g58298 = (float2(( (0.3 + (( 1.0 - temp_output_112_0_g58298 ) - 0.0) * (1.0 - 0.3) / (1.0 - 0.0)) * BaseColor136_g58298.x ) , 0.0));
			float2 RGB146_g58298 = appendResult120_g58298;
			float3 hsvTorgb122_g58298 = RGBToHSV( float3( RGB146_g58298 ,  0.0 ) );
			float VALUE219_g58298 = temp_output_112_0_g58298;
			float3 hsvTorgb126_g58298 = HSVToRGB( float3(( ( saturate( localColorShift_Modefloatswitch168_g58298 ) * _ColorShiftVariation ) + _ColorShiftVariationRGB + hsvTorgb122_g58298 ).x,( _ColorShiftSaturation * hsvTorgb122_g58298.y ),( hsvTorgb122_g58298.z + ( VALUE219_g58298 / 40 ) )) );
			float2 uv_ColorShiftMaskMap = i.uv_texcoord * _ColorShiftMaskMap_ST.xy + _ColorShiftMaskMap_ST.zw;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 transform376_g58298 = mul(unity_ObjectToWorld,float4( ase_vertex3Pos , 0.0 ));
			float3 temp_output_337_0_g58298 = saturate( ( 1.0 - ( (( SAMPLE_TEXTURE2D( _ColorShiftMaskMap, sampler_MainTex, uv_ColorShiftMaskMap ) * transform376_g58298 )).rgb / max( _ColorShiftMaskFuzziness , 1E-05 ) ) ) );
			float3 lerpResult314_g58298 = lerp( hsvTorgb126_g58298 , BaseColor136_g58298 , temp_output_337_0_g58298);
			float3 lerpResult311_g58298 = lerp( BaseColor136_g58298 , hsvTorgb126_g58298 , temp_output_337_0_g58298);
			float3 lerpResult389_g58298 = lerp( lerpResult314_g58298 , lerpResult311_g58298 , _ColorShiftMaskInverted);
			float3 lerpResult387_g58298 = lerp( hsvTorgb126_g58298 , lerpResult389_g58298 , _ColorShiftEnableMask);
			float3 lerpResult392_g58298 = lerp( temp_output_134_0_g58298 , lerpResult387_g58298 , _ColorShiftInfluence);
			float temp_output_402_0_g58298 = ( _ColorShiftEnable + ( ( _CATEGORY_COLORSHIFT + _SPACE_COLORSHIFT ) * 0.0 ) );
			float3 lerpResult393_g58298 = lerp( temp_output_134_0_g58298 , lerpResult392_g58298 , temp_output_402_0_g58298);
			o.Albedo = lerpResult393_g58298;
			float3 MASK_B1377_g58289 = (SAMPLE_TEXTURE2D( _MetallicGlossMap, sampler_MetallicGlossMap, UV213_g58289 )).rgb;
			o.Metallic = ( _MetallicStrength * MASK_B1377_g58289 ).x;
			float3 MASK_G158_g58289 = (SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_SmoothnessMap, UV213_g58289 )).rgb;
			float3 temp_output_2651_0_g58289 = ( 1.0 - MASK_G158_g58289 );
			float3 lerpResult2650_g58289 = lerp( MASK_G158_g58289 , temp_output_2651_0_g58289 , _SmoothnessSource);
			float3 temp_output_2693_0_g58289 = ( lerpResult2650_g58289 * _SmoothnessStrength );
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float2 appendResult2645_g58289 = (float2(ase_worldViewDir.xy));
			float3 appendResult2644_g58289 = (float3(appendResult2645_g58289 , ( ase_worldViewDir.z / 1.06 )));
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 break2680_g58289 = UnpackScaleNormal( NORMAL_RGBA1382_g58289, _NormalStrength );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3 normalizeResult2641_g58289 = normalize( ( ( ase_worldTangent * break2680_g58289.x ) + ( ase_worldBitangent * break2680_g58289.y ) + ( ase_worldNormal * break2680_g58289.z ) ) );
			float3 Normal_Per_Pixel2690_g58289 = normalizeResult2641_g58289;
			float fresnelNdotV2685_g58289 = dot( normalize( Normal_Per_Pixel2690_g58289 ), appendResult2644_g58289 );
			float fresnelNode2685_g58289 = ( 0.0 + ( 1.0 - _SmoothnessFresnelScale ) * pow( max( 1.0 - fresnelNdotV2685_g58289 , 0.0001 ), _SmoothnessFresnelPower ) );
			float3 temp_cast_8 = (fresnelNode2685_g58289).xxx;
			float3 lerpResult2636_g58289 = lerp( temp_output_2693_0_g58289 , ( temp_output_2693_0_g58289 - temp_cast_8 ) , _SmoothnessFresnelEnable);
			o.Smoothness = saturate( lerpResult2636_g58289 ).x;
			float3 MASK_R1378_g58289 = (SAMPLE_TEXTURE2D( _OcclusionMap, sampler_OcclusionMap, UV213_g58289 )).rgb;
			float3 lerpResult3415_g58289 = lerp( float3( 1,0,0 ) , MASK_R1378_g58289 , _OcclusionStrengthAO);
			float lerpResult3414_g58289 = lerp( 1.0 , i.vertexColor.a , _OcclusionStrengthAO);
			float3 temp_cast_10 = (lerpResult3414_g58289).xxx;
			float3 lerpResult2709_g58289 = lerp( lerpResult3415_g58289 , temp_cast_10 , _OcclusionSource);
			float3 temp_output_2730_0_g58289 = saturate( lerpResult2709_g58289 );
			o.Occlusion = temp_output_2730_0_g58289.x;
			float3 temp_output_249_0_g58294 = (_TransmissionColor).rgb;
			float4 color71_g58294 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			float3 temp_output_247_0_g58294 = (color71_g58294).rgb;
			float2 temp_output_101_0_g58294 = UV213_g58289;
			float3 temp_output_162_0_g58294 = saturate( ( (SAMPLE_TEXTURE2D( _TransmissionMaskMap, sampler_MainTex, temp_output_101_0_g58294 )).rgb / max( _TransmissionMaskFeather , 1E-05 ) ) );
			float3 lerpResult172_g58294 = lerp( temp_output_247_0_g58294 , temp_output_162_0_g58294 , _TransmissionMaskStrength);
			float temp_output_165_0_g58294 = ( 0.0 - 1.0 );
			float temp_output_168_0_g58294 = ( temp_output_162_0_g58294.x - 1.0 );
			float lerpResult173_g58294 = lerp( ( temp_output_165_0_g58294 / temp_output_168_0_g58294 ) , ( temp_output_168_0_g58294 / temp_output_165_0_g58294 ) , ( 0.7 + _TransmissionMaskStrength ));
			float3 lerpResult148_g58294 = lerp( ( temp_output_249_0_g58294 * _TransmissionStrength * lerpResult172_g58294 ) , ( temp_output_249_0_g58294 * _TransmissionStrength * saturate( lerpResult173_g58294 ) ) , _TransmissionMaskInverted);
			float3 lerpResult147_g58294 = lerp( ( temp_output_249_0_g58294 * _TransmissionStrength ) , lerpResult148_g58294 , _TransmissionSource);
			float3 lerpResult122_g58294 = lerp( float3( 0,0,0 ) , lerpResult147_g58294 , ( _TransmissionEnable + ( ( _CATEGORY_TRANSLUCENCY + _SPACE_TRANSMISSION ) * 0.0 ) ));
			o.Transmission = lerpResult122_g58294;
			float3 temp_output_248_0_g58294 = (_TranslucencyColor).rgb;
			float3 temp_output_113_0_g58294 = saturate( ( (SAMPLE_TEXTURE2D( _ThicknessMap, sampler_MainTex, temp_output_101_0_g58294 )).rgb / max( _ThicknessFeather , 1E-05 ) ) );
			float3 lerpResult34_g58294 = lerp( temp_output_247_0_g58294 , temp_output_113_0_g58294 , _ThicknessStrength);
			float temp_output_69_0_g58294 = ( 0.0 - 1.0 );
			float temp_output_22_0_g58294 = ( temp_output_113_0_g58294.x - 1.0 );
			float lerpResult66_g58294 = lerp( ( temp_output_69_0_g58294 / temp_output_22_0_g58294 ) , ( temp_output_22_0_g58294 / temp_output_69_0_g58294 ) , ( 0.7 + _ThicknessStrength ));
			float3 lerpResult153_g58294 = lerp( ( temp_output_248_0_g58294 * lerpResult34_g58294 * _TranslucencyStrength ) , ( temp_output_248_0_g58294 * saturate( lerpResult66_g58294 ) * _TranslucencyStrength ) , _ThicknessMapInverted);
			float3 lerpResult150_g58294 = lerp( ( temp_output_248_0_g58294 * _TranslucencyStrength ) , lerpResult153_g58294 , _TranslucencySource);
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 temp_output_88_0_g58294 = ( ( 1 * ase_lightColor.rgb ) * max( ase_lightColor.a , 0.0 ) );
			float3 lerpResult123_g58294 = lerp( float3( 0,0,0 ) , ( lerpResult150_g58294 * saturate( temp_output_88_0_g58294 ) ) , ( _TranslucencyEnable + ( ( _SPACE_TRANSLUCENCY + _CATEGORY_TRANSMISSION ) * 0.0 ) ));
			o.Translucency = lerpResult123_g58294;
			float temp_output_22_0_g58335 = tex2DNode2048_g58289.a;
			float temp_output_22_0_g58337 = temp_output_22_0_g58335;
			float temp_output_286_0_g58340 = ( (0.0 + (( 1.0 - temp_output_22_0_g58337 ) - 0.0) * (( _AlphaRemapMin + ( _AlphaRemap.x * 0.0 ) ) - 0.0) / (1.0 - 0.0)) + (0.0 + (temp_output_22_0_g58337 - 0.0) * (_AlphaRemapMax - 0.0) / (1.0 - 0.0)) );
			float temp_output_94_0_g58340 = ( 1.0 - _AlphaCutoffBias );
			clip( temp_output_286_0_g58340 - temp_output_94_0_g58340);
			float temp_output_340_291_g58335 = saturate( ( ( temp_output_286_0_g58340 / max( fwidth( temp_output_286_0_g58340 ) , 0.0001 ) ) + 0.5 ) );
			o.Alpha = temp_output_340_291_g58335;
			float3 temp_output_95_0_g58339 = cross( ddy( ase_worldPos ) , ddx( ase_worldPos ) );
			float3 normalizeResult96_g58339 = normalize( temp_output_95_0_g58339 );
			float dotResult74_g58335 = dot( normalizeResult96_g58339 , ase_worldViewDir );
			float temp_output_76_0_g58335 = ( 1.0 - abs( dotResult74_g58335 ) );
			#ifdef UNITY_PASS_SHADOWCASTER
				float staticSwitch281_g58335 = 1.0;
			#else
				float staticSwitch281_g58335 = ( 1.0 - ( temp_output_76_0_g58335 * temp_output_76_0_g58335 ) );
			#endif
			float lerpResult80_g58335 = lerp( 1.0 , staticSwitch281_g58335 , ( _GlancingClipMode + ( ( _CATEGORY_ALPHACLIPPING + _SPACE_ALPHACLIP ) * 0.0 ) ));
			clip( lerpResult80_g58335 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ALP8310_ShaderGUI"
}
/*ASEBEGIN
Version=19303
Node;AmplifyShaderEditor.FunctionNode;3140;-4672,-3712;Inherit;False;DESF Weather Wind;171;;58224;b135a554f7e4d0b41bba02c61b34ae74;5,3133,1,2371,1,2432,1,3138,0,3139,0;0;1;FLOAT3;2190
Node;AmplifyShaderEditor.StickyNoteNode;3155;-4448,-4080;Inherit;False;330.8999;334.9998;;;0,0,0,1;_TransmissionShadow$$_TranslucencyStrength$_TranslucencyNormalDistortion$_TranslucencyScattering$_TranslucencyDirect$_TranslucencyAmbient$_TranslucencyShadow;0;0
Node;AmplifyShaderEditor.IntNode;3135;-3968,-3792;Inherit;False;Property;_Cull;Render Face;1;2;[HideInInspector];[Enum];Create;False;1;;0;1;Front,2,Back,1,Both,0;True;0;False;2;0;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;3157;-4432,-3904;Inherit;False;Property;_CATEGORY_TRANSLUCENCYASE;CATEGORY_TRANSLUCENCY ASE;162;0;Create;True;0;0;0;True;1;DE_DrawerCategory(TRANSLUCENCY ASE,true,_TranslucencyStrength,0,0);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3156;-4432,-3824;Inherit;False;Property;_SPACE_TRANSLUCENCYASE;SPACE_TRANSLUCENCYASE;170;0;Create;True;0;0;0;True;1;DE_DrawerSpace(10);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;3163;-4416,-3712;Inherit;False;DESF Core Lit;2;;58289;e0cdd7758f4404849b063afff4596424;39,442,0,1557,1,1749,1,1556,1,2284,0,2283,0,2213,0,2481,0,2411,0,2399,0,2172,0,2282,0,3300,0,3301,0,3299,0,2132,0,3146,0,2311,0,3108,0,3119,0,3076,0,3408,0,3291,0,3290,0,3289,0,3287,0,96,2,2591,0,2559,0,1368,0,2125,0,2131,0,2028,0,1333,0,2126,1,1896,0,1415,0,830,0,2523,1;1;1234;FLOAT3;0,0,0;False;17;FLOAT3;38;FLOAT3;35;FLOAT3;37;FLOAT3;1922;FLOAT3;33;FLOAT3;34;FLOAT;46;FLOAT;814;FLOAT;1660;FLOAT3;656;FLOAT3;657;FLOAT3;655;FLOAT3;1235;FLOAT3;2760;SAMPLERSTATE;1819;SAMPLERSTATE;1824;SAMPLERSTATE;1818
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;1319;-3968,-3712;Float;False;True;-1;3;ALP8310_ShaderGUI;200;0;Standard;ALP/Cutout Translucency Wind;False;False;False;False;False;False;False;False;False;False;False;False;True;False;True;False;False;False;True;True;True;Back;0;False;_ZWriteMode;3;False;;False;0;False;;0;False;;False;3;Custom;0.45;True;True;0;True;TransparentCutout;;Geometry;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;200;;0;163;-1;-1;0;False;0;0;True;_Cull;-1;0;False;_MaskClipValue;1;Pragma;multi_compile_instancing;False;;Custom;False;0;0;;0;0;False;0.1;False;;0;False;;True;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3163;1234;3140;2190
WireConnection;1319;0;3163;38
WireConnection;1319;1;3163;35
WireConnection;1319;3;3163;37
WireConnection;1319;4;3163;33
WireConnection;1319;5;3163;34
WireConnection;1319;6;3163;656
WireConnection;1319;7;3163;657
WireConnection;1319;9;3163;46
WireConnection;1319;10;3163;814
WireConnection;1319;11;3163;1235
ASEEND*/
//CHKSM=EB0A8217EB457984FFE28183485EF6BD3B189FB6