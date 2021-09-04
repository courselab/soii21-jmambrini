/* stripcomment-funct.c - Replace copyright note, auxiliary function.
 
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


#include <stdio.h>
#include <stdlib.h>
#include "../config.h"
#include "debug.h"

#define PROGRAM "stripcomment"
#define PROGRAM_VERSION "0.1.0"

/* Program usage information. */

void usage()
{
#define msg(s)   fprintf (stdout, s "\n");
  msg("");
  msg("Usage   " PROGRAM " [[option] | <input-file> [<output-file>]]");
  msg("");
  msg("          Remove comments from source file");
  msg("");
  msg("          <input-file>             if not given, reads from stdin");
  msg("          <output-file>            if not given, writes to stdout");
  msg("");
  msg("          options:   --help        this help");
  msg("                     --version     software version");
  msg("                     -c            first C-style multine comment");
  msg("                     -h            first consecutive hash-comments");
  msg("                     -m            first consecutive m4 comments");
  msg("");
}


void strip_c (FILE *fpin, FILE *fpout, int global);
void strip_Makefile (FILE *fpin, FILE *fpout, int global);
void strip_m4 (FILE *fpin, FILE *fpout, int global);


/* Main program. */

  
int main (int argc, char **argv)
{
  FILE *fpin, *fpout;
  
  fpin = stdin;
  fpout = stdout;

  
  /* Process options. */


  if (argc<2)
    {
      usage();
      exit (EXIT_FAILURE);
    }

  
  if (argc > 1)
    {
      if (!strcmp (argv[1], "--help"))
	{
	  usage();
	  exit(EXIT_SUCCESS);
	}
      if (!strcmp (argv[1], "--version"))
	{
	  printf ("Version: %s %s\n", PROGRAM, PROGRAM_VERSION);
	  exit(EXIT_SUCCESS);
	}

      
      if (argc > 2)
	{
	  fpin = fopen(argv[2], "r");
	  sysfatal(!fpin);
	}
      
      if (argc > 3)
	{
	  fpout = fopen(argv[3], "w");
	  sysfatal(!fpout);
	}
    }
  

  /* Do the actual job. 

     Implemented but not tested option to remove globally (all coments)
     is currently disabled. 
*/

  if (!strcmp (argv[1],"-c"))
    strip_c (fpin, fpout, 0);
  else if (!strcmp (argv[1], "-h"))
    strip_Makefile (fpin, fpout, 0);
  else if (!strcmp (argv[1], "-m"))
    strip_m4 (fpin, fpout, 0);
  else
    fprintf (stderr, "Unkown option\n");
  
  
  return EXIT_SUCCESS;

}




