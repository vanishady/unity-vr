using System.Collections.Generic;
using UnityEngine;
using extOSC;

public class ProximityDetector : MonoBehaviour
{
    [Header("OSC Settings")]
    public OSCTransmitter Transmitter;
    public string oscAddress = "/danger_input";

    [Header("Proximity Settings")]
    public float detectionRadius = 1.0f;
    public float sendInterval = 1.0f;

    private float timer = 0f;
    private Transform player;
    private List<Transform> dangerObjects = new List<Transform>();

    void Start()
    {
        player = GameObject.FindGameObjectWithTag("Player").transform;

        GameObject[] enemies = GameObject.FindGameObjectsWithTag("Enemy");
        foreach (GameObject enemy in enemies)
        {
            dangerObjects.Add(enemy.transform);
        }

        if (dangerObjects.Count == 0)
            Debug.LogWarning("Nessun oggetto con tag 'Enemy' trovato nella scena.");
    }

    void Update()
    {
        timer += Time.deltaTime;
        if (timer >= sendInterval)
        {
            timer = 0f;
            float closestDistance = GetClosestDangerDistance();

            if (closestDistance <= detectionRadius)
            {
                float normalized = Mathf.Clamp01(closestDistance / detectionRadius); // 0=vicinissimo, 1=al limite
                SendDangerDistance(normalized);
            }
        }
    }

    float GetClosestDangerDistance()
    {
        float minDistance = float.MaxValue;
        foreach (Transform danger in dangerObjects)
        {
            float dist = Vector3.Distance(player.position, danger.position);
            if (dist < minDistance)
                minDistance = dist;
        }
        return minDistance;
    }

    void SendDangerDistance(float normalizedDistance)
    {
        var message = new OSCMessage(oscAddress);
        message.AddValue(OSCValue.Float(normalizedDistance));
        Transmitter.Send(message);

        Debug.Log($"Inviata distanza normalizzata: {normalizedDistance:F2}");
    }
}
