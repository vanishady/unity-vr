using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace MimicSpace
{
    /// <summary>
    /// This script enables movement for the Mimic when the player is within a certain distance.
    /// Movement involves translating the Mimic by -50 on the Z-axis.
    /// </summary>
    public class MimicMovement : MonoBehaviour
    {
        [Header("Controls")]
        [Tooltip("Body Height from ground")]
        [Range(0.5f, 5f)] public float height = 0.8f;
        public float speed = 5f;
        private Vector3 velocity = Vector3.zero;
        public float velocityLerpCoef = 4f;

        [Header("Player Detection")]
        [Tooltip("Reference to the player's transform")]
        public Transform player;
        [Tooltip("Activation distance for Mimic movement")]
        public float activationDistance = 20f;

        private Mimic myMimic;
        public AudioSource myAudio; 

        private bool isPlaying = false;

        private void Start()
        {
            myMimic = GetComponent<Mimic>();
            if (myMimic == null)
            {
                Debug.LogError("Mimic component is missing on this GameObject!");
            }

            if (player == null)
            {
                Debug.LogError("Player reference is missing! Please assign the player transform in the inspector.");
            }
        }

        private void Update()
        {
            if (player == null) return;

            // Check the distance to the player
            float distanceToPlayer = Vector3.Distance(transform.position, player.position);

            if (distanceToPlayer <= activationDistance)
            {
                HandleMovement();
                AdjustHeight();
                if (!isPlaying)
                    StartPlaying();
            }
        }

        private void StartPlaying()
        {
            isPlaying = true;
            myAudio.Play();
        }

        private void HandleMovement()
        {
            // Simple translation of -50 on the Z-axis
            Vector3 targetPosition = transform.position + new Vector3(0, 0, -100);

            // Smoothly move towards the target position
            velocity = Vector3.Lerp(velocity, (targetPosition - transform.position).normalized * speed, velocityLerpCoef * Time.deltaTime);

            // Assign velocity to Mimic
            if (myMimic != null)
            {
                myMimic.velocity = velocity;
            }

            // Update position
            transform.position += velocity * Time.deltaTime;
        }

        private void AdjustHeight()
        {
            RaycastHit hit;
            Vector3 destHeight = transform.position;

            // Raycast to determine ground level
            if (Physics.Raycast(transform.position + Vector3.up * 5f, Vector3.down, out hit))
            {
                destHeight = new Vector3(transform.position.x, hit.point.y + height, transform.position.z);
            }

            // Smooth height adjustment
            transform.position = Vector3.Lerp(transform.position, destHeight, velocityLerpCoef * Time.deltaTime);
        }
    }
}
