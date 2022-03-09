using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;
using DeckardRender;

[Serializable]
public class DeckardControlBehaviour : PlayableBehaviour
{
    [SerializeField]
    public float focusDistance = 60f;
    [SerializeField]
    public float aperture = 1f;

    public override void ProcessFrame(Playable playable, FrameData info, object playerData)
    {
        var deckard = playerData as DeckardRender.DeckardRender;
        if (deckard == null)
        {
            return;
        }

       
    }
}
