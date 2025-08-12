using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

// Makes enemy navigate towards the player

public class EnemyNavigation : MonoBehaviour
{
    public Transform player;
    private NavMeshAgent agent;
    // Start is called before the first frame update
    void Start()
    {
        agent = GetComponent<NavMeshAgent>();
    }

    // Update is called once per frame
    void Update()
    {
        agent.destination = player.position;
    }
}
