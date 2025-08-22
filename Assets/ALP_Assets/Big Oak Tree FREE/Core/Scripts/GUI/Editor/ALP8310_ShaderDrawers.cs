// Support:David Olshefski http://deenvironment.com/

using UnityEngine;
using UnityEditor;
using System;

namespace ALP8310.ShaderDrawers
{
    #region [DE_Constants]
    public static class DE_CONSTANTS
    {
        public static Color CategoryColor
        {
            get
            {
                if (EditorGUIUtility.isProSkin)
                {
                    return DE_CONSTANTS.ColorDarkGray;
                }
                else
                {
                    return DE_CONSTANTS.ColorLightGray;
                }
            }
        }

        public static Color LineColor
        {
            get
            {
                if (EditorGUIUtility.isProSkin)
                {
                    return new Color(0.15f, 0.15f, 0.15f, 1.0f);
                }
                else
                {
                    return new Color(0.65f, 0.65f, 0.65f, 1.0f);
                }
            }
        }

        public static Color ColorDarkGray
        {
            get
            {
                return new Color(0.2f, 0.2f, 0.2f, 1.0f);
            }
        }

        public static Color ColorLightGray
        {
            get
            {
                return new Color(0.82f, 0.82f, 0.82f, 1.0f);
            }
        }

        public static GUIStyle TitleStyle
        {
            get
            {
                GUIStyle guiStyle = new GUIStyle("label")
                {
                    richText = true,
                    alignment = TextAnchor.MiddleCenter
                };

                return guiStyle;
            }
        }

        public static GUIStyle HeaderStyle
        {
            get
            {
                GUIStyle guiStyle = new GUIStyle("label")
                {
                    richText = true,
                    fontStyle = FontStyle.Bold,
                    alignment = TextAnchor.MiddleLeft
                };

                return guiStyle;
            }
        }
    }
    #endregion [DE_Constants]

    #region [DE_Drawers]
    public static class DE_Drawers
    {
        public static bool DrawInspectorCategory(string bannerText, bool enabled, bool colapsable, float top, float down, Material material)
        {
            //if (colapsable)
            //{
            //    if (enabled)
            //    {
            //        GUILayout.Space(top);
            //    }
            //    else
            //    {
            //        GUILayout.Space(0);
            //    }
            //}
            //else
            //{
            //    GUILayout.Space(top);
            //}

            var fullRect = GUILayoutUtility.GetRect(0, 0, 18, 0);
            var fillRect = new Rect(0, fullRect.y, fullRect.xMax + 10, 18);
            var lineRect = new Rect(0, fullRect.y - 1, fullRect.xMax + 10, 1);
            var titleRect = new Rect(fullRect.position.x - 1, fullRect.position.y, fullRect.width, 18);
            var arrowRect = new Rect(fullRect.position.x - 15, fullRect.position.y, fullRect.width, 18);

            if (colapsable)
            {
                if (GUI.Button(arrowRect, "", GUIStyle.none))
                {
                    enabled = !enabled;
                }
            }
            else
            {
                enabled = true;
            }

            EditorGUI.DrawRect(fillRect, DE_CONSTANTS.CategoryColor);
            EditorGUI.DrawRect(lineRect, DE_CONSTANTS.LineColor);

            GUI.color = new Color(1, 1, 1, 0.9f);

            GUI.Label(titleRect, bannerText, DE_CONSTANTS.HeaderStyle);

            if (material.GetTag("RenderPipeline", false) != "HDRenderPipeline")
            {
                GUI.color = new Color(1, 1, 1, 0.39f);

                if (colapsable)
                {
                    if (enabled)
                    {
                        GUI.Label(arrowRect, "<size=10>▼</size>", DE_CONSTANTS.HeaderStyle);
                        //GUILayout.Space(down);
                    }
                    else
                    {
                        GUI.Label(arrowRect, "<size=10>►</size>", DE_CONSTANTS.HeaderStyle);
                        //GUILayout.Space(0);
                    }
                }
                else
                {
                    //GUILayout.Space(down);
                }
            }

            GUI.color = Color.white;

            GUILayout.Space(5);

            return enabled;
        }
    }
    #endregion [DE_Constants]

    #region [DE_DrawerEmissionFlags]
    public class DE_DrawerEmissionFlags : MaterialPropertyDrawer
    {
        public override void OnGUI(Rect position, MaterialProperty prop, String label, MaterialEditor editor)
        {
            var material = editor.target as Material;

            float flag = prop.floatValue;

            if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
            {
                EditorGUILayout.BeginHorizontal();
                GUILayout.Space(0);
                GUILayout.Label(label, GUILayout.Width(EditorGUIUtility.labelWidth ));
                flag = EditorGUILayout.Popup((int)flag, new string[] { "None", "Any", "Baked", "Realtime" });
                EditorGUILayout.EndHorizontal();
            }
            else
            {
                EditorGUILayout.BeginHorizontal();
                GUILayout.Space(-2);
                GUILayout.Label(label, GUILayout.Width(EditorGUIUtility.labelWidth));
                flag = EditorGUILayout.Popup((int)flag, new string[] { "None", "Any", "Baked", "Realtime" });
                EditorGUILayout.EndHorizontal();
            }

            if (flag == 0)
            {
                material.globalIlluminationFlags = MaterialGlobalIlluminationFlags.None;
            }
            else if (flag == 1)
            {
                material.globalIlluminationFlags = MaterialGlobalIlluminationFlags.AnyEmissive;
            }
            else if (flag == 2)
            {
                material.globalIlluminationFlags = MaterialGlobalIlluminationFlags.BakedEmissive;
            }
            else if (flag == 3)
            {
                material.globalIlluminationFlags = MaterialGlobalIlluminationFlags.RealtimeEmissive;
            }

            prop.floatValue = flag;
        }

        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
        {
            return -2;
        }
    }
    #endregion [DE_DrawerEmissionFlags]

