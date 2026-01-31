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

LIST MASKS = (flirty), (angry), brooding, bubbly, jock, bandgeek, none

VAR last_choice = none

VAR jock_happiness = 0
VAR jock_unhapiness = 0

-> the_jock

=== the_jock ===

    =encounter1
        JOCK: You're coming to the sportsball game right?
    
        ->masks->
        {last_choice:
            -angry: YOU: You can't make me do anything I don't want to.
            -flirty: YOU: WINK.
            -brooding: YOU: Of course, or like, whatever.
            -bubbly: YOU: I can't wait! I love sportsball!
        }
    
        {last_choice == flirty or last_choice == brooding: 
            Whatever! #char: jock #response: unhappy
        - else:
            You're the best.
            ~jock_happiness++
        }
    
    

//<-masks
//+->

//



-> END

=== masks ===
    +{have_mask(flirty)}[Flirty]
        ~last_choice = flirty
    +{have_mask(angry)}[Angry]
        ~last_choice = angry
    +{have_mask(brooding)}[Brooding]
        ~last_choice = brooding
    +{have_mask(bubbly)}[Bubbly]
        ~last_choice = bubbly
- ->->

=== function have_mask(mask)
    ~return MASKS ? mask
    
=== function get_mask(mask)
    ~ MASKS += mask