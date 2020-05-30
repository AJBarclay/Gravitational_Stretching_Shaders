using System.Collections;
using System.Collections.Generic;
using System;
using UnityEngine;

public class AffectedScript : MonoBehaviour
{
	public GameObject Source;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        transform.position = Source.transform.position + 
		new Vector3(3*((float)Math.Sin(Time.time)),0,3*((float)-Math.Cos(Time.time)));
    }
}