    #region [DE_DrawerEmissiveIntensity]
    public class DE_DrawerEmissiveIntensity : MaterialPropertyDrawer
    {
        public string reference = "";
        public float top = 0;
        public float down = 0;

        public DE_DrawerEmissiveIntensity()
        {
            this.top = 0;
            this.down = 0;
        }

        public DE_DrawerEmissiveIntensity(string reference)
        {
            this.reference = reference;
            this.top = 0;
            this.down = 0;
        }

        public DE_DrawerEmissiveIntensity(float top, float down)
        {
            this.top = top;
            this.down = down;
        }

        public DE_DrawerEmissiveIntensity(string reference, float top, float down)
        {
            this.reference = reference;
            this.top = top;
            this.down = down;
        }

        public override void OnGUI(Rect position, MaterialProperty prop, String label, MaterialEditor editor)
        {
            var stylePopup = new GUIStyle(EditorStyles.popup)
            {
                fontSize = 9,
                alignment = TextAnchor.MiddleCenter,
            };

            var internalReference = MaterialEditor.GetMaterialProperty(editor.targets, reference);

            Vector4 propVector = prop.vectorValue;

            GUILayout.Space(top);

            EditorGUI.BeginChangeCheck();

            EditorGUI.showMixedValue = prop.hasMixedValue;

            // Add this to get the material
            var material = editor.target as Material;

            if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
            {
                GUILayout.BeginHorizontal();

                GUILayout.Space(1);

                GUILayout.Label(label, GUILayout.Width(EditorGUIUtility.labelWidth ));

                if (propVector.w == 0)
                {
                    propVector.y = EditorGUILayout.FloatField(propVector.y);
                }
                else if (propVector.w == 1)
                {
                    propVector.z = EditorGUILayout.FloatField(propVector.z);
                }

                GUILayout.Space(-25);

                propVector.w = (float)EditorGUILayout.Popup((int)propVector.w, new string[] { "Nits", "EV100" }, stylePopup, GUILayout.Width(65));

                GUILayout.EndHorizontal();
            }
            else
            {
                GUILayout.BeginHorizontal();
                GUILayout.Space(-1);
                GUILayout.Label(label, GUILayout.Width(EditorGUIUtility.labelWidth));

                if (propVector.w == 0)
                {
                    propVector.y = EditorGUILayout.FloatField(propVector.y);
                }
                else if (propVector.w == 1)
                {
                    propVector.z = EditorGUILayout.FloatField(propVector.z);
                }

                GUILayout.Space(2);

                propVector.w = (float)EditorGUILayout.Popup((int)propVector.w, new string[] { "Nits", "EV100" }, stylePopup, GUILayout.Width(50));

                GUILayout.EndHorizontal();
            }

            EditorGUI.showMixedValue = false;

            if (EditorGUI.EndChangeCheck())
            {
                if (propVector.w == 0)
                {
                    propVector.x = propVector.y;
                }
                else if (propVector.w == 1)
                {
                    propVector.x = ConvertEvToLuminance(propVector.z);
                }

                if (internalReference.displayName != null)
                {
                    internalReference.floatValue = propVector.x;
                }

                prop.vectorValue = propVector;
            }

            GUILayout.Space(down);
        }

        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
        {
            return -2;
        }

        //public float ConvertLuminanceToEv(float luminance)
        //{
        //    return (float)Math.Log((luminance * 100f) / 12.5f, 2);
        //}

        public float ConvertEvToLuminance(float ev)
        {
            return (12.5f / 100.0f) * Mathf.Pow(2f, ev);
        }
    }
    #endregion [DE_DrawerEmissiveIntensity]

    #region [DE_DrawerFloatEnum]
    public class DE_DrawerFloatEnum : MaterialPropertyDrawer
    {
        public string options = "";

        public float top = 0;
        public float down = 0;

        public DE_DrawerFloatEnum(string options)
        {
            this.options = options;

            this.top = 0;
            this.down = 0;
        }

        public DE_DrawerFloatEnum(string options, float top, float down)
        {
            this.options = options;

            this.top = top;
            this.down = down;
        }

        public override void OnGUI(Rect position, MaterialProperty prop, String label, MaterialEditor materialEditor)
        {
            GUIStyle styleLabel = new GUIStyle(EditorStyles.label)
            {
                richText = true,
                alignment = TextAnchor.MiddleCenter,
                wordWrap = true
            };

            string[] enums = options.Split(char.Parse("_"));

            GUILayout.Space(top);

            int index = (int)prop.floatValue;

            index = EditorGUILayout.Popup(prop.displayName, index, enums);

            // Debug Value
            //EditorGUILayout.LabelField(index.ToString());

            prop.floatValue = index;

            GUI.enabled = true;

            GUILayout.Space(down);
        }

        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
        {
            return -2;
        }
    }
    #endregion [DE_DrawerFloatEnum]

