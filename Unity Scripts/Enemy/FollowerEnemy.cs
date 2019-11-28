using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FollowerEnemy : Enemy {
    public float speed = 0.5f;

    private GameObject player;

    // Use this for initialization
    void Start () {
        player = GameObject.Find("Player");
    }
	
	// Update is called once per frame
	void Update () {
        OrientEnemy();
        MoveEnemy();
    }

    // Orient enemy based on the planet TODO this may not be needed so delete it
    private void OrientEnemy()
    {
        // If player doesn't exist, exit function
        if (player == null)
            return;

        // Some voodoo magic I don't quite understand... 
        Vector3 diff = player.transform.position - transform.position;
        diff.Normalize();

        float rot_z = Mathf.Atan2(diff.y, diff.x) * Mathf.Rad2Deg;
        transform.rotation = Quaternion.Euler(0f, 0f, rot_z + 270);
    }

    // Move the enemy slowly to the player
    // TODO WORK ON MAKING THE ENEMY GO AROUND THE PLANET
    private void MoveEnemy()
    {
        // If player doesn't exist, exit function
        if (player == null)
            return;

        RaycastHit2D hit = Physics2D.Raycast(transform.position, transform.up);
        Debug.DrawRay(transform.position, transform.up, Color.green);

        //Debug.Log("transform.position: " + transform.position);
        //Debug.Log("player.transform.position: " + player.transform.position);
        Debug.Log("hit.collider.gameObject.name: " + hit.collider.gameObject.name);
        //Debug.Log("dist: " + hit.distance);

        // if the raycast collided object is not player, then keep moving towards until certain distance
        if (hit.collider.gameObject.name != "player")
        {
            // if the distance between the enemy and obstacle (like planet) less than 1f, then stop the enemy from moving
            float distance = Vector2.Distance(hit.transform.position, transform.position);
            if (distance > 1f)
            {
                transform.position = Vector2.MoveTowards(transform.position, player.transform.position, 0.01f);
            }
        }
        else
        {
            transform.position = Vector2.MoveTowards(transform.position, player.transform.position, 0.01f);
        }
    }
}
