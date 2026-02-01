
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
        {not already_saw(->sportsball_pregameritual_cats) and not has_unlock(joanne_unlocks, cats): ->converse(->sportsball_pregameritual_cats)}
        {not already_saw(->schooldance_bodyimage) and not has_unlock(joanne_unlocks, body_image): ->converse(->schooldance_bodyimage)}
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

    = sportsball_pregameritual_cats
        JOANNE: I'm getting locked in for the game.
        +[YOU: I don't want to bother you]
            JOANNE: Preparing for the game takes more time than you'd think.
        +{have_mask(angry)} [YOU: That's stupid.]
            JOANNE: You're stupid.
        +{have_mask(brooding)} [YOU: You can be chill about it]
            JOANNE: If you only knew what I went through to win these games.
            JOANNE: I meditate for 2 hours before every game with all 10 of my cats.
            JOANNE: <bold>I love my cats. They keep me grounded</bold>
            ~get_unlock(joanne_unlocks, cats)
            ~get_mask(angry)
        +{have_mask(flirty)} [YOU: And I'm locked in on you. WINK]
            JOANNE: Umm... yeah... lots to do.
        +{have_mask(bubbly)} [YOU: Wow... do you use healing crystals?]
            JOANNE: Not crystals, but preparing for the game takes more time than you'd think.
    - ->->

    = schooldance_bodyimage
        JOANNE: Can you believe we don't have a sportsball game the weekend of the school dance?
        +[YOU: Of course, no time for sportsball wehen there's a big dance.]
            JOANNE: Sportsball is life!
        +[YOU: Aren't you going to the dance?]
            JOANNE: Dances aren't my thing, I'd rather play sportsball.
        +{have_mask(brooding)} [YOU: Sounds like a lose/lose weekend to me.]
            JOANNE: Coach always says, "We don't lose when we win!".
        +{have_mask(flirty)} [YOU: If only a star sportsballer would ask me to the dance...].
            JOANNE: I think Mark is looking to go with someone.
        +{have_mask(bubbly)} [YOU: Dances are so magical!]
            JOANNE: And awkward.
            JOANNE: Heals are the worst, no traction.
            JOANNE: <bold>And I look so silly being taller than every boy in the school. It's embarassing.</bold>
            ~get_unlock(joanne_unlocks, body_image)
            ~get_mask(angry)

    - ->->

    = reactions
        {turns_taken == 4:
            {joanne == 1 and not have_mask(flirty): ->gotta_flirt->}
            JOANNE: I've gotta go.  
            JOANNE: Later.
            -> character_selection
        }
    - ->->
- -> DONE

/** 
Points to uncover:
[x] loves cats
[x] body image
[ ] wants to open a bakery (travel game)
[ ] fears her parents disapproval (college)
**/
