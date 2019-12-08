/*
 The last thing we need before being able to build some useful executables is to read command line input.
 Input is provided as strings, and we really mostly want to work with numbers, so we will need to grab
 another C function: atoi. Maybe later we can roll our own.

 As explained previously, RCX, RDX, R8 and R9 hold the arguments passed to a function. That's true for
 the main function too. In C we have "int main(int argc, char **argv)", and here RCX will have the value
 that argc would have in C while RDX will have the value that argv would have in C. We want the pointer
 to the first command-line argument, and that's is argv[1] (argv[0] is the name of the program). Pointers
 are 64 bits = 8 bytes, so we use the move-with-offset notation below to specify that we want to copy the
 value 8 bytes beyond RDX into RCX.

 To build and run:
    > gcc 8_command_line_input.S -o command_line_input.exe && command_line_input 99
*/
 .globl main
 .globl atoi
 .globl printf
message:
 .ascii "Hello %d\0"
main:
 # Allocate stack frame
  sub $32, %rsp

  # Call atoi with the first command-line argument.
  mov 8(%rdx), %rcx
  call atoi

  # Output of atoi is in EAX. Copy it to EDX to make it the second argument to printf.
  # Move the message to RCX to make it the first argument. Then call the function.
  mov %eax, %edx
  lea (message), %rcx
  call printf

  # Return 0
  mov $0, %eax
  add $32, %rsp
  ret
