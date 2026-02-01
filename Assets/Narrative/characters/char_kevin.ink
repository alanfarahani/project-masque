===kevin===
    ~turns_taken = 0
    ~clear_covered()

    -> opening_statement

    =opening_statement
    KEVIN: Yeah?
    - -> your_turn

    = their_turn
        -> reactions ->
        -> your_turn
    -> DONE

    = your_turn
        <-conversation
    -> DONE
    
    = conversation
        {not already_saw(->exams_intro): ->converse(->exams_intro)}
        {not already_saw(->exams_whatsonit): ->converse(->exams_whatsonit)}
        /*{not already_saw(->schooldance_intro): ->converse(->schooldance_intro)}
        {not already_saw(->exams_intro): ->converse(->exams_intro)}
        */
        
        -> DONE

    = converse(->go_to)
        ->go_to->
        ~just_saw(go_to)
        -> hedge ->
        ~turns_taken++
        -> their_turn
    - -> DONE

    = hedge
        {shuffle:
            - KEVIN: Not like I care.
            - KEVIN: Yeah. So.
        }
    - ->->

    = gotta_flirt
        KEVIN: You know what makes you cool?
        KEVIN: If other people think you like them.
        KEVIN: Keep that in mind.
        ~get_mask(flirty)
        - ->->

    = exams_intro
        KEVIN: Hey, listen. You're smart.
        KEVIN: Help me out with the next test?
       +[YOU: Sure, however I can.]
            KEVIN: Um, ok.  Cool or whatever. I'll think about it.
        +[YOU: You can help yourself.]
            KEVIN: OF course I can take care of all it myself.
            KEVIN: I just thought...
            KEVIN: Whatever.
        +{have_mask(flirty)}[YOU: Only if we can study together.]
            KEVIN: Whoa, uh, yeah I mean chill out.
            KEVIN: You don't need to come on so hard.
            KEVIN: Cool kids don't try so much.
            ~get_mask(brooding)
        - ->->

    = exams_whatsonit
        KEVIN: When do you even find the time to study?
        +[YOU: You have to make it.]
            KEVIN: Yeah sure, easy for you to say.
        +[YOU: It's really hard sometimes.]
            KEVIN: It is...
            KEVIN: I mean, whatever, it's not like it matters.
        - ->->
    
    =exams_failing
        KEVIN: We're all totally gonna fail the exam, right?
        +[YOU: Yeah, it's not looking good.]
            KEVIN: Yeah sure, easy for you to say.
        +[YOU: It's really hard sometimes.]
            KEVIN: It is...
            KEVIN: I mean, whatever, it's not like it matters.
        +{have_mask(bubbly)}[YOU: Teamwork makes the dreamwork!]
            KEVIN: What are you talking about?
            KEVIN: Are you on something?
            KEVIN: <bold>This is serious for me.</bold>
            ~get_mask(angry)
        - ->->


    = reactions
        {turns_taken == 2:
            {kevin == 1 and not have_mask(flirty): ->gotta_flirt->}
            KEVIN: Got stuff to do.  
            KEVIN: See you. Or not.
            -> character_selection
        }
    - ->->
- -> DONE