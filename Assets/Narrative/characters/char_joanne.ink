
===joanne===
    ~turns_taken = 0
    ~clear_covered()

    -> opening_statement

    =opening_statement
    JOANNE: {Hey, you. | {~ Hi again. | Heya! | Oh, hello.}}
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
        {already_saw(->sportsball_game): {~ ->converse(->sportsball_doyoulike) | ->converse(->sportsball_pregameritual_cats) | ->converse(->schooldance_bodyimage)}}
        /*
        {not already_saw(->sportsball_doyoulike): ->converse(->sportsball_doyoulike)}
        {not already_saw(->sportsball_pregameritual_cats) and not has_unlock(joanne_unlocks, cats): ->converse(->sportsball_pregameritual_cats)}
        {not already_saw(->schooldance_bodyimage) and not has_unlock(joanne_unlocks, body_image): ->converse(->schooldance_bodyimage)}
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
            - JOANNE: Oh, right.
        }
    - ->->

    = gotta_flirt
        JOANNE: You know, if you want people to like you more, you could try flirting with them a little.
        JOANNE: Not that I need to.  
        JOANNE: I mean, have you seen my sportsball numbers?
        ~get_mask(flirty)
        - ->->
// this is always your first convo with Joanne.
    = sportsball_game
        JOANNE: So, coming to my big sportsball game?
        + YOU: Yep, I'll be there.  
            JOANNE: Of course you'll be there, it's the biggest sportsball game of the year.
            JOANNE: And I'm starting.
        +YOU: Nope, not me.
            JOANNE: Is anybody surprised?
        +{have_mask(flirty)} YOU: WINK.
            JOANNE: Ooh, what are you trying to tell me? You're like my cats. 
            JOANNE: I love them, but I never know what they're thinking.
            ~get_unlock(joanne_unlocks, cats)
        +{have_mask(angry)} YOU: There's more to life than sportsball!
            JOANNE: Whoa, rude!
            JOANNE: I mean, you're not wrong. 
            JOANNE: A freshly baked cupcake is life.
            JOANNE: But I'd let a lot of people down if I followed that dream.
            ~get_unlock(joanne_unlocks, bakery)

    - ->->
//randomly select one of these topics after sportsball_game, repeats OK due to deadline
    = sportsball_doyoulike
        JOANNE: Do you even like sportsball?
        +[YOU: Who doesn't?]
           JOANNE: I guess some people, but I don't get what their problem is.
        +[YOU: Not my thing.]
            JOANNE: You think you're cool, liking other things?
            JOANNE: I'll pretend you didn't just say that.
        +{have_mask(bubbly)}[YOU: OMG! I super love sportsball!]
            JOANNE: Are you making fun of me? 
            JOANNE: Look, you know what? My parents never miss a game.
            JOANNE: Never. A. Single. Game. 
            JOANNE: Of course I like sportsball, but I also can't let them down...
        +{have_mask(flirty)} YOU: Only if <i>you're</i> playing.
            JOANNE: Oh, stop. 
            JOANNE: You know I’m self conscious about being this good.
            JOANNE: And ripped. 
            JOANNE: You don't find that intimidating?
            ~get_unlock(joanne_unlocks, body_image)
    - ->->

    = sportsball_pregameritual_cats
        JOANNE: I'm getting locked in for the game.
        +[YOU: Don't want to bother you]
            JOANNE: My pre-game ritual is pretty elaborate.
        +{have_mask(angry)} [YOU: That's stupid.]
            JOANNE: You're stupid.
            JOANNE: You have no idea what it takes to be this good. 
            JOANNE: And how many people are counting on me. 
            JOANNE: Sometimes I wish I could just -
            ~get_mask(angry)
        +{have_mask(brooding)} [YOU: Don't you just like, show up and play?]
            JOANNE: You're not much of a competitor, huh?
            JOANNE: If only you knew what I went through to win these games!
            ++ [YOU: Something chill?]
                JOANNE: In a way! I meditate for 2 hours with all 10 of my cats.
                JOANNE: <bold>I love my cats. They keep me grounded.</bold>
            ~get_unlock(joanne_unlocks, cats)
            //~get_mask(angry)
        +{have_mask(flirty)} [YOU: And I'm locked in on you. WINK.]
            JOANNE: What can I say? I'm tasty. Like a blueberry champagne cup cake. 
            JOANNE: Ooh, that gives me such a good idea for a new recipe. 
            JOANNE: <bold>Can't wait to try it out.</bold> 
            JOANNE: You know, when I'm not practicing, I guess.
            ~get_unlock(joanne_unlocks, bakery)
        +{have_mask(bubbly)} [YOU: Wow... do you, like, spend hours on your hair and makeup?]
            JOANNE: Please.
            JOANNE: It would just get in the way. 
            JOANNE: I mean I know that I would look a lot better, or whatever, in photos.
            ~get_unlock(joanne_unlocks, body_image)
    - ->->

    = schooldance_bodyimage
        JOANNE: Can you believe there's no game the weekend of the dance?
        +[YOU: No time for games when there's a big dance.]
            JOANNE: Sportsball is life!
        +[YOU: Aren't you going to the dance?]
            JOANNE: Dances aren't my thing, I'd rather play sportsball.
            JOANNE: <bold>Or bake, really.</bold> 
            JOANNE: But, don't tell anyone that or I'll never hear the end of it.
            ~get_unlock(joanne_unlocks, bakery)
        +{have_mask(brooding)} [YOU: Sounds like a lose/lose weekend to me.]
            JOANNE: Coach always says, "We don't lose when we win!".
            JOANNE: Although winning for me, just once, would be getting to do my own thing...
        +{have_mask(flirty)} [YOU: If only a star sportsballer would ask me to the dance...]
            JOANNE: Cute. You know who I would take if I was going?
            JOANNE: <bold>My cat</bold>, Mr. Fluffles.
            JOANNE: He's a perfect gentleman. 
            ~get_unlock(joanne_unlocks, cats)
        +{have_mask(bubbly)} [YOU: Dances are just so magical!]
            JOANNE: And awkward.
            JOANNE: Heels are the worst, no traction.
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