    #region [DE_DrawerlVectorString]
    public class DE_DrawerlVectorString : MaterialPropertyDrawer
    {
        private readonly GUIContent[] labels;
        private float height;

        public DE_DrawerlVectorString(string x) : this(new string[] { x }) { }
        public DE_DrawerlVectorString(string x, string y) : this(new string[] { x, y }) { }
        public DE_DrawerlVectorString(string x, string y, string z) : this(new string[] { x, y, z }) { }
        public DE_DrawerlVectorString(string x, string y, string z, string w) : this(new string[] { x, y, z, w }) { }
        public DE_DrawerlVectorString(params string[] labels)
        {
            this.labels = new GUIContent[labels.Length];
            for (int i = 0; i < labels.Length; i++)
            {
                this.labels[i] = new GUIContent(labels[i]);
            }
        }

        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
        {
            height = base.GetPropertyHeight(prop, label, editor);

            if (prop.type == MaterialProperty.PropType.Vector)
                return height * (this.labels.Length + 1);
            else
                return height;
        }

        public override void OnGUI(Rect position, MaterialProperty prop, GUIContent label, MaterialEditor editor)
        {
            if (prop.type == MaterialProperty.PropType.Vector)
            {
                position = EditorGUI.IndentedRect(position);
                var v = prop.vectorValue;
                position.height = height;
                GUI.Label(position, label);

                EditorGUI.BeginChangeCheck();
                EditorGUI.indentLevel += 1;
                for (int i = 0; i < this.labels.Length; i++)
                {
                    position.y += height;
                    v[i] = EditorGUI.FloatField(position, this.labels[i], v[i]);
                }
                EditorGUI.indentLevel -= 1;
                if (EditorGUI.EndChangeCheck())
                    prop.vectorValue = v;
            }
            else
                editor.DefaultShaderProperty(prop, label.text);
        }
    }
    #endregion [DE_DrawerlVectorString]

    #region [DE_DrawerSliderOptions]
    public class DE_DrawerSliderOptions : MaterialPropertyDrawer
    {
        public string nameMin = "";
        public string nameMax = "";
        public string nameVal = "";
        public float min = 0;
        public float max = 0;
        public float val = 0;
        public float top = 0;
        public float down = 0;

        bool showAdvancedOptions = false;

        public DE_DrawerSliderOptions(string nameMin, string nameMax, string nameVal, float min, float max, float val)
        {
            this.nameMin = nameMin;
            this.nameMax = nameMax;
            this.nameVal = nameVal;
            this.min = min;
            this.max = max;
            this.val = val;
            this.top = 0;
            this.down = 0;
        }

        public DE_DrawerSliderOptions(string nameMin, string nameMax, string nameVal, float min, float max, float val, float top, float down)
        {
            this.nameMin = nameMin;
            this.nameMax = nameMax;
            this.nameVal = nameVal;
            this.min = min;
            this.max = max;
            this.val = val;
            this.top = top;
            this.down = down;
        }

