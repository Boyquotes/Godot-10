using UnityEngine;
using System.Linq;

namespace Pathfinding
{
    /** Moves the target in example scenes.
	 * This is a simple script which has the sole purpose
	 * of moving the target point of agents in the example
	 * scenes for the A* Pathfinding Project.
	 *
	 * It is not meant to be pretty, but it does the job.
	 */

    public class TargetBehavior : MonoBehaviour
    {
        /** Mask for the raycast placement */
        public LayerMask mask;

        public Transform target;
        IAstarAI[] ais;


        Camera cam;

        public void Start()
        {
            //Cache the Main Camera
            cam = Camera.main;
            // Slightly inefficient way of finding all AIs, but this is just an example script, so it doesn't matter much.
            // FindObjectsOfType does not support interfaces unfortunately.
            ais = FindObjectsOfType<MonoBehaviour>().OfType<IAstarAI>().ToArray();
            useGUILayout = false;
        }

        //public void OnGUI()
        //{
        //    if (cam != null)
        //    {
        //        UpdateTargetPosition();
        //    }
        //}

        /** Update is called once per frame */
        void Update()
        {
            if (cam != null)
            {
                UpdateTargetPosition();
            }
        }

        public void UpdateTargetPosition()
        {
            Vector3 newPosition = target.transform.position;
            bool positionFound = false;

            //newPosition = cam.ScreenToWorldPoint(target.transform.position);
            newPosition.z = 0;
            positionFound = true;

            //if (positionFound && newPosition != target.position)
            if (true)
            {
                target.position = newPosition;


                for (int i = 0; i < ais.Length; i++)
                {
                    if (ais[i] != null) ais[i].SearchPath();
                }
            }
        }
    }
}
