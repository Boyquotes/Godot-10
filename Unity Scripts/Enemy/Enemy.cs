using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Enemy : MonoBehaviour {

    // Checks for player collision against enemy
    private void OnTriggerEnter2D(Collider2D collision)
    {
        if (collision.gameObject.name == "Player")
        {
            GameObject.Find("Game Manager").GetComponent<Game>().isGameOver = true;
            Destroy(collision.gameObject);
        } else if (collision.gameObject.tag == "Planet")
        {
            Destroy(transform.gameObject);
        }
    }

}