        public override void OnGUI(Rect position, MaterialProperty prop, String label, MaterialEditor editor)
        {
            var internalPropMin = MaterialEditor.GetMaterialProperty(editor.targets, nameMin);
            var internalPropMax = MaterialEditor.GetMaterialProperty(editor.targets, nameMax);
            var internalPropVal = MaterialEditor.GetMaterialProperty(editor.targets, nameVal);

            if (internalPropMin.displayName != null && internalPropMax.displayName != null && internalPropVal.displayName != null)
            {
                var stylePopup = new GUIStyle(EditorStyles.popup)
                {
                    fontSize = 9,
                };

                var styleButton = new GUIStyle(EditorStyles.label)
                {

                };

                var internalValueMin = internalPropMin.floatValue;
                var internalValueMax = internalPropMax.floatValue;
                var internalValueVal = internalPropVal.floatValue;
                Vector4 propVector = prop.vectorValue;

                EditorGUI.BeginChangeCheck();

                if (propVector.w == 2)
                {
                    propVector.x = min;
                    propVector.y = max;
                    propVector.z = internalValueVal;
                }
                else
                {
                    if (internalValueMin < internalValueMax)
                    {
                        propVector.w = 0;
                    }
                    else if (internalValueMin < internalValueMax)
                    {
                        propVector.w = 1;
                    }

                    if (propVector.w == 0)
                    {
                        propVector.x = internalValueMin;
                        propVector.y = internalValueMax;
                    }
                    else
                    {
                        propVector.x = internalValueMax;
                        propVector.y = internalValueMin;
                    }

                    propVector.z = val;
                }

                GUILayout.Space(top);

                EditorGUI.showMixedValue = prop.hasMixedValue;

                // Add this to get the material
                var material = editor.target as Material;

                //Check render pipeline
                if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
                {
                    GUILayout.BeginHorizontal();
                    //GUILayout.Space(-1);

                    GUILayout.Space(18);

                    if (GUILayout.Button(label, styleButton, GUILayout.Width(EditorGUIUtility.labelWidth - 31)))
                    {
                        showAdvancedOptions = !showAdvancedOptions;
                    }

                    if (propVector.w == 2)
                    {
                        propVector.z = GUILayout.HorizontalSlider(propVector.z, min, max);
                    }
                    else
                    {
                        EditorGUILayout.MinMaxSlider(ref propVector.x, ref propVector.y, min, max);
                    }

                    GUILayout.Space(-12);

                    propVector.w = (float)EditorGUILayout.Popup((int)propVector.w, new string[] { "Remap", "Invert", "Slider" }, stylePopup, GUILayout.Width(65));

                    GUILayout.EndHorizontal();
                }
                else
                {
                    GUILayout.BeginHorizontal();
                    //GUILayout.Space(-1);

                    if (GUILayout.Button(label, styleButton, GUILayout.Width(EditorGUIUtility.labelWidth)))
                    {
                        showAdvancedOptions = !showAdvancedOptions;
                    }

                    if (propVector.w == 2)
                    {
                        propVector.z = GUILayout.HorizontalSlider(propVector.z, min, max);
                    }
                    else
                    {
                        EditorGUILayout.MinMaxSlider(ref propVector.x, ref propVector.y, min, max);
                    }

                    GUILayout.Space(2);

                    propVector.w = (float)EditorGUILayout.Popup((int)propVector.w, new string[] { "Remap", "Invert", "Slider" }, stylePopup, GUILayout.Width(50));

                    GUILayout.EndHorizontal();
                }

                if (showAdvancedOptions)
                {
                    GUILayout.BeginHorizontal();
                    GUILayout.Space(-1);
                    GUILayout.Label("      Remap Min", GUILayout.Width(EditorGUIUtility.labelWidth));
                    propVector.x = EditorGUILayout.Slider(propVector.x, min, max);
                    GUILayout.Space(2);
                    GUILayout.EndHorizontal();

                    GUILayout.BeginHorizontal();
                    GUILayout.Space(-1);
                    GUILayout.Label("      Remap Max", GUILayout.Width(EditorGUIUtility.labelWidth));
                    propVector.y = EditorGUILayout.Slider(propVector.y, min, max);
                    GUILayout.Space(2);
                    GUILayout.EndHorizontal();

                    GUILayout.BeginHorizontal();
                    GUILayout.Space(-1);
                    GUILayout.Label("      Simple Val", GUILayout.Width(EditorGUIUtility.labelWidth));
                    propVector.z = EditorGUILayout.Slider(propVector.z, min, max);
                    GUILayout.Space(2);
                    GUILayout.EndHorizontal();
                }

                if (propVector.w == 0f)
                {
                    internalValueMin = propVector.x;
                    internalValueMax = propVector.y;
                    internalValueVal = val;
                }
                else if (propVector.w == 1f)
                {
                    internalValueMin = propVector.y;
                    internalValueMax = propVector.x;
                    internalValueVal = val;
                }
                else if (propVector.w == 2f)
                {
                    internalValueMin = min;
                    internalValueMax = max;
                    internalValueVal = propVector.z;
                }

                EditorGUI.showMixedValue = false;
                if (EditorGUI.EndChangeCheck())
                {
                    prop.vectorValue = propVector;
                    internalPropMin.floatValue = internalValueMin;
                    internalPropMax.floatValue = internalValueMax;
                    internalPropVal.floatValue = internalValueVal;
                }

                GUILayout.Space(down);
            }
        }

        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
        {
            return -2;
        }
    }
    #endregion [DE_DrawerSliderOptions]

    #region [DE_DrawerSliderRemap]
    public class DE_DrawerSliderRemap : MaterialPropertyDrawer
    {
        public string nameMin = "";
        public string nameMax = "";
        public float min = 0;
        public float max = 0;
        public float top = 0;
        public float down = 0;

        bool showAdvancedOptions = false;

        public DE_DrawerSliderRemap(string nameMin, string nameMax, float min, float max)
        {
            this.nameMin = nameMin;
            this.nameMax = nameMax;
            this.min = min;
            this.max = max;
            this.top = 0;
            this.down = 0;
        }

        public DE_DrawerSliderRemap(string nameMin, string nameMax, float min, float max, float top, float down)
        {
            this.nameMin = nameMin;
            this.nameMax = nameMax;
            this.min = min;
            this.max = max;
            this.top = top;
            this.down = down;
        }

