using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Planet : MonoBehaviour {
    public float maxGravity = 2.0f;
    public float maxGravDist = 4.0f;

    private LineRenderer lineRenderer;
    private GameObject player;
    private int vertexCount = 40;
    public float lineWidth = 0.01f;

    // Initialize variables
    void Awake()
    {
        player = GameObject.Find("Player");
        lineRenderer = GetComponent<LineRenderer>();
    }

    // Update every frame
    private void Update()
    {
        SetupOrbit();
    }

    // Update periodically
    void FixedUpdate()
    {
        if (player == null)
            return;

        // Used to give gravity to individual planets
        if (player.GetComponent<Player>().isJumping)
        {
            float dist = Vector3.Distance(transform.position, player.transform.position);

            if (dist <= maxGravDist)
            {
                Vector3 v = transform.position - player.transform.position;
                player.GetComponent<Rigidbody2D>().AddForce(v.normalized * (1.0f - dist / maxGravDist) * maxGravity);
            }
        }
    }

    // Functionality when the player collides with the planet
    private void OnCollisionEnter2D(Collision2D collision)
    {
        // If planet detects a collision with player, set the player in correct orientation and distance
        if(collision.gameObject.name == "Player")
        {
            // Set the force on player as 0
            collision.gameObject.GetComponent<Rigidbody2D>().velocity = transform.gameObject.GetComponent<Rigidbody2D>().velocity;

            // Set the player as child of the current planet
            collision.gameObject.transform.parent = transform;

            // Set the player's rotation relative to the collided planet
            collision.gameObject.transform.parent = transform;
            collision.gameObject.GetComponent<Player>().OrientPlayer(false);

            // Set the isJumping off
            collision.gameObject.GetComponent<Player>().isJumping = false;
        }
    }

    // Forces the player to stay with the parent planet if the collision ends
    private void OnCollisionExit2D(Collision2D collisionInfo)
    {
        // If the planet is the parent of the player, then force them to have the same velocity
        if (collisionInfo.gameObject.name == "Player" && collisionInfo.transform.IsChildOf(transform))
        {
            collisionInfo.gameObject.GetComponent<Rigidbody2D>().velocity = transform.gameObject.GetComponent<Rigidbody2D>().velocity;
        }
    }

    // Creates a circle that indicates the gravity range
    private void SetupOrbit()
    {
        lineRenderer.widthMultiplier = lineWidth;

        float deltaTheta = (2f * Mathf.PI) / vertexCount;
        float theta = 0f;

        lineRenderer.positionCount = vertexCount;
        for (int i = 0; i < lineRenderer.positionCount; i++)
        {
            Vector3 pos = new Vector3((maxGravDist - 0.3f) * Mathf.Cos(theta) + transform.position.x, (maxGravDist - 0.3f) * Mathf.Sin(theta) + transform.position.y, 0f);
            lineRenderer.SetPosition(i, pos);
            theta += deltaTheta;
        }
    }

//    // For previewing the gravity range in Unity editor
//#if UNITY_EDITOR
//    private void OnDrawGizmos()
//    {
//        float deltaTheta = (2f * Mathf.PI) / vertexCount;
//        float theta = 0f;

//        Vector3 oldPos = Vector3.zero;
//        for (int i = 0; i < vertexCount + 1; i++)
//        {
//            Vector3 pos = new Vector3((maxGravDist - 0.3f) * Mathf.Cos(theta), (maxGravDist - 0.3f) * Mathf.Sin(theta), 0f);
//            Gizmos.DrawLine(oldPos, transform.position + pos);
//            oldPos = transform.position + pos;

//            theta += deltaTheta;
//        }
//    }
//#endif
}
