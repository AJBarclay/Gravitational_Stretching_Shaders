using System.Collections;
using System.Collections.Generic;
using System;
using UnityEngine;

public class AffectedScript : MonoBehaviour
{
<<<<<<< HEAD
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
=======
	public GameObject Source;
	Vector3 Velocity = new Vector3(0,0,0), Acceleration;
	int Cap = 3;
    // Start is called before the first frame update
    void Start()
    {
        
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
	
    // Update is called once per frame
    void Update()
    {	
	
		Shader.SetGlobalVector("_Source",Source.transform.position);
		float xPos, yPos, zPos, t;
		t = Time.time/300;
		Vector3 diffPos = (Source.transform.position - transform.position);
		float absDiff = absDist(diffPos.x,diffPos.y,diffPos.z);
		xPos = gForce(diffPos.x)*direction(diffPos.x);
		yPos = gForce(diffPos.y)*direction(diffPos.y);
		zPos = gForce(diffPos.z)*direction(diffPos.z);
		Debug.Log("Difference Position: "+diffPos);
		Acceleration = new Vector3(xPos,yPos,zPos);
		Debug.Log("Acc:"+Acceleration);
		Velocity = Velocity +
			new Vector3(Acceleration.x*t,Acceleration.y*t,Acceleration.z*t);
		if (Velocity.x > Cap) Velocity.x = Cap;
		if (Velocity.y > Cap) Velocity.y = Cap;
		if (Velocity.z > Cap) Velocity.z = Cap;
		if (Velocity.x < -Cap) Velocity.x = -Cap;
		if (Velocity.y < -Cap) Velocity.y = -Cap;
		if (Velocity.z < -Cap) Velocity.z = -Cap;
		
		Debug.Log("Velocity: "+Velocity);
		transform.position = transform.position 
			+ new Vector3(Velocity.x*t,Velocity.y*t,Velocity.z*t);
        //transform.position = Source.transform.position + new Vector3(xPos,yPos,zPos);
    }
}
>>>>>>> 14a065022e37f41d6bfc88cd42b225f0825281d1
