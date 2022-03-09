using UnityEditor;
using UnityEngine;
using System.Collections;
using System;

namespace DeckardRender
{
    public class DeckardRenderWindow : EditorWindow
    {
        
        bool groupEnabled;
        bool myBool = true;
        float myFloat = 1.23f;
        public static DeckardRender deckardRenderComponent;
        public bool mouseMoved = false;
        public float zoom = 1f;
        public Vector2 mousePos = new Vector2(0f, 20f);
        public Vector2 finalMousePos = new Vector2(0f, 0f);
        public Vector2 delta;
        public Texture2D smpte;
        public static EditorWindow EW;

        // Add menu item named "My Window" to the Window menu
        [MenuItem("Deckard Render/Deckard View")]



            public static void ShowWindow()
        {
            //Show existing window instance. If one doesn't exist, make one.
            EW = EditorWindow.GetWindow(typeof(DeckardRenderWindow));
            //   DeckardRenderWindow window = (DeckardRenderWindow)EditorWindow.GetWindow(typeof(DeckardRenderWindow));
            if (deckardRenderComponent == null)
            {
                deckardRenderComponent = FindObjectOfType<DeckardRender>();
            }

        }




        private void OnDestroy()
        {
            DeckardRender.active = false;
        }
        public void OnGUI()
        {
            
            if (Event.current.type == EventType.MouseMove) mouseMoved = false;
            else mouseMoved = true;

            //  GUILayout.Box(Shader.GetGlobalTexture("_AperturePass"), GUILayout.ExpandWidth(true));
            if (deckardRenderComponent != null && deckardRenderComponent.gameObject.activeInHierarchy && deckardRenderComponent.rtDW != null)
            {
                EditorGUILayout.BeginVertical(GUILayout.ExpandHeight(true));
                //   GUILayout.Box(deckardRenderComponent.rtDW);

                Event e = Event.current;


                if (e.button == 0 && e.isMouse)
                {
                    if (e.mousePosition.y <= position.height - 36 && e.mousePosition.y > 36)
                    {
                        mousePos += delta;
                        delta = Vector2.zero;
                    }

                }



                if (e.type == EventType.MouseDrag)
                {
                    delta = e.delta;
                    // delta.y *= -1;  // GUI is y inverted
                }


                Vector2 finalPos = finalMousePos;

                EditorGUI.DrawPreviewTexture(new Rect(mousePos.x, mousePos.y, deckardRenderComponent.rtDW.width * zoom, deckardRenderComponent.rtDW.height * zoom), deckardRenderComponent.rtDW);


                EditorGUILayout.BeginHorizontal(GUILayout.Width(300));

               
                zoom = EditorGUILayout.Slider(new GUIContent("Scale", "Scale viewport."), zoom, 0.1f, 10f);
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.EndVertical();


                EditorGUILayout.BeginVertical();
                EditorGUILayout.BeginHorizontal();
                deckardRenderComponent.batchGroups = EditorGUILayout.IntSlider(new GUIContent("Batch Groups", "This value defines responsivness in editor mode. Greater value gives faster rendering of Deckard View, while smaller values give better response to Unity Interface."), deckardRenderComponent.batchGroups, 1, deckardRenderComponent.maxInteractiveSteps);
                deckardRenderComponent.editorQuality = EditorGUILayout.IntSlider(new GUIContent("Editor Quality", "This value defines rendering quality in editor"), deckardRenderComponent.editorQuality, 1, 200);
                
                if (GUILayout.Button("Save Render Image"))
                {
                    CaptureImage(deckardRenderComponent.rtDW);
                }
                if (GUILayout.Button("Start Rendering"))
                {
                    UnityEditor.EditorApplication.isPlaying = true;
                }
                deckardRenderComponent.zebras = EditorGUILayout.ToggleLeft(new GUIContent("Zebras", "Show Zebras"), deckardRenderComponent.zebras);
              //  deckardRenderComponent.focusAssist = EditorGUILayout.ToggleLeft(new GUIContent("Focus peaking", "Show Zebras"), deckardRenderComponent.focusAssist);
                // deckardRenderComponent.batchGroups = EditorGUILayout.IntSlider(new GUIContent("Batch Groups", "This value defines responsivness in editor mode. Greater value gives faster rendering of Deckard View, while smaller values give better response to Unity Interface."), deckardRenderComponent.batchGroups, 1, deckardRenderComponent.maxInteractiveSteps);
                EditorGUILayout.EndHorizontal();

                //     myBool = EditorGUILayout.Toggle("Interactive Render", myBool);
                if (myBool && !EditorApplication.isPlaying) DeckardRender.active = true;
                else DeckardRender.active = false;

                EditorGUILayout.EndVertical();
                if (deckardRenderComponent.optimizedSpeedRendering)
                {
                    EditorGUI.ProgressBar(new Rect(3, 3, position.width - 6, 2), (DeckardRender.curentOptimizedSteps + 0f) / (deckardRenderComponent.finalSteps * 2f), " ");
                }
                else EditorGUI.ProgressBar(new Rect(3, 3, position.width - 6, 2), (DeckardRender.curentOptimizedSteps + 0f) / (deckardRenderComponent.maxInteractiveSteps * 2f), " ");
                UnityEditorInternal.InternalEditorUtility.RepaintAllViews();
            }

            else
            {
                if (smpte == null)
                    smpte = Resources.Load("testPatternSMPTE") as Texture2D;
                EditorGUI.DrawPreviewTexture(new Rect(mousePos.x, mousePos.y, smpte.width * zoom, smpte.height * zoom), smpte);
                UnityEditorInternal.InternalEditorUtility.RepaintAllViews();

                EditorGUILayout.BeginHorizontal(GUILayout.Width(300));


                zoom = EditorGUILayout.Slider(new GUIContent("Scale", "Scale viewport."), zoom, 0.1f, 10f);
                EditorGUILayout.EndHorizontal();
            }
        }

