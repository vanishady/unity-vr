using UnityEngine; 
using System.Collections; 
 
public class WizardVoice : MonoBehaviour { 
    public AudioSource myAudio; 
    public float delay=2.0f;  // Time in seconds to delay playing the audio source
    // Use this for initialization 
    void Start () { 
 
        StartCoroutine(PlaySoundAfterDelay(myAudio, delay)); 
    } 
 
    // Update is called once per frame 
    void Update () { 
 
    } 
 
    IEnumerator PlaySoundAfterDelay(AudioSource audioSource, float delay) 
    { 
        if (audioSource == null)
        {            
            Debug.Log("Null");             
            yield break;
            }
            else
            {             
                Debug.Log("Not Null");         
                yield return new WaitForSeconds(delay);         
                audioSource.Play();
            }
    } 
 
}