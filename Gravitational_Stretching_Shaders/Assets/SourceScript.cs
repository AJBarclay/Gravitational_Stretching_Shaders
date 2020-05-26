using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class SourceScript : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
    }

    // Update is called once per frame
    void Update()
    {	
        Color color = new Color(1,0,0,1);
        Shader.SetGlobalColor("_GlobalColor",color);
    }
}
