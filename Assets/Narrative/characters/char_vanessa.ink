
===vanessa===
    ~turns_taken = 0
    ~clear_covered()

    -> opening_statement

    =opening_statement
    VANESSA: Oh, hey!!!
    // {Oh, hey!!! | {~ Omg! | Omigosh, babe! | Squeee!}}
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
        {not already_saw(->schooldance_dnd) and not has_unlock(vanessa_unlocks, dnd): ->converse(->schooldance_dnd)}
        {not already_saw(->schooldance_nerd) and not has_unlock(vanessa_unlocks, nerd): ->converse(->schooldance_nerd)}
        
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

    = schooldance_dnd
    VANESSA: The weekend of the school dance is so much fun!
        + [YOU: It's all anyone talks about.]
            VANESSA: I hope you vote for me for homecoming queen this year.
        + [YOU: It feels a little overblown to me.]
            VANESSA: Regardless, I hope you vote for me for homecoming queen this year.
        +{have_mask(flirty)}[YOU: If you don't want to go with Mr. Homecoming King this year, I could be your date]
            VANESSA: You're sweet, but he won't be happy about that.
        +{have_mask(brooding)}[YOU: It's alright.]
            VANESSA: Well, as long as I can get your vote for Homecoming Queen.
            VANESSA: I'll kill you if you tell anyone, but you seem cool.
            VANESSA: I'm probably more excited for the next day when I play D&D with my friends.
            VANESSA: I'm going to be dungeon master!
            ~get_unlock(vanessa_unlocks, dnd)
            ~get_mask(bubbly)
        +{have_mask(angry)}[YOU: Homecoming is for losers!]
            VANESSA: Ouch, having trouble finding a date?
        +{have_mask(bubbly)}[YOU: It's the most wonderful time of the year!]
            VANESSA: We'll dance all night!
    - ->->

    = schooldance_nerd
    VANESSA: I don't know what Mr. Thompson was thinking giving us a big science test the week of homecoming?
        + [YOU: I didn't think you cared about that kind of stuff.]
            VANESSA: Yeah, it doesn't matter. It's not going to ruin my fun.
        + [YOU: Yeah, I'm going to have to spend extra time studying.]
            VANESSA: That's cute. You try so hard.
        +{have_mask(flirty)}[YOU: I can help you study, just the two of us]
            VANESSA: Don't be like that.
            VANESSA: Seriously, though, I do need to study.
            VANESSA: No funny business, but just keep it between us.
            VANESSA: Science is kind of my thing, but that's not really something everyone needs to know.
            ~get_unlock(vanessa_unlocks, nerd)
            ~get_mask(bubbly)
        +{have_mask(brooding)}[YOU: If you care about that kind of stuff.]
            VANESSA: It's like he's TRYING to ruin our fun.
        +{have_mask(angry)}[YOU: Yeah, what a jerk!]
            VANESSA: It's like he's TRYING to ruin our fun.
        +{have_mask(bubbly)}[YOU: There's a science test? Let's get our hair done together.]
            VANESSA: You're the best.

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

/** 
Points to uncover:
[ ] wants to be an astronaut
[ ] loves D&D
[ ] scared of ex-boyfriend
[ ] insecure about being seen as a nerd

**/
