/*
 Conditional instructions can also be used to build if/else statements.
 The code below corresponds to the following pseudocode:

     RAX = -5
     if RAX >= 0:
       RAX += 1
     else:
       RAX -= 1

 Remember that MOV does not update status registers. We can still make
 decisions based on the value of RAX by executing an arithmetic or logical
 instruction that doesn't change the value of RAX. For example, here we
 call "or %rax %rax" which translates to "RAX = RAX | RAX". This doesn't
 do anything to RAX, but updates CPU status flags according to whatever
 the value of RAX is.

 After that's done with, we use a conditional jump instruction to skip
 to the "if" section, if the CPU status flags indicate that RAX is not
 negative (jns stands for "Jump if the Sign flag is Not set", or "Jump
 if Not Sign is negative" if you prefer). So if RAX is nonnegative, the 
 next instruction increments RAX, and then we return from the program.
 If RAX is negative however, we do not jump and the next instruction
 instead decrements RAX. We also need to perform an unconditional jump
 to the end so that we don't perform the .rax_is_not_negative part in
 this case.

 The assembly will look a little bit backwards compared to the pseudo-
 code: we actually define the "else" clause first. That's just how it
 be sometimes.

 One fun thing we could do at this point is to try and tune the assembly
 to execute in as few instructions as possible, or to create the smallest 
 possible program that does the job. It's probably not needed, but then
 again, there aren't that many situations where assembly is needed at al
 either.

 For example, we could replace the "dec %rax" and "jmp .main_end" with
 a single instruction: "sub $2, %rax". This way, we take into account
 the INC instruction after the .rax_is_not_negative label and get the
 right answer in the end anyway. It might not actually help though,
 since it's possible that the encoding DEC and JMP takes fewer bytes
 than the SUB.

 Making things run fast is even harder than making the program small.
 since it requires an understanding about the time it takes the CPU to 
 execute different instructions as well as a lot of knowledge about the 
 caches, pipelines and speculative execution machinery in the CPU you're 
 workin with. To make things small, you can just figure out clever ways 
 to do the job with fewer instructions. Often this makes the program 
 run faster anyway, so everyone wins.

 To run and look at the return code:
    > gcc 5_if_else.S -o if_else.exe
    > if_else.exe
    > echo %errorlevel%

 The echo statement will print -6.
*/
  .globl main
main:
  mov $-5, %rax
  or %rax, %rax
  jns .rax_is_not_negative
  dec %rax
  jmp .main_end
.rax_is_not_negative:
  inc %rax
.main_end:
  ret