        public override void OnGUI(Rect position, MaterialProperty prop, String label, MaterialEditor editor)
        {
            var internalPropMin = MaterialEditor.GetMaterialProperty(editor.targets, nameMin);
            var internalPropMax = MaterialEditor.GetMaterialProperty(editor.targets, nameMax);

            if (internalPropMin.displayName != null && internalPropMax.displayName != null)
            {
                var stylePopup = new GUIStyle(EditorStyles.popup)
                {
                    fontSize = 9,
                };

                var styleButton = new GUIStyle(EditorStyles.label)
                {

                };

                var internalValueMin = internalPropMin.floatValue;
                var internalValueMax = internalPropMax.floatValue;
                Vector4 propVector = prop.vectorValue;

                EditorGUI.BeginChangeCheck();

                if (internalValueMin <= internalValueMax)
                {
                    propVector.w = 0;
                }
                else
                {
                    propVector.w = 1;
                }

                if (propVector.w == 0)
                {
                    propVector.x = internalValueMin;
                    propVector.y = internalValueMax;
                }
                else
                {
                    propVector.x = internalValueMax;
                    propVector.y = internalValueMin;
                }

                GUILayout.Space(top);

                EditorGUI.showMixedValue = prop.hasMixedValue;

                var material = editor.target as Material;

                if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
                {
                    GUILayout.BeginHorizontal();
                    GUILayout.Space(18);
                    if (GUILayout.Button(label, styleButton, GUILayout.Width(EditorGUIUtility.labelWidth - 31)))
                    {
                        showAdvancedOptions = !showAdvancedOptions;
                    }

                    EditorGUILayout.MinMaxSlider(ref propVector.x, ref propVector.y, min, max);
                    GUILayout.Space(-12);
                    propVector.w = (float)EditorGUILayout.Popup((int)propVector.w, new string[] { "Remap", "Invert" }, stylePopup, GUILayout.Width(65));
                    GUILayout.EndHorizontal();
                }
                else
                {
                    GUILayout.BeginHorizontal();
                    GUILayout.Space(-1);
                    if (GUILayout.Button(label, styleButton, GUILayout.Width(EditorGUIUtility.labelWidth)))
                    {
                        showAdvancedOptions = !showAdvancedOptions;
                    }
                    EditorGUILayout.MinMaxSlider(ref propVector.x, ref propVector.y, min, max);
                    GUILayout.Space(2);
                    propVector.w = (float)EditorGUILayout.Popup((int)propVector.w, new string[] { "Remap", "Invert" }, stylePopup, GUILayout.Width(50));
                    GUILayout.EndHorizontal();
                }

                if (showAdvancedOptions)
                {
                    GUILayout.BeginHorizontal();
                    GUILayout.Space(-1);
                    GUILayout.Label("      Remap Min", GUILayout.Width(EditorGUIUtility.labelWidth));
                    propVector.x = EditorGUILayout.Slider(propVector.x, min, max);
                    GUILayout.Space(2);
                    GUILayout.EndHorizontal();

                    GUILayout.BeginHorizontal();
                    GUILayout.Space(-1);
                    GUILayout.Label("      Remap Max", GUILayout.Width(EditorGUIUtility.labelWidth));
                    propVector.y = EditorGUILayout.Slider(propVector.y, min, max);
                    GUILayout.Space(2);
                    GUILayout.EndHorizontal();
                }

                if (propVector.w == 0f)
                {
                    internalValueMin = propVector.x;
                    internalValueMax = propVector.y;
                }
                else if (propVector.w == 1f)
                {
                    internalValueMin = propVector.y;
                    internalValueMax = propVector.x;
                }

                EditorGUI.showMixedValue = false;
                if (EditorGUI.EndChangeCheck())
                {
                    prop.vectorValue = propVector;
                    internalPropMin.floatValue = internalValueMin;
                    internalPropMax.floatValue = internalValueMax;
                }

                GUILayout.Space(down);
            }
        }

        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
        {
            return -2;
        }
    }
    #endregion [DE_DrawerSliderRemap]

    #region [DE_DrawerSliderRemapSimple]
    public class DE_DrawerSliderRemapSimple : MaterialPropertyDrawer
    {
        public override void OnGUI(Rect position, MaterialProperty prop, String label, MaterialEditor editor)
        {
            EditorGUI.BeginChangeCheck();
            Vector4 value = prop.vectorValue;

            EditorGUI.showMixedValue = prop.hasMixedValue;

            var cacheLabel = EditorGUIUtility.labelWidth;
            var cacheField = EditorGUIUtility.fieldWidth;
            if (cacheField <= 64)
            {
                float total = position.width;
                EditorGUIUtility.labelWidth = Mathf.Ceil(0.45f * total) - 30;
                EditorGUIUtility.fieldWidth = Mathf.Ceil(0.55f * total) + 30;
            }

            EditorGUI.MinMaxSlider(position, label, ref value.x, ref value.y, 0, 1);

            EditorGUIUtility.labelWidth = cacheLabel;
            EditorGUIUtility.fieldWidth = cacheField;
            EditorGUI.showMixedValue = false;
            if (EditorGUI.EndChangeCheck())
            {
                prop.vectorValue = value;
            }
        }
    }
    #endregion [DE_DrawerSliderRemapSimple]

