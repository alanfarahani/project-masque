===kevin===
    ~turns_taken = 0
    ~clear_covered()

    -> opening_statement

    =opening_statement
    KEVIN: {Oh, it's you. | {~ Yeah? | 'Sup. | Hey.}}
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
            - KEVIN: Yeah. Um.
            - KEVIN: Yeah. Anyway.
        }
    - ->->

    = gotta_flirt
        KEVIN: You know what makes you cool?
        KEVIN: If other people think you like them.
        KEVIN: Keep that in mind.
        ~get_mask(flirty)
        // play audio
        - ->->

    = exams_intro
        KEVIN: Hey, listen. You're smart.
        KEVIN: Help me out with the next test?
       +[YOU: Sure, I'll help you.]
            KEVIN: Oh, really?  Cool or whatever. I'll think about it.
        +[YOU: You can help yourself.]
            KEVIN: OF course I can take care of all it myself.
            KEVIN: I just thought...
            KEVIN: Whatever.
        +{have_mask(flirty)}[YOU: Only if we can study together.]
            KEVIN: Whoa, uh, yeah I mean chill out.
            KEVIN: I don't want anything like that.
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
            KEVIN: I mean, whatever, it's not like it matters.
            KEVIN: Well, for me, it kinda does.
            KEVIN: I guess. Whatever.
        +[YOU: Nah, it'll be fine.]
            KEVIN: I mean, whatever, it's not like it matters.
            KEVIN: Well, for me, it kinda does.
            KEVIN: I guess. Whatever.
        +{have_mask(bubbly)}[YOU: Teamwork makes the dreamwork!]
            KEVIN: What are you talking about?
            KEVIN: Are you on something?
            KEVIN: <bold>This is serious for me.</bold>
            KEVIN: If I fail, I won't be able to --
            KEVIN: Nevermind.
            ~get_mask(angry)
            // play audio
            // learn_serious
        +{have_mask(flirty)}[YOU: I won't let you fail, WINK.]
            KEVIN: I told you, I'm not interested.
            KEVIN: <bold>This is serious for me.</bold>
            KEVIN: If I fail, I won't be able to --
            KEVIN: Nevermind.
        +{have_mask(brooding)}[YOU: Don't worry, it's not like it matters.]
            KEVIN: How can you be so chill about it?
            KEVIN: <bold>This is serious for me.</bold>
            KEVIN: If I fail, I won't be able to --
            KEVIN: Nevermind.
        - ->->

    =exams_future
        KEVIN: Listen, do you have any tips for passing?
        +[YOU: Pretend to be sick.]
            KEVIN: Wow, why would you say that?
            KEVIN: <bold>My grandma really is sick, you know that?<bold>
            ~get_mask(angry)
        +[YOU: Really be sick.]
            KEVIN: Wow, why would you say that?
            KEVIN: <bold>My grandma really is sick, you know that?<bold>
            ~get_mask(angry)
        +{have_mask(bubbly)}[YOU: Just think about how important this single moment is for shaping your entire future!]
            KEVIN: Not helping. At all.
            KEVIN: You really think the Academy won't take me if I fail? 
            KEVIN: <bold>This is serious for me.</bold>
            ~get_mask(angry)
            // play audio
        +{have_mask(flirty)}[YOU: Just pretend the exam is something you really, really like. WINK.]
            KEVIN: Hmm. You know what I really like?
            KEVIN: <bold>F1 racing.</bold> 
            KEVIN: The precision. The elegance. It's like a </bold>modern dance at high speed.</bold>
            KEVIN: Don't think that changes the exam, though.
            KEVIN: Whatever.
        +{have_mask(brooding)}[YOU: Just don't try.]
            KEVIN: What are you talking about?
            KEVIN: <bold>This is serious for me.</bold>
            KEVIN: I won't be able to --
            KEVIN: Nevermind.
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

/** 
Points to uncover:
[ ] wants to be a modern dancer
[ ] live F1
[ ] scared of grandma dying
[ ] being seen like he cares

**/
