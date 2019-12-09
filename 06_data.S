/*
 Below are some ways to define data that we can use in our program.

 In the end, the mov instruction below loads the value stored at the label "long" into RAX.
 RAX will then have the value 0x6789abcd (1737075661 in decimal) when we return, as we will
 see from the error code.

 Here is what the output would be if we changed up the last MOV a bit. As you can see, there are
 many fun and exciting ways to shoot yourself in the foot!

+---------------------------+------------------+--------------+---------------------------------------------------------------------+
| Instruction               | Output (decimal) | Output (hex) | Explanation                                                         |
|---------------------------+------------------+--------------+---------------------------------------------------------------------+
| mov (long), %rax          | 1737075661       | 0x6789abcd   | Seems legit                                                         |
| mov (long), %eax          | 1737075661       | 0x6789abcd   | Seems legit (EAX is the lower 32 bits of RAX)                       |
| mov (long), %ax           | 43981            | 0x0000abcd   | AX is the lower 16 bits of EAX; the lower 16 bits are written       |
| mov (long), %al           | 205              | 0x000000cd   | AL is the lower 8 bits of AX; the lower 8 bits are written          |
| mov (long), %ah           | 205              | 0x0000cd00   | AL is the upper 8 bits of AX; the upper 8 bits are written          |
|---------------------------+------------------+--------------+---------------------------------------------------------------------+
| mov (char), %al           | 1                | 0x00000001   | Seems legit                                                         |
| mov (char), %ah           | 256              | 0x00000100   | Seems legit                                                         |
| mov (char), %ax           | 17665            | 0x00004501   | Lower byte of short is stored next to char, so that gets written    |
| mov (char), %eax          | -853326591       | 0xcd234501   | Now bytes are written from both short and long in addition to char  |
| mov (char), %rax          | -853326591       | 0xcd234501   | Same as above. Seems like return codes are just 32 bits             |
|---------------------------+------------------+--------------+---------------------------------------------------------------------+
| mov (bytearray), %eax     | 1159922159       | 0x452301ef   | All 4 bytes written                                                 |
| mov (bytearray), %ax      | 495              | 0x000001ef   | Lower 2 bytes written                                               |
| mov (bytearray + 1), %ax  | 8961             | 0x00002301   | Lower 2 bytes written starting at the second byte                   |
| mov (bytearray + 2), %ax  | 17699            | 0x00004523   | Lower 2 bytes written starting at the third byte                    |
| mov (bytearray + 3), %ax  | 18501            | 0x00004845   | Lower 3 bytes written starting at the fourth byte, but now we are   |
|                           |                  |              | getting into the 'H' from the string below which is ASCII 72=0x48   |
| mov (bytearray - 1), %ax  | 61287            | 0x0000ef67   | bytearray - 1 points to the upper byte of long                      |
| mov (bytearray - 1), %eax | 587329383        | 0x2301ef67   | Same as above, but we get some more bytes from the array            |
| mov (bytearray - 4), %eax | 1737075661       | 0x6789abcd   | bytearray - 4 is equivalent to long due to the memory layout here   |
|---------------------------+------------------+--------------+---------------------------------------------------------------------+
| mov (string), %eax        | 2189640          | 0x00216948   | The string is just bytes: 0x48='H', 0x69='i', 0x21='!', 0x00='\0'   |
+---------------------------+------------------+--------------+---------------------------------------------------------------------+

 To run and look at the return code:
    > gcc 6_data.S -o data.exe
    > data.exe
    > echo %errorlevel%

 The echo statement will print 1737075661.
*/
  .globl main
  .data
zeros:
    .zero 100
char:        
    .byte 0x01
short:        
    .short 0x2345
long:
    .long 0x6789abcd
bytearray:
    .byte 0xef, 0x01, 0x23, 0x45
string:
    .string "Hi!\0"
  .text
main:
  mov $0, %rax
  mov (bytearray), %eax
  ret
