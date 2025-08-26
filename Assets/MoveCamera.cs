using UnityEngine;

public class MoveCamera : MonoBehaviour
{
    public float movementSpeed = 5.0f;
    public float rotationSpeed = 100.0f;

    void Update()
    {
        // Movimento avanti e indietro (W/S) e destra e sinistra (A/D)
        float horizontalInput = Input.GetAxis("Horizontal");
        float verticalInput = Input.GetAxis("Vertical");

        Vector3 moveDirection = new Vector3(horizontalInput, 0, verticalInput);
        transform.Translate(moveDirection * movementSpeed * Time.deltaTime, Space.Self);

        // Rotazione della telecamera (Q/E)
        if (Input.GetKey(KeyCode.Q))
        {
            transform.Rotate(Vector3.up, -rotationSpeed * Time.deltaTime);
        }
        if (Input.GetKey(KeyCode.E))
        {
            transform.Rotate(Vector3.up, rotationSpeed * Time.deltaTime);
        }
    }
}