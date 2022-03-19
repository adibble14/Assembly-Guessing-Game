;Andrew Dibble
;Machine Organization HW #4
;This program simulates a simple guessing game where the user tries to see how fast they can guess a fixed number

            .ORIG       x3000               ;start at x3000
            
            AND         R2, R2, 0           ;initializing R2 to 0, this will be the counter for the number of guesses
            LEA         R0, Prompt          ;asking for guess
            PUTS                            ;ouputs the prompt
            GETC                            ;gets the input character from keyboard
            LD          R1, CorrectNum      ;loading the correct number into R1
            LD          R3, LowestVal       ;loading the min value allowed in R3
            LD          R4, HighestVal      ;loading the max value allowed in R4
            
            NOT         R3, R3              ; taking twos comp
            ADD         R3, R3, #1
            ADD         R3, R3, R0          
            BRn         GuessInvalid        ;if the input - lowest value is negative, then input is too low
            
            NOT         R4, R4              ;taking twos comp
            ADD         R4, R4, #1
            ADD         R4, R4, R0
            BRp         GuessInvalid        ;if the input - highest val is postive, then input is too high
            
            ADD         R1, R1, R0          ;adding the input and the correctNum
            BRz         GuessCorrect
            BRn         GuessSmall
            BRp         GuessBig
            
Guess                                       ;handles the guesses after the first guess with the same algorithm as above
            LEA         R0, PromptAgain     
            PUTS                            
            GETC                           
            LD          R1, CorrectNum 
            LD          R3, LowestVal       
            LD          R4, HighestVal     
            
            NOT         R3, R3              
            ADD         R3, R3, #1
            ADD         R3, R3, R0          
            BRn         GuessInvalid        
            
            NOT         R4, R4              
            ADD         R4, R4, #1
            ADD         R4, R4, R0
            BRp         GuessInvalid       
            
            ADD         R1, R1, R0          
            BRz         GuessCorrect
            BRn         GuessSmall
            BRp         GuessBig

GuessCorrect
            ADD         R2, R2, #1          ;incrementing counter
            LEA         R0, CorrectPT1      ;outputs the correct response 
            PUTS
            LD          R0, Zero            ;setting R0 to 0
            ADD         R0, R0, R2          ;adding the counter to it and outputting the number of guesses taken
            OUT
            LEA         R0, CorrectPT2      ;outputs the correct response 
            PUTS
            HALT
GuessSmall
            ADD         R2, R2, #1          ;incrementing counter
            LEA         R0, Small           ;outputs the too small response
            PUTS                           
            BRnzp       Guess               ;goes back to guess to enter a new guess
GuessBig
            ADD         R2, R2, #1          ;incrementing counter
            LEA         R0, Big             ;outputs the too big response
            PUTS                            
            BRnzp       Guess               ;goes back to guess to enter a new guess
GuessInvalid
            ADD         R2, R2, #1          ;incrementing counter
            LEA         R0, Invalid         ;outputs the invalid response
            PUTS                 
            BRnzp       Guess               ;goes back to guess to enter a new guess
        
CorrectNum  .FILL       #-54                ;the correct number is 6 -> ASCII value 54(making it negative for operation purposes)
Prompt      .STRINGZ    "Guess a number between 0 and 9:\n"
PromptAgain .STRINGZ    "Guess Again:\n"    ;output strings
Invalid     .STRINGZ    "Invalid Input\n"
Small       .STRINGZ    "Too Small\n"
Big         .STRINGZ    "Too Big\n"
CorrectPT1  .STRINGZ    "Correct! You took "
CorrectPT2  .STRINGZ    " guesses\n"
Zero      .FILL         #48                 ;this is the ASCII equivalent value of 0
HighestVal  .FILL       #57                 ;range of possible values between characters 0 and 9
LowestVal   .FILL       #48

.END