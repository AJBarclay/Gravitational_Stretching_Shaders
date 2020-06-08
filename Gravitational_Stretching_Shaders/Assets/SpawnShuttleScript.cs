using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnShuttleScript : MonoBehaviour
{
    public GameObject shuttleObject;

    public void AddObject()
    {
        float spawnXpos = Random.Range(-30.0f, 30.0f);
        float spawnZpos = Random.Range(-30.0f, 30.0f);
        Vector3 spawnPos = new Vector3(spawnXpos, 0.0f, spawnZpos);
        Instantiate(shuttleObject, spawnPos, Quaternion.identity);
        this.shuttleObject.transform.localScale = new Vector3(2.0f, 2.0f, 2.0f);
    }

}
