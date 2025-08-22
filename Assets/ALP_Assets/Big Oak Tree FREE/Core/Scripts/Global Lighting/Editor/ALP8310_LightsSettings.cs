using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

namespace ALP8310LightingController.Lights
{

    /// <summary>
    /// A utility class that provides methods for controlling linear intensity and color temperature settings for lights using the Built-in Render Pipeline in Unity Editor.
    /// NOTE: You can never have too many comments. I have included inline and XML comments so that users can understand each step and customise the scripts for how they see fit.
    /// </summary>
    public static class LightSettingsController
    {

        /// <summary>
        /// Toggles the linear intensity setting for lights in the Built-in Render Pipeline.
        /// https://docs.unity3d.com/ScriptReference/Rendering.GraphicsSettings-lightsUseLinearIntensity.html
        /// </summary>
        /// <param name="useLinearIntensity">The new value for the linear intensity setting.</param>
        /// <param name="debug">Optional parameter to enable debug logging.</param>
        public static void ToggleLinearIntensity(bool useLinearIntensity, bool debug = false)
        {
            // Begin checking for changes in the Editor GUI elements.
            EditorGUI.BeginChangeCheck();
            // Draw a toggle for the linear intensity setting and assign the value to useLinearIntensity.
            useLinearIntensity = EditorGUILayout.Toggle(new GUIContent("Use Linear Intensity", "Enable/Disable Linear Intensity"), useLinearIntensity);
            // Check if there were any changes in the Editor GUI elements.
            if (EditorGUI.EndChangeCheck())
            {
                // If debug mode is enabled, log the updated linear intensity setting.
                if (debug)
                    Debug.Log("Linear Intensity Updated. Use Linear Intensity: " + useLinearIntensity);

                // Update the linear intensity setting in the GraphicsSettings.
                GraphicsSettings.lightsUseLinearIntensity = useLinearIntensity;

                // If the new value is false and color temperature is enabled, disable it.
                // Reset values of all lights in the scene
                if (useLinearIntensity == false && IsColourTemperature() == true)
                {
                    ResetColorTemperature(false);
                }

                RefreshInspector();
            }
        }

        /// <summary>
        /// Resets the color temperature setting for lights in the Built-in Render Pipeline.
        /// </summary>
        /// <param name="useColorTemperature">The new value for the color temperature setting.</param>
        /// <remarks>
        /// This method updates the global color temperature setting in GraphicsSettings.lightsUseColorTemperature
        /// and individually updates all the lights in the scene to use color temperature if supported (Unity 2019.3 or newer).
        /// </remarks>
        public static void ResetColorTemperature(bool useColorTemperature)
        {
            // Update the global color temperature setting in GraphicsSettings.
            GraphicsSettings.lightsUseColorTemperature = useColorTemperature;

#if UNITY_2019_3_OR_NEWER
            // For Unity 2019.3 or newer, set individual lights to use color temperature if the global setting is true.
            var lights = UnityEngine.Object.FindObjectsOfType<Light>();
            for (int i = 0; i < lights.Length; i++)
                lights[i].useColorTemperature = GraphicsSettings.lightsUseColorTemperature;
#endif

            RefreshInspector();
        }


