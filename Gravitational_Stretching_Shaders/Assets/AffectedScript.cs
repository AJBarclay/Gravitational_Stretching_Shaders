using System.Collections;
using System.Collections.Generic;
using System;
using UnityEngine;

public class AffectedScript : MonoBehaviour
{
	public GameObject Source;
    public Material Spaghettify_Material;
	Vector3 Velocity = new Vector3(0,0,0), Acceleration;
	int Cap = 3;
    // Start is called before the first frame update
    void Start()
    {
        GetComponent<Renderer>().sharedMaterial.SetVector("_Vector", new Vector4(0.0f, 0.0f, 0.0f, 1.0f));
    }
	
	int direction(float pos){
		if (pos < 0) return -1;
		if (pos > 0) return 1;
		else return 0;
	}
	
	float gForce(float pos){
		return 1.0F;
		float gConstant = 1.0F;
		if (pos == 0) return 0;
		if (pos < 1 && pos > -1) return 0;
		return (gConstant / (pos*pos));
	}
	
	float absDist(float x,float y,float z){
		float a = Mathf.Sqrt(Mathf.Pow(x,2) + Mathf.Pow(y,2));
		a = Mathf.Sqrt(Mathf.Pow(a,2) + Mathf.Pow(z,2));
		return a;
	}

    float distance(Vector3 to, Vector3 from)
    {
        float toReturn = 0.0f;

        toReturn = Mathf.Sqrt(Mathf.Pow((to.x - from.x), 2) + Mathf.Pow((to.y - from.y), 2) + Mathf.Pow((to.z - from.z), 2));

        return toReturn;
    }
	
    // Update is called once per frame
    void Update()
    {


    float xPos, yPos, zPos, t, tolerance;
		t = Time.time/300;
        tolerance = 0.1f;
		Vector3 diffPos = (Source.transform.position - transform.position);
		float absDiff = absDist(diffPos.x,diffPos.y,diffPos.z);
		xPos = gForce(diffPos.x)*direction(diffPos.x);
		yPos = gForce(diffPos.y)*direction(diffPos.y);
		zPos = gForce(diffPos.z)*direction(diffPos.z);
		Debug.Log("Difference Position: "+diffPos);
		Acceleration = new Vector3(xPos,yPos,zPos);
		Debug.Log("Acc:"+Acceleration);
		Velocity = Velocity + new Vector3(Acceleration.x*t,Acceleration.y*t,Acceleration.z*t);
		if (Velocity.x > Cap) Velocity.x = Cap;
		if (Velocity.y > Cap) Velocity.y = Cap;
		if (Velocity.z > Cap) Velocity.z = Cap;
		if (Velocity.x < -Cap) Velocity.x = -Cap;
		if (Velocity.y < -Cap) Velocity.y = -Cap;
		if (Velocity.z < -Cap) Velocity.z = -Cap;
		
		Debug.Log("Velocity: "+Velocity);
        Vector3 oldTransform = transform.position;
		transform.position = transform.position	+ new Vector3(Velocity.x*t,Velocity.y*t,Velocity.z*t);
        float oldDistance = distance(Source.transform.position, oldTransform);
        float newDistance = distance(Source.transform.position, transform.position);
        if (newDistance - oldDistance > tolerance)
        {
            transform.position = Source.transform.position;
            transform.localScale = new Vector3(0.01f, 0.01f, 0.01f);
        }
        GetComponent<Renderer>().sharedMaterial.SetVector("_Vector", Source.transform.position);
        //transform.position = Source.transform.position + new Vector3(xPos,yPos,zPos);
    }
}

