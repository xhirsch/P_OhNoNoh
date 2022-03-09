using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DeckardRender;

namespace DeckardRender
{

    [ExecuteInEditMode]
    public class SetCameraParameters : MonoBehaviour
    {

        public DeckardRender deckardRender;
        [SerializeField]
        public float focusDistance = 5f;
        [SerializeField]
        [Range(0.6f, 24f)]
        public float aperture = 1f;

        // Start is called before the first frame update
        void Start()
        {

        }

        // Update is called once per frame
        void LateUpdate()
        {
            if (deckardRender != null)
            {
                deckardRender.focusDistance = focusDistance;
                deckardRender.fStop = aperture;
            }
        }
    }
}
