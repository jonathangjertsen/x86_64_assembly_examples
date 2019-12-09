/*
 Our first somewhat useful program will calculate and print the Nth fibonacci number real fast.

 To build and run:
    > gcc 9_fibonacci.S -o fibonacci.exe && fibonacci 93

 It will print "Fibonacci number #93 is 12200160415121876738"
*/
 .globl main
 .globl atoi
 .globl printf
message:
 .ascii "Fibonacci number #%d is %llu\n\0"
error_message:
 .ascii "Fibonacci number %d > 93 is too large for this calculator\n\0"
main:
 # Allocate stack frame
  sub $32, %rsp

  # Call atoi with the first command-line argument.
  mov 8(%rdx), %rcx
  call atoi

  # If the result is beyond 93, it's too large to fit in the registers and we should error out
  cmp $93, %rax
  jg error

  # Remember the value so we can print it later
  push %rax

  # Use RCX for the loop counter, RDX for f_n, R8 for f_(n-1) and R9 for f_(n-2).
  mov %rax, %rcx
  mov $0, %rdx
  mov $1, %r8
  mov $0, %r9

  # Do f_n = f_(n-1) + f_(n-2) until the loop counter reaches zero
.loop:
  mov %r8, %rax
  add %r9, %rdx
  mov %r8, %r9
  mov %rdx, %r8
  dec %rcx
  jns .loop

  # Print the number we got with the right argument order
  mov %rdx, %r8
  pop %rax
  mov %rax, %rdx
  lea (message), %rcx
  call printf

  # Done
  jmp end
error:
  mov %rax, %rdx
  lea (error_message), %rcx
  call printf
end:
  # Return 0
  add $32, %rsp
  mov $0, %eax
  ret
