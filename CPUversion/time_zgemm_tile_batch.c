/**
 *
 * @file time_zgemm_tile.c
 *
 * @copyright 2009-2014 The University of Tennessee and The University of
 *                      Tennessee Research Foundation. All rights reserved.
 * @copyright 2012-2018 Bordeaux INP, CNRS (LaBRI UMR 5800), Inria,
 *                      Univ. Bordeaux. All rights reserved.
 *
 ***
 *
 * @version 1.0.0
 * @precisions normal z -> c d s
 *
 */
#define _TYPE  CHAMELEON_Complex64_t
#define _PREC  double
#define _LAMCH LAPACKE_dlamch_work

#define _NAME  "CHAMELEON_zgemm_Tile"
/* See Lawn 41 page 120 */
#define _FMULS (((M / iparam[IPARAM_NB]) * (N /  iparam[IPARAM_NB])) * FMULS_GEMM(iparam[IPARAM_NB], iparam[IPARAM_NB], iparam[IPARAM_NB]))
#define _FADDS (((M / iparam[IPARAM_NB]) * (N /  iparam[IPARAM_NB])) * FADDS_GEMM(iparam[IPARAM_NB], iparam[IPARAM_NB], iparam[IPARAM_NB]))

#include "./timing.c"
#include "timing_zauxiliary.h"

static int
RunTest(int *iparam, double *dparam, chameleon_time_t *t_)
{
    CHAMELEON_Complex64_t alpha, beta;
    PASTE_CODE_IPARAM_LOCALS( iparam );

    LDA = chameleon_max(M, iparam[IPARAM_LDA]);
    LDB = chameleon_max(M, iparam[IPARAM_LDB]);
    LDC = chameleon_max(M, iparam[IPARAM_LDC]);

    /* Allocate Data */
    PASTE_CODE_ALLOCATE_MATRIX_TILE( descA, 1, CHAMELEON_Complex64_t, ChamComplexDouble, LDA, M, N );
    PASTE_CODE_ALLOCATE_MATRIX_TILE( descB, 1, CHAMELEON_Complex64_t, ChamComplexDouble, LDB, M, N );
    PASTE_CODE_ALLOCATE_MATRIX_TILE( descC, 1, CHAMELEON_Complex64_t, ChamComplexDouble, LDC, M, N );

    /* Initialize Data */
    CHAMELEON_zplrnt_Tile( descA, 5373 );
    CHAMELEON_zplrnt_Tile( descB, 7672 );
    CHAMELEON_zplrnt_Tile( descC, 6387 );

#if !defined(CHAMELEON_SIMULATION)
    LAPACKE_zlarnv_work(1, ISEED, 1, &alpha);
    LAPACKE_zlarnv_work(1, ISEED, 1, &beta);
#else
    alpha = 1.5;
    beta = -2.3;
#endif
    //    RUNTIME_zlocality_allrestrict( STARPU_GPU );
    START_TIMING();
    CHAMELEON_zgemm_Tile_batch( ChamNoTrans, ChamConjTrans, alpha, descA, descB, beta, descC );
    STOP_TIMING();

    PASTE_CODE_FREE_MATRIX( descA );
    PASTE_CODE_FREE_MATRIX( descB );
    PASTE_CODE_FREE_MATRIX( descC );
    return 0;
}
