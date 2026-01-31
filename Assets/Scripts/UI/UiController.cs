using UnityEngine;
using UnityEngine.UIElements;

public class UiController
{
    private UIDocument document;
	
	//game start is really debug, TODO update this
	public mainContainer MainContainer { get; private set; }
    
    public UiController(UIDocument doc)
	{
		document = doc;
	}

    public void exposeGameStartUI()
    {
        MainContainer = document.rootVisualElement.Q("mainContainer");
    }



}