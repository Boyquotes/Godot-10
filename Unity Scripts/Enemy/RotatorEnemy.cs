using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RotatorEnemy : Enemy
{
    public float rotateSpeed = 5f;

    private int randRotate;

    // Initialize variables
    private void Start()
    {
        randRotate = Random.Range(0, 2); // Used to randomly pick a direction for enemy to rotate
    }

    // Update is called once per frame
    void Update()
    {
        OrientEnemy();
        RotateEnemy();
    }

    // Responsible for rotating the enemy around a planet
    private void RotateEnemy()
    {
        Vector3 zAxis = new Vector3(0, 0, 1);
        float tempSpeed;

        if (randRotate == 0)
        {
            tempSpeed = -rotateSpeed;
        }
        else
        {
            tempSpeed = rotateSpeed;
        }

        transform.RotateAround(transform.parent.position, zAxis, tempSpeed); // At center of target.position, the transform rotates around the zAxis
    }

    // Orient enemy based on the planet
    private void OrientEnemy()
    {
        // Some voodoo magic I don't quite understand... 
        Vector3 diff = transform.parent.position - transform.position;
        diff.Normalize();

        float rot_z = Mathf.Atan2(diff.y, diff.x) * Mathf.Rad2Deg;
        transform.rotation = Quaternion.Euler(0f, 0f, rot_z + 90);
    }
}
