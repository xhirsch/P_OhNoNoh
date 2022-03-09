using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;
using DeckardRender;

namespace DeckardRender
{
    public class DeckardMixer : PlayableBehaviour
    {
        private DeckardRender deckard;

        public override void ProcessFrame(Playable playable, FrameData info, object playerData)
        {
            deckard = playerData as DeckardRender;
            if (deckard == null)
                return;
            int inputCount = playable.GetInputCount();

            float focusDistance = 0f;
            float aperture = 0f;
            float totalWeight = 0f;

            for (int i = 0; i < inputCount; i++)
            {
                float inputWeight = playable.GetInputWeight(i);
                ScriptPlayable<DeckardControlBehaviour> inputPlayable = (ScriptPlayable<DeckardControlBehaviour>)playable.GetInput(i);
                DeckardControlBehaviour behaviour = inputPlayable.GetBehaviour();
                focusDistance += behaviour.focusDistance * inputWeight;
                aperture += behaviour.aperture * inputWeight;
                totalWeight += inputWeight;
            }

            deckard.focusDistance = focusDistance;
            deckard.fStop = aperture;

            base.ProcessFrame(playable, info, playerData);
        }
    }
}
