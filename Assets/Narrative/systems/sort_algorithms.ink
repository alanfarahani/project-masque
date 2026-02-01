=== function sort_list(type, list)
~setup_sort(list)

{type:
    -max:
        ~return max_sort(SortTower)
    -min:
        ~return min_sort(SortTower)
}

=== function setup_sort(ref list)
    ~SortTower = ()
    ~SortTower +=  list
    ~SortTemp = ()

=== function max_sort(list)
~temp n_rem = LIST_COUNT(list)
{n_rem > 1:
    
        ~temp var1 = pop(list)
        ~temp var2 = pop(list)
        
        ~temp val1 = getValueOfState(var1)
        ~temp val2 = getValueOfState(var2)

        {
         - val1 > val2:
            ~list += var1
            ~list -= var2
         - val2 > val1:
            ~list += var2
            ~list -= var1
         - else:
            ~SortTemp = ()
            ~SortTemp += var1
            ~SortTemp += var2
            ~temp randomTie = LIST_RANDOM(SortTemp)
            ~list += randomTie
        }
        
        {LIST_COUNT(list) == 1:
            ~return list 
         - else:
            ~return max_sort(list)
        }
        
    - else:
        ~return "error"
        }
        
=== function min_sort(list)
~temp n_rem = LIST_COUNT(list)
{n_rem > 1:
    
        ~temp var1 = pop(list)
        ~temp var2 = pop(list)
        
        ~temp val1 = getValueOfState(var1)
        ~temp val2 = getValueOfState(var2)

        {
         - val1 < val2:
            ~list += var1
            ~list -= var2
         - val2 < val1:
            ~list += var2
            ~list -= var1
         - else:
            ~SortTemp = ()
            ~SortTemp += var1
            ~SortTemp += var2
            ~temp randomTie = LIST_RANDOM(SortTemp)
            ~list += randomTie
        }
        
        {LIST_COUNT(list) == 1:
            ~return list 
         - else:
            ~return min_sort(list)
        }
        
    - else:
        ~return "error"
        }