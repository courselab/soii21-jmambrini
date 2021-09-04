/* syseg.c - SYSeg information.
 
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


/* This program reads an ASCII file containing a series of byte values
   in hexadcimal representation and converts each one into its binary
   value. For instance, the string "0c" in the input file is converted
   to the value 12 in the output.  */


#include <stdio.h>
#include <stdlib.h>
#include "../config.h"
#include "debug.h"

#define PROGRAM "syseg"

/* Program usage information. */

void usage()
{
#define msg(s)   fprintf (stderr, s "\n");
  msg("");
  msg("Usage   " PROGRAM " [option]");
  msg("");
  msg("          options:   --help        this help");
  msg("                     --version     syseg version");
  msg("");
}

/* Main program. */

int main (int argc, char **argv)
{
  
  /* Process options. */


  if (argc == 1)
    {
      printf ("%s\n", PACKAGE_STRING);
      exit(EXIT_SUCCESS);
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
	  printf ("%s\n", PACKAGE_STRING);
	  exit(EXIT_SUCCESS);
	}
    }

  return EXIT_SUCCESS;
}