        /// <summary>
        /// Toggles the color temperature setting for lights in the Built-in Render Pipeline.
        /// https://docs.unity3d.com/ScriptReference/Rendering.GraphicsSettings-lightsUseColorTemperature.html
        /// </summary>
        /// <param name="useColorTemperature">The new value for the color temperature setting.</param>
        /// <param name="debug">Optional parameter to enable debug logging.</param>
        public static void ToggleColorTemperature(bool useColorTemperature, bool debug = false)
        {
            if(IsLinearIntensity())
                EditorGUILayout.HelpBox(new GUIContent("Warning: This will update all lights in your scene", "Enable/Disable Color Temperature - Warning:This will update all lights in your scene"));

            // Disable color temperature toggle if linear intensity is not enabled.
            EditorGUI.BeginDisabledGroup(!IsLinearIntensity());
            EditorGUI.BeginChangeCheck();
            // Draw a toggle for the color temperature setting and assign the value to useColorTemperature.
            useColorTemperature = EditorGUILayout.Toggle(new GUIContent("Use Color Temperature", "Enable/Disable Color Temperature \r\nWarning: This will update all lights in your scene"), useColorTemperature);
            // Check if there were any changes in the Editor GUI elements.
            if (EditorGUI.EndChangeCheck())
            {
                ResetColorTemperature(useColorTemperature);
                              
                // If debug mode is enabled, log the updated color temperature setting.
                if (debug)
                    Debug.Log("Color Temperature Updated. Use Color Temperature: " + useColorTemperature);
            }

            EditorGUI.EndDisabledGroup();
        }

        /// <summary>
        /// Checks if the linear intensity setting is enabled.
        /// </summary>
        /// <returns>True if linear intensity is enabled, false otherwise.</returns>
        public static bool IsLinearIntensity()
        {
            return GraphicsSettings.lightsUseLinearIntensity;
        }

        /// <summary>
        /// Checks if the color temperature setting is enabled.
        /// </summary>
        /// <returns>True if color temperature is enabled, false otherwise.</returns>
        public static bool IsColourTemperature()
        {
            return GraphicsSettings.lightsUseColorTemperature;
        }

        // EditorPrefs keys for saving the values.
        private const string LinearIntensityPrefKey = "LinearIntensity";
        private const string ColorTemperaturePrefKey = "ColorTemperature";


        /// <summary>
        /// Method to get the saved values of linear intensity and color temperature from EditorPrefs.
        /// </summary>
        /// <param name="UsePlayerPrefs">Set UsePlayerPrefs to true if you want to store the values in PlayerPrefs</param>
        /// <remarks>
        /// This method retrieves the saved values for linear intensity and color temperature from EditorPrefs.
        /// The values are then assigned to GraphicsSettings.lightsUseLinearIntensity and GraphicsSettings.lightsUseColorTemperature.
        /// </remarks>
        public static void GetValues(bool UsePlayerPrefs = false)
        {
            //Change UsePlayerPrefs to true if you want to store the values in PlayerPrefs
            if (UsePlayerPrefs == true)
            {
                // Load the saved values from EditorPrefs with the specified keys and assign them to GraphicsSettings.
                GraphicsSettings.lightsUseLinearIntensity = EditorPrefs.GetBool(LinearIntensityPrefKey, false);
                GraphicsSettings.lightsUseColorTemperature = EditorPrefs.GetBool(ColorTemperaturePrefKey, false);
            }
        }

        /// <summary>
        /// Method to save the current values of linear intensity and color temperature to EditorPrefs.
        /// </summary>
        /// <param name="UsePlayerPrefs">Set UsePlayerPrefs to true if you want to store the values in PlayerPrefs</param>
        /// <remarks>
        /// This method saves the current values of linear intensity and color temperature from GraphicsSettings
        /// to EditorPrefs with the specified keys.
        /// </remarks>
        public static void SaveValues(bool UsePlayerPrefs = false)
        {
            //Change UsePlayerPrefs to true if you want to store the values in PlayerPrefs
            if (UsePlayerPrefs == true)
            {
                // Save the current values to EditorPrefs with the specified keys from GraphicsSettings.
                EditorPrefs.SetBool(LinearIntensityPrefKey, GraphicsSettings.lightsUseLinearIntensity);
                EditorPrefs.SetBool(ColorTemperaturePrefKey, GraphicsSettings.lightsUseColorTemperature);
            }
        }

        private static void RefreshInspector()
        {
            if (Selection.activeGameObject != null)
            {
                EditorUtility.SetDirty(Selection.activeGameObject);
            }
        }
    }
}