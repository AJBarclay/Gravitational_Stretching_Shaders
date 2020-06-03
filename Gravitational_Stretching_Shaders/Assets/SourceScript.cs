using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;


public class SourceScript : MonoBehaviour
{

    // Start is called before the first frame update
    void Start()
    {
        GetComponent<Renderer>().sharedMaterial.SetVector("_Vector", new Vector4(0.0f,0.0f,0.0f,1.0f));
    }

    // Update is called once per frame
    void Update()
    {
        transform.position = new Vector3((float)(3 * Math.Sin(Time.time)), 0, (float)(3 * Math.Cos(Time.time)));

        //Shader.SetGlobalVector("_Vector", transform.position);

        //GetComponent<Renderer>().material.SetVector("_Vector",new Vector4((float)transform.position.x, (float)transform.position.y, (float)transform.position.z, 1.0f));
        GetComponent<Renderer>().sharedMaterial.SetVector("_Vector", transform.position);
        Debug.Log("GravitatorPos: " + transform.position.x + ", " + transform.position.y + ", " + transform.position.z);
    }
}
