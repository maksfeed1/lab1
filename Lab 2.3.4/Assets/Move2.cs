using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Move2 : MonoBehaviour
{

    private Rigidbody rigidbody;
    public float force;
    // Start is called before the first frame update
    void Start()
    {
        rigidbody = GetComponent<Rigidbody>();
    }

    // Update is called once per frame
    void Update()
    {
        float x = Input.GetAxis("Horizontal") * force * Time.deltaTime;
        float z = Input.GetAxis("Vertical") * force * Time.deltaTime;

        rigidbody.AddForce(x, 0, z);
    }
}