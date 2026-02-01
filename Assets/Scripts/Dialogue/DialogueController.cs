using System;
using System.Collections;
using Ink.Runtime;
using Unity.VectorGraphics;
using UnityEngine;
using UnityEngine.UIElements;

public class DialogueController : MonoBehaviour
{
   	[SerializeField]
	private TextAsset inkJSONAsset = null;

    public Story story;
    public static event Action<Story> OnCreateStory;

	private ElemAnims animElem;
	private TagOperations fmtTag;
	private SceneChanger changeScene;
	private UiController uiItems;

    void Awake()
    {
		fmtTag = new TagOperations();
		animElem = new ElemAnims();
		changeScene = new SceneChanger(this);
		uiItems = GameObject.FindGameObjectsWithTag("mainUI")[0].GetComponent<UiController>();

        StartGame();
    }

    private void StartGame () {
		
		story = new Story(inkJSONAsset.text);

		SceneChanger.currentGamePhase = "character-selection";

		if (OnCreateStory != null) OnCreateStory(story);

		//uiItems.exposeGameStartUI();

		AdvanceStory();
	}

    	
	public void AdvanceStory()
	{
		StartCoroutine(StoryContinues());
		
	}

    private IEnumerator StoryContinues()
	{
		
		if (story.canContinue)
		{
			/* To use an ink list item as a parameter
			var propItem = new InkList("Props", story);
			propItem.AddItem("ChoiceText");
			var result = story.EvaluateFunction("EGF_TROLLBRIDGE_server", out string textOutput, propItem);
			Debug.Log("Result: " + textOutput);
			*/

			string current_line = story.Continue();

			// AF Notes: roughly provides the current knot, but probably better to use tags
			// Debug.Log("Previous path string " + story.state.previousPathString);
					
			if (story.currentTags.Count > 0)
			{
				for (int i = 0; i < story.currentTags.Count; i++)
				{
					string this_tag = story.currentTags[i];
									
					string this_tag_type = fmtTag.getTagType(this_tag);
					string this_tag_prop = fmtTag.getTagProp(this_tag);

					Debug.Log(this_tag);
			
					yield return StartCoroutine(changeScene.SceneChange(this_tag_type, this_tag_prop));
				}
			}

			//changeScene.clearTextAreas();
			Debug.Log("Current line " + current_line);
			Debug.Log("Can story continue?" + story.canContinue);

			//fmtText.formatTextandAdvance(current_line, SceneChangeManager.currentGamePhase);

			//CheckNullText();
			
				if (!story.canContinue && story.currentChoices.Count > 0)
				{
					Debug.Log("hit choices");
					DisplayChoices();
				}
				else if(current_line.Trim() == "")
				{
					AdvanceStory();
				}
				else
				{
					Debug.Log("waiting for click");
					//registerClicktoAdvance();
				}
			}
			
			yield return null;
	}
    private void DisplayChoices()
	{

		//unregisterClicktoAdvance();

		var current_choices = story.currentChoices;

		//clearChoiceContainers();

			if (current_choices.Count > 0)
				{
					for (int i = 0; i < current_choices.Count; i++)
					{
						Choice choice = current_choices[i];

						var choice_text = choice.text.Trim();
						Debug.Log("Choice: " + choice_text);
						
						string choice_tag = "";

							if(choice.tags != null)
							{
								foreach (string item in choice.tags)
									{
										Debug.Log("Choice tags: " + item);
										choice_tag = item;
									}	
							}
		
						formatRelevantChoices(choice_text, choice, choice_tag);

					}
			}
	}

	private void formatRelevantChoices(string choice_text, Choice choice, string choice_tag){

		if(SceneChanger.currentGamePhase == "character-selection"){
			formatCharSelect(choice, choice_tag);
		}

		if(SceneChanger.currentGamePhase == "conversation"){
			
		}

	}

	void formatCharSelect(Choice choice, string choice_tag){
		string this_tag_type = fmtTag.getTagType(choice_tag);
		string this_tag_prop = fmtTag.getTagProp(choice_tag);

		if(this_tag_prop == "joanne"){
			uiItems.charJoanne.RegisterCallback<ClickEvent>(evt => OnClickChoiceButton(evt, choice));
		}

		if(this_tag_prop == "kevin"){
			uiItems.charKevin.RegisterCallback<ClickEvent>(evt => OnClickChoiceButton(evt, choice));
		}
		
		if(this_tag_prop == "vanessa"){
			uiItems.charKevin.RegisterCallback<ClickEvent>(evt => OnClickChoiceButton(evt, choice));
		}
	}

    void registerClicktoAdvance(Choice choice, string text)
    {
        Button leave_gear = new Button() { text = text };
		
		leave_gear.RegisterCallback<ClickEvent>(evt => OnClickChoiceButton(evt, choice));
    }

    public void goToKnot(string knot_name)
	{
		story.ChoosePathString(knot_name);
        AdvanceStory();

	}

	private void OnClickChoiceButton(ClickEvent evt, Choice choice) {
		evt.StopPropagation();

		story.ChooseChoiceIndex (choice.index);	


		AdvanceStory();
	}

    public void updateInkVar(string varName, int varVal)
    {
        story.variablesState[varName] = varVal;
    }

    public void incrementInkVar(string varName)
    {
        var currentVal = (int) story.variablesState[varName];
        currentVal++;
        story.variablesState[varName] = currentVal;
    }
	
}
