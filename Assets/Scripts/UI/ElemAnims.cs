using UnityEngine.UIElements;

public class ElemAnims
{
    
	public void fadeOut(VisualElement elem)
	{
		elem.AddToClassList("invis");
		
	}

	public void fadeIn(VisualElement elem)
	{
		elem.RemoveFromClassList("invis");

	}

	public void dimElem(VisualElement elem)
	{
		elem.AddToClassList("dim");
	}

}
