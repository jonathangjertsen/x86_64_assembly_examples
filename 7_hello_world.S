/*
 Using the return code as output is getting a bit tiring, so let's do it the regular way with stdout and strings.

 It is surprisingly difficult to make a useful assembly program without using the C standard library,
 at least with Windows. At least in Linux the system calls are publicly documented. Alas, we will need
 to use some C library functions for I/O. It feels a bit like cheating, but hopefully printf will be all
 we need for a little while.

 There is some new boilerplate related to the stack. This seems to be required to enter and exit cleanly.
 The program will work without them, but then there is a noticeable delay between "Hello world!" being printed
 and the cursor re-appearing in the console. My guess is that the OS is NOT happy about what's going on and has
 to do some serious work to get back into a good state.

 The actual relevant code is the LEAQ (load effective address to quad word) and CALL. When we call a function,
 the ABI (application binary interface) defines which arguments should be put where, and this is platform dependent.
 On Windows, the first 4 integer or pointer arguments should be placed in RCX, RDX, R8 and R9.
 My source for this is https://stackoverflow.com/a/45940640 but the links there are dead, so who knows really.
*/
  .globl main
  .def printf
message:
  .string "Hello, World!\0"
main:
  # Boilerplate for entering
  pushq %rbp
  movq %rsp, %rbp
  subq $48, %rsp

  # RCX should hold the first argument to printf, so we load our message there and then call printf.
  leaq (message), %rcx
  call printf

  # Boilerplate for leaving.
  addq $48, %rsp
  popq %rbp

  # Set error code to 0 (success) and return
  movl $0, %eax
  ret
