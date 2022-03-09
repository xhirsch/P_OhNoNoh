using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DeckardRender;


namespace DeckardRender
{
    [CreateAssetMenu(fileName = "NewFilmTransfeStyle", menuName = "DeckardRender/NewFilmTransferStyle")]

    public class FilmTransferStyle : ScriptableObject
    {
        [Range(0f, 2f)]
        public float saturation = 1f;
        [Range(0f, 2f)]
        public float RContrast = 1f;
        [Range(0f, 2f)]
        public float GContrast = 1f;
        [Range(0f, 2f)]
        public float BContrast = 1f;

        [Range(0f, 1f)]
        public float RMidpoint = 0.5f;
        [Range(0f, 1f)]
        public float GMidpoint = 0.5f;
        [Range(0f, 1f)]
        public float BMidpoint = 0.5f;


        
        [Range(0f, 10f)]
        public float filmScattering = 1f;
        [Range(0f, 1f)]
        public float channelOffset = 0.4f;
        [Range(4, 32)]
        public int directions = 4;
        [Range(0f, 30f)]
        public float halationSize = 0f;
        [Range(1f, 30f)]
        public float filmScatteringQuality = 1f;
        public float HalationIntensity = 0.68f;
        

        public Vector4 noiseResponse;
        [Range(0f, 1.2f)]
        public float grainScale = 0.61f;
        [Range(0f, 1f)]
        public float NoiseAmount = 0.1f;


    }
}
