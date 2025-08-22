using UnityEditor;
using UnityEngine;
using ALP8310LightingController.Lights;

/// <summary>
/// Represents an existing Editor Window that includes lighting toggles for linear intensity and color temperature.
/// </summary>
public class ALP8310GlobalLightingSettingsWindow : EditorWindow
{
    private bool useLinearIntensity;
    private bool useColorTemperature;

    // Add a menu item to open this window from the Unity Editor.
    [UnityEditor.MenuItem("Window/ALP8310/Global Lighting Settings")]
    public static void ShowWindow()
    {
        GetWindow<ALP8310GlobalLightingSettingsWindow>("Global Lighting Settings");
    }

    // Method to get the current values of linear intensity and color temperature.
    private void GetValues()
    {
        //use param set to true to get the value from PlayerPrefs
        LightSettingsController.GetValues();

        useLinearIntensity = LightSettingsController.IsLinearIntensity();
        if (!useLinearIntensity && useColorTemperature == true)
        {
            useColorTemperature = false;
            LightSettingsController.ResetColorTemperature(false);
        }
        else
        {
            useColorTemperature = LightSettingsController.IsColourTemperature();
        }
    }

    // Unity's GUI method for rendering the window's contents.
    private void OnGUI()
    {
        // Retrieve the saved values of linear intensity and color temperature.
        GetValues();
        GUILayout.Space(EditorGUIUtility.singleLineHeight);
        GUILayout.Label("Global Lighting Settings", EditorStyles.boldLabel);

        // Call the LightSettingsController.ToggleLinearIntensity method to toggle linear intensity setting.
        // Pass the current value of useLinearIntensity as a parameter.
        LightSettingsController.ToggleLinearIntensity(useLinearIntensity);

        // Call the LightSettingsController.ToggleColorTemperature method to toggle color temperature setting.
        // Pass the current value of useColorTemperature as a parameter along with an optional GUIStyle for the label.
        LightSettingsController.ToggleColorTemperature(useColorTemperature);

        // Save the current values when the window is closed or recompiled.
        // set UsePlayerPrefs param to true to use PlayerPrefs to store the value
        LightSettingsController.SaveValues();
    }

}
