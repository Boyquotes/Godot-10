using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor.SceneManagement;

public class Game : MonoBehaviour {
    public GameObject player;
    public GameObject gameOverScreen;

    public bool isGameOver = false;
	
	// Update is called once per frame
	void Update () {
		if (isGameOver == true)
        {
            // Let the game over screen appear is player has collided w/ the goal planet
            gameOverScreen.GetComponent<SpriteRenderer>().enabled = true;

            // TODO temproary restart button for testing
            if (Input.GetKeyDown(KeyCode.Return))
            {
                EditorSceneManager.LoadScene(EditorSceneManager.GetActiveScene().name);
            }
        }
	}
}
