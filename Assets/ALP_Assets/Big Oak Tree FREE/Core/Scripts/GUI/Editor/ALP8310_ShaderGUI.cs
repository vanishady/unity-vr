// Support:David Olshefski http://deenvironment.com/

using UnityEngine;
using UnityEditor;
using System.Collections.Generic;
using ALP8310.ShaderDrawers;

public class ALP8310_ShaderGUI : ShaderGUI
{

    bool showCategory = true;
    bool showAdvanced = false;
    bool showSurfaceSettings = true;

    float Cutoff;

    int RenderFace;
    int ZWriteMode;
    int AlphatoCoverage;


    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
    {

        var material0 = materialEditor.target as Material;
        //var materials = materialEditor.targets;

        //if (materials.Length > 1)
        //    multiSelection = true;

        DrawDynamicInspector(material0, materialEditor, props);

        //for each (Material material in materials)
        //{

        //} 

    }

    void DrawDynamicInspector(Material material, MaterialEditor materialEditor, MaterialProperty[] props)
    {
        var customPropsList = new List<MaterialProperty>();
        //var customSpaces = new List<int>();
        //var customCategories = new List<int>();

        #region [CATEGORY - SURFACE SETTINGS]
        DE_Drawers.DrawInspectorCategory("SURFACE SETTINGS", true, true, 0, 0, material);

        if (showSurfaceSettings)
        {

            #region [Render Face]
            //[HideInInspector][Enum(Front,2,Back,1,Both,0)]_Cull("Render Face", Int) = 2
            if (material.HasProperty("_Cull"))
            {
                var cull = material.GetInt("_Cull");

                RenderFace = EditorGUILayout.Popup("Render Face", RenderFace, new string[] { "Both", "Back", "Front" });

                material.SetInt("_Cull", RenderFace);

            }
            #endregion [Render Face]

            #region [ZWrite Mode]
            //[HideInInspector][Enum(Off,0,On,1)]_ZWriteMode("ZWrite Mode", Int) = 1
            if (material.HasProperty("_ZWriteMode"))
            {
                var ZWriteMode = material.GetInt("_ZWriteMode");

                ZWriteMode = EditorGUILayout.Popup("ZWrite Mode", ZWriteMode, new string[] { "Off", "On" });

                material.SetInt("_ZWriteMode", ZWriteMode);

            }
            #endregion [ZWrite Mode]

            #region [Alpha to Coverage]
            if (material.HasProperty("_AlphatoCoverage"))
            {
                var AlphatoCoverage = material.GetInt("_AlphatoCoverage");

                AlphatoCoverage = EditorGUILayout.Popup("Alpha to Coverage", AlphatoCoverage, new string[] { "Off", "On" });

                material.SetInt("_AlphatoCoverage", AlphatoCoverage);

            }
            #endregion [Alpha to Coverage]

            //to-do
            #region [Mask Clip Value]
            //_Cutoff ( "Mask Clip Value", Float ) = 0.5
            #endregion [Mask Clip Value]

            // to-do (HDRP Surface Type)
            #region [HDRP Surface Type]
            // #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
            //[HideInInspector] _SurfaceType("Surface Type", Float) = 0

            #endregion [HDRP Surface Type]

            // to-do (HDRP OpaqueCullMode)
            #region [HDRP OpaqueCullMode]
            //[Enum(UnityEditor.Rendering.HighDefinition.OpaqueCullMode)] _OpaqueCullMode("_OpaqueCullMode", Int) = 2
            #endregion [HDRP OpaqueCullMode]

            // to-do (HDRP TransparentCullMode)
            #region [HDRP TransparentCullMode]
            //[Enum(UnityEditor.Rendering.HighDefinition.TransparentCullMode)] _TransparentCullMode("_TransparentCullMode", Int) = 2

            #endregion [HDRP TransparentCullMode]

            // this is not working correctly yet 
            #region [HDRP Double Sided]
            //[HideInInspector][ToggleUI] _DoubleSidedEnable("Double Sided Enable", Float) = 0
            if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
                if (material.HasProperty("_DoubleSidedEnable"))
                {
                    if (material.HasProperty("_DoubleSidedEnable"))
                    {
                        var control = material.GetInt("_DoubleSidedEnable");

                        bool toggle = false;

                        if (control > 0.5f)
                        {
                            toggle = true;
                        }

                        toggle = EditorGUILayout.Toggle("Double Sided", toggle);

                        if (toggle)
                        {
                            material.SetInt("_DoubleSidedEnable", 1);
                            material.DisableKeyword("DOUBLESIDED_ON");
                        }
                        else
                        {
                            material.SetInt("_DoubleSidedEnable", 0);
                            material.EnableKeyword("DOUBLESIDED_ON");
                        }
                    }
                }
            #endregion [HDRP Double Sided]

            // to-do (HDRP normal Mode)
            #region [HDRP normal Mode]

            #endregion [HDRP normal Mode]

            #region [HDRP Receive Decals]
            if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
                if (material.HasProperty("_SupportDecals"))
                {
                    if (material.HasProperty("_SupportDecals"))
                    {
                        var control = material.GetInt("_SupportDecals");

                        bool toggle = false;

                        if (control > 0.5f)
                        {
                            toggle = true;
                        }

                        toggle = EditorGUILayout.Toggle("Receive Decals", toggle);

                        if (toggle)
                        {
                            material.SetInt("_SupportDecals", 1);
                            material.DisableKeyword("DECALS_OFF");
                        }
                        else
                        {
                            material.SetInt("_SupportDecals", 0);
                            material.EnableKeyword("DECALS_OFF");
                        }
                    }
                }
            #endregion [HDRP Receive Decals]

            #region [HDRP Geometric Specular AA]
            //#pragma shader_feature_local_fragment _ENABLE_GEOMETRIC_SPECULAR_AA
            if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
                if (material.HasProperty("_EnableGeometricSpecularAA"))
                {
                    if (material.HasProperty("_EnableGeometricSpecularAA"))
                    {
                        var control = material.GetInt("_EnableGeometricSpecularAA");

                        bool toggle = false;

                        if (control > 0.5f)
                        {
                            toggle = true;
                        }

                        toggle = EditorGUILayout.Toggle("Geometric Specular AA", toggle);

                        if (toggle)
                        {
                            material.SetInt("_EnableGeometricSpecularAA", 1);
                            material.DisableKeyword("ENABLE_GEOMETRIC_SPECULAR_AA");
                        }
                        else
                        {
                            material.SetInt("_EnableGeometricSpecularAA", 0);
                            material.EnableKeyword("ENABLE_GEOMETRIC_SPECULAR_AA");
                        }
                    }
                }
            #endregion [HDRP Geometric Specular AA]

            //Transparent only
            #region [HDRP Preserve Specular Lighting]
            //[HideInInspector][ToggleUI] _EnableBlendModePreserveSpecularLighting("Enable Blend Mode Preserve Specular Lighting", Float) = 1
            if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
                if (material.HasProperty("_EnableBlendModePreserveSpecularLighting"))
                {
                    if (material.HasProperty("_EnableBlendModePreserveSpecularLighting"))
                    {
                        var control = material.GetInt("_EnableBlendModePreserveSpecularLighting");

                        bool toggle = false;

                        if (control > 0.5f)
                        {
                            toggle = true;
                        }

                        toggle = EditorGUILayout.Toggle("Preserve Specular Lighting", toggle);

                        if (toggle)
                        {
                            material.SetInt("_EnableBlendModePreserveSpecularLighting", 1);
                            material.DisableKeyword("SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING");
                        }
                        else
                        {
                            material.SetInt("_EnableBlendModePreserveSpecularLighting", 0);
                            material.EnableKeyword("SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING");
                        }
                    }
                }
            #endregion [HDRP Double Sided]

            //Transparent only
            #region [HDRP Enable Fog On Transparent]
            //#pragma shader_feature_local_fragment _ENABLE_FOG_ON_TRANSPARENT
            //[HideInInspector][ToggleUI] _EnableFogOnTransparent("Enable Fog", Float) = 1
            if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
                if (material.HasProperty("_EnableFogOnTransparent"))
                {
                    if (material.HasProperty("_EnableFogOnTransparent"))
                    {
                        var control = material.GetInt("_EnableFogOnTransparent");

                        bool toggle = false;

                        if (control > 0.5f)
                        {
                            toggle = true;
                        }

                        toggle = EditorGUILayout.Toggle("Enable Fog On Transparent", toggle);

                        if (toggle)
                        {
                            material.SetInt("_EnableFogOnTransparent", 1);
                            material.DisableKeyword("ENABLE_FOG_ON_TRANSPARENT");
                        }
                        else
                        {
                            material.SetInt("_EnableFogOnTransparent", 0);
                            material.EnableKeyword("ENABLE_FOG_ON_TRANSPARENT");
                        }
                    }
                }
            #endregion [HDRP Enable Fog On Transparent]

            //Transparent only
            #region [HDRP Back Then Front Rendering]
            if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
                if (material.HasProperty("_CullModeForward"))
                {
                    if (material.HasProperty("_CullModeForward"))
                    {
                        var control = material.GetInt("_CullModeForward");

                        bool toggle = false;

                        if (control > 0.5f)
                        {
                            toggle = true;
                        }

                        toggle = EditorGUILayout.Toggle("Back Then Front Rendering", toggle);

                        if (toggle)
                        {
                            material.SetInt("_CullModeForward", 1);
                            material.DisableKeyword("USE_CLUSTERED_LIGHTLIST");
                        }
                        else
                        {
                            material.SetInt("_CullModeForward", 0);
                            material.EnableKeyword("USE_CLUSTERED_LIGHTLIST");
                        }
                    }
                }
            #endregion [HDRP Enable Fog On Transparent]

            //Transparent only
            #region [HDRP Transparent Depth Prepass]
            if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
                if (material.HasProperty("_TransparentDepthPrepassEnable"))
                {
                    if (material.HasProperty("_TransparentDepthPrepassEnable"))
                    {
                        var control = material.GetInt("_TransparentDepthPrepassEnable");

                        bool toggle = false;

                        if (control > 0.5f)
                        {
                            toggle = true;
                        }

                        toggle = EditorGUILayout.Toggle("Transparent Depth Prepass", toggle);

                        if (toggle)
                        {
                            material.SetInt("_TransparentDepthPrepassEnable", 1);
                            material.EnableKeyword("CUTOFF_TRANSPARENT_DEPTH_PREPASS");
                        }
                        else
                        {
                            material.SetInt("_TransparentDepthPrepassEnable", 0);
                            material.DisableKeyword("CUTOFF_TRANSPARENT_DEPTH_PREPASS");
                        }
                    }
                }
            #endregion [HDRP Transparent Depth Prepass]

            //Transparent only
            #region [HDRP Transparent Depth Postpass]
            if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
                if (material.HasProperty("_TransparentDepthPostpassEnable"))
                {
                    if (material.HasProperty("_TransparentDepthPostpassEnable"))
                    {
                        var control = material.GetInt("_TransparentDepthPostpassEnable");

                        bool toggle = false;

                        if (control > 0.5f)
                        {
                            toggle = true;
                        }

                        toggle = EditorGUILayout.Toggle("Transparent Depth Postpass", toggle);

                        if (toggle)
                        {
                            material.SetInt("_TransparentDepthPostpassEnable", 1);
                            material.EnableKeyword("CUTOFF_TRANSPARENT_DEPTH_POSTPASS");
                        }
                        else
                        {
                            material.SetInt("_TransparentDepthPostpassEnable", 0);
                            material.DisableKeyword("CUTOFF_TRANSPARENT_DEPTH_POSTPASS");
                        }
                    }
                }
            #endregion [HDRP Transparent Depth Postpass]

            //Transparent only
            #region [HDRP Transparent Writes Motion Vector]
            //API 12x #pragma shader_feature_local _TRANSPARENT_WRITES_MOTION_VEC
            //API 16x #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC _TRANSPARENT_REFRACTIVE_SORT
            // [HideInInspector][ToggleUI] _TransparentWritingMotionVec("Transparent Writing MotionVec", Float) = 0
            if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
                if (material.HasProperty("_TransparentWritingMotionVec"))
                {
                    if (material.HasProperty("_TransparentWritingMotionVec"))
                    {
                        var control = material.GetInt("_TransparentWritingMotionVec");

                        bool toggle = false;

                        if (control > 0.5f)
                        {
                            toggle = true;
                        }

                        toggle = EditorGUILayout.Toggle("Transparent Writes Motion Vector", toggle);

                        if (toggle)
                        {
                            material.SetInt("_TransparentWritingMotionVec", 1);
                            material.EnableKeyword("WRITES_MOTION_VEC");
                        }
                        else
                        {
                            material.SetInt("_TransparentWritingMotionVec", 0);
                            material.DisableKeyword("WRITES_MOTION_VEC");
                        }
                    }
                }
            #endregion [HDRP Transparent Writes Motion Vector]

            #region [HDRP Receive SSR]
            //#pragma shader_feature_local_fragment _DISABLE_SSR
            //#pragma shader_feature_local_raytracing _DISABLE_SSR
            //[HideInInspector][ToggleUI] _ReceivesSSR("Receives SSR", Float) = 1
            if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
                if (material.HasProperty("_ReceivesSSR"))
                {
                    if (material.HasProperty("_ReceivesSSR"))
                    {
                        var control = material.GetInt("_ReceivesSSR");

                        bool toggle = false;

                        if (control > 0.5f)
                        {
                            toggle = true;
                        }

                        toggle = EditorGUILayout.Toggle("Receive SSR", toggle);

                        if (toggle)
                        {
                            material.SetInt("_ReceivesSSR", 1);
                            material.EnableKeyword("DISABLE_SSR");

                            material.SetInt("_StencilRef", 0);
                            material.SetInt("_StencilRefDepth", 0);
                            material.SetInt("_StencilRefDistortionVec", 4);
                            material.SetInt("_StencilRefGBuffer", 2);
                            material.SetInt("_StencilRefMV", 32);
                            material.SetInt("_StencilWriteMask", 6);
                            material.SetInt("_StencilWriteMaskDepth", 8);
                            material.SetInt("_StencilWriteMaskDistortionVec", 4);
                            material.SetInt("_StencilWriteMaskGBuffer", 14);
                            material.SetInt("_StencilWriteMaskMV", 40);
                        }
                        else
                        {
                            material.SetInt("_ReceivesSSR", 0);
                            material.DisableKeyword("DISABLE_SSR");

                            material.SetInt("_StencilRef", 0);
                            material.SetInt("_StencilRefDepth", 8);
                            material.SetInt("_StencilRefDistortionVec", 4);
                            material.SetInt("_StencilRefGBuffer", 10);
                            material.SetInt("_StencilRefMV", 40);
                            material.SetInt("_StencilWriteMask", 6);
                            material.SetInt("_StencilWriteMaskDepth", 8);
                            material.SetInt("_StencilWriteMaskDistortionVec", 4);
                            material.SetInt("_StencilWriteMaskGBuffer", 14);
                            material.SetInt("_StencilWriteMaskMV", 40);
                        }
                    }
                }
            #endregion [HDRP Receive SSR]

            //Transparent only
            #region [HDRP Receive SSR Transparent]
            //#pragma shader_feature_local _DISABLE_SSR_TRANSPARENT
            //[HideInInspector][ToggleUI] _ReceivesSSRTransparent("Receives SSR Transparent", Float) = 0
            if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
                if (material.HasProperty("_ReceivesSSRTransparent"))
                {
                    if (material.HasProperty("_ReceivesSSRTransparent"))
                    {
                        var control = material.GetInt("_ReceivesSSRTransparent");

                        bool toggle = false;

                        if (control > 0.5f)
                        {
                            toggle = true;
                        }

                        toggle = EditorGUILayout.Toggle("Receive SSR Transparent", toggle);

                        if (toggle)
                        {
                            material.SetInt("_ReceivesSSRTransparent", 1);
                            material.EnableKeyword("DISABLE_SSR_TRANSPARENT");

                            material.SetInt("_StencilRef", 0);
                            material.SetInt("_StencilRefDepth", 0);
                            material.SetInt("_StencilRefDistortionVec", 4);
                            material.SetInt("_StencilRefGBuffer", 2);
                            material.SetInt("_StencilRefMV", 32);
                            material.SetInt("_StencilWriteMask", 6);
                            material.SetInt("_StencilWriteMaskDepth", 8);
                            material.SetInt("_StencilWriteMaskDistortionVec", 4);
                            material.SetInt("_StencilWriteMaskGBuffer", 14);
                            material.SetInt("_StencilWriteMaskMV", 40);
                        }
                        else
                        {
                            material.SetInt("_ReceivesSSRTransparent", 0);
                            material.DisableKeyword("DISABLE_SSR_TRANSPARENT");

                            material.SetInt("_StencilRef", 0);
                            material.SetInt("_StencilRefDepth", 8);
                            material.SetInt("_StencilRefDistortionVec", 4);
                            material.SetInt("_StencilRefGBuffer", 10);
                            material.SetInt("_StencilRefMV", 40);
                            material.SetInt("_StencilWriteMask", 6);
                            material.SetInt("_StencilWriteMaskDepth", 8);
                            material.SetInt("_StencilWriteMaskDistortionVec", 4);
                            material.SetInt("_StencilWriteMaskGBuffer", 14);
                            material.SetInt("_StencilWriteMaskMV", 40);
                        }
                    }
                }
            #endregion [HDRP Receive SSR Transparent]

            #region [URP Receive Shadows]
            //(API 12x14x15x16x) #pragma shader_feature_local _RECEIVE_SHADOWS_OFF
            //[HideInInspector][ToggleOff] _ReceiveShadows("Receive Shadows", Float) = 1.0
            if (material.HasProperty("_ReceiveShadows"))
            {
                if (material.HasProperty("_ReceiveShadows"))
                {
                    var control = material.GetInt("_ReceiveShadows");

                    bool toggle = false;

                    if (control > 0.5f)
                    {
                        toggle = true;
                    }

                    toggle = EditorGUILayout.Toggle("Receive Shadows", toggle);

                    if (toggle)
                    {
                        material.SetInt("_ReceiveShadows", 1);
                        material.DisableKeyword("_RECEIVE_SHADOWS_OFF");
                    }
                    else
                    {
                        material.SetInt("_ReceiveShadows", 0);
                        material.EnableKeyword("_RECEIVE_SHADOWS_OFF");
                    }
                }
            }
            #endregion [ReceiveShadows]

            #region [HDRP DECAL Affects Albedo]
            //#pragma shader_feature_local_fragment _MATERIAL_AFFECTS_ALBEDO
            //[ToggleUI]_AffectAlbedo("Boolean", Float) = 1
            if (material.HasProperty("_AffectAlbedo"))
            {
                if (material.HasProperty("_AffectAlbedo"))
                {
                    var control = material.GetInt("_AffectAlbedo");

                    bool toggle = false;

                    if (control > 0.5f)
                    {
                        toggle = true;
                    }

                    toggle = EditorGUILayout.Toggle("Affects Albedo", toggle);

                    if (toggle)
                    {
                        material.SetInt("_AffectAlbedo", 1);
                        material.DisableKeyword("_MATERIAL_AFFECTS_ALBEDO");
                    }
                    else
                    {
                        material.SetInt("_AffectAlbedo", 0);
                        material.EnableKeyword("_MATERIAL_AFFECTS_ALBEDO");
                    }
                }
            }
            #endregion [HDRP DECAL Affects Albedo]

            #region [HDRP DECAL Affects Normal]
            //#pragma shader_feature_local_fragment _MATERIAL_AFFECTS_NORMAL
            //[ToggleUI]_AffectNormal("Boolean", Float) = 1
            if (material.HasProperty("_AffectNormal"))
            {
                if (material.HasProperty("_AffectNormal"))
                {
                    var control = material.GetInt("_AffectNormal");

                    bool toggle = false;

                    if (control > 0.5f)
                    {
                        toggle = true;
                    }

                    toggle = EditorGUILayout.Toggle("Affects Normal", toggle);

                    if (toggle)
                    {
                        material.SetInt("_AffectNormal", 1);
                        material.DisableKeyword("_MATERIAL_AFFECTS_NORMAL");
                    }
                    else
                    {
                        material.SetInt("_AffectNormal", 0);
                        material.EnableKeyword("_MATERIAL_AFFECTS_NORMAL");
                    }
                }
            }
            #endregion [HDRP DECAL Affects Normal]

            #region [HDRP DECAL Affects AO]
            //[ToggleUI]_AffectAO("Boolean", Float) = 0
            if (material.HasProperty("_AffectAO"))
            {
                if (material.HasProperty("_AffectAO"))
                {
                    var control = material.GetInt("_AffectAO");

                    bool toggle = false;

                    if (control > 0.5f)
                    {
                        toggle = true;
                    }

                    toggle = EditorGUILayout.Toggle("Affects AO", toggle);

                    if (toggle)
                    {
                        material.SetInt("_AffectAO", 1);
                        material.DisableKeyword("_MATERIAL_AFFECTS_NORMAL_BLEND");
                    }
                    else
                    {
                        material.SetInt("_AffectAO", 0);
                        material.EnableKeyword("_MATERIAL_AFFECTS_NORMAL_BLEND");
                    }
                }
            }
            #endregion [HDRP DECAL Affects AO]

            #region [URP DECAL Affects Metal]
            //[ToggleUI]_AffectMetal("Boolean", Float) = 1
            if (material.HasProperty("_AffectMetal"))
            {
                if (material.HasProperty("_AffectMetal"))
                {
                    var control = material.GetInt("_AffectMetal");

                    bool toggle = false;

                    if (control > 0.5f)
                    {
                        toggle = true;
                    }

                    toggle = EditorGUILayout.Toggle("Affects Metal", toggle);

                    if (toggle)
                    {
                        material.SetInt("_AffectMetal", 1);
                        material.DisableKeyword("_MATERIAL_AFFECTS_MAOS");
                    }
                    else
                    {
                        material.SetInt("_AffectMetal", 0);
                        material.EnableKeyword("_MATERIAL_AFFECTS_MAOS");
                    }
                }
            }
            #endregion [HDRP DECAL Affects Metal]

            #region [URP DECAL Affects Smoothness]
            //[ToggleUI]_AffectSmoothness("Boolean", Float) = 1
            if (material.HasProperty("_AffectSmoothness"))
            {
                if (material.HasProperty("_AffectSmoothness"))
                {
                    var control = material.GetInt("_AffectSmoothness");

                    bool toggle = false;

                    if (control > 0.5f)
                    {
                        toggle = true;
                    }

                    toggle = EditorGUILayout.Toggle("Affects Smoothness", toggle);

                    if (toggle)
                    {
                        material.SetInt("_AffectSmoothness", 1);
                        material.DisableKeyword("_MATERIAL_AFFECTS_MAOS");
                    }
                    else
                    {
                        material.SetInt("_AffectSmoothness", 0);
                        material.EnableKeyword("_MATERIAL_AFFECTS_MAOS");
                    }
                }
            }
            #endregion [HDRP DECAL Affects Smoothness]

            #region [HDRP DECAL Affects Emission]
            //[ToggleUI]_AffectEmission("Boolean", Float) = 0
            if (material.HasProperty("_AffectEmission"))
            {
                if (material.HasProperty("_AffectEmission"))
                {
                    var control = material.GetInt("_AffectEmission");

                    bool toggle = false;

                    if (control > 0.5f)
                    {
                        toggle = true;
                    }

                    toggle = EditorGUILayout.Toggle("Affects Emission", toggle);

                    if (toggle)
                    {
                        material.SetInt("_AffectEmission", 1);
                        material.DisableKeyword("_MATERIAL_AFFECTS_EMISSION");
                    }
                    else
                    {
                        material.SetInt("_AffectEmission", 0);
                        material.EnableKeyword("_MATERIAL_AFFECTS_EMISSION");
                    }
                }
            }
            #endregion [HDRP DECAL Affects Emission]

            GUILayout.Space(10);

        }
        #endregion [CATEGORY - SURFACE SETTINGS]

        for (int i = 0; i < props.Length; i++)
        {
            var prop = props[i];

            if (prop.flags == MaterialProperty.PropFlags.HideInInspector)
                continue;

            if (prop.name == "unity_Lightmaps")
                continue;
            if (prop.name == "unity_LightmapsInd")
                continue;
            if (prop.name == "unity_ShadowMasks")
                continue;
            if (prop.name == "_SpecularHighlights")
                continue;
            if (prop.name == "_GlossyReflections")
                continue;


            #region [DESF Core UV Reveal]
            if (material.HasProperty("_UVLight00Enable"))
            {
                if (material.GetInt("_UVLight00Enable") == 0)
                {
                    if (prop.name == "_UVLight00Color")
                        continue;
                    if (prop.name == "_UVLight00MainLightInfluence")
                        continue;
                    if (prop.name == "_UVLight00Brightness")
                        continue;
                    if (prop.name == "_UVLight00Map")
                        continue;
                    if (prop.name == "_UVLight00UVs")
                        continue;
                    if (prop.name == "_UVLight00Rotation")
                        continue;
                    if (prop.name == "_UVLight00NormalMap")
                        continue;
                    if (prop.name == "_UVLight00NormalStrength")
                        continue;
                    if (prop.name == "_UVLight00EmissiveRenderFace")
                        continue;
                    if (prop.name == "_EmissionFlags")
                        continue;
                    if (prop.name == "_UVLight00FilteredColor")
                        continue;
                    if (prop.name == "_UVLight00Threshold")
                        continue;
                    if (prop.name == "_UVLight00ThresholdTemp")
                        continue;
                }
            }
            if (material.HasProperty("_UVLight01Enable"))
            {
                if (material.GetInt("_UVLight01Enable") == 0)
                {
                    if (prop.name == "_UVLight01Color")
                        continue;
                    if (prop.name == "_UVLight01MainLightInfluence")
                        continue;
                    if (prop.name == "_UVLight01Brightness")
                        continue;
                    if (prop.name == "_UVLight01Map")
                        continue;
                    if (prop.name == "_UVLight01UVs")
                        continue;
                    if (prop.name == "_UVLight01Rotation")
                        continue;
                    if (prop.name == "_UVLight01NormalMap")
                        continue;
                    if (prop.name == "_UVLight01NormalStrength")
                        continue;
                    if (prop.name == "_UVLight01EmissiveRenderFace")
                        continue;
                    if (prop.name == "_EmissionFlags")
                        continue;
                    if (prop.name == "_UVLight01FilteredColor")
                        continue;
                    if (prop.name == "_UVLight01Threshold")
                        continue;
                    if (prop.name == "_UVLight01ThresholdTemp")
                        continue;
                }
            }
            #endregion [DESF Core UV Reveal]

            #region [DESF Core Fabric]
            if (material.HasProperty("_FuzzMaskEnable"))
            {
                if (material.GetInt("_FuzzMaskEnable") == 0)
                {
                    if (prop.name == "_FuzzMaskColor")
                        continue;
                    if (prop.name == "_FuzzMaskMap")
                        continue;
                    if (prop.name == "_FuzzMaskUV")
                        continue;
                    if (prop.name == "_FuzzMaskStrength")
                        continue;
                }
            }
            if (material.HasProperty("_ThreadMaskEnable"))
            {
                if (material.GetInt("_ThreadMaskEnable") == 0)
                {
                    if (prop.name == "_ThreadNormalMap")
                        continue;
                    if (prop.name == "_ThreadNormalStrength")
                        continue;
                    if (prop.name == "_ThreadMaskUVAffectchannel0")
                        continue;
                    if (prop.name == "_ThreadMaskUVAffectchannel1")
                        continue;
                    if (prop.name == "_ThreadMaskUVAffectchannel2")
                        continue;
                    if (prop.name == "_ThreadMaskUVAffectchannel3")
                        continue;
                    if (prop.name == "_ThreadMaskUV")
                        continue;
                    if (prop.name == "_ThreadMaskMap")
                        continue;
                    if (prop.name == "_ThreadMaskOcclusionStrengthAO")
                        continue;
                    if (prop.name == "_ThreadMaskOcclusionStrengthAORemapMin")
                        continue;
                    if (prop.name == "_ThreadMaskOcclusionStrengthAORemapMax")
                        continue;
                    if (prop.name == "_ThreadMaskSmoothnessStrength")
                        continue;
                    if (prop.name == "_ThreadMaskSmoothnessStrengthRemapMin")
                        continue;
                    if (prop.name == "_ThreadMaskSmoothnessStrengthRemapMax")
                        continue;
                }
            }
            #endregion [DESF Core Fabric]

            #region [DESF Module Detail]
            if (material.HasProperty("_DetailBlendVertexColorEnable"))
            {
                if (material.GetInt("_DetailBlendVertexColorEnable") == 0)
                {
                    if (prop.name == "_DetailBlendVertexColor")
                        continue;
                }
            }
            if (material.HasProperty("_DetailBlendEnableAltitudeMask"))
            {
                if (material.GetInt("_DetailBlendEnableAltitudeMask") == 0)
                {
                    if (prop.name == "_DetailBlendHeightMin")
                        continue;
                    if (prop.name == "_DetailBlendHeightMax")
                        continue;
                }
            }
            if (material.HasProperty("_DetailMaskEnable"))
            {
                if (material.GetInt("_DetailMaskEnable") == 0)
                {
                    if (prop.name == "_DetailMaskIsInverted")
                        continue;
                    if (prop.name == "_DetailMaskMap")
                        continue;
                    if (prop.name == "_DetailMaskUVs")
                        continue;
                    if (prop.name == "_DetailMaskUVRotation")
                        continue;
                    if (prop.name == "_DetailMaskBlendStrength")
                        continue;
                    if (prop.name == "_DetailMaskBlendHardness")
                        continue;
                    if (prop.name == "_DetailMaskBlendFalloff")
                        continue;
                    if (prop.name == "_DetailMaskNormalFiltering")
                        continue;
                    if (prop.name == "_DetailMaskNormalStrength")
                        continue;
                }
            }
            if (material.HasProperty("_DetailSecondaryEnable"))
            {
                if (material.GetInt("_DetailSecondaryEnable") == 0)
                {
                    if (prop.name == "_DetailSecondaryColor")
                        continue;
                    if (prop.name == "_DetailSecondaryBrightness")
                        continue;
                    if (prop.name == "_DetailSecondarySaturation")
                        continue;
                    if (prop.name == "_DetailSecondaryColorMap")
                        continue;
                    if (prop.name == "_DetailSecondaryUVs")
                        continue;
                    if (prop.name == "_DetailSecondaryUVMode")
                        continue;
                    if (prop.name == "_DetailSecondaryUVRotation")
                        continue;
                    if (prop.name == "_DetailSecondaryNormalMap")
                        continue;
                    if (prop.name == "_DetailSecondaryNormalStrength")
                        continue;
                    if (prop.name == "_DetailSecondaryBlendVertexColorEnable")
                        continue;
                    if (prop.name == "_DetailSecondaryBlendVertexColor")
                        continue;
                    if (prop.name == "_DetailSecondaryBlendSource")
                        continue;
                    if (prop.name == "_DetailSecondaryBlendWeightLayer1")
                        continue;
                    if (prop.name == "_DetailSecondaryBlendWeightLayer2")
                        continue;
                    if (prop.name == "_DetailSecondaryBlendStrength")
                        continue;
                    if (prop.name == "_DetailSecondaryBlendHeight")
                        continue;
                    if (prop.name == "_DetailSecondaryBlendSmooth")
                        continue;
                    if (prop.name == "_DetailSecondaryBlendEnableAltitudeMask")
                        continue;
                    if (prop.name == "_DetailSecondaryBlendHeightMin")
                        continue;
                    if (prop.name == "_DetailSecondaryBlendHeightMax")
                        continue;
                    if (prop.name == "_DetailSecondaryMaskEnable")
                        continue;
                    if (prop.name == "_DetailSecondaryMaskIsInverted")
                        continue;
                    if (prop.name == "_DetailSecondaryMaskMap")
                        continue;
                    if (prop.name == "_DetailSecondaryMaskUVs")
                        continue;
                    if (prop.name == "_DetailSecondaryMaskUVRotation")
                        continue;
                    if (prop.name == "_DetailSecondaryMaskBlendSource")
                        continue;
                    if (prop.name == "_DetailSecondaryMaskBlendStrength")
                        continue;
                    if (prop.name == "_DetailSecondaryMaskBlendHardness")
                        continue;
                    if (prop.name == "_DetailSecondaryMaskBlendFalloff")
                        continue;
                    if (prop.name == "_DetailSecondaryMaskNormalFiltering")
                        continue;
                    if (prop.name == "_DetailSecondaryMaskNormalStrength")
                        continue;
                }
            }
            if (material.HasProperty("_DetailSecondaryBlendEnableAltitudeMask"))
            {
                if (material.GetInt("_DetailSecondaryBlendEnableAltitudeMask") == 0)
                {
                    if (prop.name == "_DetailSecondaryBlendHeightMin")
                        continue;
                    if (prop.name == "_DetailSecondaryBlendHeightMax")
                        continue;
                }
            }
            if (material.HasProperty("_DetailSecondaryBlendVertexColorEnable"))
            {
                if (material.GetInt("_DetailSecondaryBlendVertexColorEnable") == 0)
                {
                    if (prop.name == "_DetailSecondaryBlendVertexColor")
                        continue;
                }
            }
            if (material.HasProperty("_DetailSecondaryMaskEnable"))
            {
                if (material.GetInt("_DetailSecondaryMaskEnable") == 0)
                {
                    if (prop.name == "_DetailSecondaryMaskIsInverted")
                        continue;
                    if (prop.name == "_DetailSecondaryMaskMap")
                        continue;
                    if (prop.name == "_DetailSecondaryMaskUVs")
                        continue;
                    if (prop.name == "_DetailSecondaryMaskUVRotation")
                        continue;
                    if (prop.name == "_DetailSecondaryMaskBlendSource")
                        continue;
                    if (prop.name == "_DetailSecondaryMaskBlendStrength")
                        continue;
                    if (prop.name == "_DetailSecondaryMaskBlendHardness")
                        continue;
                    if (prop.name == "_DetailSecondaryMaskBlendFalloff")
                        continue;
                    if (prop.name == "_DetailSecondaryMaskNormalFiltering")
                        continue;
                    if (prop.name == "_DetailSecondaryMaskNormalStrength")
                        continue;
                }
            }
            #endregion [DESF Module Detail]

            #region [DESF Module Dissolve]
            if (material.HasProperty("_DissolveFadeEnable"))
            {
                if (material.GetInt("_DissolveFadeEnable") == 0)
                {
                    if (prop.name == "_DissolveFadeStart")
                        continue;
                    if (prop.name == "_DissolveFadeEnd")
                        continue;
                    if (prop.name == "_DissolveDitherEnable")
                        continue;
                    if (prop.name == "_DissolveDitherMap")
                        continue;
                }
            }
            if (material.HasProperty("_DissolveDitherEnable"))
            {
                if (material.GetInt("_DissolveDitherEnable") == 0)
                {
                    if (prop.name == "_DissolveDitherMap")
                        continue;
                }
            }
            #endregion [DESF Module Dissolve]

            #region [DESF Module Emission]
            if (material.HasProperty("_EmissiveMapEnable"))
            {
                if (material.GetInt("_EmissiveMapEnable") == 0)
                {
                    if (prop.name == "_EmissiveColorMapInverted")
                        continue;
                    if (prop.name == "_EmissiveColorMap")
                        continue;
                    if (prop.name == "_EmissiveColorMapUVs")
                        continue;
                    if (prop.name == "_EmissivePanningisGlobal")
                        continue;
                    if (prop.name == "_EmissivePanningColor")
                        continue;
                    if (prop.name == "_EmissivePanningIntensity")
                        continue;
                    if (prop.name == "_EmissivePanningIntensityHDRP")
                        continue;
                    if (prop.name == "_EmissivePanningExposureWeight")
                        continue;
                    if (prop.name == "_EmissivePanningIsRandom")
                        continue;
                    if (prop.name == "_EmissivePanningRandomSpeed")
                        continue;
                    if (prop.name == "_EmissivePanningRotation")
                        continue;
                    if (prop.name == "_EmissiveColorMapFlicker")
                        continue;
                    if (prop.name == "_EmissivePanningSpeedX")
                        continue;
                    if (prop.name == "_EmissivePanningSpeedY")
                        continue;
                    if (prop.name == "_EmissiveWorldSpaceBlend")
                        continue;
                    if (prop.name == "_EmissiveWorldSpaceOffset")
                        continue;
                    if (prop.name == "_EmissiveWorldSpaceShift")
                        continue;
                    if (prop.name == "_EmissiveWorldSpaceScatter")
                        continue;
                    if (prop.name == "_EmissiveWorldSpaceDistance")
                        continue;
                }
            }
            if (material.HasProperty("_EmissiveColorMaskingEnable"))
            {
                if (material.GetInt("_EmissiveColorMaskingEnable") == 0)
                {
                    if (prop.name == "_EmissiveColorMaskingColor")
                        continue;
                    if (prop.name == "_EmissiveColorMaskingRange")
                        continue;
                    if (prop.name == "_EmissiveColorMaskingFuzziness")
                        continue;
                }
            }
            if (material.HasProperty("_EmissiveGlowEnable"))
            {
                if (material.GetInt("_EmissiveGlowEnable") == 0)
                {
                    if (prop.name == "_EmissiveGlowisGlobal")
                        continue;
                    if (prop.name == "_EmissiveGlowColor")
                        continue;
                    if (prop.name == "_EmissiveGlowIntensity")
                        continue;
                    if (prop.name == "_EmissiveGlowIntensityHDRP")
                        continue;
                    if (prop.name == "_EmissiveGlowExposureWeight")
                        continue;
                    if (prop.name == "_EmissiveGlowIsRandom")
                        continue;
                    if (prop.name == "_EmissiveGlowRandomSpeed")
                        continue;
                }
            }
            if (material.HasProperty("_EmissiveMaskEnable"))
            {
                if (material.GetInt("_EmissiveMaskEnable") == 0)
                {
                    if (prop.name == "_EmissiveMaskisGlobal")
                        continue;
                    if (prop.name == "_EmissiveMask")
                        continue;
                    if (prop.name == "_EmissiveMaskUVs")
                        continue;
                    if (prop.name == "_EmissiveMaskRotation")
                        continue;
                    if (prop.name == "_EmissiveMaskPanningSpeedX")
                        continue;
                    if (prop.name == "_EmissiveMaskPanningSpeedY")
                        continue;
                    if (prop.name == "_EmissiveMaskRColor")
                        continue;
                    if (prop.name == "_EmissiveMaskRIntensity")
                        continue;
                    if (prop.name == "_EmissiveMaskRIntensityHDRP")
                        continue;
                    if (prop.name == "_EmissiveMaskRExposureWeight")
                        continue;
                    if (prop.name == "_EmissiveMaskGColor")
                        continue;
                    if (prop.name == "_EmissiveMaskGIntensity")
                        continue;
                    if (prop.name == "_EmissiveMaskGIntensityHDRP")
                        continue;
                    if (prop.name == "_EmissiveMaskGExposureWeight")
                        continue;
                    if (prop.name == "_EmissiveMaskBColor")
                        continue;
                    if (prop.name == "_EmissiveMaskBIntensity")
                        continue;
                    if (prop.name == "_EmissiveMaskBIntensityHDRP")
                        continue;
                    if (prop.name == "_EmissiveMaskBExposureWeight")
                        continue;
                    if (prop.name == "_EmissiveMaskAColor")
                        continue;
                    if (prop.name == "_EmissiveMaskAIntensity")
                        continue;
                    if (prop.name == "_EmissiveMaskAIntensityHDRP")
                        continue;
                    if (prop.name == "_EmissiveMaskAExposureWeight")
                        continue;
                }
            }
            #endregion [DESF Module Emission]

            #region [DESF Module Emission Blending]
            if (material.HasProperty("_BlendEmissiveSpace"))
            {
                if (material.GetInt("_BlendEmissiveSpace") == 0)
                {
                    if (prop.name == "_BlendEmissionWorldSpaceOffset")
                        continue;
                    if (prop.name == "_BlendEmissionWorldSpaceBlend")
                        continue;
                    if (prop.name == "_BlendEmissionWorldSpaceScatter")
                        continue;
                    if (prop.name == "_BlendEmissionWorldSpaceShift")
                        continue;
                    if (prop.name == "_BlendEmissionWorldSpaceDistance")
                        continue;
                }
            }
            #endregion [DESF Module Emission Blending]

            #region [DESF Module Emission Double Sided]
            if (material.HasProperty("_EmissiveMapEnable"))
            {
                if (material.GetInt("_EmissiveMapEnable") == 0)
                {
                    if (prop.name == "_EmissiveColorMap")
                        continue;
                    if (prop.name == "_EmissiveColorMapUVs")
                        continue;
                    if (prop.name == "_EmissiveColorMapNoise")
                        continue;
                    if (prop.name == "_EmissivePanningRotation")
                        continue;
                    if (prop.name == "_EmissivePanningSpeedX")
                        continue;
                    if (prop.name == "_EmissivePanningSpeedY")
                        continue;
                    if (prop.name == "_EmissiveWorldSpaceBlend")
                        continue;
                    if (prop.name == "_EmissiveWorldSpaceOffset")
                        continue;
                    if (prop.name == "_EmissiveWorldSpaceShift")
                        continue;
                    if (prop.name == "_EmissiveWorldSpaceScatter")
                        continue;
                    if (prop.name == "_EmissiveWorldSpaceDistance")
                        continue;
                }
            }
            if (material.HasProperty("_EmissiveColorMaskingEnable"))
            {
                if (material.GetInt("_EmissiveColorMaskingEnable") == 0)
                {
                    if (prop.name == "_EmissiveColorMaskingColor")
                        continue;
                    if (prop.name == "_EmissiveColorMaskingRange")
                        continue;
                    if (prop.name == "_EmissiveColorMaskingFuzziness")
                        continue;
                }
            }
            if (material.HasProperty("_EmissiveGlowEnable"))
            {
                if (material.GetInt("_EmissiveGlowEnable") == 0)
                {
                    if (prop.name == "_EmissiveGlowisGlobal")
                        continue;
                    if (prop.name == "_EmissiveGlowColor")
                        continue;
                    if (prop.name == "_EmissiveGlowIntensity")
                        continue;
                    if (prop.name == "_EmissiveGlowIntensityHDRP")
                        continue;
                    if (prop.name == "_EmissiveGlowExposureWeight")
                        continue;
                }
            }
            if (material.HasProperty("_EmissiveMaskEnable"))
            {
                if (material.GetInt("_EmissiveMaskEnable") == 0)
                {
                    if (prop.name == "_EmissiveMaskisGlobal")
                        continue;
                    if (prop.name == "_EmissiveMask")
                        continue;
                    if (prop.name == "_EmissiveMaskUVs")
                        continue;
                    if (prop.name == "_EmissiveMaskRotation")
                        continue;
                    if (prop.name == "_EmissiveMaskPanningSpeedX")
                        continue;
                    if (prop.name == "_EmissiveMaskPanningSpeedY")
                        continue;
                    if (prop.name == "_EmissiveMaskColor")
                        continue;
                    if (prop.name == "_EmissiveMaskRColor")
                        continue;
                    if (prop.name == "_EmissiveMaskIntensity")
                        continue;
                    if (prop.name == "_EmissiveMaskRIntensity")
                        continue;
                    if (prop.name == "_EmissiveMaskIntensityHDRP")
                        continue;
                    if (prop.name == "_EmissiveMaskRIntensityHDRP")
                        continue;
                    if (prop.name == "_EmissiveMaskExposureWeight")
                        continue;
                    if (prop.name == "_EmissiveMaskRExposureWeight")
                        continue;
                    if (prop.name == "_EmissiveMaskGColor")
                        continue;
                    if (prop.name == "_EmissiveMaskGIntensity")
                        continue;
                    if (prop.name == "_EmissiveMaskGIntensityHDRP")
                        continue;
                    if (prop.name == "_EmissiveMaskGExposureWeight")
                        continue;
                    if (prop.name == "_EmissiveMaskBColor")
                        continue;
                    if (prop.name == "_EmissiveMaskBIntensity")
                        continue;
                    if (prop.name == "_EmissiveMaskBIntensityHDRP")
                        continue;
                    if (prop.name == "_EmissiveMaskBExposureWeight")
                        continue;
                    if (prop.name == "_EmissiveMaskAColor")
                        continue;
                    if (prop.name == "_EmissiveMaskAIntensity")
                        continue;
                    if (prop.name == "_EmissiveMaskAIntensityHDRP")
                        continue;
                    if (prop.name == "_EmissiveMaskAExposureWeight")
                        continue;
                }
            }
            #endregion [DESF Module Emission Double Sided]

            #region [DESF Module Moss]
            if (material.HasProperty("_MossHeightEnable"))
            {
                if (material.GetInt("_MossHeightEnable") == 0)
                {
                    if (prop.name == "_MossHeightStrength")
                        continue;
                    if (prop.name == "_MossHeightWeight")
                        continue;
                    if (prop.name == "_MossHeightDepth")
                        continue;
                    if (prop.name == "_MossHeightNoiseScale")
                        continue;
                    if (prop.name == "_MossHeightNoiseShift")
                        continue;
                }
            }
            if (material.HasProperty("_MossMode"))
            {
                if (material.GetInt("_MossMode") == 0)
                {
                    if (prop.name == "_MossBlendNormalInfluenceBottom")
                        continue;
                    if (prop.name == "_MossBlendStrengthBottom")
                        continue;
                    if (prop.name == "_MossBlendStrengthHeightBottom")
                        continue;
                    if (prop.name == "_MossBlendOffsetBottom")
                        continue;
                }
            }
            if (material.HasProperty("_MossMode"))
            {
                if (material.GetInt("_MossMode") == 1)
                {
                    if (prop.name == "_MossBlendNormalInfluence")
                        continue;
                    if (prop.name == "_MossBlendStrength")
                        continue;
                    if (prop.name == "_MossBlendStrengthHeight")
                        continue;
                    if (prop.name == "_MossBlendOffset")
                        continue;
                    if (prop.name == "_MossBlendSideStrength")
                        continue;
                }
            }
            if (material.HasProperty("_MossWetnessEnable"))
            {
                if (material.GetInt("_MossWetnessEnable") == 0)
                {
                    if (prop.name == "_MossWetnessStrength")
                        continue;
                }
            }
            #endregion [DESF Module Moss]

            #region [DESF Module Tessellation]
            if (material.HasProperty("_TessellationEnable"))
            {
                if (material.GetInt("_TessellationEnable") == 0)
                {
                    if (prop.name == "_TessellationStrength")
                        continue;
                    if (prop.name == "_TessellationDistanceMin")
                        continue;
                    if (prop.name == "_TessellationDistanceMax")
                        continue;
                    if (prop.name == "_TessellationCulling")
                        continue;
                }
            }
            #endregion [DESF Module Tessellation]

            #region [DESF Module Color Shift]
            if (material.HasProperty("_ColorShiftSource"))
            {
                if (material.GetInt("_ColorShiftSource") == 0)
                {
                    if (prop.name == "_ColorShiftWorldSpaceDistance")
                        continue;
                    if (prop.name == "_ColorShiftWorldSpaceOffset")
                        continue;
                    if (prop.name == "_ColorShiftWorldSpaceNoiseShift")
                        continue;
                }
            }
            if (material.HasProperty("_ColorShiftSource"))
            {
                if (material.GetInt("_ColorShiftSource") == 2)
                {
                    if (prop.name == "_ColorShiftWorldSpaceDistance")
                        continue;
                    if (prop.name == "_ColorShiftWorldSpaceOffset")
                        continue;
                    if (prop.name == "_ColorShiftWorldSpaceNoiseShift")
                        continue;
                }
            }
            if (material.HasProperty("_ColorShiftSource"))
            {
                if (material.GetInt("_ColorShiftSource") == 3)
                {
                    if (prop.name == "_ColorShiftWorldSpaceDistance")
                        continue;
                    if (prop.name == "_ColorShiftWorldSpaceOffset")
                        continue;
                    if (prop.name == "_ColorShiftWorldSpaceNoiseShift")
                        continue;
                }
            }
            if (material.HasProperty("_ColorShiftEnableMask"))
            {
                if (material.GetInt("_ColorShiftEnableMask") == 0)
                {
                    if (prop.name == "_ColorShiftMaskMap")
                        continue;
                    if (prop.name == "_ColorShiftMaskInverted")
                        continue;
                    if (prop.name == "_ColorShiftMaskFuzziness")
                        continue;
                }
            }
            #endregion [DESF Module Color Shift]

            #region [DESF Module Outline]
            if (material.HasProperty("_OutlineMaskEnable"))
            {
                if (material.GetInt("_OutlineMaskEnable") == 0)
                {
                    if (prop.name == "_OutlineMaskSource")
                        continue;
                    if (prop.name == "_OutlineMaskEmissiveColor")
                        continue;
                    if (prop.name == "_OutlineMaskEmissiveIntensity")
                        continue;
                    if (prop.name == "_OutlineMaskEmissiveExposureWeight")
                        continue;
                    if (prop.name == "_OutlineMaskMap")
                        continue;
                    if (prop.name == "_OutlineMaskUVs")
                        continue;
                    if (prop.name == "_OutlineMaskPanningSpeedX")
                        continue;
                    if (prop.name == "_OutlineMaskPanningSpeedY")
                        continue;
                }
            }
            if (material.HasProperty("_OutlineMaskSource"))
            {
                if (material.GetInt("_OutlineMaskSource") == 0)
                {
                    if (prop.name == "_OutlineMaskEmissiveColor")
                        continue;
                    if (prop.name == "_OutlineMaskEmissiveIntensity")
                        continue;
                    if (prop.name == "_OutlineMaskEmissiveExposureWeight")
                        continue;
                    if (prop.name == "_OutlineMaskMap")
                        continue;
                    if (prop.name == "_OutlineMaskUVs")
                        continue;
                    if (prop.name == "_OutlineMaskPanningSpeedX")
                        continue;
                    if (prop.name == "_OutlineMaskPanningSpeedY")
                        continue;
                }
            }
            #endregion [DESF Module Outline]

            #region [DESF Module Rim Light]
            if (material.HasProperty("_EnableRimLightNoise"))
            {
                if (material.GetInt("_EnableRimLightNoise") == 0)
                {
                    if (prop.name == "_RimLightNoiseNoiseMap")
                        continue;
                    if (prop.name == "_RimLightNoiseColor")
                        continue;
                    if (prop.name == "_RimLightNoiseIntensity")
                        continue;
                    if (prop.name == "_RimLightNoiseExposureWeight")
                        continue;
                    if (prop.name == "_RimLightNoiseStrength")
                        continue;
                }
            }
            if (material.HasProperty("_EnableRimLightBump"))
            {
                if (material.GetInt("_EnableRimLightBump") == 0)
                {
                    if (prop.name == "_RimLightBumpMap")
                        continue;
                    if (prop.name == "_RimLightBumpStrength")
                        continue;
                    if (prop.name == "_RimLightBumpPower")
                        continue;
                }
            }
            #endregion [DESF Module Rim Light]

            #region [DESF Module Reflection Probe URP]
            if (material.HasProperty("_ReflectionProbeFresnelEnable"))
            {
                if (material.GetInt("_ReflectionProbeFresnelEnable") == 0)
                {
                    if (prop.name == "_ReflectionProbeFresnelStrength")
                        continue;
                    if (prop.name == "_ReflectionProbeFresnelScale")
                        continue;
                    if (prop.name == "_ReflectionProbeFresnelPower")
                        continue;
                }
            }
            #endregion [DESF Module Reflection Probe URP]

            #region [DESF Module Vertex Melt]
            if (material.HasProperty("_VertexMeltOscillationAutoEnable"))
            {
                if (material.GetInt("_VertexMeltOscillationAutoEnable") == 0)
                {
                    if (prop.name == "_VertexMeltOscillationAutoStrength")
                        continue;
                    if (prop.name == "_VertexMeltOscillationAutoLimit")
                        continue;
                    if (prop.name == "_VertexMeltOscillationAutoSpeed")
                        continue;
                }
            }
            if (material.HasProperty("_VertexMeltOscillationAutoEnable"))
            {
                if (material.GetInt("_VertexMeltOscillationAutoEnable") == 1)
                {
                    if (prop.name == "_VertexMeltOscillationStrength")
                        continue;
                }
            }
            #endregion [DESF Module Vertex Melt]

            #region [DESF Module Weather Snow]
            if (material.HasProperty("_SnowHeightEnable"))
            {
                if (material.GetInt("_SnowHeightEnable") == 0)
                {
                    if (prop.name == "_SnowHeightStrength")
                        continue;
                    if (prop.name == "_SnowHeightClipFar")
                        continue;
                    if (prop.name == "_SnowHeightWeight")
                        continue;
                    if (prop.name == "_SnowHeightDepth")
                        continue;
                    if (prop.name == "_SnowHeightNoiseScale")
                        continue;
                    if (prop.name == "_SnowHeightNoiseShift")
                        continue;
                }
            }
            if (material.HasProperty("_SnowMode"))
            {
                if (material.GetInt("_SnowMode") == 0)
                {
                    if (prop.name == "_SnowBlendNormalInfluenceBottom")
                        continue;
                    if (prop.name == "_SnowBlendStrengthBottom")
                        continue;
                    if (prop.name == "_SnowBlendStrengthHeightBottom")
                        continue;
                    if (prop.name == "_SnowBlendOffsetBottom")
                        continue;
                }
            }
            if (material.HasProperty("_SnowMode"))
            {
                if (material.GetInt("_SnowMode") == 1)
                {
                    if (prop.name == "_SnowBlendNormalInfluence")
                        continue;
                    if (prop.name == "_SnowBlendStrength")
                        continue;
                    if (prop.name == "_SnowBlendStrengthHeight")
                        continue;
                    if (prop.name == "_SnowBlendOffset")
                        continue;
                    if (prop.name == "_SnowBlendSideStrength")
                        continue;
                }
            }
            if (material.HasProperty("_SnowSparkleEnable"))
            {
                if (material.GetInt("_SnowSparkleEnable") == 0)
                {
                    if (prop.name == "_SnowSparkleColor")
                        continue;
                    if (prop.name == "_SnowSparkleMap")
                        continue;
                    if (prop.name == "_SnowSparkleSaturate")
                        continue;
                    if (prop.name == "_SnowSparkleStrength")
                        continue;
                    if (prop.name == "_SnowSparkleFlicker")
                        continue;
                    if (prop.name == "_SnowSparkleCutoff")
                        continue;
                    if (prop.name == "_SnowSparkleFrequency")
                        continue;
                    if (prop.name == "_SnowSparkleScreenContribution")
                        continue;
                    if (prop.name == "_SnowSparkleAnimation")
                        continue;
                    if (prop.name == "_SnowSparkleSpeed")
                        continue;
                }
            }
            if (material.HasProperty("_SnowWetnessEnable"))
            {
                if (material.GetInt("_SnowWetnessEnable") == 0)
                {
                    if (prop.name == "_SnowWetnessStrength")
                        continue;
                }
            }
            #endregion [DESF Module Weather Snow]

            #region [DESF Module Weather Rain]
            if (material.HasProperty("_RainHorizontalEnable"))
            {
                if (material.GetInt("_RainHorizontalEnable") == 0)
                {
                    if (prop.name == "_RainHorizontalRainMap")
                        continue;
                    if (prop.name == "_RainHorizontalIntensity")
                        continue;
                    if (prop.name == "_RainHorizontalSpeed")
                        continue;
                    if (prop.name == "_RainHorizontalScreenContribution")
                        continue;
                    if (prop.name == "_RainHorizontalColumns")
                        continue;
                    if (prop.name == "_RainHorizontalRows")
                        continue;
                    if (prop.name == "_RainHorizontalUVTye")
                        continue;
                    if (prop.name == "_RainHorizontalUVs")
                        continue;
                }
            }
            if (material.HasProperty("_RainVerticalEnable"))
            {
                if (material.GetInt("_RainVerticalEnable") == 0)
                {
                    if (prop.name == "_RainVerticalRainMap")
                        continue;
                    if (prop.name == "_RainVerticalIntensity")
                        continue;
                    if (prop.name == "_RainVerticalSmoothEdge")
                        continue;
                    if (prop.name == "_RainVerticalSpeed")
                        continue;
                    if (prop.name == "_RainVerticalScreenContribution")
                        continue;
                    if (prop.name == "_RainVerticalColumns")
                        continue;
                    if (prop.name == "_RainVerticalRows")
                        continue;
                    if (prop.name == "_RainVerticalUVType")
                        continue;
                    if (prop.name == "_RainVerticalUVs")
                        continue;
                }
            }
            if (material.HasProperty("_RainStaticEnable"))
            {
                if (material.GetInt("_RainStaticEnable") == 0)
                {
                    if (prop.name == "_RainStaticRainMap")
                        continue;
                    if (prop.name == "_RainStaticIntensity")
                        continue;
                    if (prop.name == "_RainStaticScreenContribution")
                        continue;
                    if (prop.name == "_RainStaticUVType")
                        continue;
                    if (prop.name == "_RainStaticUVs")
                        continue;
                }
            }
            #endregion [DESF Module Weather Rain]

            #region [DESF Module Weather Wind]
            if (material.HasProperty("_WindMaskType"))
            {
                if (material.GetInt("_WindMaskType") == 1)
                {
                    if (prop.name == "_WindMaskMap")
                        continue;
                    if (prop.name == "_WindMaskMapIntensity")
                        continue;

                }
            }
            if (material.HasProperty("_WindMaskType"))
            {
                if (material.GetInt("_WindMaskType") == 0)
                {
                    if (prop.name == "_WindMaskProcedralTopDown")
                        continue;
                    if (prop.name == "_WindMaskProcedralBottomUp")
                        continue;
                    if (prop.name == "_WindMaskProcedralSpherical")
                        continue;
                    if (prop.name == "_WindMaskProcedralSphericalInverted")
                        continue;
                }
            }
            if (material.HasProperty("_WindEnableMode"))
            {
                if (material.GetInt("_WindEnableMode") == 1)
                {
                    if (prop.name == "_WindGlobalIntensity")
                        continue;
                    if (prop.name == "_WindGlobalTurbulence")
                        continue;
                }
            }
            if (material.HasProperty("_WindEnableMode"))
            {
                if (material.GetInt("_WindEnableMode") == 0)
                {
                    if (prop.name == "_WindLocalIntensity")
                        continue;
                    if (prop.name == "_WindLocalTurbulence")
                        continue;
                    if (prop.name == "_WindLocalPulseFrequency")
                        continue;
                    if (prop.name == "_WindLocalRandomOffset")
                        continue;
                    if (prop.name == "_WindLocalDirection")
                        continue;
                }
            }
            #endregion [DESF Module Weather Wind]

            #region [DESF Input Displacement]
            if (material.HasProperty("_DisplacementEnable"))
            {
                if (material.GetInt("_DisplacementEnable") == 0)
                {
                    if (prop.name == "_DisplacementNormalReconstructed")
                        continue;
                    if (prop.name == "_DisplacementStrength")
                        continue;
                    if (prop.name == "_DisplacementBlendInversion")
                        continue;
                    if (prop.name == "_DisplacementOffset")
                        continue;
                    if (prop.name == "_ParallaxMap")
                        continue;
                    if (prop.name == "_DisplacementEdgeEnable")
                        continue;
                    if (prop.name == "_DisplacementEdgeMin")
                        continue;
                    if (prop.name == "_DisplacementEdgeMax")
                        continue;
                    if (prop.name == "_DisplacementFadeEnable")
                        continue;
                    if (prop.name == "_DisplacementFadeDepth")
                        continue;
                    if (prop.name == "_DisplacementFadeStart")
                        continue;
                    if (prop.name == "_DisplacementFadeEnd")
                        continue;
                }
            }
            if (material.HasProperty("_00DisplacementEnable"))
            {
                if (material.GetInt("_00DisplacementEnable") == 0)
                {
                    if (prop.name == "_00DisplacementNormalReconstructed")
                        continue;
                    if (prop.name == "_00DisplacementStrength")
                        continue;
                    if (prop.name == "_00DisplacementOffset")
                        continue;
                    if (prop.name == "_00ParallaxMap")
                        continue;
                    if (prop.name == "_00DisplacementEdgeEnable")
                        continue;
                    if (prop.name == "_00DisplacementEdgeMin")
                        continue;
                    if (prop.name == "_00DisplacementEdgeMax")
                        continue;
                    if (prop.name == "_00DisplacementFadeEnable")
                        continue;
                    if (prop.name == "_00DisplacementFadeDepth")
                        continue;
                    if (prop.name == "_00DisplacementFadeStart")
                        continue;
                    if (prop.name == "_00DisplacementFadeEnd")
                        continue;
                }
            }
            if (material.HasProperty("_01DisplacementEnable"))
            {
                if (material.GetInt("_01DisplacementEnable") == 0)
                {
                    if (prop.name == "_01DisplacementNormalReconstructed")
                        continue;
                    if (prop.name == "_01DisplacementStrength")
                        continue;
                    if (prop.name == "_01DisplacementOffset")
                        continue;
                    if (prop.name == "_01ParallaxMap")
                        continue;
                    if (prop.name == "_01DisplacementEdgeEnable")
                        continue;
                    if (prop.name == "_01DisplacementEdgeMin")
                        continue;
                    if (prop.name == "_01DisplacementEdgeMax")
                        continue;
                    if (prop.name == "_01DisplacementFadeEnable")
                        continue;
                    if (prop.name == "_01DisplacementFadeDepth")
                        continue;
                    if (prop.name == "_01DisplacementFadeStart")
                        continue;
                    if (prop.name == "_01DisplacementFadeEnd")
                        continue;
                }
            }
            if (material.HasProperty("_02DisplacementEnable"))
            {
                if (material.GetInt("_02DisplacementEnable") == 0)
                {
                    if (prop.name == "_02DisplacementNormalReconstructed")
                        continue;
                    if (prop.name == "_02DisplacementStrength")
                        continue;
                    if (prop.name == "_02DisplacementOffset")
                        continue;
                    if (prop.name == "_02ParallaxMap")
                        continue;
                    if (prop.name == "_02DisplacementEdgeEnable")
                        continue;
                    if (prop.name == "_02DisplacementEdgeMin")
                        continue;
                    if (prop.name == "_02DisplacementEdgeMax")
                        continue;
                    if (prop.name == "_02DisplacementFadeEnable")
                        continue;
                    if (prop.name == "_02DisplacementFadeDepth")
                        continue;
                    if (prop.name == "_02DisplacementFadeStart")
                        continue;
                    if (prop.name == "_02DisplacementFadeEnd")
                        continue;
                }
            }
            if (material.HasProperty("_DisplacementEdgeEnable"))
            {
                if (material.GetInt("_DisplacementEdgeEnable") == 0)
                {
                    if (prop.name == "_DisplacementEdgeMin")
                        continue;
                    if (prop.name == "_DisplacementEdgeMax")
                        continue;
                }
            }
            if (material.HasProperty("_DisplacementFadeEnable"))
            {
                if (material.GetInt("_DisplacementFadeEnable") == 0)
                {
                    if (prop.name == "_DisplacementFadeDepth")
                        continue;
                    if (prop.name == "_DisplacementFadeStart")
                        continue;
                    if (prop.name == "_DisplacementFadeEnd")
                        continue;
                }
            }
            #endregion [DESF Input Displacement]

            #region [DESF Input Occlusion]
            if (material.HasProperty("_OcclusionSourceBaked"))
            {
                if (material.GetInt("_OcclusionSourceBaked") == 1)
                {
                    if (prop.name == "_OcclusionSourceInverted")
                        continue;
                    if (prop.name == "_OcclusionMap")
                        continue;
                }
            }
            #endregion [DESF Input Occlusion]

            #region [DESF Input Smoothness]
            if (material.HasProperty("_SmoothnessSourceTexture"))
            {
                if (material.GetInt("_SmoothnessSourceTexture") == 0)
                {
                    if (prop.name == "_SmoothnessSource")
                        continue;
                    if (prop.name == "_SmoothnessMap")
                        continue;
                    if (prop.name == "_SmoothnessUVs")
                        continue;
                    if (prop.name == "_SmoothnessRotation")
                        continue;
                }
            }
            if (material.HasProperty("_SmoothnessFresnelEnable"))
            {
                if (material.GetInt("_SmoothnessFresnelEnable") == 0)
                {
                    if (prop.name == "_SmoothnessFresnelScale")
                        continue;
                    if (prop.name == "_SmoothnessFresnelPower")
                        continue;
                }
            }
            #endregion [DESF Input Smoothness]

            #region [DESF Input Smoothness Custom]
            if (material.HasProperty("_00SmoothnessSourceTexture"))
            {
                if (material.GetInt("_00SmoothnessSourceTexture") == 0)
                {
                    if (prop.name == "_00SmoothnessSource")
                        continue;
                    if (prop.name == "_00SmoothnessMap")
                        continue;
                }
            }
            if (material.HasProperty("_00SmoothnessFresnelEnable"))
            {
                if (material.GetInt("_00SmoothnessFresnelEnable") == 0)
                {
                    if (prop.name == "_00SmoothnessFresnelScale")
                        continue;
                    if (prop.name == "_00SmoothnessFresnelPower")
                        continue;
                }
            }
            if (material.HasProperty("_01SmoothnessSourceTexture"))
            {
                if (material.GetInt("_01SmoothnessSourceTexture") == 0)
                {
                    if (prop.name == "_01SmoothnessSource")
                        continue;
                    if (prop.name == "_01SmoothnessMap")
                        continue;
                }
            }
            if (material.HasProperty("_01SmoothnessFresnelEnable"))
            {
                if (material.GetInt("_01SmoothnessFresnelEnable") == 0)
                {
                    if (prop.name == "_01SmoothnessFresnelScale")
                        continue;
                    if (prop.name == "_01SmoothnessFresnelPower")
                        continue;
                }
            }
            if (material.HasProperty("_02SmoothnessSourceTexture"))
            {
                if (material.GetInt("_02SmoothnessSourceTexture") == 0)
                {
                    if (prop.name == "_02SmoothnessSource")
                        continue;
                    if (prop.name == "_02SmoothnessMap")
                        continue;
                }
            }
            if (material.HasProperty("_02SmoothnessFresnelEnable"))
            {
                if (material.GetInt("_02SmoothnessFresnelEnable") == 0)
                {
                    if (prop.name == "_02SmoothnessFresnelScale")
                        continue;
                    if (prop.name == "_02SmoothnessFresnelPower")
                        continue;
                }
            }
            if (material.HasProperty("_DirtSmoothnessSourceTexture"))
            {
                if (material.GetInt("_DirtSmoothnessSourceTexture") == 0)
                {
                    if (prop.name == "_DirtSmoothnessSource")
                        continue;
                    if (prop.name == "_DirtSmoothnessMap")
                        continue;
                }
            }
            if (material.HasProperty("_DirtSmoothnessFresnelEnable"))
            {
                if (material.GetInt("_DirtSmoothnessFresnelEnable") == 0)
                {
                    if (prop.name == "_DirtSmoothnessFresnelScale")
                        continue;
                    if (prop.name == "_DirtSmoothnessFresnelPower")
                        continue;
                }
            }
            if (material.HasProperty("_SnowSmoothnessSourceTexture"))
            {
                if (material.GetInt("_SnowSmoothnessSourceTexture") == 0)
                {
                    if (prop.name == "_SnowSmoothnessSource")
                        continue;
                    if (prop.name == "_SnowSmoothnessMap")
                        continue;
                }
            }
            if (material.HasProperty("_SnowSmoothnessFresnelEnable"))
            {
                if (material.GetInt("_SnowSmoothnessFresnelEnable") == 0)
                {
                    if (prop.name == "_SnowSmoothnessFresnelScale")
                        continue;
                    if (prop.name == "_SnowSmoothnessFresnelPower")
                        continue;
                }
            }
            if (material.HasProperty("_MossSmoothnessSourceTexture"))
            {
                if (material.GetInt("_MossSmoothnessSourceTexture") == 0)
                {
                    if (prop.name == "_MossSmoothnessSource")
                        continue;
                    if (prop.name == "_SnowSmoothnessMap")
                        continue;
                }
            }
            if (material.HasProperty("_MossSmoothnessFresnelEnable"))
            {
                if (material.GetInt("_MossSmoothnessFresnelEnable") == 0)
                {
                    if (prop.name == "_MossSmoothnessFresnelScale")
                        continue;
                    if (prop.name == "_MossSmoothnessFresnelPower")
                        continue;
                }
            }
            #endregion [DESF Input Smoothness Custom]

            #region [DESF Input Specular]
            if (material.HasProperty("_SpecularMode"))
            {
                if (material.GetInt("_SpecularMode") == 0)
                {
                    if (prop.name == "_SpecularStrengthDielectric")
                        continue;
                    if (prop.name == "_SpecularStrengthDielectricIOR")
                        continue;
                }
            }
            if (material.HasProperty("_SpecularMode"))
            {
                if (material.GetInt("_SpecularMode") == 1)
                {
                    if (prop.name == "_SpecularStrength")
                        continue;
                    if (prop.name == "_SpecularStrengthDielectricIOR")
                        continue;
                }
            }
            if (material.HasProperty("_SpecularMode"))
            {
                if (material.GetInt("_SpecularMode") == 2)
                {
                    if (prop.name == "_SpecularStrength")
                        continue;
                    if (prop.name == "_SpecularStrengthDielectric")
                        continue;
                }
            }
            #endregion [DESF Input Specular]

            #region [DESF Input Subsurface Forward]
            if (material.HasProperty("_TransmissionSource"))
            {
                if (material.GetInt("_TransmissionSource") == 0)
                {
                    if (prop.name == "_TransmissionMaskMap")
                        continue;
                    if (prop.name == "_TransmissionMaskInverted")
                        continue;
                    if (prop.name == "_TransmissionMaskStrength")
                        continue;
                    if (prop.name == "_TransmissionMaskFeather")
                        continue;
                }
            }
            if (material.HasProperty("_TransmissionColorTempEnable"))
            {
                if (material.GetInt("_TransmissionColorTempEnable") == 0)
                {
                    if (prop.name == "_TransmissionColorTemp")
                        continue;
                }
            }
            if (material.HasProperty("_TranslucencySource"))
            {
                if (material.GetInt("_TranslucencySource") == 0)
                {
                    if (prop.name == "_ThicknessMap")
                        continue;
                    if (prop.name == "_ThicknessMapInverted")
                        continue;
                    if (prop.name == "_ThicknessStrength")
                        continue;
                    if (prop.name == "_ThicknessFeather")
                        continue;
                }
            }
            if (material.HasProperty("_TranslucencyColorTempEnable"))
            {
                if (material.GetInt("_TranslucencyColorTempEnable") == 0)
                {
                    if (prop.name == "_TranslucencyColorTemp")
                        continue;
                }
            }
            #endregion [DESF Input Subsurface Forward]

            #region [DESF Input Water Reflection]
            if (material.HasProperty("_WaterReflectionEnableFresnel"))
            {
                if (material.GetInt("_WaterReflectionEnableFresnel") == 0)
                {
                    if (prop.name == "_WaterReflectionFresnelStrength")
                        continue;
                    if (prop.name == "_WaterReflectionFresnelBias")
                        continue;
                    if (prop.name == "_WaterReflectionFresnelScale")
                        continue;
                }
            }
            if (material.HasProperty("_WaterReflectionType"))
            {
                if (material.GetInt("_WaterReflectionType") == 1)
                {
                    if (prop.name == "_WaterReflectionSmoothness")
                        continue;
                }
            }
            if (material.HasProperty("_WaterReflectionType"))
            {
                if (material.GetInt("_WaterReflectionType") == 0)
                {
                    if (prop.name == "_WaterReflectionProbeDetailURP")
                        continue;
                }
            }
            #endregion [DESF Input Water Reflection]

            #region [DESF Color Gradient Remap]
            if (material.HasProperty("_GradientEnable"))
            {
                if (material.GetInt("_GradientEnable") == 0)
                {
                    if (prop.name == "_GradientInverted")
                        continue;
                    if (prop.name == "_GradientColor")
                        continue;
                    if (prop.name == "_GradientColorSide")
                        continue;
                    if (prop.name == "_GradientColorBottom")
                        continue;
                    if (prop.name == "_GradientColorBottomSide")
                        continue;
                    if (prop.name == "_GradientColorCurvature")
                        continue;
                    if (prop.name == "_GradientRamp")
                        continue;
                    if (prop.name == "_GradientContrast")
                        continue;
                    if (prop.name == "_GradientHeightMin")
                        continue;
                    if (prop.name == "_GradientHeightMax")
                        continue;
                }
            }
            #endregion [DESF Color Gradient Remap]

            #region [DESF Color Gradient Remap Noise]
            if (material.HasProperty("_GradientNoiseEnable"))
            {
                if (material.GetInt("_GradientNoiseEnable") == 0)
                {
                    if (prop.name == "_GradientInverted")
                        continue;
                    if (prop.name == "_GradientNoiseStrengthRemap")
                        continue;
                    if (prop.name == "_GradientNoiseStrengthMin")
                        continue;
                    if (prop.name == "_GradientNoiseStrengthMax")
                        continue;
                    if (prop.name == "_GradientNoiseScale")
                        continue;
                    if (prop.name == "_GradientNoiseShift")
                        continue;
                }
            }
            #endregion [DESF Color Gradient Remap Noise]

            #region [DESF Light Flicker]
            if (material.HasProperty("_DigitalFlickerEnable"))
            {
                if (material.GetInt("_DigitalFlickerEnable") == 0)
                {
                    if (prop.name == "_DigitalFlickerIsInverted")
                        continue;
                    if (prop.name == "_DigitalFlickerSpeed")
                        continue;
                    if (prop.name == "_DigitalFlickerFrequency")
                        continue;
                    if (prop.name == "_DigitalFlickerFrequencyScale")
                        continue;
                }
            }
            #endregion [DESF Light Flicker]

            #region [DESF Sample Pixellate]
            if (material.HasProperty("_DigitalPixellateEnable"))
            {
                if (material.GetInt("_DigitalPixellateEnable") == 0)
                {
                    if (prop.name == "_DigitalPixellateIsInverted")
                        continue;
                    if (prop.name == "_DigitalPixellateColor")
                        continue;
                    if (prop.name == "_DigitalPixellateMap")
                        continue;
                    if (prop.name == "_DigitalPixellateMipBias")
                        continue;
                    if (prop.name == "_PixellateUVs")
                        continue;
                    if (prop.name == "_DigitalPixellateSize")
                        continue;
                    if (prop.name == "_DigitalPixellateIntensity")
                        continue;
                }
            }
            #endregion [DESF Sample Pixellate]

            #region [DESF UV Shake]
            if (material.HasProperty("_DigitalShakeEnable"))
            {
                if (material.GetInt("_DigitalShakeEnable") == 0)
                {
                    if (prop.name == "_DigitalShakeOpacity")
                        continue;
                    if (prop.name == "_DigitalShakeIntensity")
                        continue;
                    if (prop.name == "_DigitalShakeInterval")
                        continue;
                }
            }
            #endregion [DESF UV Shake]

            #region [DESF Noise Glitch]
            if (material.HasProperty("_DigitalNoiseEnable"))
            {
                if (material.GetInt("_DigitalNoiseEnable") == 0)
                {
                    if (prop.name == "_DigitalNoiseMap")
                        continue;
                    if (prop.name == "_DigitalNoiseMapInverted")
                        continue;
                    if (prop.name == "_DigitalNoiseDirection")
                        continue;
                    if (prop.name == "_DigitalNoiseStrength")
                        continue;
                    if (prop.name == "_DigitalNoiseSpeed")
                        continue;
                    if (prop.name == "_DigitalNoiseWidth")
                        continue;
                }
            }
            #endregion [DESF Noise Glitch]

            #region [DESF Vertex Data Grow]
            if (material.HasProperty("_VertexGrowEnable"))
            {
                if (material.GetInt("_VertexGrowEnable") == 0)
                {
                    if (prop.name == "_VertexGrowXYZ")
                        continue;
                    if (prop.name == "_VertexGrowX")
                        continue;
                    if (prop.name == "_VertexGrowY")
                        continue;
                    if (prop.name == "_VertexGrowZ")
                        continue;
                }
            }
            #endregion [DESF Vertex Data Grow]

            #region [DESF Vertex Data Glitch]
            if (material.HasProperty("_VertexGlitchEnable"))
            {
                if (material.GetInt("_VertexGlitchEnable") == 0)
                {
                    if (prop.name == "_VertexGlitchIntensity")
                        continue;
                    if (prop.name == "_VertexGlitchSpeed")
                        continue;
                    if (prop.name == "_VertexGlitchOffsetX")
                        continue;
                    if (prop.name == "_VertexGlitchOffsetY")
                        continue;
                    if (prop.name == "_VertexGlitchOffsetZ")
                        continue;
                }
            }
            #endregion [DESF Vertex Data Glitch]

            #region [CATEGORY INDEX and SPACES]
            int categoryIndex = 1;

            //customPropsList.Add(prop);

            if (prop.name.Contains("_CATEGORY"))
            {
                categoryIndex++;

                customPropsList.Add(prop);

                if (material.GetInt(prop.name) == 0)
                {
                    showCategory = false;
                    //customCategories.Add(-categoryIndex);
                }
                else
                {
                    showCategory = true;
                    //customCategories.Add(categoryIndex);

                    categoryIndex++;
                }
            }
            else
            {
                if (showCategory)
                {
                    customPropsList.Add(prop);
                    //customCategories.Add(categoryIndex);
                }
            }

        }

        //customSpaces.Add(0);

        //for (int i = 1; i < customCategories.Count; i++)
        //{
        //    if (customCategories[i - 1] != customCategories[i])
        //    {
        //        if (customCategories[i - 1] > 0)
        //        {
        //            customSpaces.Add(10);
        //        }
        //        else
        //        {
        //            customSpaces.Add(0);
        //        }
        //    }
        //    else
        //    {
        //        customSpaces.Add(0);
        //    }
        //}

        //Draw Custom GUI
        for (int i = 0; i < customPropsList.Count; i++)
        {
            var prop = customPropsList[i];

            //GUILayout.Space(customSpaces[i]);

            materialEditor.ShaderProperty(prop, prop.displayName);

        }
        #endregion [CATEGORY INDEX and SPACES]

        #region [CATEGORY - ADVANCED SETTINGS]
        showAdvanced = DE_Drawers.DrawInspectorCategory("ADVANCED SETTINGS", showAdvanced, true, 0, 0, material);

        if (showAdvanced)
        {

            #region [URP SpecularHighlights]
            //(API 12x14x15x16x) #pragma shader_feature_local_fragment _SPECULARHIGHLIGHTS_OFF
            //[HideInInspector][ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
            if (material.HasProperty("_SpecularHighlights"))
            {
                if (material.HasProperty("_SpecularHighlights"))
                {
                    var control = material.GetInt("_SpecularHighlights");

                    bool toggle = false;

                    if (control > 0.5f)
                    {
                        toggle = true;
                    }

                    toggle = EditorGUILayout.Toggle("Specular Highlights", toggle);

                    if (toggle)
                    {
                        material.SetInt("_SpecularHighlights", 1);
                        material.DisableKeyword("_SPECULARHIGHLIGHTS_OFF");
                    }
                    else
                    {
                        material.SetInt("_SpecularHighlights", 0);
                        material.EnableKeyword("_SPECULARHIGHLIGHTS_OFF");
                    }
                }
            }
            #endregion [URP SpecularHighlights]

            #region [URP EnvironmentReflections]
            //(API 12x14x15x16x) #pragma shader_feature_local_fragment _ENVIRONMENTREFLECTIONS_OFF
            //[HideInInspector][ToggleOff] _EnvironmentReflections("Environment Reflections", Float) = 1.0
            if (material.HasProperty("_EnvironmentReflections"))
            {
                if (material.HasProperty("_EnvironmentReflections"))
                {
                    var control = material.GetInt("_EnvironmentReflections");

                    bool toggle = false;

                    if (control > 0.5f)
                    {
                        toggle = true;
                    }

                    toggle = EditorGUILayout.Toggle("Environment Reflections", toggle);

                    if (toggle)
                    {
                        material.SetInt("_EnvironmentReflections", 1);
                        material.DisableKeyword("_ENVIRONMENTREFLECTIONS_OFF");
                    }
                    else
                    {
                        material.SetInt("_EnvironmentReflections", 0);
                        material.EnableKeyword("_ENVIRONMENTREFLECTIONS_OFF");
                    }
                }
            }
            #endregion [URP EnvironmentReflections]

            #region [BIRP GlossyReflections]
            if (material.HasProperty("_GlossyReflections"))
            {
                if (material.HasProperty("_GlossyReflections"))
                {
                    var control = material.GetInt("_GlossyReflections");

                    bool toggle = false;

                    if (control > 0.5f)
                    {
                        toggle = true;
                    }

                    toggle = EditorGUILayout.Toggle("Glossy Reflections", toggle);

                    if (toggle)
                    {
                        material.SetInt("_GlossyReflections", 1);
                        material.DisableKeyword("_GLOSSYREFLECTIONS_OFF");
                    }
                    else
                    {
                        material.SetInt("_GlossyReflections", 0);
                        material.EnableKeyword("_GLOSSYREFLECTIONS_OFF");
                    }
                }
            }
            #endregion [BIRP GlossyReflections]

            #region [EnableInstancingField]
            materialEditor.EnableInstancingField();
            #endregion [EnableInstancingField]

            #region [DoubleSidedGIField]
            //[Enum(Auto, 0, On, 1, Off, 2)] _DoubleSidedGIMode("Double sided GI mode", Float) = 0
            materialEditor.DoubleSidedGIField();
            #endregion [DoubleSidedGIField]

            #region [HDRP Add Precomputed Velocity]
            if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
                if (material.HasProperty("_AddPrecomputedVelocity"))
                {
                    if (material.HasProperty("_AddPrecomputedVelocity"))
                    {
                        var control = material.GetInt("_AddPrecomputedVelocity");

                        bool toggle = false;

                        if (control > 0.5f)
                        {
                            toggle = true;
                        }

                        toggle = EditorGUILayout.Toggle("Add Precomputed Velocity", toggle);

                        if (toggle)
                        {
                            material.SetInt("_AddPrecomputedVelocity", 1);
                            material.DisableKeyword("ADD_PRECOMPUTED_VELOCITY");
                        }
                        else
                        {
                            material.SetInt("_AddPrecomputedVelocity", 0);
                            material.EnableKeyword("ADD_PRECOMPUTED_VELOCITY");
                        }
                    }
                }
            #endregion [HDRP Add Precomputed Velocity]

            #region [URP Alembic Motion Vectors]
            //[HideInInspector] _AddPrecomputedVelocity("_AddPrecomputedVelocity", Float) = 0.0
            if (material.GetTag("RenderPipeline", false) == "UniversalPipeline")
                if (material.HasProperty("_AddPrecomputedVelocity"))
                {
                    if (material.HasProperty("_AddPrecomputedVelocity"))
                    {
                        var control = material.GetInt("_AddPrecomputedVelocity");

                        bool toggle = false;

                        if (control > 0.5f)
                        {
                            toggle = true;
                        }

                        toggle = EditorGUILayout.Toggle("Alembic Motion Vectors", toggle);

                        if (toggle)
                        {
                            material.SetInt("_AddPrecomputedVelocity", 1);
                            material.DisableKeyword("ADD_PRECOMPUTED_VELOCITY");
                        }
                        else
                        {
                            material.SetInt("_AddPrecomputedVelocity", 0);
                            material.EnableKeyword("ADD_PRECOMPUTED_VELOCITY");
                        }
                    }
                }
            #endregion [URP Alembic Motion Vectorsy]

            #region [Decal MeshBiasType]
            if (material.HasProperty("_DecalMeshBiasType"))
            {
                var control = material.GetInt("_DecalMeshBiasType");
                var depth = material.GetFloat("_DecalMeshDepthBias");
                var view = material.GetFloat("_DecalMeshViewBias");

                control = EditorGUILayout.Popup("Mesh Bias Type", control, new string[] { "Depth Bias", "View Bias" });

                if (control == 0)
                {
                    depth = EditorGUILayout.FloatField("Depth Bias", depth);
                }
                else
                {
                    view = EditorGUILayout.FloatField("View Bias", view);
                }

                material.SetInt("_DecalMeshBiasType", control);
                material.SetFloat("_DecalMeshDepthBias", depth);
                material.SetFloat("_DecalMeshViewBias", view);
            }
            #endregion [Decal MeshBiasType]

            #region [Decal DrawOrder]
            if (material.HasProperty("_DrawOrder"))
            {
                var offset = material.GetInt("_DrawOrder");

                offset = EditorGUILayout.IntSlider("Sorting Priority", offset, -50, 50);

                material.SetInt("_DrawOrder", offset);
            }
            #endregion [Decal DrawOrder]

            #region [QueueControl]
            if (material.HasProperty("_QueueControl") && material.HasProperty("_QueueOffset"))
            {
                var control = material.GetInt("_QueueControl");
                var offset = material.GetInt("_QueueOffset");

                if (control < 0)
                {
                    control = 0;
                }

                control = EditorGUILayout.Popup("Queue Control", control, new string[] { "Auto", "User Defined" });

                if (control == 0)
                {
                    offset = EditorGUILayout.IntSlider("Sorting Priority", offset, -50, 50);

                    if (material.GetTag("RenderType", false) == "Transparent")
                    {
                        material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.Transparent + offset;
                    }
                    else
                    {
                        material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.AlphaTest + offset;
                    }
                }
                else
                {
                    materialEditor.RenderQueueField();
                }

                material.SetInt("_QueueControl", control);
                material.SetInt("_QueueOffset", offset);
            }
            #endregion [QueueControl]

            #region [Decal QueueControl]
            if (!material.HasProperty("_QueueControl") && material.HasProperty("_QueueOffset"))
            {
                var offset = material.GetInt("_QueueOffset");

                offset = EditorGUILayout.IntSlider("Sorting Priority", offset, -50, 50);

                if (material.GetTag("RenderType", false) == "Transparent")
                {
                    material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.Transparent + offset;
                }
                else
                {
                    material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.AlphaTest + offset;
                }

                material.SetInt("_QueueOffset", offset);
            }

            if (!material.HasProperty("_QueueControl") && !material.HasProperty("_QueueOffset"))
            {
                materialEditor.RenderQueueField();
            }
        }
        #endregion [Decal QueueControl]

        GUILayout.Space(10);
    }
    #endregion [CATEGORY - ADVANCED SETTINGS]

}