using System.Collections;
using System.Collections.Generic;
using UnityEngine;
// Makes enemy disappear after collision with the player

public class EnemyCollision : MonoBehaviour
{

    void OnCollisionEnter(Collision collision)
    {
        Debug.Log("Entered collision with " + collision.gameObject.name);

    
        if (collision.gameObject.CompareTag("Player")) 
        {
            // Destroy this GameObject to make the enemy disappear
            Destroy(gameObject);

            // Alternatively, if you just want to hide it without destroying:
            // gameObject.SetActive(false);
        }
    }
}

