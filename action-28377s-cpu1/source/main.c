// Include necessary headers
#include "F28x_Project.h"

/**
 * main.c
 */
int main(void)
{
    // Initialize system clock and other settings
    InitSysCtrl();

    // Disable interrupts
    DINT;

    // Initialize PIE control (position-independent executable)
    InitPieCtrl();

    // Clear interrupt flags
    IER = 0x0000;
    IFR = 0x0000;

    // Initialize the PIE Vector Table
    InitPieVectTable();

    // Enable real-time mode and global interrupts
    ERTM;
    EINT;

    // Infinite loop to keep the program running
    while(1)
    {

    }
}
