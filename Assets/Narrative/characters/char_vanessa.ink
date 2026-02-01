
===vanessa===
    ~turns_taken = 0
    ~clear_covered()

    -> opening_statement

    =opening_statement
    VANESSA: Oh, hey!!!
    - -> your_turn

    = their_turn
        -> reactions ->
        -> your_turn
    -> DONE

    = your_turn
        <-conversation
    -> DONE
    
    = conversation
        {not already_saw(->schooldance_bring_someone): ->converse(->schooldance_bring_someone)}
        {not already_saw(->schooldance_what_wearing): ->converse(->schooldance_what_wearing)}
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
            - VANESSA: Ummm...
            - VANESSA: Sooo anyway...
            - VANESSA: Yeah, so, like...
        }
    - ->->

    = gotta_flirt
        VANESSA: You know babe, maybe be more like me?
        VANESSA: Know what I mean?
        VANESSA: Like, people like people who are into people.
        ~get_mask(flirty)
        - ->->


    = schooldance_bring_someone
    VANESSA: Finally convince someone to go to the dance with YOU?
       +[YOU: I did find someone!]
            VANESSA: Bet you didn't.  All the good ones asked me.
            VANESSA: It's what happens when you're homecoming queen two years in a row.
        +[YOU: I haven't found anybody yet.]
            VANESSA: Are you even trying?
            VANESSA: Do you even want to go?
        +{have_mask(flirty)}[YOU: Only if there's a chance I can dance with you.]
            VANESSA: Wow, babe, that's sweet.  Like friends, though?
            VANESSA: Because uh, my, uh, boyfriend doesn't find stuff like that funny.
            VANESSA: You know how he gets.
        
    - ->->

    = schooldance_what_wearing
    VANESSA: Are you wearing anything fancy?
        + [YOU: I spent all my money on my outfit.]
            VANESSA: Oooh!  Just like me! 
            VANESSA: But mine is like, definitely fancier.
        + [YOU: I'm wearing a trash bag.]
            VANESSA: That's not funny.
            VANESSA: This is a serious event!
    
    - ->->

    = reactions
        {turns_taken == 2:
            {vanessa == 1 and not have_mask(flirty): ->gotta_flirt->}
            VANESSA: Lots to do!
            VANESSA: Biyeee!
            -> character_selection
        }
    - ->->
- -> DONE