    #region [DE_DrawerSliderRemapVect2]
    public class DE_DrawerSliderRemapVect2 : MaterialPropertyDrawer
    {
        public override void OnGUI(Rect position, MaterialProperty prop, String label, MaterialEditor editor)
        {
            EditorGUI.BeginChangeCheck();
            Vector4 value = prop.vectorValue;

            var material = editor.target as Material;
            EditorGUI.showMixedValue = prop.hasMixedValue;

            if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
            {
                GUILayout.Space(1);
                GUILayout.BeginHorizontal();
                GUILayout.Space(2);
                GUILayout.Label(label, GUILayout.Width(EditorGUIUtility.labelWidth));
                EditorGUILayout.MinMaxSlider(ref value.x, ref value.y, 0, 1);
                GUILayout.EndHorizontal();
            }
            else
            {
                GUILayout.Space(1);
                GUILayout.BeginHorizontal();
                GUILayout.Space(-1);
                GUILayout.Label(label, GUILayout.Width(EditorGUIUtility.labelWidth));
                EditorGUILayout.MinMaxSlider(ref value.x, ref value.y, 0, 1);
                GUILayout.EndHorizontal();
            }

            EditorGUI.showMixedValue = false;
            if (EditorGUI.EndChangeCheck())
            {
                prop.vectorValue = value;
            }
        }
        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
        {
            return -2;
        }
    }
    #endregion [DE_DrawerSliderRemapVect2]

    #region [DE_DrawerSliderRemapVect4]
    public class DE_DrawerSliderRemapVect4 : MaterialPropertyDrawer
    {
        public override void OnGUI(Rect position, MaterialProperty prop, String label, MaterialEditor editor)
        {
            EditorGUI.BeginChangeCheck();
            Vector4 value = prop.vectorValue;

            EditorGUI.showMixedValue = prop.hasMixedValue;

            var cacheLabel = EditorGUIUtility.labelWidth;
            var cacheField = EditorGUIUtility.fieldWidth;
            if (cacheField <= 64)
            {
                float total = position.width;
                EditorGUIUtility.labelWidth = Mathf.Ceil(0.45f * total) - 22;
                EditorGUIUtility.fieldWidth = Mathf.Ceil(0.55f * total) + 30;
            }

            EditorGUI.MinMaxSlider(position, label, ref value.x, ref value.y, value.z, value.w);

            EditorGUIUtility.labelWidth = cacheLabel;
            EditorGUIUtility.fieldWidth = cacheField;
            EditorGUI.showMixedValue = false;
            if (EditorGUI.EndChangeCheck())
            {
                prop.vectorValue = value;
            }
        }
    }
    #endregion [DE_DrawerSliderRemapVect4]

    #region [DE_DrawerSliderSimple]
    public class DE_DrawerSliderSimple : MaterialPropertyDrawer
    {
        public string nameMin = "";
        public string nameMax = "";
        public float min = 0;
        public float max = 0;
        public float top = 0;
        public float down = 0;

        bool showAdvancedOptions = false;

        public DE_DrawerSliderSimple(string nameMin, string nameMax, float min, float max)
        {
            this.nameMin = nameMin;
            this.nameMax = nameMax;
            this.min = min;
            this.max = max;
            this.top = 0;
            this.down = 0;
        }

        public DE_DrawerSliderSimple(string nameMin, string nameMax, float min, float max, float top, float down)
        {
            this.nameMin = nameMin;
            this.nameMax = nameMax;
            this.min = min;
            this.max = max;
            this.top = top;
            this.down = down;
        }

        public override void OnGUI(Rect position, MaterialProperty prop, String label, MaterialEditor editor)
        {
            var internalPropMin = MaterialEditor.GetMaterialProperty(editor.targets, nameMin);
            var internalPropMax = MaterialEditor.GetMaterialProperty(editor.targets, nameMax);

            if (internalPropMin.displayName != null && internalPropMax.displayName != null)
            {
                var styleButton = new GUIStyle(EditorStyles.label)
                {

                };

                var internalValueMin = internalPropMin.floatValue;
                var internalValueMax = internalPropMax.floatValue;
                Vector4 propVector = prop.vectorValue;

                EditorGUI.BeginChangeCheck();

                propVector.x = internalValueMin;
                propVector.y = internalValueMax;

                GUILayout.Space(top);

                EditorGUI.showMixedValue = prop.hasMixedValue;

                // Add this to get the material
                var material = editor.target as Material;


                //Check render pipeline
                if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
                {

                    GUILayout.BeginHorizontal();

                    GUILayout.Space(2);

                    if (GUILayout.Button(label, styleButton, GUILayout.Width(EditorGUIUtility.labelWidth )))
                    {
                        showAdvancedOptions = !showAdvancedOptions;
                    }

                    EditorGUILayout.MinMaxSlider(ref propVector.x, ref propVector.y, min, max);

                    GUILayout.EndHorizontal();
                }
                else
                {
                    GUILayout.Space(1);
                    GUILayout.BeginHorizontal();
                    //GUILayout.Space(2);

                    if (GUILayout.Button(label, styleButton, GUILayout.Width(EditorGUIUtility.labelWidth)))
                    {
                        showAdvancedOptions = !showAdvancedOptions;
                    }

                    EditorGUILayout.MinMaxSlider(ref propVector.x, ref propVector.y, min, max);

                    GUILayout.EndHorizontal();
                }

                if (showAdvancedOptions)
                {
                    GUILayout.BeginHorizontal();
                    GUILayout.Space(-1);
                    GUILayout.Label("      Remap Min", GUILayout.Width(EditorGUIUtility.labelWidth));
                    propVector.x = EditorGUILayout.Slider(propVector.x, min, max);
                    GUILayout.Space(2);
                    GUILayout.EndHorizontal();

                    GUILayout.BeginHorizontal();
                    GUILayout.Space(-1);
                    GUILayout.Label("      Remap Max", GUILayout.Width(EditorGUIUtility.labelWidth));
                    propVector.y = EditorGUILayout.Slider(propVector.y, min, max);
                    GUILayout.Space(2);
                    GUILayout.EndHorizontal();
                }

                internalValueMin = propVector.x;
                internalValueMax = propVector.y;

                EditorGUI.showMixedValue = false;
                if (EditorGUI.EndChangeCheck())
                {
                    prop.vectorValue = propVector;
                    internalPropMin.floatValue = internalValueMin;
                    internalPropMax.floatValue = internalValueMax;
                }

                GUILayout.Space(down);
            }
        }

        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
        {
            return -2;
        }
    }
    #endregion [DE_DrawerSliderSimple]

