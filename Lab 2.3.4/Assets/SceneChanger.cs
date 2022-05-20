using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SceneChanger : MonoBehaviour
{
    public int _sceneNumber;
    public void LootScene(int _sceneNumber)
    {
        SceneManager.LoadScene(_sceneNumber);
    }
}

