# By default, the CPU will execute each instruction in turn.
# We can use a JMP instruction to take control of the execution.
# Below, we define a label and jump to it. The two INC instructions
# between the jump instruction and the target are not executed.
#
# To run and look at the return code:
#    > gcc 3_jump.S -o jump.exe
#    > jump.exe
#    > echo %errorlevel%
#
# The echo statement will print 4.
  .globl main
main:
  mov $5, %rax
  jmp .target
  inc %rax
  inc %rax
.target:
  dec %rax
  ret
