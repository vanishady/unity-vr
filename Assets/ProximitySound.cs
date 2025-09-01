using UnityEngine;

[RequireComponent(typeof(Collider))]
public class ProximitySound : MonoBehaviour
{
    [Tooltip("Tag del player che attiva il suono")]
    public string playerTag = "Player";

    [Header("Audio")]
    [Tooltip("AudioSource con il clip relativo a questo oggetto")]
    public AudioSource audioSource;

    [Tooltip("Se assegnato, riproduce questo clip con PlayOneShot; altrimenti usa il clip dell'AudioSource")]
    public AudioClip clip;

    [Tooltip("Suona solo la prima volta")]
    public bool playOnce = false;

    private bool hasPlayed = false;

    void Reset()
    {
        // Auto-setup quando aggiungi lo script
        var col = GetComponent<Collider>();
        col.isTrigger = true;
        audioSource = GetComponent<AudioSource>();
    }

    void Awake()
    {
        var col = GetComponent<Collider>();
        if (!col.isTrigger)
            Debug.LogWarning($"{name}: il Collider deve avere 'Is Trigger' abilitato.");

        if (audioSource == null)
            audioSource = GetComponent<AudioSource>();

        if (audioSource != null)
            audioSource.playOnAwake = false;
    }

    void OnTriggerEnter(Collider other)
    {
        if (!other.CompareTag(playerTag)) return;
        if (playOnce && hasPlayed) return;

        if (audioSource != null)
        {
            if (clip != null) audioSource.PlayOneShot(clip);
            else audioSource.Play();
            hasPlayed = true;
        }
        else
        {
            Debug.LogWarning($"{name}: manca AudioSource. Assegnane uno in Inspector.");
        }
    }

    void OnTriggerExit(Collider other)
    {
        if (!other.CompareTag(playerTag)) return;
        if (!playOnce) hasPlayed = false; // permetti di risuonare a ogni nuovo passaggio
    }
}
