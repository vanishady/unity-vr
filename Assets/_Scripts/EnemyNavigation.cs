using UnityEngine;
using UnityEngine.AI;

/// CarNavigationActivator
/// - L'auto resta ferma finché il player non entra nel raggio (default 50f)
/// - All'attivazione: parte il NavMeshAgent e suona una sola volta l'audio
public class CarNavigationActivator : MonoBehaviour
{
    [Header("Riferimenti")]
    public Transform destination;     // dove deve andare l'auto
    public Transform player;          // se non assegnato, prova a cercare tag "Player"

    [Header("Attivazione")]
    public float activationRadius = 50f;

    [Header("Audio (una volta all'avvio)")]
    public AudioSource myAudio;
    private bool isPlaying = false;

    private NavMeshAgent agent;
    private bool started = false;

    void Awake()
    {
        agent = GetComponent<NavMeshAgent>();
        if (agent == null) Debug.LogError($"NavMeshAgent mancante su {name}");
    }

    void Start()
    {
        if (agent != null) agent.isStopped = true;

        if (player == null)
        {
            GameObject go = GameObject.FindGameObjectWithTag("Player");
            if (go) player = go.transform;
        }
    }

    void Update()
    {
        if (!started)
        {
            if (player == null) return;

            // attiva quando il Player è entro activationRadius
            float sqrDist = (player.position - transform.position).sqrMagnitude;
            if (sqrDist <= activationRadius * activationRadius)
            {
                started = true;
                if (agent != null) agent.isStopped = false;

                // suona una sola volta
                if (!isPlaying)
                    StartPlaying();
            }
        }

        // se attivo, aggiorna la destinazione
        if (started && agent != null && destination != null)
        {
            agent.destination = destination.position;
        }
    }

    private void StartPlaying()
        {
            isPlaying = true;
            myAudio.Play();
        }

#if UNITY_EDITOR
    private void OnDrawGizmosSelected()
    {
        Gizmos.color = new Color(0.1f, 0.6f, 1f, 0.35f);
        Gizmos.DrawWireSphere(transform.position, activationRadius);
    }
#endif
}