    #region [DE_DrawerTilingOffset]
    public class DE_DrawerTilingOffset : MaterialPropertyDrawer
    {
        override public void OnGUI(Rect position, MaterialProperty prop, string label, MaterialEditor editor)
        {
            var cacheLabel = EditorGUIUtility.labelWidth;
            var cacheField = EditorGUIUtility.fieldWidth;

            Vector4 vec4value = prop.vectorValue;
            Vector2 tiling = new Vector2(vec4value.x, vec4value.y);
            Vector2 offset = new Vector2(vec4value.z, vec4value.w);

            var material = editor.target as Material;

            if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
            {
                GUILayout.Space(-4);
                EditorGUI.BeginChangeCheck();
                EditorGUILayout.BeginVertical();
                EditorGUILayout.BeginHorizontal();
                GUILayout.Label("Tiling", GUILayout.Width(cacheLabel));
                tiling = EditorGUILayout.Vector2Field("", tiling);
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal();
                GUILayout.Label("Offset", GUILayout.Width(cacheLabel));
                offset = EditorGUILayout.Vector2Field("", offset);
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndVertical();
                GUILayout.Space(4);
            }
            else
            {
                GUILayout.Space(-4);
                EditorGUI.BeginChangeCheck();
                EditorGUILayout.BeginVertical();
                EditorGUILayout.BeginHorizontal();
                GUILayout.Label("Tiling", GUILayout.Width(cacheLabel));
                tiling = EditorGUILayout.Vector2Field("", tiling);
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal();
                GUILayout.Label("Offset", GUILayout.Width(cacheLabel));
                offset = EditorGUILayout.Vector2Field("", offset);
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndVertical();
                GUILayout.Space(4);
            }

            if (EditorGUI.EndChangeCheck())
            {
                prop.vectorValue = new Vector4(tiling.x, tiling.y, offset.x, offset.y);
            }
        }

        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
        {
            return 0;
        }
    }
    #endregion [DE_DrawerTilingOffset]

    #region [DE_DrawerTextureOneLine]
    public class DE_DrawerTextureOneLine : MaterialPropertyDrawer
    {
        public float size;
        public float top;
        public float down;

        public DE_DrawerTextureOneLine()
        {
            this.size = 50;
            this.top = 0;
            this.down = 0;
        }

        public DE_DrawerTextureOneLine(float size)
        {
            this.size = size;
            this.top = 0;
            this.down = 0;
        }

        public DE_DrawerTextureOneLine(float size, float top, float down)
        {
            this.size = size;
            this.top = top;
            this.down = down;
        }

        public override void OnGUI(Rect position, MaterialProperty prop, string label, MaterialEditor materialEditor)
        {
            GUILayout.Space(top);

            EditorGUI.BeginChangeCheck();

            EditorGUI.showMixedValue = prop.hasMixedValue;

            Texture tex = null;

            if (prop.textureDimension == UnityEngine.Rendering.TextureDimension.Tex2D)
            {
                tex = (Texture2D)EditorGUILayout.ObjectField(prop.displayName, prop.textureValue, typeof(Texture2D), false, GUILayout.Height(50));
            }

            if (prop.textureDimension == UnityEngine.Rendering.TextureDimension.Cube)
            {
                tex = (Cubemap)EditorGUILayout.ObjectField(prop.displayName, prop.textureValue, typeof(Cubemap), false, GUILayout.Height(50));
            }

            EditorGUI.showMixedValue = false;

            if (EditorGUI.EndChangeCheck())
            {
                prop.textureValue = tex;
            }

            GUILayout.Space(down);
        }

        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
        {
            return -2;
        }
    }
    #endregion [DE_DrawerTextureOneLine]

    #region [DE_DrawerTextureSingleLine]
    public class DE_DrawerTextureSingleLine : MaterialPropertyDrawer
    {
        public override void OnGUI(Rect position, MaterialProperty prop, String label, MaterialEditor editor)
        {
            EditorGUI.BeginChangeCheck();
            EditorGUI.showMixedValue = prop.hasMixedValue;

            Texture value = editor.TexturePropertyMiniThumbnail(position, prop, label, string.Empty);

            EditorGUI.showMixedValue = false;
            if (EditorGUI.EndChangeCheck())
            {
                prop.textureValue = value;
            }
        }
    }
    #endregion [DE_DrawerTextureSingleLine]

