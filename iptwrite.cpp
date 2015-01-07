/*
lptwrite.c

Compile in MATLAB with mex lptwrite.c [-O] [-g] [-v]
For description see lptwrite.m

Copyright (C) 2006 Andreas Widmann, University of Leipzig, widmann@uni-leipzig.de

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

#include "stdio.h"
#include "windows.h"
#include "pt_ioctl.c"
#include "mex.h"
#include "stdafx.h"

typedef void(__stdcall *lpOut32)(short, short);
typedef short(__stdcall *lpInp32)(short);
typedef BOOL(__stdcall *lpIsInpOutDriverOpen)(void);
typedef BOOL(__stdcall *lpIsXP64Bit)(void);

//Some global function pointers (messy but fine for an example)
lpOut32 gfpOut32;
lpInp32 gfpInp32;
lpIsInpOutDriverOpen gfpIsInpOutDriverOpen;
lpIsXP64Bit gfpIsXP64Bit;

void __cdecl mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	double *port, *value;
	int mrows, ncols, arg;

	/* Check for proper number of arguments. */
	if (nrhs != 2) {
		mexErrMsgTxt("Two input arguments required.");
	}
	else if (nlhs > 0) {
		mexErrMsgTxt("Too many output arguments.");
	}

	/* The input must be noncomplex scalar double.*/
	for (arg = 0; arg < 2; arg++) {
		mrows = mxGetM(prhs[arg]);
		ncols = mxGetN(prhs[arg]);
		if (!mxIsDouble(prhs[arg]) || mxIsComplex(prhs[arg]) || !(mrows == 1 && ncols == 1)) {
			mexErrMsgTxt("Input must be noncomplex scalar double.");
		}
	}

	/* Assign pointers to each input and output. */
	port = mxGetData(prhs[0]);
	value = mxGetData(prhs[1]);

	OpenPortTalk();
	outportb(*port, *value);
	ClosePortTalk();

	/* This is where the new code begins    */


	//Dynamically load the DLL at runtime (not linked at compile time)
	HINSTANCE hInpOutDll;
	hInpOutDll = LoadLibrary("InpOutx64.DLL");	//The 32bit DLL. If we are building x64 C++ 
	//applicaiton then use InpOutx64.dll
	if (hInpOutDll != NULL)
	{
		gfpOut32 = (lpOut32)GetProcAddress(hInpOutDll, "Out32");
		gfpInp32 = (lpInp32)GetProcAddress(hInpOutDll, "Inp32");
		gfpIsInpOutDriverOpen = (lpIsInpOutDriverOpen)GetProcAddress(hInpOutDll, "IsInpOutDriverOpen");
		gfpIsXP64Bit = (lpIsXP64Bit)GetProcAddress(hInpOutDll, "IsXP64Bit");

		if (gfpIsInpOutDriverOpen())
		{
			//Make some noise through the PC Speaker - hey it can do more that a single beep using InpOut32
			Beep(2000);
			Sleep(200);
			Beep(1000);
			Sleep(300);
			Beep(2000);
			Sleep(250);
			StopBeep();

			if (!strcmp(argv[1], "read"))
			{
				short iPort = atoi(argv[2]);
				WORD wData = gfpInp32(iPort);	//Read the port
				printf("Data read from address %s is %d \n\n\n\n", argv[2], wData);
			}
			else if (!strcmp(argv[1], "write"))
			{
				if (argc < 4)
				{
					printf("Error in arguments supplied");
					printf("\n***** Usage *****\n\nInpoutTest read <ADDRESS> \nor \nInpoutTest write <ADDRESS> <DATA>\n\n\n\n\n");
				}
				else
				{
					short iPort = atoi(argv[2]);
					WORD wData = atoi(argv[3]);
					gfpOut32(iPort, wData);
					printf("data written to %s\n\n\n", argv[2]);
				}
			}
		}
		else
		{
			printf("Unable to open InpOut32 Driver!\n");
		}

		//All done
		FreeLibrary(hInpOutDll);
		return 0;
	}
	else
	{
		printf("Unable to load InpOut32 DLL!\n");
		return -1;
	}
}
	