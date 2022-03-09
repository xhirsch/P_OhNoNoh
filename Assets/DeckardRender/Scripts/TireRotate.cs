using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[ExecuteInEditMode]
public class TireRotate : MonoBehaviour
{
    // Start is called before the first frame update
    public Vector3 oldPosition;
    public float rotationAmount = 1;
    public float flipDirection = 1;

    void Start()
    {
        oldPosition = gameObject.transform.position;
    }

    // Update is called once per frame
    void LateUpdate()
    {
        float distance = Vector3.Distance(oldPosition, gameObject.transform.position) * rotationAmount;
       // float localPos = 
        gameObject.transform.Rotate(distance * flipDirection, 0, 0);
        oldPosition = gameObject.transform.position;
    }
}
