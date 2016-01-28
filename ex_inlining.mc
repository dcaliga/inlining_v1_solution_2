/* $Id: ex01.mc,v 2.1 2005/06/14 22:16:46 jls Exp $ */

/*
 * Copyright 2005 SRC Computers, Inc.  All Rights Reserved.
 *
 *	Manufactured in the United States of America.
 *
 * SRC Computers, Inc.
 * 4240 N Nevada Avenue
 * Colorado Springs, CO 80907
 * (v) (719) 262-0213
 * (f) (719) 262-0223
 *
 * No permission has been granted to distribute this software
 * without the express permission of SRC Computers, Inc.
 *
 * This program is distributed WITHOUT ANY WARRANTY OF ANY KIND.
 */

#include <libmap.h>


int32_t comp (int64_t a);

void subr (int32_t I0[], int32_t I1[], int32_t Out[], int num, int64_t *time, int mapnum) {

    OBM_BANK_A (AL, int64_t, MAX_OBM_SIZE)
    OBM_BANK_B (BL, int64_t, MAX_OBM_SIZE)
    OBM_BANK_C (CL, int64_t, MAX_OBM_SIZE)
    OBM_BANK_D (DL, int64_t, MAX_OBM_SIZE)

    int64_t t0, t1;
    int64_t j64;
    int i;
    int v,a0,a1,b0,b1,c0,c1;

    Stream_64 SA,SB,SC,SD;


    buffered_dma_cpu (CM2OBM, PATH_0, AL, MAP_OBM_stripe (1,"A"), I0, 1, num*8);
    buffered_dma_cpu (CM2OBM, PATH_0, BL, MAP_OBM_stripe (1,"B"), I1, 1, num*8);


    read_timer (&t0);

    for (i=0; i<num; i++) {
        c0 = comp(AL[i]);
        c1 = comp(BL[i]);
    
 
        comb_32to64 (c1,c0,&CL[i]);

    }

    read_timer (&t1);

    *time = t1 - t0;


    buffered_dma_cpu (OBM2CM, PATH_0, CL, MAP_OBM_stripe (1,"C"), Out, 1, num*8);


}

/*
int32_t comp (int64_t i64) {
    int32_t v;
    int a,b;

    a = (int32_t)((i64<<32)>>32);
    b = (int32_t)(i64>>32);

    v = a + b;
    if (a > b)
        v = v + 42;
    return v * 3;
}
*/
#include "comp.c"
