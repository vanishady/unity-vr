using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LightGlitch : MonoBehaviour
{

    public Light myLight;
    public System.Random interval = new System.Random();
    float timer = 0f;
    // Start is called before the first frame update
    void Start()
    {
        myLight = GetComponent<Light>();
    }

    // Update is called once per frame
    void Update()
    {
        double _interval = interval.NextDouble(); //
        timer += Time.deltaTime;
        if (timer > _interval)
        {
            myLight.enabled = !myLight.enabled;
            timer -= (float)_interval;
        }

    }
}
