/*
This example reads a file and prints its contents to stdout.

To build and run:
  > gcc 10_read_file.S -o read_file.exe && read_file.exe

The program will print the contents of the file, or an error message
if it fails for some reason.
*/
 .globl main
fopen_mode_read:
  .string "r\0"
filename:
  .string "text_file.txt\0"
error_message:
  .string "Failed to open file\0"
main:
  # Allocate stack frame
  push %rbx
  sub $32, %rsp

  # Open file in read mode
  lea fopen_mode_read, %rdx
  lea filename, %rcx
  call fopen

  # If opening the file failed, fopen returns 0.
  # If so, go to the error handler
  test %rax, %rax
  je fopen_error

  # RAX now holds a valid file pointer. Copy it to RBX
  # so we can use RAX for other stuff.
  mov %rax, %rbx
print_each_char:
  # Pass the file pointer as the first argument to fgetc
  # to put the next byte in the stream into AL (the rest
  # of RAX might not be updated!)
  mov %rbx, %rcx
  call fgetc

  # If AL is 0xff (EOF), we are done
  cmp $0xff, %al
  je close_file

  # AL is not EOF. Copy the byte over to CL and call putchar
  # to print it out
  mov %al, %cl
  call putchar

  # Go to next character
  jmp print_each_char
close_file:
  # Pass the file pointer as the first argument to fclose
  # to close the file.
  mov %rbx, %rcx
  call fclose
  jmp end
fopen_error:
  # Print an error message
  lea error_message, %rcx
  call printf
end:
  # Pop off the stack
  add $32, %rsp
  pop %rbx

  # Return 0
  mov $0, %eax
  ret
