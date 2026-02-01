VAR _COUNT_MODE = true
VAR _TOPIC_COUNT = 1

=== select(-> topics) ===
    ~_TOPIC_COUNT = 0
    ~_COUNT_MODE = true

    <- topics
    + ->

    -

    ~_COUNT_MODE = false
    ~_TOPIC_COUNT += 1

    -(pull_topic)

    ~minStory = sort_list(min, TOPIC_BUCKETS)

    <- topics

    {CHOICE_COUNT() == 0:
        ->pull_topic
    }

    + ->-> // Optional: fallback for if no topics are valid

// Could be expanded with weights/salience
=== function test(item, condition) ===
    {_COUNT_MODE:
        {condition:
            ~_TOPIC_COUNT += 1
        }
        ~return false
    - else:
        {condition:
            ~_TOPIC_COUNT -= 1
                {item == minStory:
                    ~inc_state(item)
                    ~return true
                }
            
        -else:
            // AF: if the condition isn't valid we remove that storylet from the pool of possibles
            // this can be "abstracted" by allowing a ref list to access other storylet lists
            // or else a different "collector" variable used to gather up available topics
            ~TOPIC_BUCKETS -= item
            // AF: for bookkeeping, so that we know this storylet condition was flagged as a false
            ~setValueOfState(item, 1000)
            ~minStory = sort_list(min, TOPIC_BUCKETS)
            ~return false
        }
}