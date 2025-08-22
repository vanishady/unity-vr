// Made with Amplify Shader Editor v1.9.3.3
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ALP/Surface Detail Wind"
{
	Properties
	{
		[HideInInspector][Enum(Front,2,Back,1,Both,0)]_Cull("Render Face", Int) = 2
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
		_NormalStrength("Normal Strength", Float) = 1
		[DE_DrawerSpace(10)]_SPACE_SURFACEINPUTS("SPACE_SURFACE INPUTS", Float) = 0
		[DE_DrawerCategory(TRANSMISSION,true,_TransmissionEnable,0,0)]_CATEGORY_TRANSMISSION("CATEGORY_TRANSMISSION", Float) = 0
		[DE_DrawerSpace(10)]_SPACE_TRANSLUCENCY("SPACE_TRANSLUCENCY", Float) = 0
		[DE_DrawerCategory(DETAIL MAPPING,true,_DetailEnable,0,0)]_CATEGORY_DETAILMAPPING("CATEGORY_DETAIL MAPPING", Float) = 0
		[DE_DrawerToggleLeft]_DetailEnable("ENABLE DETAIL MAP", Float) = 0
		[HDR]_DetailColor("Detail Color", Color) = (1,1,1,0)
		_DetailBrightness("Brightness", Range( 0 , 2)) = 1
		[DE_DrawerTextureSingleLine]_DetailColorMap("Detail Map", 2D) = "white" {}
		[DE_DrawerTilingOffset]_DetailUVs("Detail UVs", Vector) = (1,1,0,0)
		[DE_DrawerFloatEnum(UV0 _UV1 _UV2 _UV3)]_DetailUVMode("Detail UV Mode", Float) = 0
		_DetailUVRotation("Detail UV Rotation", Float) = 0
		[Normal][DE_DrawerTextureSingleLine]_DetailNormalMap("Normal Map", 2D) = "bump" {}
		_DetailNormalStrength("Normal Strength", Float) = 1
		[DE_DrawerFloatEnum(Off _Red _Green _Blue _Alpha)]_DetailBlendVertexColor("Blend Vertex Color", Int) = 0
		[DE_DrawerFloatEnum(BaseColor _Detail)]_DetailBlendSource("Blend Source", Float) = 1
		_DetailBlendStrength("Blend Strength", Range( 0 , 3)) = 1
		_DetailBlendHeight("Blend Height", Range( 0.001 , 3)) = 0.5
		_DetailBlendSmooth("Blend Smooth", Range( 0.001 , 1)) = 0.5
		[DE_DrawerToggleLeft][Space(5)]_DetailBlendEnableAltitudeMask("ENABLE ALTITUDE MASK", Float) = 0
		_DetailBlendHeightMin("Blend Height Min", Float) = -0.5
		_DetailBlendHeightMax("Blend Height Max", Float) = 1
		[DE_DrawerToggleLeft][Space(10)]_DetailMaskEnable("ENABLE DETAIL MAP MASK", Float) = 0
		[DE_DrawerToggleNoKeyword]_DetailMaskIsInverted("Detail Mask Is Inverted", Float) = 0
		[DE_DrawerTextureSingleLine]_DetailMaskMap("Detail Mask", 2D) = "white" {}
		[DE_DrawerTilingOffset]_DetailMaskUVs("Detail Mask UVs", Vector) = (1,1,0,0)
		_DetailMaskUVRotation("Detail Mask Rotation", Float) = 0
		_DetailMaskBlendStrength("Detail Mask Blend Strength", Range( 0.001 , 1)) = 1
		_DetailMaskBlendHardness("Detail Mask Blend Hardness", Range( 0.001 , 5)) = 1
		_DetailMaskBlendFalloff("Detail Mask Blend Falloff", Range( 0.001 , 0.999)) = 0.999
		[DE_DrawerSpace(10)]_SPACE_DETAIL("SPACE_DETAIL", Float) = 0
		[DE_DrawerCategory(DETAIL MAPPING SECONDARY,true,_DetailSecondaryEnable,0,0)]_CATEGORY_DETAILMAPPINGSECONDARY("CATEGORY_DETAIL MAPPING SECONDARY", Float) = 0
		[DE_DrawerSpace(10)]_SPACE_DETAILSECONDARY("SPACE_DETAILSECONDARY", Float) = 0
		[DE_DrawerCategory(WIND,true,_WindEnable,0,0)]_CATEGORY_WIND("CATEGORY_WIND", Float) = 0
		[DE_DrawerToggleLeft]_WindEnable("ENABLE WIND", Float) = 0
		[DE_DrawerFloatEnum(Global _Local)]_WindEnableMode("Enable Wind Mode", Float) = 0
		[Header(WIND GLOBAL)]_WindGlobalIntensity("Wind Intensity", Float) = 1
		[Header(WIND LOCAL)]_WindLocalIntensity("Local Wind Intensity", Float) = 1
		_WindLocalPulseFrequency("Local Wind Pulse Frequency", Float) = 0.1
		_WindLocalRandomOffset("Local Random Offset", Float) = 0.2
		_WindLocalDirection("Local Wind Direction", Range( 0 , 360)) = 0
		[DE_DrawerSpace(10)]_SPACE_WIND("SPACE_WIND", Float) = 0
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry-10" "IgnoreProjector" = "True" }
		LOD 200
		Cull [_Cull]
		ZTest LEqual
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
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

		#pragma surface surf Standard keepalpha addshadow fullforwardshadows dithercrossfade vertex:vertexDataFunc 
		struct Input
		{
			float2 vertexToFrag70_g58525;
			float2 vertexToFrag70_g58581;
			float4 vertexColor : COLOR;
			float2 vertexToFrag70_g58584;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform float _SPACE_TRANSLUCENCY;
		uniform float _CATEGORY_TRANSMISSION;
		uniform float _CATEGORY_SURFACEINPUTS;
		uniform float _SPACE_SURFACEINPUTS;
		uniform float _SPACE_COLOR;
		uniform float _CATEGORY_COLOR;
		uniform int _Cull;
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
		uniform half _WindEnable;
		uniform float _CATEGORY_WIND;
		uniform float _SPACE_WIND;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_BumpMap);
		uniform float _UVMode;
		uniform float4 _MainUVs;
		SamplerState sampler_BumpMap;
		uniform half _NormalStrength;
		uniform half4 _BaseColor;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainTex);
		SamplerState sampler_MainTex;
		uniform half _Brightness;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_DetailColorMap);
		uniform half _DetailUVRotation;
		uniform half _DetailUVMode;
		uniform float4 _DetailUVs;
		float4 _DetailColorMap_TexelSize;
		uniform half _DetailBlendSource;
		uniform half _DetailBlendStrength;
		uniform half _DetailBlendSmooth;
		uniform int _DetailBlendVertexColor;
		uniform half _DetailBlendHeight;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_DetailNormalMap);
		float4 _DetailNormalMap_TexelSize;
		uniform half _DetailNormalStrength;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_DetailMaskMap);
		uniform half _DetailMaskUVRotation;
		uniform float4 _DetailMaskUVs;
		float4 _DetailMaskMap_TexelSize;
		uniform half _DetailMaskIsInverted;
		uniform half _DetailMaskBlendStrength;
		uniform half _DetailMaskBlendHardness;
		uniform half _DetailMaskBlendFalloff;
		uniform half _DetailMaskEnable;
		uniform half _DetailEnable;
		uniform float _CATEGORY_DETAILMAPPING;
		uniform float _SPACE_DETAIL;
		uniform float _CATEGORY_DETAILMAPPINGSECONDARY;
		uniform float _SPACE_DETAILSECONDARY;
		uniform half4 _DetailColor;
		uniform half _DetailBrightness;
		uniform half _DetailBlendHeightMin;
		uniform half _DetailBlendHeightMax;
		uniform float _DetailBlendEnableAltitudeMask;
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


		float2 float2switchUVMode80_g58581( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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


		float MaskVCSwitch44_g58597( float m_switch, float m_Off, float m_R, float m_G, float m_B, float m_A )
		{
			if(m_switch ==0)
				return m_Off;
			else if(m_switch ==1)
				return m_R;
			else if(m_switch ==2)
				return m_G;
			else if(m_switch ==3)
				return m_B;
			else if(m_switch ==4)
				return m_A;
			else
			return float(0);
		}


		float2 float2switchUVMode80_g58584( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 VERTEX_POSITION_MATRIX2352_g57830 = mul( unity_ObjectToWorld, float4( ase_vertex3Pos , 0.0 ) ).xyz;
			float3 break2265_g57830 = VERTEX_POSITION_MATRIX2352_g57830;
			float GlobalWindIntensity3173_g57830 = _GlobalWindIntensity;
			float WIND_MODE2462_g57830 = _WindEnableMode;
			float lerpResult3147_g57830 = lerp( ( _WindGlobalIntensity * GlobalWindIntensity3173_g57830 ) , _WindLocalIntensity , WIND_MODE2462_g57830);
			float _WIND_STRENGHT2400_g57830 = lerpResult3147_g57830;
			float GlobalWindRandomOffset3174_g57830 = _GlobalWindRandomOffset;
			float lerpResult3149_g57830 = lerp( GlobalWindRandomOffset3174_g57830 , _WindLocalRandomOffset , WIND_MODE2462_g57830);
			float4 transform3073_g57830 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float2 appendResult2307_g57830 = (float2(transform3073_g57830.x , transform3073_g57830.z));
			float dotResult2341_g57830 = dot( appendResult2307_g57830 , float2( 12.9898,78.233 ) );
			float lerpResult2238_g57830 = lerp( 0.8 , ( ( lerpResult3149_g57830 / 2.0 ) + 0.9 ) , frac( ( sin( dotResult2341_g57830 ) * 43758.55 ) ));
			float _WIND_RANDOM_OFFSET2244_g57830 = ( _Time.x * lerpResult2238_g57830 );
			float _WIND_TUBULENCE_RANDOM2274_g57830 = ( sin( ( ( _WIND_RANDOM_OFFSET2244_g57830 * 40.0 ) - ( VERTEX_POSITION_MATRIX2352_g57830.z / 15.0 ) ) ) * 0.5 );
			float GlobalWindPulse3177_g57830 = _GlobalWindPulse;
			float lerpResult3152_g57830 = lerp( GlobalWindPulse3177_g57830 , _WindLocalPulseFrequency , WIND_MODE2462_g57830);
			float _WIND_PULSE2421_g57830 = lerpResult3152_g57830;
			float FUNC_Angle2470_g57830 = ( _WIND_STRENGHT2400_g57830 * ( 1.0 + sin( ( ( ( ( _WIND_RANDOM_OFFSET2244_g57830 * 2.0 ) + _WIND_TUBULENCE_RANDOM2274_g57830 ) - ( VERTEX_POSITION_MATRIX2352_g57830.z / 50.0 ) ) - ( v.color.r / 20.0 ) ) ) ) * sqrt( v.color.r ) * _WIND_PULSE2421_g57830 );
			float FUNC_Angle_SinA2424_g57830 = sin( FUNC_Angle2470_g57830 );
			float FUNC_Angle_CosA2362_g57830 = cos( FUNC_Angle2470_g57830 );
			float GlobalWindDirection3175_g57830 = _GlobalWindDirection;
			float lerpResult3150_g57830 = lerp( GlobalWindDirection3175_g57830 , _WindLocalDirection , WIND_MODE2462_g57830);
			float _WindDirection2249_g57830 = lerpResult3150_g57830;
			float2 localDirectionalEquation2249_g57830 = DirectionalEquation( _WindDirection2249_g57830 );
			float2 break2469_g57830 = localDirectionalEquation2249_g57830;
			float _WIND_DIRECTION_X2418_g57830 = break2469_g57830.x;
			float lerpResult2258_g57830 = lerp( break2265_g57830.x , ( ( break2265_g57830.y * FUNC_Angle_SinA2424_g57830 ) + ( break2265_g57830.x * FUNC_Angle_CosA2362_g57830 ) ) , _WIND_DIRECTION_X2418_g57830);
			float3 break2340_g57830 = VERTEX_POSITION_MATRIX2352_g57830;
			float3 break2233_g57830 = VERTEX_POSITION_MATRIX2352_g57830;
			float _WIND_DIRECTION_Y2416_g57830 = break2469_g57830.y;
			float lerpResult2275_g57830 = lerp( break2233_g57830.z , ( ( break2233_g57830.y * FUNC_Angle_SinA2424_g57830 ) + ( break2233_g57830.z * FUNC_Angle_CosA2362_g57830 ) ) , _WIND_DIRECTION_Y2416_g57830);
			float3 appendResult2235_g57830 = (float3(lerpResult2258_g57830 , ( ( break2340_g57830.y * FUNC_Angle_CosA2362_g57830 ) - ( break2340_g57830.z * FUNC_Angle_SinA2424_g57830 ) ) , lerpResult2275_g57830));
			float3 VERTEX_POSITION2282_g57830 = ( mul( unity_WorldToObject, float4( appendResult2235_g57830 , 0.0 ) ).xyz - ase_vertex3Pos );
			float3 lerpResult3142_g57830 = lerp( float3(0,0,0) , VERTEX_POSITION2282_g57830 , ( _WindEnable + ( ( _CATEGORY_WIND + _SPACE_WIND ) * 0.0 ) ));
			float3 temp_output_1234_0_g57865 = lerpResult3142_g57830;
			v.vertex.xyz += temp_output_1234_0_g57865;
			v.vertex.w = 1;
			float m_switch80_g58525 = _UVMode;
			float2 m_UV080_g58525 = v.texcoord.xy;
			float2 m_UV180_g58525 = v.texcoord1.xy;
			float2 m_UV280_g58525 = v.texcoord2.xy;
			float2 m_UV380_g58525 = v.texcoord3.xy;
			float2 localfloat2switchUVMode80_g58525 = float2switchUVMode80_g58525( m_switch80_g58525 , m_UV080_g58525 , m_UV180_g58525 , m_UV280_g58525 , m_UV380_g58525 );
			float2 temp_output_1955_0_g57865 = (_MainUVs).xy;
			float2 temp_output_1953_0_g57865 = (_MainUVs).zw;
			float2 Offset235_g58525 = temp_output_1953_0_g57865;
			float2 temp_output_41_0_g58525 = ( ( localfloat2switchUVMode80_g58525 * temp_output_1955_0_g57865 ) + Offset235_g58525 );
			o.vertexToFrag70_g58525 = temp_output_41_0_g58525;
			float temp_output_6_0_g58581 = _DetailUVRotation;
			float temp_output_200_0_g58581 = radians( temp_output_6_0_g58581 );
			float temp_output_13_0_g58581 = cos( temp_output_200_0_g58581 );
			float m_switch80_g58581 = _DetailUVMode;
			float2 m_UV080_g58581 = v.texcoord.xy;
			float2 m_UV180_g58581 = v.texcoord1.xy;
			float2 m_UV280_g58581 = v.texcoord2.xy;
			float2 m_UV380_g58581 = v.texcoord3.xy;
			float2 localfloat2switchUVMode80_g58581 = float2switchUVMode80_g58581( m_switch80_g58581 , m_UV080_g58581 , m_UV180_g58581 , m_UV280_g58581 , m_UV380_g58581 );
			float2 temp_output_9_0_g58581 = float2( 0.5,0.5 );
			float2 break39_g58581 = ( localfloat2switchUVMode80_g58581 - temp_output_9_0_g58581 );
			float temp_output_14_0_g58581 = sin( temp_output_200_0_g58581 );
			float2 appendResult36_g58581 = (float2(( ( temp_output_13_0_g58581 * break39_g58581.x ) + ( temp_output_14_0_g58581 * break39_g58581.y ) ) , ( ( temp_output_13_0_g58581 * break39_g58581.y ) - ( temp_output_14_0_g58581 * break39_g58581.x ) )));
			float2 Offset235_g58581 = (_DetailUVs).zw;
			float2 temp_output_41_0_g58581 = ( ( ( appendResult36_g58581 * ( (_DetailUVs).xy / 1.0 ) ) + temp_output_9_0_g58581 ) + Offset235_g58581 );
			float2 _ConstantAnchor = float2(0.5,0.5);
			o.vertexToFrag70_g58581 = ( temp_output_41_0_g58581 - ( ( ( (_DetailUVs).xy / 1.0 ) * _ConstantAnchor ) - _ConstantAnchor ) );
			float temp_output_6_0_g58584 = _DetailMaskUVRotation;
			float temp_output_200_0_g58584 = radians( temp_output_6_0_g58584 );
			float temp_output_13_0_g58584 = cos( temp_output_200_0_g58584 );
			float DetailUVMode1060_g58567 = _DetailUVMode;
			float m_switch80_g58584 = DetailUVMode1060_g58567;
			float2 m_UV080_g58584 = v.texcoord.xy;
			float2 m_UV180_g58584 = v.texcoord1.xy;
			float2 m_UV280_g58584 = v.texcoord2.xy;
			float2 m_UV380_g58584 = v.texcoord3.xy;
			float2 localfloat2switchUVMode80_g58584 = float2switchUVMode80_g58584( m_switch80_g58584 , m_UV080_g58584 , m_UV180_g58584 , m_UV280_g58584 , m_UV380_g58584 );
			float2 temp_output_9_0_g58584 = float2( 0.5,0.5 );
			float2 break39_g58584 = ( localfloat2switchUVMode80_g58584 - temp_output_9_0_g58584 );
			float temp_output_14_0_g58584 = sin( temp_output_200_0_g58584 );
			float2 appendResult36_g58584 = (float2(( ( temp_output_13_0_g58584 * break39_g58584.x ) + ( temp_output_14_0_g58584 * break39_g58584.y ) ) , ( ( temp_output_13_0_g58584 * break39_g58584.y ) - ( temp_output_14_0_g58584 * break39_g58584.x ) )));
			float2 Offset235_g58584 = (_DetailMaskUVs).zw;
			float2 temp_output_41_0_g58584 = ( ( ( appendResult36_g58584 * ( (_DetailMaskUVs).xy / 1.0 ) ) + temp_output_9_0_g58584 ) + Offset235_g58584 );
			o.vertexToFrag70_g58584 = ( temp_output_41_0_g58584 - ( ( ( (_DetailMaskUVs).xy / 1.0 ) * _ConstantAnchor ) - _ConstantAnchor ) );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 UV213_g57865 = i.vertexToFrag70_g58525;
			float4 NORMAL_RGBA1382_g57865 = SAMPLE_TEXTURE2D( _BumpMap, sampler_BumpMap, UV213_g57865 );
			float3 temp_output_38_0_g58567 = UnpackScaleNormal( NORMAL_RGBA1382_g57865, _NormalStrength );
			float3 temp_output_1923_0_g57865 = (_BaseColor).rgb;
			float4 tex2DNode2048_g57865 = SAMPLE_TEXTURE2D( _MainTex, sampler_MainTex, UV213_g57865 );
			float3 ALBEDO_RGBA1381_g57865 = (tex2DNode2048_g57865).rgb;
			float3 temp_output_3_0_g57865 = ( temp_output_1923_0_g57865 * ALBEDO_RGBA1381_g57865 * _Brightness );
			float3 temp_output_39_0_g58567 = temp_output_3_0_g57865;
			float BaseColor_R1273_g58567 = temp_output_39_0_g58567.x;
			float localStochasticTiling159_g58572 = ( 0.0 );
			float2 temp_output_1334_0_g58567 = i.vertexToFrag70_g58581;
			float2 UV159_g58572 = temp_output_1334_0_g58567;
			float4 TexelSize159_g58572 = _DetailColorMap_TexelSize;
			float4 Offsets159_g58572 = float4( 0,0,0,0 );
			float2 Weights159_g58572 = float2( 0,0 );
			{
			UV159_g58572 = UV159_g58572 * TexelSize159_g58572.zw - 0.5;
			float2 f = frac( UV159_g58572 );
			UV159_g58572 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV159_g58572.x - 0.5, UV159_g58572.x + 1.5, UV159_g58572.y - 0.5, UV159_g58572.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets159_g58572 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize159_g58572.xyxy;
			Weights159_g58572 = float2( w0, w1 );
			}
			float4 Input_FetchOffsets70_g58573 = Offsets159_g58572;
			float2 Input_FetchWeights143_g58573 = Weights159_g58572;
			float2 break46_g58573 = Input_FetchWeights143_g58573;
			float4 lerpResult20_g58573 = lerp( SAMPLE_TEXTURE2D( _DetailColorMap, sampler_MainTex, (Input_FetchOffsets70_g58573).yw ) , SAMPLE_TEXTURE2D( _DetailColorMap, sampler_MainTex, (Input_FetchOffsets70_g58573).xw ) , break46_g58573.x);
			float4 lerpResult40_g58573 = lerp( SAMPLE_TEXTURE2D( _DetailColorMap, sampler_MainTex, (Input_FetchOffsets70_g58573).yz ) , SAMPLE_TEXTURE2D( _DetailColorMap, sampler_MainTex, (Input_FetchOffsets70_g58573).xz ) , break46_g58573.x);
			float4 lerpResult22_g58573 = lerp( lerpResult20_g58573 , lerpResult40_g58573 , break46_g58573.y);
			float4 Output_Fetch2D44_g58573 = lerpResult22_g58573;
			float BaseColor_DetailR887_g58567 = Output_Fetch2D44_g58573.r;
			float lerpResult1105_g58567 = lerp( BaseColor_R1273_g58567 , BaseColor_DetailR887_g58567 , _DetailBlendSource);
			float m_switch44_g58597 = (float)_DetailBlendVertexColor;
			float m_Off44_g58597 = 1.0;
			float dotResult58_g58597 = dot( i.vertexColor.g , i.vertexColor.g );
			float dotResult61_g58597 = dot( i.vertexColor.b , i.vertexColor.b );
			float m_R44_g58597 = ( dotResult58_g58597 + dotResult61_g58597 );
			float dotResult57_g58597 = dot( i.vertexColor.r , i.vertexColor.r );
			float m_G44_g58597 = ( dotResult57_g58597 + dotResult58_g58597 );
			float m_B44_g58597 = ( dotResult57_g58597 + dotResult61_g58597 );
			float m_A44_g58597 = i.vertexColor.a;
			float localMaskVCSwitch44_g58597 = MaskVCSwitch44_g58597( m_switch44_g58597 , m_Off44_g58597 , m_R44_g58597 , m_G44_g58597 , m_B44_g58597 , m_A44_g58597 );
			float clampResult54_g58597 = clamp( ( ( localMaskVCSwitch44_g58597 * _DetailBlendHeight ) / _DetailBlendSmooth ) , 0.0 , 1.0 );
			float Blend647_g58567 = saturate( ( ( ( ( lerpResult1105_g58567 - 0.5 ) * ( ( 1.0 - _DetailBlendStrength ) - 0.9 ) ) / ( 1.0 - _DetailBlendSmooth ) ) + ( 1.0 - clampResult54_g58597 ) ) );
			float localStochasticTiling159_g58578 = ( 0.0 );
			float2 UV159_g58578 = temp_output_1334_0_g58567;
			float4 TexelSize159_g58578 = _DetailNormalMap_TexelSize;
			float4 Offsets159_g58578 = float4( 0,0,0,0 );
			float2 Weights159_g58578 = float2( 0,0 );
			{
			UV159_g58578 = UV159_g58578 * TexelSize159_g58578.zw - 0.5;
			float2 f = frac( UV159_g58578 );
			UV159_g58578 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV159_g58578.x - 0.5, UV159_g58578.x + 1.5, UV159_g58578.y - 0.5, UV159_g58578.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets159_g58578 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize159_g58578.xyxy;
			Weights159_g58578 = float2( w0, w1 );
			}
			float4 Input_FetchOffsets70_g58577 = Offsets159_g58578;
			float2 Input_FetchWeights143_g58577 = Weights159_g58578;
			float2 break46_g58577 = Input_FetchWeights143_g58577;
			float4 lerpResult20_g58577 = lerp( SAMPLE_TEXTURE2D( _DetailNormalMap, sampler_BumpMap, (Input_FetchOffsets70_g58577).yw ) , SAMPLE_TEXTURE2D( _DetailNormalMap, sampler_BumpMap, (Input_FetchOffsets70_g58577).xw ) , break46_g58577.x);
			float4 lerpResult40_g58577 = lerp( SAMPLE_TEXTURE2D( _DetailNormalMap, sampler_BumpMap, (Input_FetchOffsets70_g58577).yz ) , SAMPLE_TEXTURE2D( _DetailNormalMap, sampler_BumpMap, (Input_FetchOffsets70_g58577).xz ) , break46_g58577.x);
			float4 lerpResult22_g58577 = lerp( lerpResult20_g58577 , lerpResult40_g58577 , break46_g58577.y);
			float4 Output_Fetch2D44_g58577 = lerpResult22_g58577;
			float3 Normal_In880_g58567 = temp_output_38_0_g58567;
			float localStochasticTiling159_g58579 = ( 0.0 );
			float2 temp_output_1339_0_g58567 = i.vertexToFrag70_g58584;
			float2 UV159_g58579 = temp_output_1339_0_g58567;
			float4 TexelSize159_g58579 = _DetailMaskMap_TexelSize;
			float4 Offsets159_g58579 = float4( 0,0,0,0 );
			float2 Weights159_g58579 = float2( 0,0 );
			{
			UV159_g58579 = UV159_g58579 * TexelSize159_g58579.zw - 0.5;
			float2 f = frac( UV159_g58579 );
			UV159_g58579 -= f;
			float4 xn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.xxxx;
			float4 yn = float4( 1.0, 2.0, 3.0, 4.0 ) - f.yyyy;
			float4 xs = xn * xn * xn;
			float4 ys = yn * yn * yn;
			float3 xv = float3( xs.x, xs.y - 4.0 * xs.x, xs.z - 4.0 * xs.y + 6.0 * xs.x );
			float3 yv = float3( ys.x, ys.y - 4.0 * ys.x, ys.z - 4.0 * ys.y + 6.0 * ys.x );
			float4 xc = float4( xv.xyz, 6.0 - xv.x - xv.y - xv.z );
			float4 yc = float4( yv.xyz, 6.0 - yv.x - yv.y - yv.z );
			float4 c = float4( UV159_g58579.x - 0.5, UV159_g58579.x + 1.5, UV159_g58579.y - 0.5, UV159_g58579.y + 1.5 );
			float4 s = float4( xc.x + xc.y, xc.z + xc.w, yc.x + yc.y, yc.z + yc.w );
			float w0 = s.x / ( s.x + s.y );
			float w1 = s.z / ( s.z + s.w );
			Offsets159_g58579 = ( c + float4( xc.y, xc.w, yc.y, yc.w ) / s ) * TexelSize159_g58579.xyxy;
			Weights159_g58579 = float2( w0, w1 );
			}
			float4 Input_FetchOffsets70_g58580 = Offsets159_g58579;
			float2 Input_FetchWeights143_g58580 = Weights159_g58579;
			float2 break46_g58580 = Input_FetchWeights143_g58580;
			float4 lerpResult20_g58580 = lerp( SAMPLE_TEXTURE2D( _DetailMaskMap, sampler_MainTex, (Input_FetchOffsets70_g58580).yw ) , SAMPLE_TEXTURE2D( _DetailMaskMap, sampler_MainTex, (Input_FetchOffsets70_g58580).xw ) , break46_g58580.x);
			float4 lerpResult40_g58580 = lerp( SAMPLE_TEXTURE2D( _DetailMaskMap, sampler_MainTex, (Input_FetchOffsets70_g58580).yz ) , SAMPLE_TEXTURE2D( _DetailMaskMap, sampler_MainTex, (Input_FetchOffsets70_g58580).xz ) , break46_g58580.x);
			float4 lerpResult22_g58580 = lerp( lerpResult20_g58580 , lerpResult40_g58580 , break46_g58580.y);
			float4 Output_Fetch2D44_g58580 = lerpResult22_g58580;
			float4 break50_g58580 = Output_Fetch2D44_g58580;
			float lerpResult997_g58567 = lerp( ( 1.0 - break50_g58580.r ) , break50_g58580.r , _DetailMaskIsInverted);
			float temp_output_15_0_g58595 = ( 1.0 - lerpResult997_g58567 );
			float temp_output_26_0_g58595 = _DetailMaskBlendStrength;
			float temp_output_24_0_g58595 = _DetailMaskBlendHardness;
			float saferPower2_g58595 = abs( max( saturate( (0.0 + (temp_output_15_0_g58595 - ( 1.0 - temp_output_26_0_g58595 )) * (temp_output_24_0_g58595 - 0.0) / (1.0 - ( 1.0 - temp_output_26_0_g58595 ))) ) , 0.0 ) );
			float temp_output_22_0_g58595 = _DetailMaskBlendFalloff;
			float Blend_DetailMask986_g58567 = saturate( pow( saferPower2_g58595 , ( 1.0 - temp_output_22_0_g58595 ) ) );
			float3 lerpResult1286_g58567 = lerp( Normal_In880_g58567 , UnpackScaleNormal( Output_Fetch2D44_g58577, _DetailNormalStrength ) , Blend_DetailMask986_g58567);
			float3 lerpResult1011_g58567 = lerp( UnpackScaleNormal( Output_Fetch2D44_g58577, _DetailNormalStrength ) , lerpResult1286_g58567 , _DetailMaskEnable);
			float3 Normal_Detail199_g58567 = lerpResult1011_g58567;
			float layeredBlendVar1278_g58567 = Blend647_g58567;
			float3 layeredBlend1278_g58567 = ( lerp( temp_output_38_0_g58567,Normal_Detail199_g58567 , layeredBlendVar1278_g58567 ) );
			float3 break817_g58567 = layeredBlend1278_g58567;
			float3 appendResult820_g58567 = (float3(break817_g58567.x , break817_g58567.y , ( break817_g58567.z + 0.001 )));
			float temp_output_634_0_g58567 = ( _DetailEnable + ( ( _CATEGORY_DETAILMAPPING + _SPACE_DETAIL + _CATEGORY_DETAILMAPPINGSECONDARY + _SPACE_DETAILSECONDARY ) * 0.0 ) );
			float3 lerpResult410_g58567 = lerp( temp_output_38_0_g58567 , appendResult820_g58567 , temp_output_634_0_g58567);
			o.Normal = lerpResult410_g58567;
			float3 temp_output_44_0_g58567 = ( (_DetailColor).rgb * (Output_Fetch2D44_g58573).rgb * _DetailBrightness );
			float3 temp_output_1272_0_g58567 = (unity_ColorSpaceDouble).rgb;
			float3 temp_output_1190_0_g58567 = ( temp_output_44_0_g58567 * temp_output_1272_0_g58567 );
			float3 BaseColor_RGB40_g58567 = temp_output_39_0_g58567;
			float3 lerpResult1194_g58567 = lerp( BaseColor_RGB40_g58567 , temp_output_1190_0_g58567 , Blend_DetailMask986_g58567);
			float temp_output_1162_0_g58567 = ( 1.0 - Blend_DetailMask986_g58567 );
			float3 appendResult1161_g58567 = (float3(temp_output_1162_0_g58567 , temp_output_1162_0_g58567 , temp_output_1162_0_g58567));
			float3 lerpResult1005_g58567 = lerp( temp_output_1190_0_g58567 , ( ( lerpResult1194_g58567 * Blend_DetailMask986_g58567 ) + appendResult1161_g58567 ) , _DetailMaskEnable);
			float3 BaseColor_Detail255_g58567 = lerpResult1005_g58567;
			float temp_output_1171_0_g58567 = ( 1.0 - Blend647_g58567 );
			float3 appendResult1174_g58567 = (float3(temp_output_1171_0_g58567 , temp_output_1171_0_g58567 , temp_output_1171_0_g58567));
			float3 temp_output_1173_0_g58567 = ( ( BaseColor_Detail255_g58567 * Blend647_g58567 ) + appendResult1174_g58567 );
			float temp_output_20_0_g58598 = _DetailBlendHeightMin;
			float temp_output_21_0_g58598 = _DetailBlendHeightMax;
			float3 ase_worldPos = i.worldPos;
			float3 worldToObj1466_g58567 = mul( unity_WorldToObject, float4( ase_worldPos, 1 ) ).xyz;
			float3 WorldPosition1436_g58567 = worldToObj1466_g58567;
			float smoothstepResult25_g58598 = smoothstep( temp_output_20_0_g58598 , temp_output_21_0_g58598 , WorldPosition1436_g58567.y);
			float DetailBlendHeight1440_g58567 = smoothstepResult25_g58598;
			float3 lerpResult1438_g58567 = lerp( temp_output_1173_0_g58567 , temp_output_39_0_g58567 , DetailBlendHeight1440_g58567);
			float3 lerpResult1457_g58567 = lerp( temp_output_1173_0_g58567 , lerpResult1438_g58567 , _DetailBlendEnableAltitudeMask);
			float3 temp_output_1180_0_g58567 = ( temp_output_39_0_g58567 * lerpResult1457_g58567 );
			float3 lerpResult409_g58567 = lerp( temp_output_39_0_g58567 , temp_output_1180_0_g58567 , temp_output_634_0_g58567);
			o.Albedo = lerpResult409_g58567;
			float3 MASK_B1377_g57865 = (SAMPLE_TEXTURE2D( _MetallicGlossMap, sampler_MetallicGlossMap, UV213_g57865 )).rgb;
			o.Metallic = ( _MetallicStrength * MASK_B1377_g57865 ).x;
			float3 MASK_G158_g57865 = (SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_SmoothnessMap, UV213_g57865 )).rgb;
			float3 temp_output_2651_0_g57865 = ( 1.0 - MASK_G158_g57865 );
			float3 lerpResult2650_g57865 = lerp( MASK_G158_g57865 , temp_output_2651_0_g57865 , _SmoothnessSource);
			float3 temp_output_2693_0_g57865 = ( lerpResult2650_g57865 * _SmoothnessStrength );
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float2 appendResult2645_g57865 = (float2(ase_worldViewDir.xy));
			float3 appendResult2644_g57865 = (float3(appendResult2645_g57865 , ( ase_worldViewDir.z / 1.06 )));
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 break2680_g57865 = UnpackScaleNormal( NORMAL_RGBA1382_g57865, _NormalStrength );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 normalizeResult2641_g57865 = normalize( ( ( ase_worldTangent * break2680_g57865.x ) + ( ase_worldBitangent * break2680_g57865.y ) + ( ase_worldNormal * break2680_g57865.z ) ) );
			float3 Normal_Per_Pixel2690_g57865 = normalizeResult2641_g57865;
			float fresnelNdotV2685_g57865 = dot( normalize( Normal_Per_Pixel2690_g57865 ), appendResult2644_g57865 );
			float fresnelNode2685_g57865 = ( 0.0 + ( 1.0 - _SmoothnessFresnelScale ) * pow( max( 1.0 - fresnelNdotV2685_g57865 , 0.0001 ), _SmoothnessFresnelPower ) );
			float3 temp_cast_7 = (fresnelNode2685_g57865).xxx;
			float3 lerpResult2636_g57865 = lerp( temp_output_2693_0_g57865 , ( temp_output_2693_0_g57865 - temp_cast_7 ) , _SmoothnessFresnelEnable);
			o.Smoothness = saturate( lerpResult2636_g57865 ).x;
			float3 MASK_R1378_g57865 = (SAMPLE_TEXTURE2D( _OcclusionMap, sampler_OcclusionMap, UV213_g57865 )).rgb;
			float3 lerpResult3415_g57865 = lerp( float3( 1,0,0 ) , MASK_R1378_g57865 , _OcclusionStrengthAO);
			float lerpResult3414_g57865 = lerp( 1.0 , i.vertexColor.a , _OcclusionStrengthAO);
			float3 temp_cast_9 = (lerpResult3414_g57865).xxx;
			float3 lerpResult2709_g57865 = lerp( lerpResult3415_g57865 , temp_cast_9 , _OcclusionSource);
			float3 temp_output_2730_0_g57865 = saturate( lerpResult2709_g57865 );
			o.Occlusion = temp_output_2730_0_g57865.x;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ALP8310_ShaderGUI"
}
/*ASEBEGIN
Version=19303
Node;AmplifyShaderEditor.FunctionNode;470;480,-768;Inherit;False;DESF Weather Wind;223;;57830;b135a554f7e4d0b41bba02c61b34ae74;5,3133,0,2371,0,2432,0,3138,0,3139,0;0;1;FLOAT3;2190
Node;AmplifyShaderEditor.FunctionNode;483;704,-768;Inherit;False;DESF Core Lit;2;;57865;e0cdd7758f4404849b063afff4596424;39,442,0,1557,1,1749,1,1556,1,2284,0,2283,0,2213,0,2481,0,2411,0,2399,0,2172,0,2282,0,3300,0,3301,0,3299,0,2132,0,3146,0,2311,0,3108,0,3119,0,3076,0,3408,0,3291,0,3290,0,3289,0,3287,0,96,0,2591,0,2559,0,1368,0,2125,0,2131,0,2028,0,1333,0,2126,0,1896,0,1415,0,830,0,2523,1;1;1234;FLOAT3;0,0,0;False;17;FLOAT3;38;FLOAT3;35;FLOAT3;37;FLOAT3;1922;FLOAT3;33;FLOAT3;34;FLOAT;46;FLOAT;814;FLOAT;1660;FLOAT3;656;FLOAT3;657;FLOAT3;655;FLOAT3;1235;FLOAT3;2760;SAMPLERSTATE;1819;SAMPLERSTATE;1824;SAMPLERSTATE;1818
Node;AmplifyShaderEditor.IntNode;482;1408,-848;Inherit;False;Property;_Cull;Render Face;0;2;[HideInInspector];[Enum];Create;False;1;;0;1;Front,2,Back,1,Both,0;True;0;False;2;2;False;0;1;INT;0
Node;AmplifyShaderEditor.FunctionNode;471;1120,-832;Inherit;False;DESF Module Detail;162;;58567;49c077198be2bdb409ab6ad879c0ca28;17,666,1,1023,1,1260,1,665,1,663,1,662,1,1006,1,1012,1,650,1,1067,0,727,0,726,0,874,0,602,0,945,1,1075,0,1316,0;4;39;FLOAT3;0,0,0;False;38;FLOAT3;0,0,1;False;456;SAMPLERSTATE;0;False;464;SAMPLERSTATE;0;False;2;FLOAT3;73;FLOAT3;72
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;194;1408,-768;Float;False;True;-1;3;ALP8310_ShaderGUI;200;0;Standard;ALP/Surface Detail Wind;False;False;False;False;False;False;False;False;False;False;False;False;True;False;True;False;False;False;True;True;True;Back;0;False;_ZWriteMode;3;False;;False;0;False;;0;False;;False;0;Custom;0.45;True;True;-10;True;Opaque;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;200;;1;-1;-1;-1;0;False;0;0;True;_Cull;-1;0;False;_MaskClipValue1;1;Pragma;multi_compile_instancing;False;;Custom;False;0;0;;0;0;False;0.1;False;;0;False;;True;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;483;1234;470;2190
WireConnection;471;39;483;38
WireConnection;471;38;483;35
WireConnection;471;456;483;1819
WireConnection;471;464;483;1824
WireConnection;194;0;471;73
WireConnection;194;1;471;72
WireConnection;194;3;483;37
WireConnection;194;4;483;33
WireConnection;194;5;483;34
WireConnection;194;11;483;1235
ASEEND*/
//CHKSM=EBBB3BD4C80D4D583851812368AC49BAD4578731