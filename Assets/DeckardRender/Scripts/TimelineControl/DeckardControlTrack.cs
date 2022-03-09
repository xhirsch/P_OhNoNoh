using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

[Serializable]
public class DeckardControlTrack : PlayableAsset, ITimelineClipAsset
{
    [SerializeField]
    private DeckardControlBehaviour template = new DeckardControlBehaviour();



    public ClipCaps clipCaps
    {
        get
        {
            return ClipCaps.Blending;
        }
        
        
}

    public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
    {
        return ScriptPlayable<DeckardControlBehaviour>.Create(graph, template);
    }
}
