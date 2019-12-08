# INC and DEC instructions are simple to understand.
#
# INC increments its argument.
# DEC decrements its argument.
#
# To run and look at the return code:
#    > gcc 2_inc_and_dec.S -o inc_and_dec.exe
#    > inc_and_dec.exe
#    > echo %errorlevel%
#
# The echo statement will print 6.
  .globl main
main:
  mov $5, %rax
  inc %rax
  inc %rax
  dec %rax
  ret
