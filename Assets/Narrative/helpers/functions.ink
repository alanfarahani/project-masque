//mask inventory
=== function have_mask(mask)
    ~return MASKS ? mask
    
=== function get_mask(mask)
    ~ MASKS += mask

=== function has_unlock(list, unlock)
    ~return list ? unlock

=== function get_unlock(ref list, unlock)
    ~ list += unlock

// knowledge states
=== function reached (knowledge_list, x) 
   ~ return knowledge_list ? x 

=== function between(knowledge_list, x, y) 
   ~ return knowledge_list ? x && not (knowledge_list ^ y)

=== function reach(ref knowledge_list, statesToSet) 
   ~ temp x = pop(statesToSet)
   {
   - not x: 
      ~ return false 

   - not reached(knowledge_list, x):
      ~ temp chain = LIST_ALL(x)
      ~ temp statesGained = LIST_RANGE(chain, LIST_MIN(chain), x)
      ~ knowledge_list += statesGained
      ~ reach (knowledge_list, statesToSet)     // set any other states left to set
      ~ return true            // and we set this state, so true
 
    - else:
      ~ return false || reach(knowledge_list, statesToSet) 
    }

// conversation utilities
=== function topic_is(topic)
    ~return current_topic == topic

=== function seen_ever(->x)
    // has this piece of content ever been seen?
    ~ return TURNS_SINCE(x) >= 0 

=== function came_from(-> x) 
    // were you at "x" during this turn
    ~ return TURNS_SINCE(x) == 0
    
=== function one_turn_after(-> x) 
    // were you at "x" during the last turn (or this one)
    ~ return TURNS_SINCE(x) <= 1 && seen_ever(x)
    
=== function seen_very_recently(-> x)
    // did we see this line recently?
    ~ return TURNS_SINCE(x) <= 3 && seen_ever(x)

=== function just_saw(->thread)
    ~topics_covered += "<{thread}>"

=== function already_saw(->thread)
    ~temp this_thread = "<{thread}>"
    ~return topics_covered ? this_thread

=== function clear_covered()
    ~topics_covered = ""

// pop function
=== function pop(ref _list) 
    ~ temp el = LIST_MIN(_list) 
    ~ _list -= el
    ~ return el 

// assigning values to list items

// AF: assign a value to all elements of a particular list
=== function mass_updt_states(ref list, value)
  ~ temp this_item = pop(StateClearance)
    ~ setValueOfState(this_item, value)
        {
            - StateClearance != ():
                ~mass_updt_states(list, value)
        }

// AF: increment the value of a list item
=== function inc_state(item)
    ~temp curr_val = getValueOfState(item)
    
    ~setValueOfState(item, curr_val+1)

// "STORYLET" system
// Shorthand for storylets with no conditions
=== function no_cond(item) ===
    ~return test(item, true)
    