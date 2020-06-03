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
        new Vector3(((float)Math.Sin(Time.time))/100.0f, 0,  ((float)-Math.Cos(Time.time))/100.0f);
    }
}