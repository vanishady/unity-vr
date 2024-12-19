using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace MimicSpace
{
    public class Leg : MonoBehaviour
    {
        Mimic myMimic;
        public bool isDeployed = false;
        public Vector3 footPosition;
        public float maxLegDistance;
        public int legResolution;
        //public GameObject legObject;
        public LineRenderer legLine;
        public int handlesCount = 8; // 8 (7 legs + 1 finalfoot)

        public float legMinHeight;
        public float legMaxHeight;
        float legHeight;
        public Vector3[] handles;
        public float handleOffsetMinRadius;
        public float handleOffsetMaxRadius;
        public Vector3[] handleOffsets;
        public float finalFootDistance;

        public float growCoef;
        public float growTarget = 1;

        [Range(0, 1f)]
        public float progression;

        bool isRemoved = false;
        bool canDie = false;
        public float minDuration;

        [Header("Rotation")]
        public float rotationSpeed;
        public float minRotSpeed;
        public float maxRotSpeed;
        float rotationSign = 1;
        public float oscillationSpeed;
        public float minOscillationSpeed;
        public float maxOscillationSpeed;
        float oscillationProgress;

        public Color myColor;

        public void Initialize(Vector3 footPosition, int legResolution, float maxLegDistance, float growCoef, Mimic myMimic, float lifeTime)
        {
            myColor = new Color(Random.Range(0, 1f), Random.Range(0, 1f), Random.Range(0, 1f));
            this.footPosition = footPosition;
            this.legResolution = legResolution;
            this.maxLegDistance = maxLegDistance;
            this.growCoef = growCoef;
            this.myMimic = myMimic;

            this.legLine = GetComponent<LineRenderer>();
            handles = new Vector3[handlesCount];

            // We initialize a bunch of random offsets for many aspects of the legs so every leg part is unique
            // This will make the leg look more organic
            handleOffsets = new Vector3[6];
            handleOffsets[0] = Random.onUnitSphere * Random.Range(handleOffsetMinRadius, handleOffsetMaxRadius);
            handleOffsets[1] = Random.onUnitSphere * Random.Range(handleOffsetMinRadius, handleOffsetMaxRadius);
            handleOffsets[2] = Random.onUnitSphere * Random.Range(handleOffsetMinRadius, handleOffsetMaxRadius);
            handleOffsets[3] = Random.onUnitSphere * Random.Range(handleOffsetMinRadius, handleOffsetMaxRadius);
            handleOffsets[4] = Random.onUnitSphere * Random.Range(handleOffsetMinRadius, handleOffsetMaxRadius);
            handleOffsets[5] = Random.onUnitSphere * Random.Range(handleOffsetMinRadius, handleOffsetMaxRadius);

            // each leg part have the same foot position, butto make it look like "toes" the last handle (handles[7])
            // is a bit offset for every leg part
            Vector2 footOffset = Random.insideUnitCircle.normalized * finalFootDistance;
            RaycastHit hit;
            Physics.Raycast(footPosition + Vector3.up * 5f + new Vector3(footOffset.x, 0, footOffset.y), -Vector3.up, out hit);
            handles[7] = hit.point;

            legHeight = Random.Range(legMinHeight, legMaxHeight);
            rotationSpeed = Random.Range(minRotSpeed, maxRotSpeed); // * (Random.Range(0f, 1f) > 0.5f ? -1 : 1);
            rotationSign = 1;//(Random.Range(0f, 1f) > 0.5f ? -1 : 1);
            oscillationSpeed = Random.Range(minOscillationSpeed, maxOscillationSpeed);
            oscillationProgress = 0;

            myMimic.legCount++;
            growTarget = 1;

            isRemoved = false;
            canDie = false;
            isDeployed = false;
            StartCoroutine("WaitToDie");
            StartCoroutine("WaitAndDie", lifeTime);
            Sethandles();
        }

        IEnumerator WaitToDie()
        {
            yield return new WaitForSeconds(minDuration);
            canDie = true;
        }

        IEnumerator WaitAndDie(float lifeTime)
        {
            yield return new WaitForSeconds(lifeTime);
            while (myMimic.deployedLegs < myMimic.minimumAnchoredParts)
                yield return null;
            growTarget = 0;
        }

        private void Update()
        {
            // The growTarget is set to 1 if the leg must grow, and 0 if it must retract
            if (growTarget == 1 && Vector3.Distance(new Vector3(myMimic.legPlacerOrigin.x, 0, myMimic.legPlacerOrigin.z), new Vector3(footPosition.x, 0, footPosition.z)) > maxLegDistance && canDie && myMimic.deployedLegs > myMimic.minimumAnchoredParts)
                growTarget = 0;
            else if (growTarget == 1)
            {
                // Check is the body is in line of sight from the foot position, and initiates the retractation if it isn't
                RaycastHit hit;
                if (Physics.Linecast(footPosition, transform.position, out hit))
                {
                    growTarget = 0;
                }
            }
            // progression defines the percentage of deployement (1 being fully deployed and 0 fully retracted)
            progression = Mathf.Lerp(progression, growTarget, growCoef * Time.deltaTime);

            // we signal the leg deployement to the Mimic for the leg spawn logic
            if (!isDeployed && progression > 0.9f)
            {
                myMimic.deployedLegs++;
                isDeployed = true;
            }
            else if (isDeployed && progression < 0.9f)
            {
                myMimic.deployedLegs--;
                isDeployed = false;
            }
            if (progression < 0.5f && growTarget == 0)
            {
                if (!isRemoved)
                {
                    GetComponentInParent<Mimic>().legCount--;
                    isRemoved = true;
                }

                if (progression < 0.05f)
                {
                    //StopAllCoroutines();
                    legLine.positionCount = 0;
                    myMimic.RecycleLeg(this.gameObject);
                    return;
                }

            }

            // We update the handle position defining the spline
            Sethandles();

            // Then sample the spline and assign the values to the line renderer
            Vector3[] points = GetSamplePoints((Vector3[])handles.Clone(), legResolution, progression);
            legLine.positionCount = points.Length;
            legLine.SetPositions(points);
        }

        void Sethandles()
        {
            // Start handle at body position
            handles[0] = transform.position;

            // The foot position is moved upward,
            // in combination with the Handles[7] offset it will look like an "ankle"
            handles[6] = footPosition + Vector3.up * 0.05f;

            // we take a point 40% along the leg and raise it to make the highest part of the leg
            handles[2] = Vector3.Lerp(handles[0], handles[6], 0.4f);
            handles[2].y = handles[0].y + legHeight;

            // then we interpolate the rest of the handles
            handles[1] = Vector3.Lerp(handles[0], handles[2], 0.5f);
            handles[3] = Vector3.Lerp(handles[2], handles[6], 0.25f);
            handles[4] = Vector3.Lerp(handles[2], handles[6], 0.5f);
            handles[5] = Vector3.Lerp(handles[2], handles[6], 0.75f);

            // we rotate the handles offsets based on the leg axis to make them look alive
            RotateHandleOffset();

            // and we apply the offsets to the handle position
            handles[1] += handleOffsets[0];
            handles[2] += handleOffsets[1];
            handles[3] += handleOffsets[2];
            handles[4] += handleOffsets[3] / 2f;
            handles[5] += handleOffsets[4] / 4f;
        }

        void RotateHandleOffset()
        {
            oscillationProgress += Time.deltaTime * oscillationSpeed;
            if (oscillationProgress >= 360f)
                oscillationProgress -= 360f;

            float newAngle = rotationSpeed * Time.deltaTime * Mathf.Cos(oscillationProgress * Mathf.Deg2Rad) + 1f;

            Vector3 axisRotation;
            for (int i = 1; i < 6; i++)
            {
                axisRotation = (handles[i + 1] - handles[i - 1]) / 2f;
                handleOffsets[i - 1] = Quaternion.AngleAxis(newAngle, rotationSign * axisRotation) * handleOffsets[i - 1];
            }

        }

        Vector3[] GetSamplePoints(Vector3[] curveHandles, int resolution, float t)
        {
            List<Vector3> segmentPos = new List<Vector3>();
            float segmentLength = 1f / (float)resolution;

            for (float _t = 0; _t <= t; _t += segmentLength)
                segmentPos.Add(GetPointOnCurve((Vector3[])curveHandles.Clone(), _t));
            segmentPos.Add(GetPointOnCurve(curveHandles, t));
            return segmentPos.ToArray();
        }

        Vector3 GetPointOnCurve(Vector3[] curveHandles, float t)
        {
            int currentPoints = curveHandles.Length;

            while (currentPoints > 1)
            {
                for (int i = 0; i < currentPoints - 1; i++)
                    curveHandles[i] = Vector3.Lerp(curveHandles[i], curveHandles[i + 1], t);
                currentPoints--;
            }
            return curveHandles[0];
        }
    }
}