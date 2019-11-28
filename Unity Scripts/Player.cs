using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : MonoBehaviour {
    public float rotateSpeed = 5f;
    public float jumpSpeed = 15f;

    [HideInInspector]
    public bool isJumping = true;

    // Update is called once per frame
    void Update () {
        OrientPlayer(isJumping);
        RotatePlayer();
        Jump();
    }

    // Player jumps from a planet
    private void Jump()
    {
        if (Input.GetKeyDown(KeyCode.Space) && !isJumping)
        {
            // Make the player jump directly above
            Vector2 jumpDirection = new Vector2(0, 1);
            transform.GetComponent<Rigidbody2D>().velocity = new Vector2(0, 0);
            transform.GetComponent<Rigidbody2D>().AddRelativeForce(jumpDirection * jumpSpeed);

            // Detect from parent and set jumping to true
            isJumping = true;

            // Set the planet flying in the opposite direction
            Vector2 planetRecoilDir = -transform.up;
            transform.parent.GetComponent<Rigidbody2D>().AddRelativeForce(planetRecoilDir * jumpSpeed);

            // Set parent to null for planet to reset the parent
            transform.parent = null;
        }
    }

    // Responsible for rotating the player around a planet
    private void RotatePlayer()
    {
        // Prevent the player from moving while the player is jumping
        if (isJumping)
            return;

        Vector3 zAxis = new Vector3(0, 0, 1);
        float tempSpeed;

        if (Input.GetKey(KeyCode.A))
        {
            tempSpeed = -rotateSpeed;
        }
        else if (Input.GetKey(KeyCode.D))
        {
            tempSpeed = rotateSpeed;
        }
        else
        {
            tempSpeed = 0;
        }

        transform.RotateAround(transform.parent.position, zAxis, tempSpeed); // At center of target.position, the transform rotates around the zAxis
    }

    // Orient player based on the planet
    public void OrientPlayer(bool isJumping)
    {
        if (isJumping)
            return;

        // Some voodoo magic I don't quite understand... 
        Vector3 diff = transform.parent.position - transform.position;
        diff.Normalize();

        float rot_z = Mathf.Atan2(diff.y, diff.x) * Mathf.Rad2Deg;
        transform.rotation = Quaternion.Euler(0f, 0f, rot_z + 90);
    }

    // Checking for collisions of player
    private void OnCollisionEnter2D(Collision2D collision)
    {
        // If collided w/ a goal planet, the current game is over
        if (collision.gameObject.name == "Goal")
        {
            GameObject.Find("Game Manager").GetComponent<Game>().isGameOver = true;
        }
    }
}
