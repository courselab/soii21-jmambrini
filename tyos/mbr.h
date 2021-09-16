/* mbr.h -  MbrCmd command
 
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

#ifndef MBR_H
#define MBR_H

/* 
 *  Core functions.
 */

/* Print the null-terminated buffer on standard output. */

void date();

void time();

/* 
 * Commands.
 */

/* Prints a help message. */

#define HELP_CMD "help"

/* Prints date. */

#define DATE_CMD "date"

/* Prints time. */

#define TIME_CMD "time"

/* Quit. */

#define QUIT_CMD "quit"

#define quit() printnl("Actually, I can't close the program with this function... You'll need to click on the X.")


#define NOT_FOUND " command not found"

#endif	/* MBR_H */
