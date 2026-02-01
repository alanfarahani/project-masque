
===joanne===
    ~turns_taken = 0
    ~clear_covered()

    -> opening_statement

    =opening_statement
    JOANNE: Hey, you.
    //{Hey, you. | {~ Hi again. | Heya!. | Oh, hello.}}
    /*{current_topic:
        - sportsball: 
            -> converse(->sportsball_game)
        - schooldance:
            -> converse(->schooldance_intro)
        - exams:
            -> converse(->exams_intro)
    }
    */
    - -> your_turn

    = their_turn
        -> reactions ->
        -> your_turn
    -> DONE

    = your_turn
        <-conversation
    -> DONE
    
    = conversation
        {not already_saw(->sportsball_game): ->converse(->sportsball_game)}
        {not already_saw(->sportsball_doyoulike): ->converse(->sportsball_doyoulike)}
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

    = sportsball_game
        JOANNE: So, coming to my big sportsball game?
        + YOU: Yep, I'll be there.  
            JOANNE: Of course you'll be there, it's the biggest sportsball game of the year.
            JOANNE: And I'm starting.
        +YOU: Nope, not me.
            JOANNE: Is anybody surprised?
        +{have_mask(angry)} YOU: There's more to life than sportsball!
            JOANNE: Whoa, rude!
            JOANNE: I mean you're not wrong.
            
       
    - ->->

    = sportsball_doyoulike
        JOANNE: Do you even like sportsball?
       +[YOU: Who doesn't?]
           JOANNE: I guess some people, but I don't get what their problem is.
        +[YOU: Not my thing.]
            JOANNE: You think you're cool?
            JOANNE: I'll pretend you didn't just say that.
        +{have_mask(bubbly)}[YOU: OMG! I super love sportsball!]


    - ->->

    = reactions
        {turns_taken == 2:
            {joanne == 1 and not have_mask(flirty): ->gotta_flirt->}
            JOANNE: I've gotta go.  
            JOANNE: Later.
            -> character_selection
        }
    - ->->
- -> DONE