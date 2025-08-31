using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

// Makes enemy navigate toward a destination
public class EnemyNavigation : MonoBehaviour
{
    public Transform destination;
    private NavMeshAgent agent;

    private Transform player;
    private bool started = false;
    private const float ACTIVATION_RADIUS = 100f;

    [Header("Audio (opzionale)")]
    [Tooltip("Assegna un AudioSource con il clip da riprodurre all'avvio.")]
    public AudioSource startAudio;

    void Start()
    {
        agent = GetComponent<NavMeshAgent>();
        agent.isStopped = true; // fermo finché non si attiva

        GameObject go = GameObject.FindGameObjectWithTag("Player");
        if (go != null) player = go.transform;

        if (startAudio != null) startAudio.playOnAwake = false;
    }

    void Update()
    {
        if (!started && player != null)
        {
            // attiva quando il Player è entro 100
            if ((player.position - transform.position).sqrMagnitude <= ACTIVATION_RADIUS * ACTIVATION_RADIUS)
            {
                started = true;
                agent.isStopped = false;

                if (startAudio != null && !startAudio.isPlaying)
                    startAudio.Play(); // avvia l'audio una volta all'attivazione
            }
        }

        if (started && destination != null)
        {
            agent.destination = destination.position;
        }
    }
}
