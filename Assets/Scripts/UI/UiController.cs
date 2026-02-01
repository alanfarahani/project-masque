using UnityEngine;
using UnityEngine.UIElements;
using Unity.VisualScripting;

public class UiController: MonoBehaviour
{
    private UIDocument document;

    //private string chooseCharacterText = "Choose a character.";

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
    public VisualElement character1 {get; private set;}
    public VisualElement speakingNpcContainer {get; private set;}
    public VisualElement playerDialogOption {get; private set;}

    public VisualElement charSelectionContainer {get; private set;}

    public VisualElement conversationContainer {get; private set;}

    public VisualElement charJoanne {get; private set;}
    public VisualElement charKevin {get; private set;}
    public VisualElement charVanessa {get; private set;}

    [SerializeField]
    public Sprite KevinImg;
    public Sprite VanessaImg;
    public Sprite JoanneImg;

    public void exposeGameStartUI()
    {
        document = GetComponent<UIDocument>();

        mainContainer = document.rootVisualElement.Q("mainContainer");

        character1 = document.rootVisualElement.Q("character1");
        
        speakingNpcContainer = document.rootVisualElement.Q("speakingNpcContainer");

        playerDialogOption = document.rootVisualElement.Q("playerDialogOption");

        charSelectionContainer = document.rootVisualElement.Q("charSelectionContainer");

        conversationContainer = document.rootVisualElement.Q("conversationContainer");

        charJoanne = document.rootVisualElement.Q("charJoanne");

        charKevin = document.rootVisualElement.Q("charKevin");

        charVanessa = document.rootVisualElement.Q("charVanessa");
    }

    void Awake()
    {
        exposeGameStartUI();

        //SetCharacterText(chooseCharacterText);

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

    public void ClearCharacterText()
    {
        mainContainer.Q("characterText").Clear();
    }

    public void CreateChoice(string text)
    {
        //class: choice-button
        VisualElement question = new VisualElement();
        question.AddToClassList("choice-button");

        Label question_text = new Label(text);
        question.Add(question_text);

        playerDialogOption.Add(question);
        
    }

}

