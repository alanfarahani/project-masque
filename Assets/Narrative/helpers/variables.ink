
LIST MASKS = flirty, angry, brooding, bubbly, jock, bandgeek, none

LIST CHARACTERS = JOANNE, VANESSA, KEVIN

LIST TOPIC_BUCKETS = (sportsball), (schooldance), (exams)

VAR priority_topic = ()

VAR current_topic = ()

// for sorting topics

// AF: These are helpers for the sort algorithm
VAR SortTower = ()
VAR SortTemp = ()
VAR minStory = ()

LIST minMax = min, max

// AF: used to assign values to list items in one go
VAR StateClearance = ()


// conversation variables
VAR turns_taken = 0
VAR topics_covered = ""
