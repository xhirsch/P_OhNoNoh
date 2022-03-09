using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using DeckardRender;
using System.Reflection;

[ExecuteInEditMode]
public class ReflectionProbeOptimizer : MonoBehaviour
{
    public ReflectionProbe rProbe;
    public bool UseOptimization = true;
    
    // Start is called before the first frame update
    void Start()
    {
       
        rProbe = GetComponent<ReflectionProbe>();
        if (rProbe.mode == ReflectionProbeMode.Realtime)
        {
            rProbe.refreshMode = ReflectionProbeRefreshMode.ViaScripting;
        }

    }

    // Update is called once per frame
    public void RenderProbe()
    {
        if (UseOptimization && rProbe.mode == ReflectionProbeMode.Realtime)
        {
            rProbe.RenderProbe();
        }

    }
}
