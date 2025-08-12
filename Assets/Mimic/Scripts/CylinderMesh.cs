using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace MimicSpace
{
    public class CylinderMesh : MonoBehaviour
    {
        LineRenderer myLine;
        public int verticeCount;
        public float angle;

        MeshFilter myFilter;
        Mesh mesh;

        void Start()
        {
            myLine = GetComponent<LineRenderer>();
            myFilter = GetComponent<MeshFilter>();
            mesh = new Mesh();
            myFilter.sharedMesh = mesh;
        }

        IEnumerator WaitIt()
        {
            yield return new WaitForSeconds(1f);
            BuildMesh();
        }

        void BuildMesh()
        {
            mesh.Clear();
            angle = 360f / verticeCount;
            List<Vector3> vertices = new List<Vector3>();
            List<int> triangles = new List<int>();

            Vector3 circleNormal;
            Vector3 perpendicularVector;

            // Set Vertices
            for (int i = 0; i < myLine.positionCount - 1; i++)
            {
                circleNormal = (myLine.GetPosition(i + 1) - myLine.GetPosition(i)).normalized;
                perpendicularVector = Vector3.Cross(circleNormal, Vector3.up) * (myLine.widthCurve.Evaluate((float)i / (float)myLine.positionCount) / 2f);
                Quaternion verticeRotation = Quaternion.AngleAxis(angle, circleNormal);

                for (int j = 0; j < verticeCount; j++)
                {
                    vertices.Add(transform.InverseTransformPoint(perpendicularVector + myLine.GetPosition(i)));
                    perpendicularVector = verticeRotation * perpendicularVector;
                }
            }
            vertices.Add(transform.InverseTransformPoint(myLine.GetPosition(myLine.positionCount - 1)));

            // Set Triangles
            for (int i = 0; i < myLine.positionCount - 2; i++)
            {
                for (int j = 0; j < verticeCount; j++)
                {
                    triangles.Add(i * verticeCount + j);
                    triangles.Add(i * verticeCount + 1 + j);
                    triangles.Add((i + 1) * verticeCount + j);

                    triangles.Add((i + 1) * verticeCount + j);
                    triangles.Add(i * verticeCount + 1 + j);
                    triangles.Add((i + 1) * verticeCount + j + 1);
                }
            }

            int offset = (myLine.positionCount - 2) * verticeCount;

            for (int i = 1; i < verticeCount; i++)
            {
                triangles.Add(offset + i - 1);
                triangles.Add(offset + i);
                triangles.Add(vertices.Count - 1);
            }

            mesh.vertices = vertices.ToArray();
            mesh.triangles = triangles.ToArray();
            mesh.RecalculateNormals();
        }

        void Update()
        {
            BuildMesh();
        }
    }

}
