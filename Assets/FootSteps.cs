using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FootSteps : MonoBehaviour
{

    private AudioSource src;
    private Vector3 lastPos;

    void Awake()
    {
        src = GetComponent<AudioSource>();
        // Assegna in Inspector il clip 'footsteps.wav' sull'AudioSource
        src.loop = true;
        src.playOnAwake = false; // controlliamo noi quando farlo partire
        lastPos = transform.position;
    }

    void Update()
    {
        Vector3 pos = transform.position;
        Vector3 delta = pos - lastPos;

        float speed = delta.magnitude / Mathf.Max(Time.deltaTime, 1e-5f);
        bool moving = speed > 0.1f;

        if (moving)
        {
            if (!src.isPlaying) src.UnPause(); // riprende se era in pausa
            if (!src.isPlaying) src.Play();    // se non ha mai suonato, avvia
        }
        else
        {
            if (src.isPlaying) src.Pause();    // pausa quando è fermo
        }

        lastPos = pos;
    }
}
