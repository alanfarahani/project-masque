using System.Text.RegularExpressions;
using System.Globalization;

public class TagOperations
{
    
	public string getTagType(string tag)
	{
		string getTagType = @"^([^:]+):";
		Regex tagType = new Regex(getTagType);
		Match match = tagType.Match(tag);
		
		return match.Groups[1].ToString();
		
	}

	public string getTagProp(string tag)
	{
		string getTagProp = @"^[^:]+:\s*(.*)$";
		Regex tagType = new Regex(getTagProp);
		Match match = tagType.Match(tag);

		return match.Groups[1].ToString();	
			
	}

	public string Capitalize(string text)
	{
		// from https://discussions.unity.com/t/how-do-i-capatalize-the-first-character-letter-of-a-string/858749/13
		string capitalizedString;
		TextInfo textInfo = new CultureInfo("en-US", false).TextInfo;
		capitalizedString = textInfo.ToTitleCase(text);
		return capitalizedString;
	}

}
