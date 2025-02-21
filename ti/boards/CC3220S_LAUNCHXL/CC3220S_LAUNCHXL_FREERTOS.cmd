/*
 * Copyright (c) 2016-2019, Texas Instruments Incorporated
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * *  Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * *  Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * *  Neither the name of Texas Instruments Incorporated nor the names of
 *    its contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*
 *  ======== CC3220S_LAUNCHXL.cmd ========
 */

--stack_size=1024
--heap_size=0       /* minimize heap since we are using heap_4.c */
--entry_point=resetISR

/*
 * The starting address of the application.  Normally the interrupt vectors
 * must be located at the beginning of the application.
 */
#define SRAM_BASE 0x20004000
#define SRAM2_BASE 0x20000000

MEMORY
{
    SRAM  (RWX) : origin = 0x20004000, length = 0x00040000 - 0x4000
    SRAM2 (RWX) : origin = 0x20000000, length = 0x4000
}

/* Section allocation in memory */

SECTIONS
{
    .text       : > SRAM
    .TI.ramfunc : > SRAM
    .const      : > SRAM
    .rodata     : > SRAM
    .cinit      : > SRAM
    .pinit      : > SRAM
    .init_array : > SRAM

    .data       : > SRAM
    .bss        : > SRAM
    .sysmem     : > SRAM
    .stack      : > SRAM2(HIGH)

    /* these sections are used by FreeRTOS */
    .resetVecs  : > SRAM_BASE
    .ramVecs    : > SRAM2_BASE, type=NOLOAD
}
