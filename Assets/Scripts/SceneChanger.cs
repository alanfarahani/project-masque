using System.Collections;
using Unity;
using UnityEngine;

public class SceneChanger
{
    private DialogueController dialogueController;    

    private UiController uiItems;

	private ElemAnims animElem;

	public static string currentGamePhase;

    public SceneChanger(DialogueController dialogueController){
        this.dialogueController = dialogueController;
        uiItems = GameObject.FindGameObjectsWithTag("mainUI")[0].GetComponent<UiController>();
    	animElem = new ElemAnims();
    }

    public void clearTextAreas()
	{
		
		
	}

    public IEnumerator SceneChange(string this_tag_type, string this_tag_prop){

		if (this_tag_type == "start")
			{
                if(currentGamePhase != this_tag_prop)
                {
                     yield return dialogueController.StartCoroutine(endOptions(currentGamePhase, this_tag_prop));
                     yield return dialogueController.StartCoroutine(startOptions(this_tag_prop));   
                }
            }

		yield return null;
	}

    private IEnumerator startOptions(string this_tag_prop)
    {
        if(this_tag_prop == "character-selection")
        {
            dialogueController.StartCoroutine(startCharSelect());
        }
        
        if(this_tag_prop == "conversation"){
            dialogueController.StartCoroutine(startConvo());
        }

        yield return null;

    }

    private IEnumerator endOptions(string currentGamePhase, string this_tag_prop)
        {
        if(currentGamePhase == "character-selection"){
            yield return dialogueController.StartCoroutine(endCharSelect());
        } 
        
        if(currentGamePhase == "conversation"){
           yield return dialogueController.StartCoroutine(endConvo());
        }	
        

        yield return null;
    }

    private IEnumerator startCharSelect()
    {
        currentGamePhase = "character-selection";

        uiItems.charSelectionContainer.RemoveFromClassList("hidden");

        //yield return new WaitForSeconds(0.5f);

        animElem.fadeIn(uiItems.charSelectionContainer);

        yield return null;
    }

    private IEnumerator startConvo()
    {
        currentGamePhase = "conversation";
 
        uiItems.conversationContainer.RemoveFromClassList("hidden");
        
        animElem.fadeIn(uiItems.conversationContainer);

        yield return null;
    }


    private IEnumerator endCharSelect()
    {
        animElem.fadeOut(uiItems.charSelectionContainer);

        yield return new WaitForSeconds(1.5f);

        uiItems.charSelectionContainer.AddToClassList("hidden");
        
        yield return null;
    }

    private IEnumerator endConvo()
    {
        animElem.fadeOut(uiItems.conversationContainer);

        yield return new WaitForSeconds(1.5f);	

        uiItems.conversationContainer.AddToClassList("hidden");

        yield return null;
    }

    
}