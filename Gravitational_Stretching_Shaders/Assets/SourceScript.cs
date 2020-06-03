using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;


public class SourceScript : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
    }

    // Update is called once per frame
    void Update()
    {
        transform.position = new Vector3((float)(3 * Math.Sin(Time.time)), 0, (float)(3 * Math.Cos(Time.time)));
        Shader.SetGlobalVector("_Vector", transform.position);
        
    }
}
