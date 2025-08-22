// Made with Amplify Shader Editor v1.9.3.3
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ALP/Water Gestner Waves"
{
	Properties
	{
		[HideInInspector][Enum(Front,2,Back,1,Both,0)]_Cull("Render Face", Int) = 2
		[HideInInspector][Enum(Off,0,On,1)]_ZWriteMode("ZWrite Mode", Int) = 1
		[DE_DrawerCategory(COLOR WATER LAYERS,true,_WaterShorelineTint,0,0)]_CATEGORY_COLORWATERLAYERS("CATEGORY_COLOR WATER LAYERS", Float) = 1
		[HDR]_WaterShorelineTint("Shoreline Tint", Color) = (0.2784314,0.4235294,0.4431373,1)
		_WaterShorelineDepth("Shoreline Depth", Range( 0 , 100)) = 40
		_WaterShorelineOffset("Shoreline Offset", Range( -1 , 1)) = 0.1
		[HDR]_WaterMidwaterTint("Midwater Tint", Color) = (0.1490196,0.4235294,0.4705882,1)
		[HDR]_WaterDepthTint("Depth Tint", Color) = (0.1960784,0.4313726,0.509804,1)
		_WaterDepthOffset("Depth Offset", Range( 0 , 10)) = 2
		[DE_DrawerSpace(10)]_SPACE_COLORWATERLAYERS("SPACE_COLOR WATER LAYERS", Float) = 0
		[DE_DrawerCategory(OPACITY,true,_WaterOpacity,0,0)]_CATEGORY_OPACITY("CATEGORY_OPACITY", Float) = 1
		_WaterOpacity("Opacity", Range( 0.001 , 1)) = 0.05
		_WaterOpacityShoreline("Opacity Shoreline", Range( 0 , 5)) = 1
		[DE_DrawerSpace(10)]_SPACE_OPACITY("SPACE_OPACITY", Float) = 0
		[DE_DrawerCategory(FOAM SHORELINE,true,_FoamShorelineEnable,0,0)]_CATEGORY_FOAMSHORELINE("CATEGORY_FOAMSHORELINE", Float) = 0
		[DE_DrawerToggleLeft]_FoamShorelineEnable("ENABLE FOAM", Float) = 1
		[HDR][Header(Foam)]_FoamShorelineColor("Foam Color", Color) = (1,1,1,0)
		[DE_DrawerTextureSingleLine]_FoamShorelineMap("Foam Map", 2D) = "black" {}
		[DE_DrawerTilingOffset]_FoamShorelineUVs("Foam UVs", Vector) = (50,50,0,0)
		_FoamShorelineStrength("Foam Strength", Range( 0 , 5)) = 1
		[HDR][Header(Foam Detail)]_FoamShorelineDetailColor("Foam Color", Color) = (1,1,1,0)
		[DE_DrawerTextureSingleLine]_FoamShorelineMapDetail("Foam Detail Map", 2D) = "black" {}
		[DE_DrawerTilingOffset]_FoamShorelineUVsDetail("Foam UVs", Vector) = (0.25,0.25,2,2)
		_FoamShorelineSpeed("Foam Speed", Float) = 0.001
		_FoamShorelineDistance("Foam Distance", Float) = 5
		_FoamShorelineDetailStrength("Foam Strength", Range( 0 , 5)) = 1
		[DE_DrawerSpace(10)]_SPACE_FOAMOFFSHORE("SPACE_FOAMOFFSHORE", Float) = 0
		[DE_DrawerCategory(FOAM OFFSHORE,true,_FoamOffshoreEnable,0,0)]_CATEGORY_FOAMOFFSHORE("CATEGORY_FOAMOFFSHORE", Float) = 0
		[DE_DrawerToggleLeft]_FoamOffshoreEnable("ENABLE FOAM", Float) = 1
		[HDR][Header(Foam)]_FoamOffshoreColor("Foam Color", Color) = (1,1,1,0)
		[DE_DrawerTextureSingleLine]_FoamOffshoreMap("Foam Map", 2D) = "black" {}
		[DE_DrawerTilingOffset]_FoamOffshoreUVs("Foam UVs", Vector) = (50,50,0,0)
		_FoamOffshoreStrength("Foam Strength", Range( 0 , 5)) = 1
		[HDR][Header(Foam Detail)]_FoamOffshoreDetailColor("Foam Color", Color) = (1,1,1,0)
		[DE_DrawerTextureSingleLine]_FoamOffshoreMapDetail("Foam Detail Map", 2D) = "black" {}
		[DE_DrawerTilingOffset]_FoamOffshoreUVsDetail("Foam UVs", Vector) = (0.25,0.25,0,0)
		_FoamOffshoreSpeed("Foam Speed", Float) = 0.001
		_FoamOffshoreDistance("Foam Distance", Float) = 55
		_FoamOffshoreEdge("Foam Edge", Float) = 10
		_FoamOffshoreDetailStrength("Foam Strength", Range( 0 , 5)) = 1
		[DE_DrawerSpace(10)]_SPACE_FOAMSHORELINE("SPACE_FOAMSHORELINE", Float) = 0
		[DE_DrawerCategory(NORMAL RIPPLE,true,_WaterNormalEnable,0,0)]_CATEGORY_NORMALRIPPLE("CATEGORY_NORMAL RIPPLE", Float) = 0
		[DE_DrawerToggleLeft]_WaterNormalEnable("ENABLE NORMAL MAP", Float) = 1
		[Normal][DE_DrawerTextureSingleLine]_WaterNormalMap("Normal Map", 2D) = "bump" {}
		_WaterNormalStrength("Normal Strength", Float) = 0.1
		[Header(Scale)]_WaterNormalScaleX("Normal Scale X", Float) = 0.45
		_WaterNormalScaleY("Normal Scale Y", Float) = 0.35
		_WaterNormalScaleZ("Normal Scale Z", Float) = 0.17
		_WaterNormalScaleW("Normal Scale W", Float) = 0.4
		[Header(Speed)]_WaterNormalSpeedX("Normal Speed X", Float) = -0.12
		_WaterNormalSpeedY("Normal Speed Y", Float) = 0.02
		_WaterNormalSpeedZ("Normal Speed Z", Float) = -0.1
		_WaterNormalSpeedW("Normal Speed W", Float) = -0.1
		[DE_DrawerSpace(10)]_SPACE_NORMALRIPPLE("SPACE_NORMAL RIPPLE", Float) = 0
		[DE_DrawerCategory(SMOOTHNESS,true,_WaterSmoothnessStrength,0,0)]_CATEGORY_SMOOTHNESS("CATEGORY_SMOOTHNESS", Float) = 1
		_WaterSmoothnessStrength("Smoothness Strength", Range( 0 , 2.5)) = 1
		[DE_DrawerSpace(10)]_SPACE_SMOOTHNESS("SPACE_SMOOTHNESS", Float) = 0
		[DE_DrawerCategory(SPECULAR,true,_WaterSpecularEnable,0,0)]_CATEGORY_SPECULAR("CATEGORY_SPECULAR", Float) = 0
		[DE_DrawerToggleLeft]_WaterSpecularEnable("ENABLE SPECULAR", Float) = 0
		[HDR]_WaterSpecularColor("Specular Color", Color) = (0.08865561,0.1301365,0.1946179,1)
		_WaterSpecularPower("Specular Power", Range( 0 , 1)) = 0
		_WaterSpecularStrengthDielectricIOR("Specular Strength Dielectric IOR", Range( 1 , 2.5)) = 1.1
		_WaterSpecularWrapScale("Specular Wrap Scale", Range( 0 , 5)) = 0.85
		_WaterSpecularWrapOffset("Specular Wrap Offset", Range( 0 , 3)) = 0
		[DE_DrawerSpace(10)]_SPACE_SPECULAR("SPACE_SPECULAR", Float) = 0
		[DE_DrawerCategory(REFRACTION,true,_WaterRefractionScale,0,0)]_CATEGORY_REFRACTION("CATEGORY_REFRACTION", Float) = 0
		_WaterRefractionScale("Refraction Scale", Range( 0 , 1)) = 0.2
		[DE_DrawerSpace(10)]_SPACE_REFRACTION("SPACE_REFRACTION", Float) = 0
		[DE_DrawerCategory(REFLECTION,true,_WaterReflectionEnable,0,0)]_CATEGORY_REFLECTION("CATEGORY_REFLECTION", Float) = 0
		[DE_DrawerToggleLeft]_WaterReflectionEnable("ENABLE REFLECTION", Float) = 0
		[HDR][DE_DrawerTextureSingleLine]_WaterReflectionCubemap("Reflection Cubemap", CUBE) = "white" {}
		_WaterReflectionCloud("Reflection Cloud", Range( 0 , 1)) = 1
		_WaterReflectionWobble("Reflection Wobble", Range( 0 , 0.1)) = 0
		_WaterReflectionSmoothness("Reflection Smoothness", Range( 0 , 2)) = 2
		_WaterReflectionBumpStrength("Reflection Bump Strength", Range( 0 , 1)) = 0.05
		_WaterReflectionBumpScale("Reflection Bump Scale", Range( 0 , 1)) = 0.05
		_WaterReflectionBumpClamp("Reflection Bump Clamp", Range( 0 , 0.15)) = 0.15
		[DE_DrawerToggleNoKeyword]_WaterReflectionEnableFresnel("Enable Fresnel", Float) = 0
		_WaterReflectionFresnelStrength("Fresnel Strength", Range( 0.001 , 1)) = 0.15
		_WaterReflectionFresnelBias("Fresnel Bias", Range( 0 , 1)) = 1
		_WaterReflectionFresnelScale("Fresnel Scale", Range( 0 , 1)) = 0.5
		[DE_DrawerSpace(10)]_SPACE_REFLECTION("SPACE_REFLECTION", Float) = 0
		[DE_DrawerCategory(WAVES GERSTNER,true,_WaveGerstnerEnable,0,0)]_CATEGORY_WAVESGERSTNER("CATEGORY_WAVESGERSTNER", Float) = 0
		[DE_DrawerToggleLeft]_WaveGerstnerEnable("ENABLE WAVES", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[Header(Wave 01)][DE_DrawerToggleLeft]_WaveGerstner01Enable("Enable Wave 01", Float) = 1
		_WaveGerstner01Direction("Wave 01 Direction", Vector) = (-0.2,0,-0.7,0)
		_WaveGerstner01Speed("Wave 01 Speed", Float) = 0.5
		_WaveGerstner01Length("Wave 01 Length", Float) = 2.5
		_WaveGerstner01Height("Wave 01 Height", Float) = 0.075
		_WaveGerstner01PeakSharpness("Wave 01 Peak Sharpness", Float) = 0.3
		[Header(Wave 02)][DE_DrawerToggleLeft]_WaveGerstner02Enable("Enable Wave 02", Float) = 1
		_WaveGerstner02Direction("Wave 02 Direction", Vector) = (-1,0,0,0)
		_WaveGerstner02Speed("Wave 02 Speed", Float) = 0.5
		_WaveGerstner02Length("Wave 02 Length", Float) = 3
		_WaveGerstner02Height("Wave 02 Height", Float) = 0.05
		_WaveGerstner02PeakSharpness("Wave 02 Peak Sharpness", Float) = 0.3
		[Header(Wave 03)][DE_DrawerToggleLeft]_WaveGerstner03Enable("Enable Wave 03", Float) = 1
		_WaveGerstner03Direction("Wave 03 Direction", Vector) = (-0.5,0,0.5,0)
		_WaveGerstner03Speed("Wave 03 Speed", Float) = 0.5
		_WaveGerstner03Length("Wave 03 Length", Float) = 1.8
		_WaveGerstner03Height("Wave 03 Height", Float) = 0.04
		_WaveGerstner03PeakSharpness("Wave 03 Peak Sharpness", Float) = 0.4
		[Header(Wave 04)][DE_DrawerToggleLeft]_WaveGerstner04Enable("Enable Wave 04", Float) = 1
		_WaveGerstner04Direction("Wave 04 Direction", Vector) = (-0.4,0,0.4,0)
		_WaveGerstner04Speed("Wave 04 Speed", Float) = 0.5
		_WaveGerstner04Length("Wave 04 Length", Float) = 1.8
		_WaveGerstner04Height("Wave 04 Height", Float) = 0.04
		_WaveGerstner04PeakSharpness("Wave 04 Peak Sharpness", Float) = 0.4
		[DE_DrawerToggleLeft][Space(10)]_WaveGerstnerEdgeFadeEnable("ENABLE EDGE FADE", Float) = 1
		_WaveGerstnerEdgeFadeRange("Edge Fade Range", Range( 0 , 250)) = 50
		[DE_DrawerSpace(10)]_SPACE_WAVESGERSTNER("SPACE_WAVESGERSTNER", Float) = 0
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent-2" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True" }
		LOD 200
		Cull [_Cull]
		ZWrite [_ZWriteMode]
		ZTest LEqual
		Blend SrcAlpha OneMinusSrcAlpha , SrcAlpha OneMinusSrcAlpha
		
		GrabPass{ }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 4.6
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#define ASE_USING_SAMPLING_MACROS 1
		#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
		#define SAMPLE_TEXTURECUBE_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
		#else//ASE Sampling Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
		#define SAMPLE_TEXTURECUBE_LOD(tex,samplertex,coord,lod) texCUBElod (tex,half4(coord,lod))
		#endif//ASE Sampling Macros

		#pragma surface surf StandardSpecular keepalpha noinstancing exclude_path:deferred vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float4 screenPos;
			float3 worldNormal;
			INTERNAL_DATA
			float eyeDepth;
			float2 uv_texcoord;
			float3 worldRefl;
			half ASEIsFrontFacing : VFACE;
		};

		uniform float _CATEGORY_COLORWATERLAYERS;
		uniform float _SPACE_COLORWATERLAYERS;
		uniform int _ZWriteMode;
		uniform int _Cull;
		uniform float3 _WaveGerstner01Direction;
		uniform half _WaveGerstner01Length;
		uniform half _WaveGerstner01Speed;
		uniform half _WaveGerstner01Height;
		uniform half _WaveGerstner01PeakSharpness;
		uniform half _WaveGerstner01Enable;
		uniform float3 _WaveGerstner02Direction;
		uniform half _WaveGerstner02Length;
		uniform half _WaveGerstner02Speed;
		uniform half _WaveGerstner02Height;
		uniform half _WaveGerstner02PeakSharpness;
		uniform half _WaveGerstner02Enable;
		uniform float3 _WaveGerstner03Direction;
		uniform half _WaveGerstner03Length;
		uniform half _WaveGerstner03Speed;
		uniform half _WaveGerstner03Height;
		uniform half _WaveGerstner03PeakSharpness;
		uniform half _WaveGerstner03Enable;
		uniform float3 _WaveGerstner04Direction;
		uniform half _WaveGerstner04Length;
		uniform half _WaveGerstner04Speed;
		uniform half _WaveGerstner04Height;
		uniform half _WaveGerstner04PeakSharpness;
		uniform half _WaveGerstner04Enable;
		uniform float _WaveGerstnerEdgeFadeRange;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _WaveGerstnerEdgeFadeEnable;
		uniform half _WaveGerstnerEnable;
		uniform float _CATEGORY_WAVESGERSTNER;
		uniform float _SPACE_WAVESGERSTNER;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_WaterNormalMap);
		uniform half _WaterNormalScaleX;
		uniform half _WaterNormalScaleY;
		uniform half _WaterNormalScaleZ;
		uniform half _WaterNormalScaleW;
		uniform half _WaterNormalSpeedX;
		uniform half _WaterNormalSpeedY;
		uniform half _WaterNormalSpeedZ;
		uniform half _WaterNormalSpeedW;
		SamplerState sampler_WaterNormalMap;
		uniform float _WaterNormalStrength;
		uniform half _WaterNormalEnable;
		uniform float _CATEGORY_NORMALRIPPLE;
		uniform float _SPACE_NORMALRIPPLE;
		uniform half4 _WaterDepthTint;
		uniform half4 _WaterShorelineTint;
		uniform half4 _WaterMidwaterTint;
		uniform half _WaterShorelineDepth;
		uniform half _WaterShorelineOffset;
		uniform half _WaterDepthOffset;
		uniform half _WaterOpacityShoreline;
		uniform half _WaterOpacity;
		uniform float _CATEGORY_OPACITY;
		uniform float _SPACE_OPACITY;
		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
		uniform half _WaterRefractionScale;
		uniform float _CATEGORY_REFRACTION;
		uniform float _SPACE_REFRACTION;
		UNITY_DECLARE_TEXCUBE_NOSAMPLER(_WaterReflectionCubemap);
		uniform half _WaterReflectionBumpStrength;
		uniform half _WaterReflectionBumpScale;
		uniform half _WaterReflectionBumpClamp;
		uniform half _WaterReflectionWobble;
		uniform half _WaterReflectionSmoothness;
		SamplerState sampler_WaterReflectionCubemap;
		uniform half _WaterReflectionCloud;
		uniform half _WaterReflectionFresnelStrength;
		uniform half _WaterReflectionFresnelBias;
		uniform half _WaterReflectionFresnelScale;
		uniform half _WaterReflectionEnableFresnel;
		uniform half _WaterReflectionEnable;
		uniform float _CATEGORY_REFLECTION;
		uniform float _SPACE_REFLECTION;
		uniform half4 _FoamShorelineColor;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_FoamShorelineMap);
		uniform float4 _FoamShorelineUVs;
		SamplerState sampler_FoamShorelineMap;
		uniform half _FoamShorelineStrength;
		uniform half4 _FoamShorelineDetailColor;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_FoamShorelineMapDetail);
		uniform float4 _FoamShorelineUVsDetail;
		uniform float _FoamShorelineSpeed;
		SamplerState sampler_FoamShorelineMapDetail;
		uniform half _FoamShorelineDetailStrength;
		uniform half _FoamShorelineDistance;
		uniform half _FoamShorelineEnable;
		uniform float _CATEGORY_FOAMSHORELINE;
		uniform float _SPACE_FOAMSHORELINE;
		uniform half4 _FoamOffshoreColor;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_FoamOffshoreMap);
		uniform float4 _FoamOffshoreUVs;
		SamplerState sampler_FoamOffshoreMap;
		uniform half _FoamOffshoreStrength;
		uniform half4 _FoamOffshoreDetailColor;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_FoamOffshoreMapDetail);
		uniform float4 _FoamOffshoreUVsDetail;
		uniform float _FoamOffshoreSpeed;
		SamplerState sampler_FoamOffshoreMapDetail;
		uniform half _FoamOffshoreDetailStrength;
		uniform half _FoamOffshoreEdge;
		uniform half _FoamOffshoreDistance;
		uniform half _FoamOffshoreEnable;
		uniform float _CATEGORY_FOAMOFFSHORE;
		uniform float _SPACE_FOAMOFFSHORE;
		uniform half4 _WaterSpecularColor;
		uniform half _WaterSpecularWrapScale;
		uniform half _WaterSpecularWrapOffset;
		uniform half _WaterSpecularPower;
		uniform half _WaterSpecularStrengthDielectricIOR;
		uniform half _WaterSpecularEnable;
		uniform float _CATEGORY_SPECULAR;
		uniform float _SPACE_SPECULAR;
		uniform half _WaterSmoothnessStrength;
		uniform float _CATEGORY_SMOOTHNESS;
		uniform float _SPACE_SMOOTHNESS;


		float3 ASESafeNormalize(float3 inVec)
		{
			float dp3 = max(1.175494351e-38, dot(inVec, inVec));
			return inVec* rsqrt(dp3);
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 worldToObj2005_g66922 = mul( unity_WorldToObject, float4( ase_worldPos, 1 ) ).xyz;
			float3 worldToObj419_g66924 = mul( unity_WorldToObject, float4( ase_worldPos, 1 ) ).xyz;
			float3 normalizeResult407_g66924 = normalize( _WaveGerstner01Direction );
			float temp_output_409_0_g66924 = ( 6.28318548202515 / _WaveGerstner01Length );
			float dotResult417_g66924 = dot( worldToObj419_g66924 , ( normalizeResult407_g66924 * temp_output_409_0_g66924 ) );
			float temp_output_421_0_g66924 = ( dotResult417_g66924 - ( sqrt( ( temp_output_409_0_g66924 * 9.8 ) ) * ( _Time.y * _WaveGerstner01Speed ) ) );
			float temp_output_422_0_g66924 = cos( temp_output_421_0_g66924 );
			float temp_output_432_0_g66924 = _WaveGerstner01Height;
			float WaveHeight433_g66924 = temp_output_432_0_g66924;
			float3 WaveDirection429_g66924 = normalizeResult407_g66924;
			float temp_output_426_0_g66924 = sin( temp_output_421_0_g66924 );
			float temp_output_431_0_g66924 = ( temp_output_409_0_g66924 * temp_output_432_0_g66924 );
			float temp_output_435_0_g66924 = ( _WaveGerstner01PeakSharpness / temp_output_431_0_g66924 );
			float3 lerpResult2419_g66922 = lerp( float3( 0,0,0 ) , ( ( ( temp_output_422_0_g66924 * float3(0,1,0) ) * WaveHeight433_g66924 ) - ( WaveDirection429_g66924 * ( temp_output_426_0_g66924 * ( temp_output_435_0_g66924 * temp_output_432_0_g66924 ) ) ) ) , _WaveGerstner01Enable);
			float3 worldToObj419_g66929 = mul( unity_WorldToObject, float4( ase_worldPos, 1 ) ).xyz;
			float3 normalizeResult407_g66929 = normalize( _WaveGerstner02Direction );
			float temp_output_409_0_g66929 = ( 6.28318548202515 / _WaveGerstner02Length );
			float dotResult417_g66929 = dot( worldToObj419_g66929 , ( normalizeResult407_g66929 * temp_output_409_0_g66929 ) );
			float temp_output_421_0_g66929 = ( dotResult417_g66929 - ( sqrt( ( temp_output_409_0_g66929 * 9.8 ) ) * ( _Time.y * _WaveGerstner02Speed ) ) );
			float temp_output_422_0_g66929 = cos( temp_output_421_0_g66929 );
			float temp_output_432_0_g66929 = _WaveGerstner02Height;
			float WaveHeight433_g66929 = temp_output_432_0_g66929;
			float3 WaveDirection429_g66929 = normalizeResult407_g66929;
			float temp_output_426_0_g66929 = sin( temp_output_421_0_g66929 );
			float temp_output_431_0_g66929 = ( temp_output_409_0_g66929 * temp_output_432_0_g66929 );
			float temp_output_435_0_g66929 = ( _WaveGerstner02PeakSharpness / temp_output_431_0_g66929 );
			float3 lerpResult2421_g66922 = lerp( float3( 0,0,0 ) , ( ( ( temp_output_422_0_g66929 * float3(0,1,0) ) * WaveHeight433_g66929 ) - ( WaveDirection429_g66929 * ( temp_output_426_0_g66929 * ( temp_output_435_0_g66929 * temp_output_432_0_g66929 ) ) ) ) , _WaveGerstner02Enable);
			float3 worldToObj419_g66928 = mul( unity_WorldToObject, float4( ase_worldPos, 1 ) ).xyz;
			float3 normalizeResult407_g66928 = normalize( _WaveGerstner03Direction );
			float temp_output_409_0_g66928 = ( 6.28318548202515 / _WaveGerstner03Length );
			float dotResult417_g66928 = dot( worldToObj419_g66928 , ( normalizeResult407_g66928 * temp_output_409_0_g66928 ) );
			float temp_output_421_0_g66928 = ( dotResult417_g66928 - ( sqrt( ( temp_output_409_0_g66928 * 9.8 ) ) * ( _Time.y * _WaveGerstner03Speed ) ) );
			float temp_output_422_0_g66928 = cos( temp_output_421_0_g66928 );
			float temp_output_432_0_g66928 = _WaveGerstner03Height;
			float WaveHeight433_g66928 = temp_output_432_0_g66928;
			float3 WaveDirection429_g66928 = normalizeResult407_g66928;
			float temp_output_426_0_g66928 = sin( temp_output_421_0_g66928 );
			float temp_output_431_0_g66928 = ( temp_output_409_0_g66928 * temp_output_432_0_g66928 );
			float temp_output_435_0_g66928 = ( _WaveGerstner03PeakSharpness / temp_output_431_0_g66928 );
			float3 lerpResult2414_g66922 = lerp( float3( 0,0,0 ) , ( ( ( temp_output_422_0_g66928 * float3(0,1,0) ) * WaveHeight433_g66928 ) - ( WaveDirection429_g66928 * ( temp_output_426_0_g66928 * ( temp_output_435_0_g66928 * temp_output_432_0_g66928 ) ) ) ) , _WaveGerstner03Enable);
			float3 worldToObj419_g66932 = mul( unity_WorldToObject, float4( ase_worldPos, 1 ) ).xyz;
			float3 normalizeResult407_g66932 = normalize( _WaveGerstner04Direction );
			float temp_output_409_0_g66932 = ( 6.28318548202515 / _WaveGerstner04Length );
			float dotResult417_g66932 = dot( worldToObj419_g66932 , ( normalizeResult407_g66932 * temp_output_409_0_g66932 ) );
			float temp_output_421_0_g66932 = ( dotResult417_g66932 - ( sqrt( ( temp_output_409_0_g66932 * 9.8 ) ) * ( _Time.y * _WaveGerstner04Speed ) ) );
			float temp_output_422_0_g66932 = cos( temp_output_421_0_g66932 );
			float temp_output_432_0_g66932 = _WaveGerstner04Height;
			float WaveHeight433_g66932 = temp_output_432_0_g66932;
			float3 WaveDirection429_g66932 = normalizeResult407_g66932;
			float temp_output_426_0_g66932 = sin( temp_output_421_0_g66932 );
			float temp_output_431_0_g66932 = ( temp_output_409_0_g66932 * temp_output_432_0_g66932 );
			float temp_output_435_0_g66932 = ( _WaveGerstner04PeakSharpness / temp_output_431_0_g66932 );
			float3 lerpResult3196_g66922 = lerp( float3( 0,0,0 ) , ( ( ( temp_output_422_0_g66932 * float3(0,1,0) ) * WaveHeight433_g66932 ) - ( WaveDirection429_g66932 * ( temp_output_426_0_g66932 * ( temp_output_435_0_g66932 * temp_output_432_0_g66932 ) ) ) ) , _WaveGerstner04Enable);
			float3 temp_output_2006_0_g66922 = ( worldToObj2005_g66922 + ( ( ( lerpResult2419_g66922 + lerpResult2421_g66922 ) + lerpResult2414_g66922 ) + lerpResult3196_g66922 ) );
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth3376_g66922 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE_LOD( _CameraDepthTexture, float4( ase_screenPosNorm.xy, 0, 0 ) ));
			float distanceDepth3376_g66922 = saturate( abs( ( screenDepth3376_g66922 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _WaveGerstnerEdgeFadeRange ) ) );
			float saferPower3373_g66922 = abs( saturate( distanceDepth3376_g66922 ) );
			float Fade3386_g66922 = ( saturate( ( distance( _WorldSpaceCameraPos , ase_worldPos ) / _WaveGerstnerEdgeFadeRange ) ) * pow( saferPower3373_g66922 , 1.0 ) );
			float3 lerpResult3389_g66922 = lerp( ase_vertex3Pos , temp_output_2006_0_g66922 , Fade3386_g66922);
			float3 lerpResult3388_g66922 = lerp( temp_output_2006_0_g66922 , lerpResult3389_g66922 , _WaveGerstnerEdgeFadeEnable);
			float temp_output_1991_0_g66922 = ( _WaveGerstnerEnable + ( ( _CATEGORY_WAVESGERSTNER + _SPACE_WAVESGERSTNER ) * 0.0 ) );
			float3 lerpResult1995_g66922 = lerp( ase_vertex3Pos , lerpResult3388_g66922 , temp_output_1991_0_g66922);
			v.vertex.xyz = lerpResult1995_g66922;
			v.vertex.w = 1;
			float3 ase_vertexNormal = v.normal.xyz;
			float3 _Vector3 = float3(0,0,1);
			float3 break452_g66924 = ( ( temp_output_426_0_g66924 * temp_output_431_0_g66924 ) * WaveDirection429_g66924 );
			float3 appendResult454_g66924 = (float3(break452_g66924.x , ( 1.0 - ( ( temp_output_422_0_g66924 * temp_output_431_0_g66924 ) * temp_output_435_0_g66924 ) ) , break452_g66924.z));
			float3 lerpResult2420_g66922 = lerp( _Vector3 , appendResult454_g66924 , _WaveGerstner01Enable);
			float3 break452_g66929 = ( ( temp_output_426_0_g66929 * temp_output_431_0_g66929 ) * WaveDirection429_g66929 );
			float3 appendResult454_g66929 = (float3(break452_g66929.x , ( 1.0 - ( ( temp_output_422_0_g66929 * temp_output_431_0_g66929 ) * temp_output_435_0_g66929 ) ) , break452_g66929.z));
			float3 lerpResult2422_g66922 = lerp( _Vector3 , appendResult454_g66929 , _WaveGerstner02Enable);
			float3 break452_g66928 = ( ( temp_output_426_0_g66928 * temp_output_431_0_g66928 ) * WaveDirection429_g66928 );
			float3 appendResult454_g66928 = (float3(break452_g66928.x , ( 1.0 - ( ( temp_output_422_0_g66928 * temp_output_431_0_g66928 ) * temp_output_435_0_g66928 ) ) , break452_g66928.z));
			float3 lerpResult2423_g66922 = lerp( _Vector3 , appendResult454_g66928 , _WaveGerstner03Enable);
			float3 break452_g66932 = ( ( temp_output_426_0_g66932 * temp_output_431_0_g66932 ) * WaveDirection429_g66932 );
			float3 appendResult454_g66932 = (float3(break452_g66932.x , ( 1.0 - ( ( temp_output_422_0_g66932 * temp_output_431_0_g66932 ) * temp_output_435_0_g66932 ) ) , break452_g66932.z));
			float3 lerpResult3195_g66922 = lerp( _Vector3 , appendResult454_g66932 , _WaveGerstner04Enable);
			float4 weightedBlendVar3205_g66922 = float4(0.25,0.25,0.25,0.25);
			float3 weightedBlend3205_g66922 = ( weightedBlendVar3205_g66922.x*lerpResult2420_g66922 + weightedBlendVar3205_g66922.y*lerpResult2422_g66922 + weightedBlendVar3205_g66922.z*lerpResult2423_g66922 + weightedBlendVar3205_g66922.w*lerpResult3195_g66922 );
			float3 lerpResult3398_g66922 = lerp( ase_vertexNormal , weightedBlend3205_g66922 , Fade3386_g66922);
			float3 lerpResult3397_g66922 = lerp( weightedBlend3205_g66922 , lerpResult3398_g66922 , _WaveGerstnerEdgeFadeEnable);
			float3 lerpResult1996_g66922 = lerp( ase_vertexNormal , lerpResult3397_g66922 , temp_output_1991_0_g66922);
			v.normal = lerpResult1996_g66922;
			o.eyeDepth = -UnityObjectToViewPos( v.vertex.xyz ).z;
		}

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float3 ase_worldPos = i.worldPos;
			float4 appendResult2087_g66922 = (float4(ase_worldPos.x , ase_worldPos.z , ase_worldPos.x , ase_worldPos.z));
			float4 appendResult2869_g66922 = (float4(_WaterNormalScaleX , _WaterNormalScaleY , _WaterNormalScaleZ , _WaterNormalScaleW));
			float4 temp_output_2088_0_g66922 = ( appendResult2087_g66922 * appendResult2869_g66922 );
			float4 appendResult2874_g66922 = (float4(_WaterNormalSpeedX , _WaterNormalSpeedY , _WaterNormalSpeedZ , _WaterNormalSpeedW));
			float4 temp_output_2093_0_g66922 = ( temp_output_2088_0_g66922 + ( _Time.y * appendResult2874_g66922 ) );
			float3 tex2DNode2097_g66922 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _WaterNormalMap, sampler_WaterNormalMap, (temp_output_2093_0_g66922).xy ), _WaterNormalStrength );
			float3 tex2DNode2098_g66922 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _WaterNormalMap, sampler_WaterNormalMap, (temp_output_2093_0_g66922).zw ), _WaterNormalStrength );
			float4 temp_output_2107_0_g66922 = ( temp_output_2093_0_g66922 * float4( 0.17,0.19,-0.13,0.23 ) );
			float3 tex2DNode2104_g66922 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _WaterNormalMap, sampler_WaterNormalMap, (temp_output_2107_0_g66922).xy ), _WaterNormalStrength );
			float3 tex2DNode2105_g66922 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _WaterNormalMap, sampler_WaterNormalMap, (temp_output_2107_0_g66922).zw ), _WaterNormalStrength );
			float3 temp_output_3496_0_g66922 = BlendNormals( BlendNormals( tex2DNode2097_g66922 , tex2DNode2098_g66922 ) , BlendNormals( tex2DNode2104_g66922 , tex2DNode2105_g66922 ) );
			float3 break2345_g66922 = temp_output_3496_0_g66922;
			float3 appendResult2346_g66922 = (float3(break2345_g66922.x , break2345_g66922.y , ( break2345_g66922.z + 0.001 )));
			float3 lerpResult2863_g66922 = lerp( float3(0,0,1) , appendResult2346_g66922 , ( _WaterNormalEnable + ( ( _CATEGORY_NORMALRIPPLE + _SPACE_NORMALRIPPLE ) * 0.0 ) ));
			o.Normal = lerpResult2863_g66922;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth2129_g66922 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth2129_g66922 = abs( ( screenDepth2129_g66922 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _WaterShorelineDepth ) );
			float4 lerpResult25_g66922 = lerp( _WaterShorelineTint , _WaterMidwaterTint , saturate( (distanceDepth2129_g66922*1.0 + _WaterShorelineOffset) ));
			float4 lerpResult105_g66922 = lerp( _WaterDepthTint , lerpResult25_g66922 , saturate( (distanceDepth2129_g66922*-1.0 + _WaterDepthOffset) ));
			#ifdef UNITY_PASS_FORWARDADD
				float staticSwitch37_g66922 = 0.0;
			#else
				float staticSwitch37_g66922 = ( 1.0 - ( ( 1.0 - saturate( (distanceDepth2129_g66922*-5.0 + _WaterOpacityShoreline) ) ) * ( 1.0 - ( _WaterOpacity + ( ( _CATEGORY_OPACITY + _SPACE_OPACITY ) * 0.0 ) ) ) ) );
			#endif
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			ase_vertexNormal = normalize( ase_vertexNormal );
			float temp_output_8_0_g66951 = saturate( ( ( distance( _WorldSpaceCameraPos , ase_worldPos ) - 8.0 ) / 80.0 ) );
			float eyeDepth7_g66949 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float2 temp_output_21_0_g66949 = ( (( ase_vertexNormal * ( 1.0 - temp_output_8_0_g66951 ) )).xy * ( ( _WaterRefractionScale + ( ( _CATEGORY_REFRACTION + _SPACE_REFRACTION ) * 0.0 ) ) / max( i.eyeDepth , 0.1 ) ) * saturate( ( eyeDepth7_g66949 - i.eyeDepth ) ) );
			float eyeDepth27_g66949 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ( float4( temp_output_21_0_g66949, 0.0 , 0.0 ) + ase_screenPosNorm ).xy ));
			float2 temp_output_15_0_g66949 = (( float4( ( temp_output_21_0_g66949 * saturate( ( eyeDepth27_g66949 - i.eyeDepth ) ) ), 0.0 , 0.0 ) + ase_screenPosNorm )).xy;
			float4 screenColor89_g66949 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,temp_output_15_0_g66949);
			float RefractionScale119_g66949 = _WaterRefractionScale;
			float4 temp_output_2480_0_g66922 = ( ( screenColor89_g66949 * RefractionScale119_g66949 ) * staticSwitch37_g66922 );
			float4 temp_output_59_0_g66939 = temp_output_2480_0_g66922;
			float3 temp_output_70_0_g66940 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _WaterNormalMap, sampler_WaterNormalMap, i.uv_texcoord ), _WaterReflectionBumpStrength );
			float temp_output_96_0_g66940 = _WaterReflectionBumpClamp;
			float2 temp_cast_5 = (-temp_output_96_0_g66940).xx;
			float2 temp_cast_6 = (temp_output_96_0_g66940).xx;
			float2 clampResult87_g66940 = clamp( ( (( temp_output_70_0_g66940 * 50.0 )).xy * _WaterReflectionBumpScale ) , temp_cast_5 , temp_cast_6 );
			float4 appendResult85_g66940 = (float4(1.0 , 0.0 , 1.0 , temp_output_70_0_g66940.x));
			float4 texCUBENode67_g66940 = SAMPLE_TEXTURECUBE_LOD( _WaterReflectionCubemap, sampler_WaterReflectionCubemap, ( float3( clampResult87_g66940 ,  0.0 ) + WorldReflectionVector( i , UnpackScaleNormal( appendResult85_g66940, 0.15 ) ) + _WaterReflectionWobble ), ( 1.0 - _WaterReflectionSmoothness ) );
			float4 temp_cast_8 = (texCUBENode67_g66940.r).xxxx;
			float4 lerpResult91_g66940 = lerp( texCUBENode67_g66940 , temp_cast_8 , _WaterReflectionCloud);
			float4 temp_output_154_21_g66939 = lerpResult91_g66940;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float fresnelNdotV23_g66939 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode23_g66939 = ( _WaterReflectionFresnelBias + _WaterReflectionFresnelScale * pow( max( 1.0 - fresnelNdotV23_g66939 , 0.0001 ), 5.0 ) );
			float4 lerpResult73_g66939 = lerp( float4( 0,0,0,0 ) , temp_output_154_21_g66939 , ( _WaterReflectionFresnelStrength * fresnelNode23_g66939 ));
			float4 lerpResult133_g66939 = lerp( temp_output_154_21_g66939 , lerpResult73_g66939 , _WaterReflectionEnableFresnel);
			float4 switchResult85_g66939 = (((i.ASEIsFrontFacing>0)?(lerpResult133_g66939):(float4( 0,0,0,0 ))));
			float4 temp_cast_10 = (0.0).xxxx;
			#ifdef UNITY_PASS_FORWARDADD
				float4 staticSwitch95_g66939 = temp_cast_10;
			#else
				float4 staticSwitch95_g66939 = ( ( ( 1.0 - 0.5 ) * switchResult85_g66939 ) + ( temp_output_59_0_g66939 * 0.5 ) );
			#endif
			float4 lerpResult138_g66939 = lerp( temp_output_59_0_g66939 , staticSwitch95_g66939 , ( _WaterReflectionEnable + ( ( _CATEGORY_REFLECTION + _SPACE_REFLECTION ) * 0.0 ) ));
			float4 temp_output_2481_0_g66922 = ( ( lerpResult105_g66922 * ( 1.0 - staticSwitch37_g66922 ) ) + lerpResult138_g66939 );
			float3 temp_output_2248_0_g66922 = (temp_output_2481_0_g66922).rgb;
			float2 temp_output_2904_0_g66922 = ( ( i.uv_texcoord * (_FoamShorelineUVs).xy ) + (_FoamShorelineUVs).zw );
			float4 UVRipples2543_g66922 = temp_output_2088_0_g66922;
			float4 break2151_g66922 = ( _FoamShorelineUVsDetail * UVRipples2543_g66922 );
			float2 appendResult2155_g66922 = (float2(break2151_g66922.x , ( break2151_g66922.y + ( _Time.y * 0.02 ) )));
			float temp_output_2172_0_g66922 = ( _Time.y * _FoamShorelineSpeed );
			float eyeDepth2496_g66922 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float3 unityObjectToViewPos2499_g66922 = UnityObjectToViewPos( ase_vertex3Pos );
			float FoamDistanceShoreline2836_g66922 = saturate( ( ( ( 1.0 - ( eyeDepth2496_g66922 - -unityObjectToViewPos2499_g66922.z ) ) - 1.0 ) / ( ( ( 1.0 - (-99.0 + (_FoamShorelineDistance - 0.0) * (1.0 - -99.0) / (1.0 - 0.0)) ) * 0.01 ) - 1.0 ) ) );
			float3 lerpResult2381_g66922 = lerp( ( ( ( (_FoamShorelineColor).rgb * (SAMPLE_TEXTURE2D( _FoamShorelineMap, sampler_FoamShorelineMap, temp_output_2904_0_g66922 )).rgb * _FoamShorelineStrength ) + ( (_FoamShorelineDetailColor).rgb * (( ( ( ( SAMPLE_TEXTURE2D( _FoamShorelineMapDetail, sampler_FoamShorelineMapDetail, ( ( appendResult2155_g66922 + float2( 0.4181,0.3548 ) ) + ( temp_output_2172_0_g66922 * float2( 1,1 ) ) ) ) + SAMPLE_TEXTURE2D( _FoamShorelineMapDetail, sampler_FoamShorelineMapDetail, ( ( appendResult2155_g66922 + float2( 0.864861,0.148384 ) ) + ( temp_output_2172_0_g66922 * float2( -1,-1 ) ) ) ) ) + SAMPLE_TEXTURE2D( _FoamShorelineMapDetail, sampler_FoamShorelineMapDetail, ( ( appendResult2155_g66922 + float2( 0.65134,0.751638 ) ) + ( temp_output_2172_0_g66922 * float2( -1,1 ) ) ) ) ) + SAMPLE_TEXTURE2D( _FoamShorelineMapDetail, sampler_FoamShorelineMapDetail, ( appendResult2155_g66922 + ( temp_output_2172_0_g66922 * float2( 1,-1 ) ) ) ) ) * 0.25 )).rgb * _FoamShorelineDetailStrength ) ) / 3.0 ) , float3( 0,0,0 ) , FoamDistanceShoreline2836_g66922);
			float3 FoamShoreline2343_g66922 = lerpResult2381_g66922;
			float3 lerpResult2269_g66922 = lerp( temp_output_2248_0_g66922 , ( FoamShoreline2343_g66922 + temp_output_2248_0_g66922 ) , ( _FoamShorelineEnable + ( ( _CATEGORY_FOAMSHORELINE + _SPACE_FOAMSHORELINE ) * 0.0 ) ));
			float2 temp_output_2935_0_g66922 = ( ( i.uv_texcoord * (_FoamOffshoreUVs).xy ) + (_FoamOffshoreUVs).zw );
			float4 break2965_g66922 = ( _FoamOffshoreUVsDetail * UVRipples2543_g66922 );
			float2 appendResult2969_g66922 = (float2(break2965_g66922.x , ( break2965_g66922.y + ( _Time.y * 0.02 ) )));
			float temp_output_2963_0_g66922 = ( _Time.y * _FoamOffshoreSpeed );
			float FoamDistanceOffshore2834_g66922 = saturate( ( ( ( ( eyeDepth2496_g66922 + unityObjectToViewPos2499_g66922.z ) - _FoamOffshoreEdge ) * ase_screenPos.w ) / ( ( _FoamOffshoreDistance - _FoamOffshoreEdge ) * ase_screenPos.w ) ) );
			float3 lerpResult2931_g66922 = lerp( float3( 0,0,0 ) , ( ( ( (_FoamOffshoreColor).rgb * (SAMPLE_TEXTURE2D( _FoamOffshoreMap, sampler_FoamOffshoreMap, temp_output_2935_0_g66922 )).rgb * _FoamOffshoreStrength ) + ( (_FoamOffshoreDetailColor).rgb * (( ( ( ( SAMPLE_TEXTURE2D( _FoamOffshoreMapDetail, sampler_FoamOffshoreMapDetail, ( ( appendResult2969_g66922 + float2( 0.4181,0.3548 ) ) + ( temp_output_2963_0_g66922 * float2( 1,1 ) ) ) ) + SAMPLE_TEXTURE2D( _FoamOffshoreMapDetail, sampler_FoamOffshoreMapDetail, ( ( appendResult2969_g66922 + float2( 0.864861,0.148384 ) ) + ( temp_output_2963_0_g66922 * float2( -1,-1 ) ) ) ) ) + SAMPLE_TEXTURE2D( _FoamOffshoreMapDetail, sampler_FoamOffshoreMapDetail, ( ( appendResult2969_g66922 + float2( 0.65134,0.751638 ) ) + ( temp_output_2963_0_g66922 * float2( -1,1 ) ) ) ) ) + SAMPLE_TEXTURE2D( _FoamOffshoreMapDetail, sampler_FoamOffshoreMapDetail, ( appendResult2969_g66922 + ( temp_output_2963_0_g66922 * float2( 1,-1 ) ) ) ) ) * 0.25 )).rgb * _FoamOffshoreDetailStrength ) ) / 3.0 ) , FoamDistanceOffshore2834_g66922);
			float3 FoamOffshore2978_g66922 = lerpResult2931_g66922;
			float3 lerpResult2984_g66922 = lerp( lerpResult2269_g66922 , ( FoamOffshore2978_g66922 + lerpResult2269_g66922 ) , ( _FoamOffshoreEnable + ( ( _CATEGORY_FOAMOFFSHORE + _SPACE_FOAMOFFSHORE ) * 0.0 ) ));
			o.Albedo = lerpResult2984_g66922;
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 temp_output_95_0_g66936 = cross( ddy( ase_worldPos ) , ddx( ase_worldPos ) );
			float3 normalizeResult99_g66936 = ASESafeNormalize( temp_output_95_0_g66936 );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float3 normalizeResult3457_g66922 = normalize( ( ase_worldViewDir + ase_worldlightDir ) );
			float dotResult3230_g66922 = dot( normalizeResult99_g66936 , normalizeResult3457_g66922 );
			float temp_output_3475_0_g66922 = (max( saturate( dotResult3230_g66922 ) , 0.0 )*_WaterSpecularWrapScale + _WaterSpecularWrapOffset);
			float saferPower3427_g66922 = abs( temp_output_3475_0_g66922 );
			float3 lerpResult3436_g66922 = lerp( float3(0,0,0) , saturate( ( ( (_WaterSpecularColor).rgb * ( ase_lightColor.rgb * max( ase_lightColor.a , 0.0 ) ) ) * ( ( pow( saferPower3427_g66922 , _WaterSpecularPower ) * 15.0 ) * ( pow( ( _WaterSpecularStrengthDielectricIOR - 1.0 ) , 2.0 ) / pow( ( _WaterSpecularStrengthDielectricIOR + 1.0 ) , 2.0 ) ) ) ) ) , ( _WaterSpecularEnable + ( ( _CATEGORY_SPECULAR + _SPACE_SPECULAR ) * 0.0 ) ));
			o.Specular = lerpResult3436_g66922;
			float3 _Vector3 = float3(0,0,1);
			float3 worldToObj419_g66924 = mul( unity_WorldToObject, float4( ase_worldPos, 1 ) ).xyz;
			float3 normalizeResult407_g66924 = normalize( _WaveGerstner01Direction );
			float temp_output_409_0_g66924 = ( 6.28318548202515 / _WaveGerstner01Length );
			float dotResult417_g66924 = dot( worldToObj419_g66924 , ( normalizeResult407_g66924 * temp_output_409_0_g66924 ) );
			float temp_output_421_0_g66924 = ( dotResult417_g66924 - ( sqrt( ( temp_output_409_0_g66924 * 9.8 ) ) * ( _Time.y * _WaveGerstner01Speed ) ) );
			float temp_output_426_0_g66924 = sin( temp_output_421_0_g66924 );
			float temp_output_432_0_g66924 = _WaveGerstner01Height;
			float temp_output_431_0_g66924 = ( temp_output_409_0_g66924 * temp_output_432_0_g66924 );
			float3 WaveDirection429_g66924 = normalizeResult407_g66924;
			float3 break452_g66924 = ( ( temp_output_426_0_g66924 * temp_output_431_0_g66924 ) * WaveDirection429_g66924 );
			float temp_output_422_0_g66924 = cos( temp_output_421_0_g66924 );
			float temp_output_435_0_g66924 = ( _WaveGerstner01PeakSharpness / temp_output_431_0_g66924 );
			float3 appendResult454_g66924 = (float3(break452_g66924.x , ( 1.0 - ( ( temp_output_422_0_g66924 * temp_output_431_0_g66924 ) * temp_output_435_0_g66924 ) ) , break452_g66924.z));
			float3 lerpResult2420_g66922 = lerp( _Vector3 , appendResult454_g66924 , _WaveGerstner01Enable);
			float3 worldToObj419_g66929 = mul( unity_WorldToObject, float4( ase_worldPos, 1 ) ).xyz;
			float3 normalizeResult407_g66929 = normalize( _WaveGerstner02Direction );
			float temp_output_409_0_g66929 = ( 6.28318548202515 / _WaveGerstner02Length );
			float dotResult417_g66929 = dot( worldToObj419_g66929 , ( normalizeResult407_g66929 * temp_output_409_0_g66929 ) );
			float temp_output_421_0_g66929 = ( dotResult417_g66929 - ( sqrt( ( temp_output_409_0_g66929 * 9.8 ) ) * ( _Time.y * _WaveGerstner02Speed ) ) );
			float temp_output_426_0_g66929 = sin( temp_output_421_0_g66929 );
			float temp_output_432_0_g66929 = _WaveGerstner02Height;
			float temp_output_431_0_g66929 = ( temp_output_409_0_g66929 * temp_output_432_0_g66929 );
			float3 WaveDirection429_g66929 = normalizeResult407_g66929;
			float3 break452_g66929 = ( ( temp_output_426_0_g66929 * temp_output_431_0_g66929 ) * WaveDirection429_g66929 );
			float temp_output_422_0_g66929 = cos( temp_output_421_0_g66929 );
			float temp_output_435_0_g66929 = ( _WaveGerstner02PeakSharpness / temp_output_431_0_g66929 );
			float3 appendResult454_g66929 = (float3(break452_g66929.x , ( 1.0 - ( ( temp_output_422_0_g66929 * temp_output_431_0_g66929 ) * temp_output_435_0_g66929 ) ) , break452_g66929.z));
			float3 lerpResult2422_g66922 = lerp( _Vector3 , appendResult454_g66929 , _WaveGerstner02Enable);
			float3 worldToObj419_g66928 = mul( unity_WorldToObject, float4( ase_worldPos, 1 ) ).xyz;
			float3 normalizeResult407_g66928 = normalize( _WaveGerstner03Direction );
			float temp_output_409_0_g66928 = ( 6.28318548202515 / _WaveGerstner03Length );
			float dotResult417_g66928 = dot( worldToObj419_g66928 , ( normalizeResult407_g66928 * temp_output_409_0_g66928 ) );
			float temp_output_421_0_g66928 = ( dotResult417_g66928 - ( sqrt( ( temp_output_409_0_g66928 * 9.8 ) ) * ( _Time.y * _WaveGerstner03Speed ) ) );
			float temp_output_426_0_g66928 = sin( temp_output_421_0_g66928 );
			float temp_output_432_0_g66928 = _WaveGerstner03Height;
			float temp_output_431_0_g66928 = ( temp_output_409_0_g66928 * temp_output_432_0_g66928 );
			float3 WaveDirection429_g66928 = normalizeResult407_g66928;
			float3 break452_g66928 = ( ( temp_output_426_0_g66928 * temp_output_431_0_g66928 ) * WaveDirection429_g66928 );
			float temp_output_422_0_g66928 = cos( temp_output_421_0_g66928 );
			float temp_output_435_0_g66928 = ( _WaveGerstner03PeakSharpness / temp_output_431_0_g66928 );
			float3 appendResult454_g66928 = (float3(break452_g66928.x , ( 1.0 - ( ( temp_output_422_0_g66928 * temp_output_431_0_g66928 ) * temp_output_435_0_g66928 ) ) , break452_g66928.z));
			float3 lerpResult2423_g66922 = lerp( _Vector3 , appendResult454_g66928 , _WaveGerstner03Enable);
			float3 worldToObj419_g66932 = mul( unity_WorldToObject, float4( ase_worldPos, 1 ) ).xyz;
			float3 normalizeResult407_g66932 = normalize( _WaveGerstner04Direction );
			float temp_output_409_0_g66932 = ( 6.28318548202515 / _WaveGerstner04Length );
			float dotResult417_g66932 = dot( worldToObj419_g66932 , ( normalizeResult407_g66932 * temp_output_409_0_g66932 ) );
			float temp_output_421_0_g66932 = ( dotResult417_g66932 - ( sqrt( ( temp_output_409_0_g66932 * 9.8 ) ) * ( _Time.y * _WaveGerstner04Speed ) ) );
			float temp_output_426_0_g66932 = sin( temp_output_421_0_g66932 );
			float temp_output_432_0_g66932 = _WaveGerstner04Height;
			float temp_output_431_0_g66932 = ( temp_output_409_0_g66932 * temp_output_432_0_g66932 );
			float3 WaveDirection429_g66932 = normalizeResult407_g66932;
			float3 break452_g66932 = ( ( temp_output_426_0_g66932 * temp_output_431_0_g66932 ) * WaveDirection429_g66932 );
			float temp_output_422_0_g66932 = cos( temp_output_421_0_g66932 );
			float temp_output_435_0_g66932 = ( _WaveGerstner04PeakSharpness / temp_output_431_0_g66932 );
			float3 appendResult454_g66932 = (float3(break452_g66932.x , ( 1.0 - ( ( temp_output_422_0_g66932 * temp_output_431_0_g66932 ) * temp_output_435_0_g66932 ) ) , break452_g66932.z));
			float3 lerpResult3195_g66922 = lerp( _Vector3 , appendResult454_g66932 , _WaveGerstner04Enable);
			float4 weightedBlendVar3205_g66922 = float4(0.25,0.25,0.25,0.25);
			float3 weightedBlend3205_g66922 = ( weightedBlendVar3205_g66922.x*lerpResult2420_g66922 + weightedBlendVar3205_g66922.y*lerpResult2422_g66922 + weightedBlendVar3205_g66922.z*lerpResult2423_g66922 + weightedBlendVar3205_g66922.w*lerpResult3195_g66922 );
			float screenDepth3376_g66922 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth3376_g66922 = saturate( abs( ( screenDepth3376_g66922 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _WaveGerstnerEdgeFadeRange ) ) );
			float saferPower3373_g66922 = abs( saturate( distanceDepth3376_g66922 ) );
			float Fade3386_g66922 = ( saturate( ( distance( _WorldSpaceCameraPos , ase_worldPos ) / _WaveGerstnerEdgeFadeRange ) ) * pow( saferPower3373_g66922 , 1.0 ) );
			float3 lerpResult3398_g66922 = lerp( ase_vertexNormal , weightedBlend3205_g66922 , Fade3386_g66922);
			float3 lerpResult3397_g66922 = lerp( weightedBlend3205_g66922 , lerpResult3398_g66922 , _WaveGerstnerEdgeFadeEnable);
			float temp_output_1991_0_g66922 = ( _WaveGerstnerEnable + ( ( _CATEGORY_WAVESGERSTNER + _SPACE_WAVESGERSTNER ) * 0.0 ) );
			float3 lerpResult1996_g66922 = lerp( ase_vertexNormal , lerpResult3397_g66922 , temp_output_1991_0_g66922);
			float3 VertexNormal3185_g66922 = lerpResult1996_g66922;
			float3 newWorldNormal3180_g66922 = (WorldNormalVector( i , VertexNormal3185_g66922 ));
			float3 temp_output_3171_0_g66922 = ddx( newWorldNormal3180_g66922 );
			float dotResult3173_g66922 = dot( temp_output_3171_0_g66922 , temp_output_3171_0_g66922 );
			float3 temp_output_3170_0_g66922 = ddy( newWorldNormal3180_g66922 );
			float dotResult3172_g66922 = dot( temp_output_3170_0_g66922 , temp_output_3170_0_g66922 );
			o.Smoothness = saturate( ( ( _WaterSmoothnessStrength + ( ( _CATEGORY_SMOOTHNESS + _SPACE_SMOOTHNESS ) * 0.0 ) ) - min( ( ( dotResult3173_g66922 + dotResult3172_g66922 ) * 30.0 ) , 0.5 ) ) );
			float clampResult3169_g66922 = clamp( temp_output_2481_0_g66922.a , 0.5 , 1.0 );
			o.Alpha = clampResult3169_g66922;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ALP8310_ShaderGUI"
}
/*ASEBEGIN
Version=19303
Node;AmplifyShaderEditor.FunctionNode;1601;-192,-2944;Inherit;False;DESF Core Water;2;;66922;1313c42205ab0e94aaeb8af860761fd8;1,2505,1;0;9;FLOAT3;0;FLOAT3;123;FLOAT3;1651;FLOAT;122;FLOAT;2483;FLOAT3;419;FLOAT3;417;FLOAT4;3364;FLOAT4;2399
Node;AmplifyShaderEditor.IntNode;700;128,-3024;Inherit;False;Property;_ZWriteMode;ZWrite Mode;1;2;[HideInInspector];[Enum];Create;False;0;0;1;Off,0,On,1;True;0;False;1;1;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;1171;128,-3104;Inherit;False;Property;_Cull;Render Face;0;2;[HideInInspector];[Enum];Create;False;1;;0;1;Front,2,Back,1,Both,0;True;0;False;2;0;False;0;1;INT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;128,-2944;Float;False;True;-1;6;ALP8310_ShaderGUI;200;0;StandardSpecular;ALP/Water Gestner Waves;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;False;True;True;True;False;Back;0;True;_ZWriteMode;3;False;;False;0;False;;0;False;;False;0;Custom;0.5;True;False;-2;True;Transparent;;Transparent;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;18;10;25;False;0.5;True;2;5;False;;10;False;;2;5;False;;10;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Absolute;200;;-1;-1;-1;-1;0;False;0;0;True;_Cull;-1;0;True;_MaskClipValue2;0;0;0;False;0.1;False;;0;False;;True;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;0;0;1601;0
WireConnection;0;1;1601;123
WireConnection;0;3;1601;1651
WireConnection;0;4;1601;122
WireConnection;0;9;1601;2483
WireConnection;0;11;1601;419
WireConnection;0;12;1601;417
ASEEND*/
//CHKSM=92ACC38DC098A5982E8DD76FD7DE56BF9B1B9CB6