    #region [DE_DrawerToggleNoKeyword]
    public class DE_DrawerToggleNoKeyword : MaterialPropertyDrawer
    {

        public override void OnGUI(Rect position, MaterialProperty prop, String label, MaterialEditor editor)
        {
            bool value = (prop.floatValue != 0.0f);

            EditorGUI.BeginChangeCheck();
            {
                EditorGUI.showMixedValue = prop.hasMixedValue;
                value = EditorGUI.Toggle(position, label, value);
                EditorGUI.showMixedValue = false;
            }
            if (EditorGUI.EndChangeCheck())
            {
                prop.floatValue = value ? 1.0f : 0.0f;
            }
        }
    }
    #endregion [DE_DrawerToggleNoKeyword]

    #region [DE_DrawerToggleLeft]
    public class DE_DrawerToggleLeft : MaterialPropertyDrawer
    {

        public override void OnGUI(Rect position, MaterialProperty prop, string label, MaterialEditor editor)
        {
            position.width -= 24;
            bool value = prop.floatValue != 0.0f;
            EditorGUI.BeginChangeCheck();
            EditorGUI.showMixedValue = prop.hasMixedValue;
            if (EditorGUIUtility.isProSkin)
            {
                value = EditorGUI.ToggleLeft(position, label, value);
            }
            else
            {
                GUIStyle customToggleFont = new GUIStyle();
                customToggleFont.normal.textColor = Color.white;
                customToggleFont.contentOffset = new Vector2(2f, 0f);
                value = EditorGUI.ToggleLeft(position, label, value, customToggleFont);
            }
            EditorGUI.showMixedValue = false;

            if (EditorGUI.EndChangeCheck())
            {
                prop.floatValue = value ? 1.0f : 0.0f;
            }
        }
    }
    #endregion [DE_DrawerToggleLeft]

    #region [DE_DrawerCategory]

    public class DE_DrawerCategory : MaterialPropertyDrawer
    {
        public string category;
        public float top;
        public float down;
        public string colapsable;
        public string conditions = "";

        public DE_DrawerCategory(string category)
        {
            this.category = category;
            this.colapsable = "false";
            this.top = 10;
            this.down = 10;
        }

        public DE_DrawerCategory(string category, string colapsable)
        {
            this.category = category;
            this.colapsable = colapsable;
            this.top = 10;
            this.down = 10;
        }

        public DE_DrawerCategory(string category, float top, float down)
        {
            this.category = category;
            this.colapsable = "false";
            this.top = top;
            this.down = down;
        }

        public DE_DrawerCategory(string category, string colapsable, float top, float down)
        {
            this.category = category;
            this.colapsable = colapsable;
            this.top = top;
            this.down = down;
        }

        public DE_DrawerCategory(string category, string colapsable, string conditions, float top, float down)
        {
            this.category = category;
            this.colapsable = colapsable;
            this.conditions = conditions;
            this.top = top;
            this.down = down;
        }

        public override void OnGUI(Rect position, MaterialProperty prop, String label, MaterialEditor materialEditor)
        {
            GUI.enabled = true;
            EditorGUI.indentLevel = 0;

            Material material = materialEditor.target as Material;

            if (conditions == "")
            {
                DrawInspector(prop, material);
            }
            else
            {
                bool showInspector = false;

                string[] split = conditions.Split(char.Parse(" "));

                for (int i = 0; i < split.Length; i++)
                {
                    if (material.HasProperty(split[i]))
                    {
                        showInspector = true;
                        break;
                    }
                }

                if (showInspector)
                {
                    DrawInspector(prop, material);
                }
            }
        }

        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
        {
            return -2;
        }

        void DrawInspector(MaterialProperty prop, Material material)
        {
            bool isColapsable = false;

            if (colapsable == "true")
            {
                isColapsable = true;
            }

            bool isEnabled = true;

            if (prop.floatValue < 0.5f)
            {
                isEnabled = false;
            }

            isEnabled = DE_Drawers.DrawInspectorCategory(category, isEnabled, isColapsable, top, down, material);

            if (isEnabled)
            {
                prop.floatValue = 1;
            }
            else
            {
                prop.floatValue = 0;
            }
        }
    }
    #endregion [DE_DrawerCategory]

    #region [DE_DrawerSpace]
    public class DE_DrawerSpace : MaterialPropertyDrawer
    {
        public float space;
        public string conditions = "";

        public DE_DrawerSpace(float space)
        {
            this.space = space;
        }

        public DE_DrawerSpace(float space, string conditions)
        {
            this.space = space;
            this.conditions = conditions;
        }

        public override void OnGUI(Rect position, MaterialProperty prop, string label, MaterialEditor materialEditor)
        {
            if (conditions == "")
            {
                GUILayout.Space(space);
            }
            else
            {
                Material material = materialEditor.target as Material;

                bool showInspector = false;

                string[] split = conditions.Split(char.Parse(" "));

                for (int i = 0; i < split.Length; i++)
                {
                    if (material.HasProperty(split[i]))
                    {
                        showInspector = true;
                        break;
                    }
                }

                if (showInspector)
                {
                    GUILayout.Space(space);
                }
            }

        }

        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
        {
            return -2;
        }
    }
    #endregion [DE_DrawerSpace]


}