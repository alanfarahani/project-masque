/* 
    pins: 
        theater background
        it's all acting
        four starting masks
        one meter: likeability (hot) / dislike (cold)
        two endings:
            option1: some like, some dislike, and you feel good about yourself
            option2: everyone likes you (optimize choices based on character across from you)

*/
INCLUDE helpers/functions.ink
INCLUDE helpers/variables.ink

//characters

INCLUDE characters/char_joanne.ink
INCLUDE characters/char_kevin.ink
INCLUDE characters/char_vanessa.ink

// systems

INCLUDE systems/sort_algorithms.ink
INCLUDE systems/assign_value_to_list_item.ink
INCLUDE systems/topic_engine.ink

~mass_updt_states(TOPIC_BUCKETS, 0)

~priority_topic = sportsball

-> character_selection

=== character_selection
    #start: character-selection

    +[Joanne Jordan #character: joanne] 
        #start: conversation
        -> select(->evaluate_topic) -> joanne
    +[Vanessa Ruiz  #character: vanessa]
        #start: conversation
        -> select(->evaluate_topic) -> vanessa
    +[Kevin Dreezy #character: kevin]
        #start: conversation
        -> select(-> evaluate_topic) -> kevin

- -> DONE

=== evaluate_topic
    +{priority_topic != ()} ->
        ~current_topic = priority_topic
        ~priority_topic = ()
    +{no_cond(sportsball)} ->
        ~current_topic = sportsball
    +{no_cond(schooldance)} ->
        ~current_topic = schooldance
    +{no_cond(exams)} ->
        ~current_topic = exams

- ->->