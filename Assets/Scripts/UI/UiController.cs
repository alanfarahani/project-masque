using UnityEngine;
using UnityEngine.UIElements;

public class UiController: MonoBehaviour
{
    private UIDocument document;

    private string chooseCharacterText = "Choose a character.";

    private string jjText = 
@"You know, if you want people to like you more, you could try flirting with them a little.

Not that I need to.  

I mean, have you seen my sportsball numbers?";

    private string vanessaText = 
@"You know babe, maybe be more like me?

Know what I mean?

Like, people like people who are into people.";

    private string kevinText = 
@"You know what makes you cool?

If other people think you like them.

Keep that in mind.";

	//game start is really debug, TODO update this
	public VisualElement mainContainer { get; private set; }

    public void exposeGameStartUI()
    {
        mainContainer = GetComponent<UIDocument>().rootVisualElement.Q("mainContainer");
    }

    void Awake()
    {
        exposeGameStartUI();

        SetCharacterText(chooseCharacterText);

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
        
        switch (button.name)
        {
            case "characterButton0": 
                SetCharacterText(jjText);
                EnableMask(3);
                break;
            case "characterButton1": 
                SetCharacterText(vanessaText);
                EnableMask(3);
                break;
            case "characterButton2": 
                SetCharacterText(kevinText);
                EnableMask(3);
                MarkCharacterCompleted(2);
                break;
            default:
                break;
        }
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

    public void SetCharacterText(string text)
    {
        var label = mainContainer.Q("characterText") as Label;

        if (label == null)
        {
            return;
        }

        label.text = text;
    }
}

