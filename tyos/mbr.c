/* mbr.c -  MbrCmd commands.
 
   Copyright (c) 2021, Monaco F. J. <monaco@usp.br>
   Copyright (c) 2021, João Pedro S M Ruiz <joao.pedro.ruiz@usp.br>

   This file is part of SYSeg.

   SYSeg is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include <mbr.h>
#include <tyos.h>

/* Output a help(-less) message. */

void __attribute__((naked)) help (void)
{
  printnl ("I wish... (too small a program for anything else).");

  __asm__ ("ret");   	   /* Naked functions lack return. */

}

void date (void)
{
	char d, m, a0, a2;
	char data[11];

  __asm__ volatile
  (
    "		mov	$0x04, %%ah                 ;" /* Read Real Time Clock Date */
    "		int 	$0x1a                       ;" /* Real Time Clock bios service      */
    "		mov	%%ch, %[a0]                 ;"
    "		mov	%%cl, %[a2]                 ;"
    "		mov	%%dh, %[m0]                 ;" /* get higher nibble bcd number      */
    "		mov	%%dl, %[d0]                 ;" /* get higher nibble bcd number      */
   : [d0] "+m" (d), [m0] "+m" (m), [a0] "+m" (a0), [a2] "+m" (a2)
   :
   : "ax", "cx", "dx"
  );

	data[0] = (a0 >> 4) + 48;
	data[1] = (a0 & 15) + 48;
	data[2] = (a2 >> 4) + 48;
	data[3] = (a2 & 15) + 48;
	data[4] = '-';
	data[5] = (m >> 4) + 48;
	data[6] = (m & 15) + 48;
	data[7] = '-';
	data[8] = (d >> 4) + 48;
	data[9] = (d & 15) + 48;
	data[10] = 0;

	print(data);
	print(nl);
}

void time (void)
{
	char s, m, h;
	char time[9];

  __asm__ volatile
  (
    "		mov	$0x02, %%ah                 ;" /* Read Real Time Clock time */
    "		int 	$0x1a                       ;" /* Real Time Clock bios service      */
    "		mov	%%ch, %[h0]                 ;"
    "		mov	%%cl, %[m0]                 ;"
    "		mov	%%dh, %[s0]                 ;" /* get higher nibble bcd number      */
   : [s0] "+m" (s), [m0] "+m" (m), [h0] "+m" (h)
   :
   : "ax", "cx", "dx"
  );

	time[0] = (h >> 4) + 48;
	time[1] = (h & 15) + 48;
	time[2] = ':';
	time[3] = (m >> 4) + 48;
	time[4] = (m & 15) + 48;
	time[5] = ':';
	time[6] = (s >> 4) + 48;
	time[7] = (s & 15) + 48;
	time[8] = 0;

	print(time);
	print(nl);
}

/* Read string from terminal into buffer.

   Note: this function does not check for buffer overrun.
         Buffer size is BUFFER_MAX_LENGTH.

	 Good opportunity for contributing.

*/

void __attribute__((fastcall, naked)) read (char *buffer)
{

    __asm__ volatile
    (

     "   mov $0x0, %%si               ;" /* Iteration index for (%bx, %si).  */
     "loop%=:                         ;"
     "   movw $0X0, %%ax              ;" /* Choose blocking read operation.  */
     "   int $0x16                    ;" /* Call BIOS keyboard read service. */
     "   movb %%al, %%es:(%%bx, %%si) ;" /* Fill in buffer pointed by %bx.   */
     "   inc %%si                     ;"
     "   cmp $0xd, %%al               ;" /* Reiterate if not ascii 13 (CR)   */

     "   mov   $0x0e, %%ah            ;" /* Echo character on the terminal.  */
     "   int $0x10                    ;"

     "   jne loop%=                   ;"

     " mov $0x0e, %%ah                ;" /* Echo a newline.                  */
     " mov $0x0a, %%al                ;"
     "   int $0x10                    ;"

     "   movb $0x0, -1(%%bx, %%si)    ;" /* Add buffer a string delimiter.   */
     "   ret                           " /* Return from function             */

     :
     : "b" (buffer) 	          /* Ask gcc to store buffer in %bx          */
     : "ax",  "cx", "si" 	  /* Aditional clobbered registers.          */
     );


}

/* Compare two strings up to position BUFFER_MAX_LENGTH-1. */

int __attribute__((fastcall, naked)) compare (char *s1, char *s2)
{
  __asm__ volatile
    (
      "    mov %[len], %%cx   ;"
      "    mov $0x1, %%ax     ;"
      "    cld                ;"
      "    repe  cmpsb        ;"
      "    jecxz  equal       ;"
      "    mov $0x0, %%ax     ;"
      "equal:                 ;"
      "    ret                ;"
      :
      : [len] "n" (BUFFER_MAX_LENGTH-1), /* [len] is a constant.   */
	"S" (s1),		/* Ask gcc to store s1 in %si      */
	"D" (s2)		/* Ask gcc to store s2 is %di      */
      : "ax", "cx", "dx"	/* Additional clobbered registers. */
     );

  return 0;                /* Bogus return to fulfill funtion's prototype.*/
}


/* Notes.
   
   We declared all functions with attributes 'naked' and 'fastcall'.

   The 'naked' attribute prevents gcc from outputing asm code beyound
   what is strictly necessary for the particular example to execute.
   In this case, the otherwise extra code would be relevant if we 
   wanted our functions to exchange data using the stack; its omission
   leave us with the burden of taking care of stack integrity ourselves.
   Since we don't use the stack ourselves, we can play with the bare 
   minimal for simplicity.

   One side effect of the 'naked' attribute is that the compiler does not
   output a 'ret' instruction by the end of the function. We have to 
   manually include it via inline asm when applicable.

   Note, for instance, that we've done that in the function void help().

   Note also that in function compare(), we needed to issue 'ret' from within
   the inline asm (since the function is naked), but had to add a C 'return'
   statement as well, so that the preprocessor does not complain based on
   the function prototype. This last return is read by the preprocessor
   but is not converted to a 'ret' instruction by the compiler.

   The other attribute tells the compiler to use the fastcall convention
   to pass parameter among functions. With that, the first argument is
   passed in register %cx and the second in %dx. Further parameters would
   be passed via stack --- and since we opted for naked function, that
   would mean extra work if we had more than three arguments.

   Note that, with fastcall, when we needed the function argument to be 
   copied into another register, say %bx, we could manually do it in asm

       mov %cx, %bx

   or else use GNU extended asm to accomplish this, using the input operands.
   For instance, that's what we did in read() by writing

      : "c" (buffer)

   
   Values are returned by fastcall functions in register %ax.

 */
