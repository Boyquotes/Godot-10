using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Background : MonoBehaviour {
    public GameObject player;

    // If a planet/player leaves the trigger area, delete those objects
    private void OnTriggerExit2D(Collider2D collision)
    {
        if (collision.gameObject.name == "Player")
        {
            GameObject.Find("Game Manager").GetComponent<Game>().isGameOver = true;
        }
    }
}
