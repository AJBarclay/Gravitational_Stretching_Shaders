using System;
using System.Collections;
using System.Collections.Generic;
using Cinemachine;
using UnityEngine;
using UnityEngine.UIElements;

public class EnableCinemaCam : MonoBehaviour
{
    public CinemachineBrain cam;

    private void Start()
    {
        cam.enabled = true;
    }

    public void toggleValuedChanged(bool val)
    {
        cam.enabled = val;
    }
}
