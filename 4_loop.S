# There are many *conditional* JMP instructions which will only jump if
# a certain condition is true. We can combine this with the INC and DEC
# instructions to make loops.
#
# The snippet below uses JNZ, which stands for "jump if not zero".
# In other words, we will jump only if the result of the last operation
# was zero.
#
# The "mov $8, %rcx" instruction is there to illustrate that it's not
# the result of the last *instruction* that matters, but rather the
# value of the *CPU status flags*; the CPU has a number of these
# status flags like the zero flag, the sign flag, the carry flag and
# a few others. Typically, these flags are updated when the performing
# an instruction involving the ALU, i.e., when performing arithmetic
# and logical instructions. A MOV does not involve the ALU at all,
# so the status flags do not get updated. 
#
# The status flags do however get updated when we run the DEC instruction.
# The first time around, RAX will be 5 and the DEC instruction decrements
# it to 4. Since 4 is not 0, we do jump up to .loop. Then the same instruction
# runs and decrements to 3, then 2, then 1, and finally to 0. 0 *is* 0, so
# this time we do not take the jump and return from the program with 0
# as the error code.
#
# To run and look at the return code:
#    > gcc 4_loop.S -o loop.exe
#    > loop.exe
#    > echo %errorlevel%
#
# The echo statement will print 0.
  .globl main
main:
  mov $5, %rax
.loop:
  dec %rax
  mov $8, %rcx
  jnz .loop
  ret
