// Made with Amplify Shader Editor v1.9.3.3
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ALP/Billboard Cross Wind"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.45
		[HideInInspector][Enum(Front,2,Back,1,Both,0)]_Cull("Render Face", Int) = 0
		[DE_DrawerCategory(ALPHA CLIPPING,true,_GlancingClipMode,0,0)]_CATEGORY_ALPHACLIPPING("CATEGORY_ALPHACLIPPING", Float) = 0
		[DE_DrawerToggleLeft]_GlancingClipMode("Enable Clip Glancing Angle", Float) = 0
		[DE_DrawerSliderSimple(_AlphaRemapMin, _AlphaRemapMax,0, 1)]_AlphaRemap("Alpha Remapping", Vector) = (0,1,0,0)
		[HideInInspector]_AlphaRemapMin("AlphaRemapMin", Float) = 0
		[HideInInspector]_AlphaRemapMax("AlphaRemapMax", Float) = 1
		_AlphaCutoffBias("Alpha Cutoff Bias", Range( 0 , 1)) = 0.5
		[DE_DrawerSpace(10)]_SPACE_ALPHACLIP("SPACE_ALPHACLIP", Float) = 0
		[DE_DrawerCategory(SURFACE INPUTS,true,_MainTex,0,0)]_CATEGORY_SURFACEINPUTS("CATEGORY_SURFACE INPUTS", Float) = 1
		_BaseColor("Base Color", Color) = (1,1,1,0)
		_Brightness("Brightness", Range( 0 , 2)) = 1
		[DE_DrawerTextureSingleLine]_MainTex("Base Map", 2D) = "white" {}
		[DE_DrawerFloatEnum(UV0 _UV1 _UV2 _UV3)]_UVMode("UV Mode", Float) = 0
		[DE_DrawerTilingOffset]_MainUVs("Main UVs", Vector) = (1,1,0,0)
		[Space(10)]_MetallicStrength("Metallic Strength", Range( 0 , 1)) = 0
		_SmoothnessStrength("Smoothness Strength", Range( 0 , 1)) = 0
		[DE_DrawerToggleNoKeyword]_SmoothnessFresnelEnable("Enable Fresnel", Float) = 0
		_SmoothnessFresnelScale("Fresnel Scale", Range( 0 , 3)) = 1.1
		_SmoothnessFresnelPower("Fresnel Power", Range( 0 , 20)) = 10
		_OcclusionStrengthAO("Occlusion Strength", Range( 0 , 1)) = 0
		[Normal][DE_DrawerTextureSingleLine]_BumpMap("Normal Map", 2D) = "bump" {}
		[DE_DrawerFloatEnum(Flip _Mirror _None)]_DoubleSidedNormalMode("Normal Mode", Float) = 0
		_NormalStrength("Normal Strength", Float) = 1
		[DE_DrawerSpace(10)]_SPACE_SURFACEINPUTS("SPACE_SURFACE INPUTS", Float) = 0
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
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry-10" }
		LOD 200
		Cull [_Cull]
		ZTest LEqual
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
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
			float2 vertexToFrag70_g57766;
			half ASEIsFrontFacing : VFACE;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform int _Cull;
		uniform float _CATEGORY_SURFACEINPUTS;
		uniform float _SPACE_SURFACEINPUTS;
		uniform half _WindGlobalIntensity;
		uniform float _GlobalWindBillboardIntensity;
		uniform float _GlobalWindIntensity;
		uniform half _WindLocalIntensity;
		uniform half _WindEnableMode;
		uniform float _GlobalWindRandomOffset;
		uniform half _WindLocalRandomOffset;
		uniform float _GlobalWindPulse;
		uniform half _WindLocalPulseFrequency;
		uniform float _GlobalWindDirection;
		uniform half _WindLocalDirection;
		uniform float _GlobalWindBillboardEnabled;
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
		uniform float _MetallicStrength;
		uniform half _SmoothnessStrength;
		uniform half _SmoothnessFresnelScale;
		uniform half _SmoothnessFresnelPower;
		uniform half _SmoothnessFresnelEnable;
		uniform half _OcclusionStrengthAO;
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


		float2 float2switchUVMode80_g57766( float m_switch, float2 m_UV0, float2 m_UV1, float2 m_UV2, float2 m_UV3 )
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


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			//Calculate new billboard vertex position and normal;
			float3 upCamVec = float3( 0, 1, 0 );
			float3 forwardCamVec = -normalize ( UNITY_MATRIX_V._m20_m21_m22 );
			float3 rightCamVec = normalize( UNITY_MATRIX_V._m00_m01_m02 );
			float4x4 rotationCamMatrix = float4x4( rightCamVec, 0, upCamVec, 0, forwardCamVec, 0, 0, 0, 0, 1 );
			v.normal = normalize( mul( float4( v.normal , 0 ), rotationCamMatrix )).xyz;
			v.tangent.xyz = normalize( mul( float4( v.tangent.xyz , 0 ), rotationCamMatrix )).xyz;
			//This unfortunately must be made to take non-uniform scaling into account;
			//Transform to world coords, apply rotation and transform back to local;
			v.vertex = mul( v.vertex , unity_ObjectToWorld );
			v.vertex = mul( v.vertex , rotationCamMatrix );
			v.vertex = mul( v.vertex , unity_WorldToObject );
			float3 temp_output_17_0_g57770 = 0;
			float3 localVetexOffsetBIRP22_g57770 = ( temp_output_17_0_g57770 );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 VERTEX_POSITION_MATRIX2352_g57753 = mul( unity_ObjectToWorld, float4( ase_vertex3Pos , 0.0 ) ).xyz;
			float3 break2265_g57753 = VERTEX_POSITION_MATRIX2352_g57753;
			float GlobalWindBillboardIntensity3181_g57753 = _GlobalWindBillboardIntensity;
			float GlobalWindIntensity3173_g57753 = _GlobalWindIntensity;
			float WIND_MODE2462_g57753 = _WindEnableMode;
			float lerpResult3148_g57753 = lerp( ( ( _WindGlobalIntensity * GlobalWindBillboardIntensity3181_g57753 ) * GlobalWindIntensity3173_g57753 ) , _WindLocalIntensity , WIND_MODE2462_g57753);
			float _WIND_STRENGHT2400_g57753 = lerpResult3148_g57753;
			float GlobalWindRandomOffset3174_g57753 = _GlobalWindRandomOffset;
			float lerpResult3149_g57753 = lerp( GlobalWindRandomOffset3174_g57753 , _WindLocalRandomOffset , WIND_MODE2462_g57753);
			float4 transform3073_g57753 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float2 appendResult2307_g57753 = (float2(transform3073_g57753.x , transform3073_g57753.z));
			float dotResult2341_g57753 = dot( appendResult2307_g57753 , float2( 12.9898,78.233 ) );
			float lerpResult2238_g57753 = lerp( 0.8 , ( ( lerpResult3149_g57753 / 2.0 ) + 0.9 ) , frac( ( sin( dotResult2341_g57753 ) * 43758.55 ) ));
			float _WIND_RANDOM_OFFSET2244_g57753 = ( _Time.x * lerpResult2238_g57753 );
			float _WIND_TUBULENCE_RANDOM2274_g57753 = ( sin( ( ( _WIND_RANDOM_OFFSET2244_g57753 * 40.0 ) - ( VERTEX_POSITION_MATRIX2352_g57753.z / 15.0 ) ) ) * 0.5 );
			float GlobalWindPulse3177_g57753 = _GlobalWindPulse;
			float lerpResult3152_g57753 = lerp( GlobalWindPulse3177_g57753 , _WindLocalPulseFrequency , WIND_MODE2462_g57753);
			float _WIND_PULSE2421_g57753 = lerpResult3152_g57753;
			float FUNC_Angle2470_g57753 = ( _WIND_STRENGHT2400_g57753 * ( 1.0 + sin( ( ( ( ( _WIND_RANDOM_OFFSET2244_g57753 * 2.0 ) + _WIND_TUBULENCE_RANDOM2274_g57753 ) - ( VERTEX_POSITION_MATRIX2352_g57753.z / 50.0 ) ) - ( v.color.r / 20.0 ) ) ) ) * sqrt( v.color.r ) * _WIND_PULSE2421_g57753 );
			float FUNC_Angle_SinA2424_g57753 = sin( FUNC_Angle2470_g57753 );
			float FUNC_Angle_CosA2362_g57753 = cos( FUNC_Angle2470_g57753 );
			float GlobalWindDirection3175_g57753 = _GlobalWindDirection;
			float lerpResult3150_g57753 = lerp( GlobalWindDirection3175_g57753 , _WindLocalDirection , WIND_MODE2462_g57753);
			float _WindDirection2249_g57753 = lerpResult3150_g57753;
			float2 localDirectionalEquation2249_g57753 = DirectionalEquation( _WindDirection2249_g57753 );
			float2 break2469_g57753 = localDirectionalEquation2249_g57753;
			float _WIND_DIRECTION_X2418_g57753 = break2469_g57753.x;
			float lerpResult2258_g57753 = lerp( break2265_g57753.x , ( ( break2265_g57753.y * FUNC_Angle_SinA2424_g57753 ) + ( break2265_g57753.x * FUNC_Angle_CosA2362_g57753 ) ) , _WIND_DIRECTION_X2418_g57753);
			float3 break2340_g57753 = VERTEX_POSITION_MATRIX2352_g57753;
			float3 break2233_g57753 = VERTEX_POSITION_MATRIX2352_g57753;
			float _WIND_DIRECTION_Y2416_g57753 = break2469_g57753.y;
			float lerpResult2275_g57753 = lerp( break2233_g57753.z , ( ( break2233_g57753.y * FUNC_Angle_SinA2424_g57753 ) + ( break2233_g57753.z * FUNC_Angle_CosA2362_g57753 ) ) , _WIND_DIRECTION_Y2416_g57753);
			float3 appendResult2235_g57753 = (float3(lerpResult2258_g57753 , ( ( break2340_g57753.y * FUNC_Angle_CosA2362_g57753 ) - ( break2340_g57753.z * FUNC_Angle_SinA2424_g57753 ) ) , lerpResult2275_g57753));
			float3 VERTEX_POSITION_Neg3006_g57753 = appendResult2235_g57753;
			float GlobalWindBillboardEnabled3180_g57753 = _GlobalWindBillboardEnabled;
			float3 lerpResult3153_g57753 = lerp( float3(0,0,0) , ( VERTEX_POSITION_Neg3006_g57753 - VERTEX_POSITION_MATRIX2352_g57753 ) , GlobalWindBillboardEnabled3180_g57753);
			float3 VERTEX_POSITION2282_g57753 = ( mul( unity_WorldToObject, float4( appendResult2235_g57753 , 0.0 ) ).xyz - ase_vertex3Pos );
			float3 lerpResult3146_g57753 = lerp( lerpResult3153_g57753 , VERTEX_POSITION2282_g57753 , _WindEnableMode);
			float WindEnable3144_g57753 = _WindEnable;
			float3 lerpResult3143_g57753 = lerp( VERTEX_POSITION_MATRIX2352_g57753 , lerpResult3146_g57753 , WindEnable3144_g57753);
			float3 lerpResult3142_g57753 = lerp( float3(0,0,0) , lerpResult3143_g57753 , ( _WindEnable + ( ( _CATEGORY_WIND + _SPACE_WIND ) * 0.0 ) ));
			float3 temp_output_18_0_g57770 = lerpResult3142_g57753;
			{
			v.vertex.xyz += temp_output_18_0_g57770;
			}
			v.vertex.xyz += localVetexOffsetBIRP22_g57770;
			v.vertex.w = 1;
			float m_switch80_g57766 = _UVMode;
			float2 m_UV080_g57766 = v.texcoord.xy;
			float2 m_UV180_g57766 = v.texcoord1.xy;
			float2 m_UV280_g57766 = v.texcoord2.xy;
			float2 m_UV380_g57766 = v.texcoord3.xy;
			float2 localfloat2switchUVMode80_g57766 = float2switchUVMode80_g57766( m_switch80_g57766 , m_UV080_g57766 , m_UV180_g57766 , m_UV280_g57766 , m_UV380_g57766 );
			float2 Offset235_g57766 = (_MainUVs).zw;
			float2 temp_output_41_0_g57766 = ( ( localfloat2switchUVMode80_g57766 * (_MainUVs).xy ) + Offset235_g57766 );
			o.vertexToFrag70_g57766 = temp_output_41_0_g57766;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float temp_output_50_0_g57771 = _DoubleSidedNormalMode;
			float m_switch65_g57771 = temp_output_50_0_g57771;
			float3 temp_output_24_0_g57771 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _BumpMap, sampler_BumpMap, i.vertexToFrag70_g57766 ), _NormalStrength );
			float3 m_Flip65_g57771 = ( temp_output_24_0_g57771 * i.ASEIsFrontFacing );
			float3 break33_g57771 = temp_output_24_0_g57771;
			float3 appendResult41_g57771 = (float3(break33_g57771.x , break33_g57771.y , ( break33_g57771.z * i.ASEIsFrontFacing )));
			float3 m_Mirror65_g57771 = appendResult41_g57771;
			float3 m_None65_g57771 = temp_output_24_0_g57771;
			float3 local_NormalModefloat3switch65_g57771 = _NormalModefloat3switch( m_switch65_g57771 , m_Flip65_g57771 , m_Mirror65_g57771 , m_None65_g57771 );
			o.Normal = local_NormalModefloat3switch65_g57771;
			float4 tex2DNode3_g57756 = SAMPLE_TEXTURE2D( _MainTex, sampler_MainTex, i.vertexToFrag70_g57766 );
			float3 temp_output_28_0_g57756 = ( (_BaseColor).rgb * (tex2DNode3_g57756).rgb * _Brightness );
			o.Albedo = temp_output_28_0_g57756;
			o.Metallic = _MetallicStrength;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float2 appendResult899_g57756 = (float2(ase_worldViewDir.xy));
			float3 appendResult898_g57756 = (float3(appendResult899_g57756 , ( ase_worldViewDir.z / 1.06 )));
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 break928_g57756 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _BumpMap, sampler_BumpMap, i.vertexToFrag70_g57766 ), _NormalStrength );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 normalizeResult934_g57756 = normalize( ( ( ase_worldTangent * break928_g57756.x ) + ( ase_worldBitangent * break928_g57756.y ) + ( ase_worldNormal * break928_g57756.z ) ) );
			float3 Normal_Per_Pixel937_g57756 = normalizeResult934_g57756;
			float fresnelNdotV896_g57756 = dot( normalize( Normal_Per_Pixel937_g57756 ), appendResult898_g57756 );
			float fresnelNode896_g57756 = ( 0.0 + ( 1.0 - _SmoothnessFresnelScale ) * pow( max( 1.0 - fresnelNdotV896_g57756 , 0.0001 ), _SmoothnessFresnelPower ) );
			float lerpResult895_g57756 = lerp( _SmoothnessStrength , ( _SmoothnessStrength - fresnelNode896_g57756 ) , _SmoothnessFresnelEnable);
			o.Smoothness = saturate( lerpResult895_g57756 );
			o.Occlusion = saturate( ( 1.0 - _OcclusionStrengthAO ) );
			float temp_output_22_0_g57757 = tex2DNode3_g57756.a;
			float temp_output_22_0_g57759 = temp_output_22_0_g57757;
			float temp_output_286_0_g57762 = ( (0.0 + (( 1.0 - temp_output_22_0_g57759 ) - 0.0) * (( _AlphaRemapMin + ( _AlphaRemap.x * 0.0 ) ) - 0.0) / (1.0 - 0.0)) + (0.0 + (temp_output_22_0_g57759 - 0.0) * (_AlphaRemapMax - 0.0) / (1.0 - 0.0)) );
			float temp_output_94_0_g57762 = ( 1.0 - _AlphaCutoffBias );
			clip( temp_output_286_0_g57762 - temp_output_94_0_g57762);
			float temp_output_340_291_g57757 = saturate( ( ( temp_output_286_0_g57762 / max( fwidth( temp_output_286_0_g57762 ) , 0.0001 ) ) + 0.5 ) );
			o.Alpha = temp_output_340_291_g57757;
			float3 temp_output_95_0_g57761 = cross( ddy( ase_worldPos ) , ddx( ase_worldPos ) );
			float3 normalizeResult96_g57761 = normalize( temp_output_95_0_g57761 );
			float dotResult74_g57757 = dot( normalizeResult96_g57761 , ase_worldViewDir );
			float temp_output_76_0_g57757 = ( 1.0 - abs( dotResult74_g57757 ) );
			#ifdef UNITY_PASS_SHADOWCASTER
				float staticSwitch281_g57757 = 1.0;
			#else
				float staticSwitch281_g57757 = ( 1.0 - ( temp_output_76_0_g57757 * temp_output_76_0_g57757 ) );
			#endif
			float lerpResult80_g57757 = lerp( 1.0 , staticSwitch281_g57757 , ( _GlancingClipMode + ( ( _CATEGORY_ALPHACLIPPING + _SPACE_ALPHACLIP ) * 0.0 ) ));
			clip( lerpResult80_g57757 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ALP8310_ShaderGUI"
}
/*ASEBEGIN
Version=19303
Node;AmplifyShaderEditor.FunctionNode;504;-544,256;Inherit;False;DESF Weather Wind;69;;57753;b135a554f7e4d0b41bba02c61b34ae74;5,3133,2,2371,2,2432,2,3138,0,3139,0;0;1;FLOAT3;2190
Node;AmplifyShaderEditor.IntNode;516;128,176;Inherit;False;Property;_Cull;Render Face;1;2;[HideInInspector];[Enum];Create;False;1;;0;1;Front,2,Back,1,Both,0;True;0;False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.FunctionNode;526;-320,256;Inherit;False;DESF Core Billboard;2;;57756;e3fce2294f3bde941a48e407ffdf732f;5,139,0,865,0,69,0,885,1,969,0;1;457;FLOAT3;0,0,0;False;14;FLOAT3;0;FLOAT3;556;FLOAT;56;FLOAT3;770;FLOAT;50;FLOAT;57;FLOAT;49;FLOAT;351;FLOAT;649;FLOAT3;458;FLOAT3;967;FLOAT4;968;SAMPLERSTATE;703;SAMPLERSTATE;708
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;39;128,256;Float;False;True;-1;2;ALP8310_ShaderGUI;200;0;Standard;ALP/Billboard Cross Wind;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;True;True;True;Back;0;False;_ZWriteMode;3;False;;False;0;False;;0;False;;False;0;Custom;0.45;True;True;-10;True;TransparentCutout;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;True;True;Relative;200;;0;-1;-1;-1;0;False;0;0;True;_Cull;-1;0;False;_MaskClipValue;1;Pragma;multi_compile_instancing;False;;Custom;False;0;0;;0;0;False;0.1;False;;0;False;;True;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;526;457;504;2190
WireConnection;39;0;526;0
WireConnection;39;1;526;556
WireConnection;39;3;526;56
WireConnection;39;4;526;50
WireConnection;39;5;526;57
WireConnection;39;9;526;49
WireConnection;39;10;526;351
WireConnection;39;11;526;458
ASEEND*/
//CHKSM=C9C103800849F926A15FEA4EC07965204921BD71