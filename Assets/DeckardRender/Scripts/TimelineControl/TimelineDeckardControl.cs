using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Timeline;
using DeckardRender;
using UnityEngine.Playables;

namespace DeckardRender {

    [TrackColor(0, 1, 0)]
    [TrackBindingType(typeof(DeckardRender))]
    [TrackClipType(typeof(DeckardControlTrack))]
    public class TimelineDeckardControl : TrackAsset
    {
        public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
        {
            return ScriptPlayable<DeckardMixer>.Create(graph, inputCount);
        }

    }
}
