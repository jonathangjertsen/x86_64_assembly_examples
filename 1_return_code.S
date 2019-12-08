# The return code is the contents of RAX when the program returns.
# We can look at the returncode by printing %errorlevel% after the program has run.
#
# One way to put stuff in RAX is with a MOV instruction.
# In AT&T syntax, instructions are written like this: INST SOURCE, DESTINATON
# So below, the constant 5 is the source and the register %rax is the destination.
# The $ sign is required for int literals.
#
# To run and look at the return code:
#    > gcc 1_return_code.S -o return_code.exe
#    > return_code.exe
#    > echo %errorlevel%
#
# The echo statement will print 5.
  .globl main
main:
  mov $5, %rax
  ret