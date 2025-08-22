using ALP8310ControllerStyle;
using System;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode, AddComponentMenu("ALP8310 Controller Global")]
public class ALP8310Controller : MonoBehaviour
{
    #region [Wind Zone]

    public WindZone windZone;

    public bool SynchWindZone = false;
    public bool SynchTheVegetationEngine = false;
    public bool SynchMicrosplat = false;
    public float WindStrength = 0.01f;
    public float WindDirection = 0f;
    public int FadeWindDistanceMode = 0;
    public float FadeWindDistanceBias = 0;
    public float WindPulse = 10f;
    public float WindTurbulence = 0.01f;
    public float WindRandomness = 0;

    #endregion [Wind Zone]

    #region [BillboardWind]

    public bool BillboardWindEnabled = false;
    public float BillboardWindIntensity = 0;

    #endregion [BillboardWind]

    #region [GUI]

    [HideInInspector] public List<bool> foldouts;
    [HideInInspector] public List<Action> actions;
    [HideInInspector] public List<GUIContent> guiContent;

    #endregion [GUI]

    #region [Private Variables]

    private float windStrength, windDirection, windPulse, windTurbulence;
    private readonly string _WindStrength = "_GlobalWindIntensity", _WindFadeDistanceMode = "_GlobalWindFadeEnabled", _WindFadeDistanceBias = "_GlobalWindFadeBias", _WindDirection = "_GlobalWindDirection", _WindPulse = "_GlobalWindPulse", _WindTurbulence = "_GlobalWindTurbulence", _RandomWind = "_GlobalWindRandomOffset";
    private readonly string _BillboardWindEnabled = "_GlobalWindBillboardEnabled", _BillboardWindIntensity = "_GlobalWindBillboardIntensity";

    #endregion [Private Variables]

    #region [UnityCalls]

    private void OnDisable()
    {
        ResetShaders();
    }
    private void OnDestroy()
    {
        ResetShaders();
    }
    private void OnEnable()
    {
        SetShaders();
    }
    private void Update()
    {
        SetUpdateValues();
    }
    private void Reset()
    {
        WindStrength = 5f;
        FadeWindDistanceMode = 0;
        FadeWindDistanceBias = 0f;
        WindRandomness = 0.2f;
        WindPulse = 0.5f;
        WindTurbulence = 1f;
        WindDirection = 0;

        BillboardWindEnabled = true;
        BillboardWindIntensity = 0.5f;

        SetShaders();
    }

    #endregion [UnityCalls]

    #region [Public Voids]

    public void SetUpdateValues()
    {
        GetDefaultValues();
        GetWindZoneValues();
    }
    private void GetDefaultValues()
    {
        if (!SynchWindZone && (windStrength != _WindStrength.GetGlobalFloat() || transform.rotation.eulerAngles.y != _WindDirection.GetGlobalFloat() || windPulse != _WindPulse.GetGlobalFloat() || windTurbulence != _WindTurbulence.GetGlobalFloat() || windDirection != _WindDirection.GetGlobalFloat()))
        {
            SetShaders();
            windStrength = _WindStrength.GetGlobalFloat();
            windDirection = _WindDirection.GetGlobalFloat();
            windPulse = _WindPulse.GetGlobalFloat();
            windTurbulence = _WindTurbulence.GetGlobalFloat();
        }
    }
    private void GetWindZoneValues()
    {
        if (windZone && SynchWindZone && (windZone.windMain != WindStrength || windZone.windPulseFrequency != WindPulse || windZone.windTurbulence != windTurbulence))
        {
            WindStrength = windZone.windMain;
            WindPulse = windZone.windPulseFrequency;
            WindTurbulence = windZone.windTurbulence;
            SetShaders();
        }
    }
    public void SetShaders()
    {
        _WindStrength.SetGlobalFloat(WindStrength);
        _WindFadeDistanceMode.SetGlobalInt(FadeWindDistanceMode);
        _WindFadeDistanceBias.SetGlobalFloat(FadeWindDistanceBias);
        _WindDirection.SetGlobalFloat(transform.rotation.eulerAngles.y);
        _WindPulse.SetGlobalFloat(WindPulse);
        _WindTurbulence.SetGlobalFloat(WindTurbulence);
        _RandomWind.SetGlobalFloat(WindRandomness);

        if (BillboardWindEnabled)
        {
            _BillboardWindEnabled.SetGlobalInt(1);
            _BillboardWindIntensity.SetGlobalFloat(BillboardWindIntensity);
        }
        else
            _BillboardWindEnabled.SetGlobalInt(0);

    }
    private void ResetShaders()
    {
        _WindStrength.SetGlobalFloat(0);
        _WindFadeDistanceMode.SetGlobalInt(0);
        _WindFadeDistanceBias.SetGlobalFloat(0);
        _WindPulse.SetGlobalFloat(0);
        _WindTurbulence.SetGlobalFloat(0);

        _RandomWind.SetGlobalFloat(0);

        _BillboardWindEnabled.SetGlobalInt(0);
        _BillboardWindIntensity.SetGlobalFloat(0);

    }

    #endregion [Public Voids]

}
