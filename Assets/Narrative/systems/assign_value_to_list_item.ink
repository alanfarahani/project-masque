// AF: Jon's assign value to list item utility
// 1) Storage space  
  
VAR StatesBinary1 = ""
VAR StatesBinary2 = ""
VAR StatesBinary4 = ""
VAR StatesBinary8 = ""
VAR StatesBinary16 = ""
VAR StatesBinary32 = ""
VAR StatesBinary64 = ""
VAR StatesBinary128 = ""
VAR StatesBinary256 = ""
VAR StatesBinary512 = ""
VAR StatesBinary1024 = ""
VAR StatesBinary2048 = ""   // storage up to 4095
// --> ADDITIONAL STORAGE GOES HERE

CONST MAX_BINARY_BIT = 2048

VAR StatesInStorage = ()

  
// 2) Get value for state being set
    
=== function getValueOfState(state) // always single 
    // do this the dumb long way rather than a fancy loop
    ~ temp value = 0 
    ~ temp id = stateID(state)
    ~ value += returnIfTrue(StatesBinary1 ? id, 1) 
    ~ value += returnIfTrue(StatesBinary2 ? id, 2) 
    ~ value += returnIfTrue(StatesBinary4 ? id, 4) 
    ~ value += returnIfTrue(StatesBinary8 ? id, 8) 
    ~ value += returnIfTrue(StatesBinary16 ? id, 16) 
    ~ value += returnIfTrue(StatesBinary32 ? id, 32) 
    ~ value += returnIfTrue(StatesBinary64 ? id, 64) 
    ~ value += returnIfTrue(StatesBinary128 ? id, 128) 
    ~ value += returnIfTrue(StatesBinary256 ? id, 256) 
    ~ value += returnIfTrue(StatesBinary512 ? id, 512) 
    ~ value += returnIfTrue(StatesBinary1024 ? id, 1024) 
    ~ value += returnIfTrue(StatesBinary2048 ? id, 2048) 
// --> ADDITIONAL STORAGE GOES HERE
    ~ return value 

// 3) Set value for state being set   
    
=== function setValueOfState(state, value) // always single 
    { value >= 2 * MAX_BINARY_BIT: 
        [ ERROR - trying to store a value of {value}, which is the space provided. Please increase {MAX_BINARY_BIT}, and supply additional storage values. ]
    }
    ~ temp currentValue = getValueOfState(state)
    { currentValue != 0 && currentValue != value:
         ~ removeValuesForState(state)
    }
    { value != 0:
        ~ StatesInStorage += state
        ~ _setBinaryValuesForState(stateID(state), value, MAX_BINARY_BIT )
    }
    // [ {value} - set value for {state} to {getValueOfState(state) } ]

=== function _setBinaryValuesForState(id, value, binaryValue)
    { value >= binaryValue:
        ~ value -= binaryValue
        {binaryValue: 
        -  1:   ~ StatesBinary1 += id
        -  2:   ~ StatesBinary2 += id
        -  4:   ~ StatesBinary4 += id
        -  8:   ~ StatesBinary8 += id
        -  16:   ~ StatesBinary16 += id
        -  32:   ~ StatesBinary32 += id
        -  64:   ~ StatesBinary64 += id
        -  128:   ~ StatesBinary128 += id
        -  256:   ~ StatesBinary256 += id
        -  512:   ~ StatesBinary512 += id
        -  1024:   ~ StatesBinary1024 += id
        -  2048:   ~ StatesBinary2048 += id
// --> ADDITIONAL STORAGE GOES HERE
        }
    }
    { binaryValue > 1: 
        ~ _setBinaryValuesForState(id, value, binaryValue / 2)
    }


// 2) Auxiliary functions

=== function stateID(x) 
    ~ return ":{x};"
    
=== function returnIfTrue(test_it, val) 
    {test_it: 
        ~ return val  
    - else: 
        ~ return 0 
    }

// 3) Removal

=== function removeValuesForState(state)
    ~ StatesInStorage -= state
    ~ StatesBinary1 = rebuildStateStorage(StatesBinary1, StatesInStorage)
    ~ StatesBinary2 = rebuildStateStorage(StatesBinary2, StatesInStorage)
    ~ StatesBinary4 = rebuildStateStorage(StatesBinary4, StatesInStorage)
    ~ StatesBinary8 = rebuildStateStorage(StatesBinary8, StatesInStorage)
    ~ StatesBinary16 = rebuildStateStorage(StatesBinary16, StatesInStorage)
    ~ StatesBinary32 = rebuildStateStorage(StatesBinary32, StatesInStorage)
    ~ StatesBinary64 = rebuildStateStorage(StatesBinary64, StatesInStorage)
    ~ StatesBinary128 = rebuildStateStorage(StatesBinary128, StatesInStorage)
    ~ StatesBinary256 = rebuildStateStorage(StatesBinary256, StatesInStorage)
    ~ StatesBinary512 = rebuildStateStorage(StatesBinary512, StatesInStorage)
    ~ StatesBinary1024 = rebuildStateStorage(StatesBinary1024, StatesInStorage)
    ~ StatesBinary2048 = rebuildStateStorage(StatesBinary2048, StatesInStorage)

    
=== function rebuildStateStorage(storageVariable, statesToInclude) 
    ~ temp state = LIST_MIN(statesToInclude) 
    ~ statesToInclude -= state 
    { state: 
        ~ temp returnValue = "{stateID(state)}"
        { storageVariable !? returnValue: 
            ~ returnValue = "" 
        }
        ~ return returnValue + rebuildStateStorage(storageVariable, statesToInclude) 
    }
    ~ return ""