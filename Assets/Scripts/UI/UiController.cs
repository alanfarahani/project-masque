using UnityEngine;
using UnityEngine.UIElements;

public class UiController
{
    private UIDocument document;
	
	//game start is really debug, TODO update this
	public VisualElement mainContainer { get; private set; }
    
    public UiController(UIDocument doc)
	{
		document = doc;
	}

    public void exposeGameStartUI()
    {
        mainContainer = document.rootVisualElement.Q("mainContainer");
    }



}