        private void StartRendering()
        {
            throw new NotImplementedException();
        }

        public void CaptureImage(RenderTexture wcam)
        {
            Texture2D finalTexture = new Texture2D(wcam.width, wcam.height);
            RenderTexture rt = new RenderTexture(wcam.width, wcam.height, 32);
            Graphics.Blit(wcam, rt);
            RenderTexture.active = rt;
            finalTexture.ReadPixels(new Rect(0, 0, wcam.width, wcam.height), 0, 0);
            finalTexture.Apply();
            byte[] _bytes = finalTexture.EncodeToPNG();
            string datestamp = DateTime.Now.ToString("yyyy_MM_dd_hh_mm_ss");
            System.IO.File.WriteAllBytes("Assets/DeckardRender/Captures/capture_" + datestamp +".png", _bytes);

#if UNITY_EDITOR
            AssetDatabase.ImportAsset("Assets/DeckardRender/Captures/capture_" + datestamp + ".png", ImportAssetOptions.ForceUpdate);
            Debug.Log("IMAGE SAVED IN:  Assets/DeckardRender/Captures/capture_" + datestamp + ".png");
#endif
        }



        public void Update()
        {
            // This is necessary to make the framerate normal for the editor window.
            Repaint();
            if (deckardRenderComponent == null || !deckardRenderComponent.gameObject.activeInHierarchy)
            {
                DeckardRender[] deckardRenders = FindObjectsOfType<DeckardRender>();
                if (deckardRenders.Length > 1)
                {

                    for (int i = 0; i < deckardRenders.Length; i++)
                    {
                        if (deckardRenders[i].gameObject.activeInHierarchy)
                        {
                            deckardRenderComponent = deckardRenders[i];
                            break;
                        }
                    }
                }
                else if (deckardRenders.Length == 1)
                {
                    if (deckardRenders[0].gameObject.activeInHierarchy)
                    {
                        deckardRenderComponent = deckardRenders[0];
                    }
                }
            }
            //   Debug.Log(deckardRenderComponent +" "+ deckardRenderComponent.active);
        }

        public void OnMouseDrag()
        {
            mousePos += delta;
            Debug.Log(mousePos);
            // This is necessary since the EventType.MouseDrag event in OnGUI
            // is only fired when the mouse moves, so the delta is never 0
            delta = Vector2.zero;
        }
    }
}

