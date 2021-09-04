
#include <tyos.h>

void __attribute__((naked)) init()
{
  printnl ("Second stage loaded sucessuflly.");
  
  halt();			/* Halt the system. */
  main_stage2();
}

