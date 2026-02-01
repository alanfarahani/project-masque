
===joanne===
    ~turns_taken = 0
    ~clear_covered()

    -> opening_statement

    =opening_statement
    JOANNE: Hey, you.
    {current_topic:
        - sportsball: 
            -> converse(->sportsball_intro)
        - schooldance:
            -> converse(->schooldance_intro)
        - exams:
            -> converse(->exams_intro)
    }
    - -> your_turn

    = their_turn
        -> reactions ->
        -> your_turn
    -> DONE

    = your_turn
        <-conversation
    -> DONE
    
    = conversation
        {not already_saw(->sportsball_intro): ->converse(->sportsball_intro)}
        {not already_saw(->schooldance_intro): ->converse(->schooldance_intro)}
        {not already_saw(->exams_intro): ->converse(->exams_intro)}
        
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
            - JOANNE: Anyway.
            - JOANNE: Where was I?
              JOANNE: Oh, yeah.
        }
    - ->->

    = gotta_flirt
        JOANNE: You know, if you want people to like you more, you could try flirting with them a little.
        JOANNE: Not that I need to.  
        JOANNE: I mean, have you seen my sportsball numbers?
        ~get_mask(flirty)
        - ->->

    = sportsball_intro
        JOANNE: So, coming to my sportsball game?
        +[Yes]
            YOU: I'll be there.
            JOANNE: Why don't I believe you?
        +[No]
            YOU: I won't be there.
            JOANNE: Is anybody surprised?
        +{have_mask(flirty)}[Wink at Joanne]
            ACTION: You wink at Joanne suggestively.
            JOANNE: Whoa! You trying to tell me something?
        +{have_mask(angry)}[Scowl at Joanne]
            ACTION: You scowl at Joanne, making a low growl.
            JOANNE: That's one way to talk to people!
       
    - ->->

    = sportsball_something


    - ->->


    = schooldance_intro
    JOANNE: Finally convince someone to take you to the dance?
       +[Yes]
            YOU: I did find someone.
            JOANNE: Bet you didn't.  I've got guys lining up.
        +[No]
            YOU: I haven't found anybody yet.
            JOANNE: Maybe join the sportsball team?
        +{have_mask(flirty)}[Wink at Joanne]
            ACTION: You wink at Joanne suggestively.
            JOANNE: Whoa! You trying to tell me something?
        +{have_mask(angry)}[Scowl at Joanne]
            ACTION: You scowl at Joanne, making a low growl.
            JOANNE: That's one way to talk to people!
    - ->->

    = exams_intro
        JOANNE: Need any help with the bio exam?
       +[Yes]
            YOU: Whatever help you can give.
            JOANNE: Yeah right, you'll probably just rip off my hard work.
        +[No]
            YOU: I can handle it myself.
            JOANNE: Not based on what I saw last time.
        +{have_mask(flirty)}[Flirt with Joanne]
            YOU: Maybe you could, you know, help me sometime?
            JOANNE: Yeah, I'm trying to help you by telling you to study.
        +{have_mask(angry)}[Scowl at Joanne]
            ACTION: You scowl at Joanne, making a low growl.
            JOANNE: That's one way to talk to people!
    - ->->

    = reactions
        {turns_taken == 2:
            {joanne == 1: ->gotta_flirt->}
            JOANNE: Anyway, I'm good for now.  
            JOANNE: Later.
            -> character_selection
        }
    - ->->
- -> DONE