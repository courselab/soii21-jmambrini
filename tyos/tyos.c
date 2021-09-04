/* tyos.c - The tyOS function library.
 
   Copyright (c) 2021, Monaco F. J. <monaco@usp.br>

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

#include <tyos.h>

void halt()
{

  printnl ("System halted");
  __asm__ volatile
    (
     "loop%=:           ;"
     "        hlt       ;"
     "        jmp loop%=;"
     :::
     );
}


void date (void) {
  __asm__ volatile
  (
    "  mov     $0x04, %%ah  ;" /* Read Real Time Clock Date */
    "  int     $0x1a        ;" /* Real Time Clock bios service      */
    "  mov     $0x0e, %%ah  ;" /* Video BIOS service: teletype mode */
    "  mov     %%ch, %%al   ;"
    "  shr     $4, %%al     ;"
    "  add     $48, %%al    ;"
    "  int     $0x10        ;" /* Call video BIOS service.          */
    "  mov     %%ch, %%al   ;"
    "  and     $15, %%al    ;"
    "  add     $48, %%al    ;"
    "  int     $0x10        ;" /* Call video BIOS service.          */
    "  mov     %%cl, %%al   ;"
    "  shr     $4, %%al     ;"
    "  add     $48, %%al    ;"
    "  int     $0x10        ;" /* Call video BIOS service.          */
    "  mov     %%cl, %%al   ;"
    "  and     $15, %%al    ;"
    "  add     $48, %%al    ;"
    "  int     $0x10        ;" /* Call video BIOS service.          */
    "  mov     $45, %%al    ;"
    "  int     $0x10        ;" /* Call video BIOS service.          */
    "  mov     %%dh, %%al   ;"
    "  shr     $4, %%al     ;"
    "  add     $48, %%al    ;"
    "  int     $0x10        ;" /* Call video BIOS service.          */
    "  mov     %%dh, %%al   ;"
    "  and     $15, %%al    ;"
    "  add     $48, %%al    ;"
    "  int     $0x10        ;" /* Call video BIOS service.          */
    "  mov     $45, %%al    ;"
    "  int     $0x10        ;" /* Call video BIOS service.          */
    "  mov     %%cl, %%al   ;"
    "  shr     $4, %%al     ;"
    "  add     $48, %%al    ;"
    "  int     $0x10        ;" /* Call video BIOS service.          */
    "  mov     %%cl, %%al   ;"
    "  and     $15, %%al    ;"
    "  add     $48, %%al    ;"
    "  int     $0x10        ;" /* Call video BIOS service.          */
  :
  :
  : "ax", "cx", "dx"
  );

  print(nl);
}

void time (void) {
  __asm__ volatile
  (
    "  mov     $0x04, %%ah  ;" /* Read Real Time Clock Date */
    "  int     $0x1a        ;" /* Real Time Clock bios service      */
    "  mov     $0x0e, %%ah  ;" /* Video BIOS service: teletype mode */
    "  mov     %%ch, %%al   ;"
    "  shr     $4, %%al     ;"
    "  add     $48, %%al    ;"
    "  int     $0x10        ;" /* Call video BIOS service.          */
    "  mov     %%ch, %%al   ;"
    "  and     $15, %%al    ;"
    "  add     $48, %%al    ;"
    "  int     $0x10        ;" /* Call video BIOS service.          */
    "  mov     $58, %%al    ;"
    "  int     $0x10        ;" /* Call video BIOS service.          */
    "  mov     %%cl, %%al   ;"
    "  shr     $4, %%al     ;"
    "  add     $48, %%al    ;"
    "  int     $0x10        ;" /* Call video BIOS service.          */
    "  mov     %%cl, %%al   ;"
    "  and     $15, %%al    ;"
    "  add     $48, %%al    ;"
    "  int     $0x10        ;" /* Call video BIOS service.          */
    "  mov     $58, %%al    ;"
    "  int     $0x10        ;" /* Call video BIOS service.          */
    "  mov     %%dh, %%al   ;"
    "  shr     $4, %%al     ;"
    "  add     $48, %%al    ;"
    "  int     $0x10        ;" /* Call video BIOS service.          */
    "  mov     %%dh, %%al   ;"
    "  and     $15, %%al    ;"
    "  add     $48, %%al    ;"
    "  int     $0x10        ;" /* Call video BIOS service.          */
   :
   :
   : "ax", "cx", "dx"
  );

       print(nl);
}

void main_stage2(){
  char cmd[BUFFER_MAX_LENGTH];

  /* Clear screen. */

  clear();

  /* Main loop. */

  while (1) {

      print (PROMPT);                  /* Show prompt. */

      read (cmd);                      /* Read user command. */

      /* Process user command. */

      if (compare(cmd, HELP_CMD))       /* Command help. */
       help();
      else if (compare(cmd, TIME_CMD))  /* Command time. */
       time();
      else if (compare(cmd, DATE_CMD))  /* Command date. */
       date();
      else if (compare(cmd, QUIT_CMD))  /* Command quit. */
       quit();
      else
       {
         print (cmd);                  /* Unknown command. */
         printnl (NOT_FOUND);
       }
    }

}

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
       "S" (s1),               /* Ask gcc to store s1 in %si      */
       "D" (s2)                /* Ask gcc to store s2 is %di      */
      : "ax", "cx", "dx"       /* Additional clobbered registers. */
     );

  return 0;                /* Bogus return to fulfill funtion's prototype.*/
}

void __attribute__((naked)) help (void)
{
  printnl ("I wish... (too small a program for anything else).");

  __asm__ ("ret");        /* Naked functions lack return. */

}

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
     : "b" (buffer)              /* Ask gcc to store buffer in %bx          */
     : "ax",  "cx", "si"         /* Aditional clobbered registers.          */
     );


}