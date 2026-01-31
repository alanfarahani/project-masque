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

LIST MASKS = (flirty), (angry), (brooding), (bubbly), jock, bandgeek, none

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
    
        {last_choice == bubbly or last_choice == angry: 
            JOCK: You're the best.
            ~jock_happiness++
            -> encounter_jock_crush_team
        - else:
            JOCK: Whatever! #char: jock #response: unhappy
            ~jock_happiness--
            -> encounter_jock_crush_team
        }

    =encounter_jock_crush_team
        JOCK: We are going to crush the other team!

        ->masks->
        {last_choice:
            -angry: YOU: Kill 'em!
            -flirty: YOU: You're SO strong
            -brooding: YOU: As if
            -bubbly: YOU: Hehe
        }
    
        {last_choice == flirty or last_choice == brooding: 
            ~jock_happiness--
        - else:
            ~jock_happiness++
        }

        -> encounter_you_1
    
    =encounter_you_1
        ->masks->
        {last_choice:
            -angry: YOU: I hate this school
                -> encounter_school_spirit
            -flirty: YOU: Are you going to the party, Friday?
                -> encounter_jack_party
            -brooding: YOU: ...
                -> encounter_school_spirit
            -bubbly: YOU: Are you going to the party, Friday?
                -> encounter_jack_party
        }

    =encounter_school_spirit
        JOCK: Where's the school spirit?

        ->masks->
        {last_choice:
            -angry: YOU: Up your butt
                -> encounter_school_spirit
            -flirty: YOU: Wherever you want it
                -> encounter_jock_confused
            -brooding: YOU: Dead... like regular spirits
                -> encounter_school_spirit
            -bubbly: YOU: Rah, Rah, Rah!
                -> encounter_jock_excited
        }

    =encounter_jack_party
        JACK: I need my eight hours before game day
        -> encounter_you_1

    =encounter_jock_confused
        JOCK: What?
        -> encounter_you_1

    =encounter_jock_excited
        JOCK: Let's F'in Go!

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