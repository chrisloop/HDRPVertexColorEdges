using UnityEngine;
[ExecuteInEditMode]
public class WorldPos : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        Shader.SetGlobalVector("_WorldPos", transform.position);
    }
}
