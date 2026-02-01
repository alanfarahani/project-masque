using UnityEngine;
using UnityEngine.UIElements;

public class UiController: MonoBehaviour
{
    private UIDocument document;
	
	//game start is really debug, TODO update this
	public VisualElement mainContainer { get; private set; }

    public void exposeGameStartUI()
    {
        mainContainer = GetComponent<UIDocument>().rootVisualElement.Q("mainContainer");
    }

    void Awake()
    {
        exposeGameStartUI();

        mainContainer.RegisterCallback<ClickEvent>(evt =>
        {            
            var target = evt.target as VisualElement;
            if (target == null)
            {
                return;
            } 

            if (target.ClassListContains("character-button") && !target.ClassListContains("selected") && !target.ClassListContains("completed"))
            {   
                ActivateCharacter(target);
            }
        });

    }

    public void ActivateCharacter(VisualElement button)
    {
        mainContainer.Query(className: "character-button").ForEach(element =>
        {
            if (element.name == button.name)
            {
                element.AddToClassList("selected");
                return;        
            }

            element.RemoveFromClassList("selected");
        });
    }

    public void EnableMask(int index)
    {
        if (index < 0 || index > 3)
        {
            return;
        }

        mainContainer.Q("mask"+index).RemoveFromClassList("hidden");
    }

    public void MarkCharacterCompleted(int index)
    {
        if (index < 0 || index > 2)
        {
            return;
        }

        var buttonName = "characterButton" + index;
        mainContainer.Q(buttonName).RemoveFromClassList("selected");
        mainContainer.Q(buttonName).AddToClassList("completed");        
    }
}

