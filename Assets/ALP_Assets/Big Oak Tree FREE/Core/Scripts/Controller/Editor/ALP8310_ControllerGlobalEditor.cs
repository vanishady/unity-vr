
#if UNITY_EDITOR
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(ALP8310Controller))]
[CanEditMultipleObjects]
public class ALP8310_ControllerGlobalEditor : Editor
{
    #region [Properties ALP8310]

    private ALP8310Controller controller;
    private static int currentToolBoxIndex = 0;

    private SerializedProperty windZone,
        SynchWindZone,
        SynchTheVegetationEngine,
        SynchMicrosplat,
        WindStrength,
        FadeWindDistanceMode,
        FadeWindDistanceBias,
        WindPulse,
        WindDirection,
        WindTurbulence,
        WindRandomness;

    private SerializedProperty BillboardWindEnabled, BillboardWindIntensity;
    private SerializedProperty SavedTab;

    #endregion [Properties ALP8310]

    #region [Unity Actions]

    private void OnEnable()
    {
        controller = (target as ALP8310Controller);

        windZone = serializedObject.FindProperty("windZone");

        SynchWindZone = serializedObject.FindProperty("SynchWindZone");
        SynchTheVegetationEngine = serializedObject.FindProperty("SynchTheVegetationEngine");
        SynchMicrosplat = serializedObject.FindProperty("SynchMicrosplat");

        WindStrength = serializedObject.FindProperty("WindStrength");
        FadeWindDistanceMode = serializedObject.FindProperty("FadeWindDistanceMode");
        FadeWindDistanceBias = serializedObject.FindProperty("FadeWindDistanceBias");
        WindPulse = serializedObject.FindProperty("WindPulse");
        WindTurbulence = serializedObject.FindProperty("WindTurbulence");
        WindRandomness = serializedObject.FindProperty("WindRandomness");
        WindDirection = serializedObject.FindProperty("WindDirection");

        BillboardWindEnabled = serializedObject.FindProperty("BillboardWindEnabled");
        BillboardWindIntensity = serializedObject.FindProperty("BillboardWindIntensity");

        controller.foldouts = new List<bool>()
        {
            true,
            false,
            false,
            false
        };
        controller.actions = new List<System.Action>()
        {
            WindGUI,
        };
        controller.guiContent = new List<GUIContent>()
        {
            new GUIContent("Wind", "Click here to open Wind settings"),
        };

    }

    public override void OnInspectorGUI()
    {
        EditorGUI.BeginChangeCheck();

        GeneralGUI();
        /*      for (int i = 0; i < controller.foldouts.Count; i++)
              {
                  if (i != controller.foldouts.Count - 1)
                      controller.foldouts[i] = controller.foldouts[i].FoldoutField(controller.guiContent[i]);
                  else
                      controller.foldouts[i] =
                          controller.foldouts[i].FoldoutField(controller.guiContent[i], isLastInRow: true);
                  if (controller.foldouts[i])
                      controller.actions[i]();
              }
              */

        serializedObject.ApplyModifiedProperties();

        if (EditorGUI.EndChangeCheck())
            controller.SetShaders();
    }

    #endregion [Unity Actions]

    #region [GUI]
    private void GeneralGUI()
    {
        currentToolBoxIndex = GUILayout.Toolbar(
            currentToolBoxIndex,
            new string[] { "Wind" }, null,
            GUI.ToolbarButtonSize.Fixed, GUILayout.Height(50));

        switch (currentToolBoxIndex)
        {
            case 0:
                EditorGUILayout.BeginVertical("Box");
                WindZoneGUI();
                EditorGUILayout.EndVertical();
                WindGUI();
                break;

            default: break;
        }
    }

