using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnObjectScript : MonoBehaviour
{
    public GameObject sampleObject;

    public void AddObject()
    {
        float spawnXpos = Random.Range(-30.0f, 30.0f);
        float spawnZpos = Random.Range(-30.0f, 30.0f);
        Vector3 spawnPos = new Vector3(spawnXpos, 0.0f, spawnZpos);
        Instantiate(sampleObject, spawnPos, Quaternion.identity);
        this.sampleObject.transform.localScale = new Vector3(1.0f, 1.0f, 1.0f);
    }
    
}
