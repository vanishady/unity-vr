using UnityEngine;
using extOSC;
// detects collisions with the player.
// if collides with enemy, sends osc message to supercollider to activate sound.
public class CollisionDetector : MonoBehaviour
{
    public OSCTransmitter oscTransmitter;
    void Start() 
    {
        if (oscTransmitter == null)
                {
                    Debug.LogError("OSC Transmitter is not assigned in the inspector!");
                }
    }
    void OnCollisionEnter(Collision collision)
    {
        Debug.Log("Entered collision with " + collision.gameObject.name);

        if (oscTransmitter != null && collision.gameObject.tag == "Enemy")
        {
            // Create an OSC message
            OSCMessage message = new OSCMessage("/touch");

            // Add a string value to the message
            message.AddValue(OSCValue.String("hello"));

            // Send the message
            oscTransmitter.Send(message);

            Debug.Log("OSC message sent: 'hello'");
        }
    }


}