    private void WindGUI()
    {
        EditorGUILayout.BeginVertical("Box");
        EditorGUILayout.Space();
        EditorGUILayout.LabelField("Wind Setting", EditorStyles.boldLabel);
        EditorGUI.BeginDisabledGroup(controller.SynchWindZone && controller.windZone);
        WindStrength.PropertyField("Main", "wind main strength");
        WindTurbulence.PropertyField("Turbulence", "wind variation in wind direction");
        WindPulse.PropertyField("Pulse Frequency", "wind length & frequency of the wind pulses.y");
        EditorGUI.EndDisabledGroup();

        WindDirection.PropertyField("Direction", "wind zone transform rotation Y");
        WindRandomness.PropertyField("Random Offset", "wind randomness offset");
        EditorGUILayout.Space();
        EditorGUILayout.EndVertical();
        EditorGUILayout.BeginVertical("Box");
        BillboardWindGUI();
        EditorGUILayout.EndVertical();

        EditorGUILayout.BeginVertical("Box");
        FadeWindGUI();
        EditorGUILayout.EndVertical();

    }

    private void WindZoneGUI()
    {
        EditorGUI.BeginDisabledGroup(!controller.windZone);
        SynchWindZone.PropertyField("Sync WindZone", "Synch <Global Controller> with Wind Zone");
        EditorGUI.EndDisabledGroup();
        windZone.PropertyField("Wind Zone", "Unity Wind Zone");
        if (!controller.windZone)
        {
            {
                if (controller.GetComponent<WindZone>())
                    controller.windZone = controller.GetComponent<WindZone>();
                else
                    controller.windZone = controller.gameObject.AddComponent<WindZone>();
            }

            EditorGUILayout.EndHorizontal();
            EditorGUILayout.Space();
        }
    }

    private void BillboardWindGUI()
    {
        EditorGUILayout.LabelField("Wind Billboard", EditorStyles.boldLabel);

        EditorGUILayout.BeginHorizontal();
        EditorGUILayout.LabelField("Enable", GUILayout.Width(Screen.width / 4));
        BillboardWindEnabled.intValue = EditorGUILayout.IntPopup(BillboardWindEnabled.intValue,
            new string[] { "Off", "Active" }, new[] { 0, 1 });

        EditorGUILayout.EndHorizontal();

        EditorGUI.BeginDisabledGroup(!controller.BillboardWindEnabled);
        BillboardWindIntensity.PropertyField("Main");
        EditorGUI.EndDisabledGroup();
        EditorGUILayout.Space();
    }

    private void FadeWindGUI()
    {
        Rect vertical = EditorGUILayout.BeginVertical();

        EditorGUILayout.LabelField("Wind Fade", EditorStyles.boldLabel);
        EditorGUILayout.BeginHorizontal();
        EditorGUILayout.LabelField("Enable", GUILayout.Width(Screen.width / 4));
        FadeWindDistanceMode.intValue = EditorGUILayout.IntPopup(FadeWindDistanceMode.intValue,
            new string[] { "Off", "Active Fade Out", "Active Fade In" }, new[] { 0, 1, 2 });

        EditorGUILayout.EndHorizontal();
        FadeWindDistanceBias.PropertyField("Fade Bias", "Higher values, fade will happen at a greater distance");
        EditorGUILayout.EndVertical();
        EditorGUILayout.Space();
    }

    private void Callback(object userdata)
    {
        Debug.Log("Test");
    }

    #endregion [GUI]

    #region [Menu Itemm]

    [MenuItem("Window/ALP8310/Controller/Add Controller...", priority = 311)]
    public static void CreateGlobalALP8310WindController()
    {
        GameObject WindController = new GameObject("ALP8310 Controller");
        var egc = WindController.AddComponent<ALP8310Controller>();
        var wz = WindController.AddComponent<WindZone>();
        egc.windZone = wz;
        egc.SynchWindZone = true;

        if (SceneView.lastActiveSceneView != null)
        {
            WindController.transform.position = Vector3.zero;
        }
    }

    [MenuItem("GameObject/3D Object/ALP8310/Add Global Controller...", priority = 9999)]
    public static void CreateGlobalALP8310WindControllerGameObject()
    {
        GameObject WindController = new GameObject("Controller");
        var egc = WindController.AddComponent<ALP8310Controller>();
        var wz = WindController.AddComponent<WindZone>();
        egc.windZone = wz;
        egc.SynchWindZone = true;

        if (SceneView.lastActiveSceneView != null)
        {
            WindController.transform.position = Vector3.zero;
        }
    }

    #endregion [Menu Itemm]
}

#endif