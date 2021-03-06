;/*
; * Copyright (c) 2018 ARM Limited
; *
; * Licensed under the Apache License, Version 2.0 (the "License");
; * you may not use this file except in compliance with the License.
; * You may obtain a copy of the License at
; *
; *     http://www.apache.org/licenses/LICENSE-2.0
; *
; * Unless required by applicable law or agreed to in writing, software
; * distributed under the License is distributed on an "AS IS" BASIS,
; * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
; * See the License for the specific language governing permissions and
; * limitations under the License.
; *
; *
; * This file is derivative of CMSIS V5.00 gcc_arm.ld
; */

/*********** WARNING: This is an auto-generated file. Do not edit! ***********/

/* Linker script to configure memory regions. */
/* This file will be run trough the pre-processor. */

#include "region_defs.h"

MEMORY
{
  FLASH   (rx)  : ORIGIN = S_CODE_START, LENGTH = S_CODE_SIZE
  RAM     (rwx) : ORIGIN = S_DATA_START, LENGTH = S_DATA_SIZE
  VENEERS (rx)  : ORIGIN = CMSE_VENEER_REGION_START, LENGTH = CMSE_VENEER_REGION_SIZE
}

__heap_size__  = 0x00001000;
__psp_stack_size__ = 0x00001000;
__msp_stack_size__ = 0x00000800;

/* Library configurations */
GROUP(libgcc.a libc.a libm.a libnosys.a)

ENTRY(Reset_Handler)

/*
 * The test service veneers may not be referenced in the secure binary so the
 * veneer objects are explicitly declared here as extern, so the linker includes
 * the veneers in the resulting binary.
 */
EXTERN(sst_test_service_veneer_setup)
EXTERN(tfm_secure_client_service_veneer_run_tests)

SECTIONS
{
    .TFM_VECTORS : ALIGN(4)
    {
        __vectors_start__ = .;
        KEEP(*(.vectors))
        *startup*(.text*)
        . = ALIGN(4);
        __vectors_end__ = .;
    } > FLASH

#if TFM_LVL == 1
    .copy.table : ALIGN(4)
    {
        __copy_table_start__ = .;
        LONG (LOADADDR(.TFM_DATA))
        LONG (ADDR(.TFM_DATA))
        LONG (SIZEOF(.TFM_DATA))
        __copy_table_end__ = .;
    } > FLASH

    .zero.table : ALIGN(4)
    {
        __zero_table_start__ = .;
        LONG (ADDR(.TFM_BSS))
        LONG (SIZEOF(.TFM_BSS))
        LONG (ADDR(.TFM_SECURE_STACK))
        LONG (SIZEOF(.TFM_SECURE_STACK))
        LONG (ADDR(.TFM_UNPRIV_SCRATCH))
        LONG (SIZEOF(.TFM_UNPRIV_SCRATCH))
        __zero_table_end__ = .;
    } > FLASH

#else /* TFM_LVL == 1 */
    .copy.table : ALIGN(4)
    {
        __copy_table_start__ = .;
        LONG (LOADADDR(.TFM_DATA))
        LONG (ADDR(.TFM_DATA))
        LONG (SIZEOF(.TFM_DATA))
        LONG (LOADADDR(.TFM_UNPRIV_RO_DATA))
        LONG (ADDR(.TFM_UNPRIV_RO_DATA))
        LONG (SIZEOF(.TFM_UNPRIV_RO_DATA))
        LONG (LOADADDR(.TFM_SP_STORAGE_DATA))
        LONG (ADDR(.TFM_SP_STORAGE_DATA))
        LONG (SIZEOF(.TFM_SP_STORAGE_DATA))
        LONG (LOADADDR(.TFM_SP_AUDIT_LOG_DATA))
        LONG (ADDR(.TFM_SP_AUDIT_LOG_DATA))
        LONG (SIZEOF(.TFM_SP_AUDIT_LOG_DATA))
#ifdef TFM_PARTITION_TEST_CORE
        LONG (LOADADDR(.TFM_SP_CORE_TEST_DATA))
        LONG (ADDR(.TFM_SP_CORE_TEST_DATA))
        LONG (SIZEOF(.TFM_SP_CORE_TEST_DATA))
#endif /* TFM_PARTITION_TEST_CORE */
#ifdef TFM_PARTITION_TEST_CORE
        LONG (LOADADDR(.TFM_SP_CORE_TEST_2_DATA))
        LONG (ADDR(.TFM_SP_CORE_TEST_2_DATA))
        LONG (SIZEOF(.TFM_SP_CORE_TEST_2_DATA))
#endif /* TFM_PARTITION_TEST_CORE */
#ifdef TFM_PARTITION_TEST_SST
        LONG (LOADADDR(.TFM_SP_SST_TEST_PARTITION_DATA))
        LONG (ADDR(.TFM_SP_SST_TEST_PARTITION_DATA))
        LONG (SIZEOF(.TFM_SP_SST_TEST_PARTITION_DATA))
#endif /* TFM_PARTITION_TEST_SST */
#ifdef TFM_PARTITION_TEST_SECURE_SERVICES
        LONG (LOADADDR(.TFM_SP_SECURE_TEST_PARTITION_DATA))
        LONG (ADDR(.TFM_SP_SECURE_TEST_PARTITION_DATA))
        LONG (SIZEOF(.TFM_SP_SECURE_TEST_PARTITION_DATA))
#endif /* TFM_PARTITION_TEST_SECURE_SERVICES */
        __copy_table_end__ = .;
    } > FLASH

    .zero.table : ALIGN(4)
    {
        __zero_table_start__ = .;
        LONG (ADDR(.TFM_BSS))
        LONG (SIZEOF(.TFM_BSS))
        LONG (ADDR(.TFM_UNPRIV_RO_BSS))
        LONG (SIZEOF(.TFM_UNPRIV_RO_BSS))
        LONG (ADDR(.TFM_SP_STORAGE_BSS))
        LONG (SIZEOF(.TFM_SP_STORAGE_BSS))
        LONG (ADDR(.TFM_SP_STORAGE_STACK))
        LONG (SIZEOF(.TFM_SP_STORAGE_STACK))
        LONG (ADDR(.TFM_SP_AUDIT_LOG_BSS))
        LONG (SIZEOF(.TFM_SP_AUDIT_LOG_BSS))
        LONG (ADDR(.TFM_SP_AUDIT_LOG_STACK))
        LONG (SIZEOF(.TFM_SP_AUDIT_LOG_STACK))
#ifdef TFM_PARTITION_TEST_CORE
        LONG (ADDR(.TFM_SP_CORE_TEST_BSS))
        LONG (SIZEOF(.TFM_SP_CORE_TEST_BSS))
        LONG (ADDR(.TFM_SP_CORE_TEST_STACK))
        LONG (SIZEOF(.TFM_SP_CORE_TEST_STACK))
#endif /* TFM_PARTITION_TEST_CORE */
#ifdef TFM_PARTITION_TEST_CORE
        LONG (ADDR(.TFM_SP_CORE_TEST_2_BSS))
        LONG (SIZEOF(.TFM_SP_CORE_TEST_2_BSS))
        LONG (ADDR(.TFM_SP_CORE_TEST_2_STACK))
        LONG (SIZEOF(.TFM_SP_CORE_TEST_2_STACK))
#endif /* TFM_PARTITION_TEST_CORE */
#ifdef TFM_PARTITION_TEST_SST
        LONG (ADDR(.TFM_SP_SST_TEST_PARTITION_BSS))
        LONG (SIZEOF(.TFM_SP_SST_TEST_PARTITION_BSS))
        LONG (ADDR(.TFM_SP_SST_TEST_PARTITION_STACK))
        LONG (SIZEOF(.TFM_SP_SST_TEST_PARTITION_STACK))
#endif /* TFM_PARTITION_TEST_SST */
#ifdef TFM_PARTITION_TEST_SECURE_SERVICES
        LONG (ADDR(.TFM_SP_SECURE_TEST_PARTITION_BSS))
        LONG (SIZEOF(.TFM_SP_SECURE_TEST_PARTITION_BSS))
        LONG (ADDR(.TFM_SP_SECURE_TEST_PARTITION_STACK))
        LONG (SIZEOF(.TFM_SP_SECURE_TEST_PARTITION_STACK))
#endif /* TFM_PARTITION_TEST_SECURE_SERVICES */
        LONG (ADDR(.TFM_UNPRIV_SCRATCH))
        LONG (SIZEOF(.TFM_UNPRIV_SCRATCH))
        __zero_table_end__ = .;
    } > FLASH

    .TFM_UNPRIV_CODE : ALIGN(32)
    {
        *tfm_unpriv_api.o(.text*)
        *tfm_unpriv_api.o(.rodata*)
        *tfm_sst_secure_api.o(.text*)
        *tfm_sst_secure_api.o(.rodata*)
        *dummy_crypto_keys.o(.text*)
        *dummy_crypto_keys.o(.rodata*)
        *platform_retarget_dev.o(.text*)
        *platform_retarget_dev.o(.rodata*)
        *(SFN)
        *libgcc*:*(.text*)
        *libgcc*:*(.rodata*)
        . = ALIGN(32);
    } > FLASH
    Image$$TFM_UNPRIV_CODE$$RO$$Base = ADDR(.TFM_UNPRIV_CODE);
    Image$$TFM_UNPRIV_CODE$$RO$$Limit = ADDR(.TFM_UNPRIV_CODE) + SIZEOF(.TFM_UNPRIV_CODE);

    .TFM_SP_STORAGE : ALIGN(32)
    {
        *tfm_storage*:*(.text*)
        *tfm_storage*:*(.rodata*)
        . = ALIGN(32);
    } > FLASH
    Image$$TFM_SP_STORAGE$$RO$$Base = ADDR(.TFM_SP_STORAGE);
    Image$$TFM_SP_STORAGE$$RO$$Limit = ADDR(.TFM_SP_STORAGE) + SIZEOF(.TFM_SP_STORAGE);
    Image$$TFM_SP_STORAGE$$Base = ADDR(.TFM_SP_STORAGE);
    Image$$TFM_SP_STORAGE$$Limit = ADDR(.TFM_SP_STORAGE) + SIZEOF(.TFM_SP_STORAGE);

    .TFM_SP_AUDIT_LOG : ALIGN(32)
    {
        *tfm_audit*:*(.text*)
        *tfm_audit*:*(.rodata*)
        . = ALIGN(32);
    } > FLASH
    Image$$TFM_SP_AUDIT_LOG$$RO$$Base = ADDR(.TFM_SP_AUDIT_LOG);
    Image$$TFM_SP_AUDIT_LOG$$RO$$Limit = ADDR(.TFM_SP_AUDIT_LOG) + SIZEOF(.TFM_SP_AUDIT_LOG);
    Image$$TFM_SP_AUDIT_LOG$$Base = ADDR(.TFM_SP_AUDIT_LOG);
    Image$$TFM_SP_AUDIT_LOG$$Limit = ADDR(.TFM_SP_AUDIT_LOG) + SIZEOF(.TFM_SP_AUDIT_LOG);

#ifdef TFM_PARTITION_TEST_CORE
    .TFM_SP_CORE_TEST : ALIGN(32)
    {
        *tfm_ss_core_test.*(.text*)
        *tfm_ss_core_test.*(.rodata*)
        . = ALIGN(32);
    } > FLASH
    Image$$TFM_SP_CORE_TEST$$RO$$Base = ADDR(.TFM_SP_CORE_TEST);
    Image$$TFM_SP_CORE_TEST$$RO$$Limit = ADDR(.TFM_SP_CORE_TEST) + SIZEOF(.TFM_SP_CORE_TEST);
    Image$$TFM_SP_CORE_TEST$$Base = ADDR(.TFM_SP_CORE_TEST);
    Image$$TFM_SP_CORE_TEST$$Limit = ADDR(.TFM_SP_CORE_TEST) + SIZEOF(.TFM_SP_CORE_TEST);

#endif /* TFM_PARTITION_TEST_CORE */
#ifdef TFM_PARTITION_TEST_CORE
    .TFM_SP_CORE_TEST_2 : ALIGN(32)
    {
        *tfm_ss_core_test_2.*(.text*)
        *tfm_ss_core_test_2.*(.rodata*)
        . = ALIGN(32);
    } > FLASH
    Image$$TFM_SP_CORE_TEST_2$$RO$$Base = ADDR(.TFM_SP_CORE_TEST_2);
    Image$$TFM_SP_CORE_TEST_2$$RO$$Limit = ADDR(.TFM_SP_CORE_TEST_2) + SIZEOF(.TFM_SP_CORE_TEST_2);
    Image$$TFM_SP_CORE_TEST_2$$Base = ADDR(.TFM_SP_CORE_TEST_2);
    Image$$TFM_SP_CORE_TEST_2$$Limit = ADDR(.TFM_SP_CORE_TEST_2) + SIZEOF(.TFM_SP_CORE_TEST_2);

#endif /* TFM_PARTITION_TEST_CORE */
#ifdef TFM_PARTITION_TEST_SST
    .TFM_SP_SST_TEST_PARTITION : ALIGN(32)
    {
        *sst_test_service.*(.text*)
        *sst_test_service.*(.rodata*)
        . = ALIGN(32);
    } > FLASH
    Image$$TFM_SP_SST_TEST_PARTITION$$RO$$Base = ADDR(.TFM_SP_SST_TEST_PARTITION);
    Image$$TFM_SP_SST_TEST_PARTITION$$RO$$Limit = ADDR(.TFM_SP_SST_TEST_PARTITION) + SIZEOF(.TFM_SP_SST_TEST_PARTITION);
    Image$$TFM_SP_SST_TEST_PARTITION$$Base = ADDR(.TFM_SP_SST_TEST_PARTITION);
    Image$$TFM_SP_SST_TEST_PARTITION$$Limit = ADDR(.TFM_SP_SST_TEST_PARTITION) + SIZEOF(.TFM_SP_SST_TEST_PARTITION);

#endif /* TFM_PARTITION_TEST_SST */
#ifdef TFM_PARTITION_TEST_SECURE_SERVICES
    .TFM_SP_SECURE_TEST_PARTITION : ALIGN(32)
    {
        *tfm_secure_client_service.*(.text*)
        *tfm_secure_client_service.*(.rodata*)
        . = ALIGN(32);
    } > FLASH
    Image$$TFM_SP_SECURE_TEST_PARTITION$$RO$$Base = ADDR(.TFM_SP_SECURE_TEST_PARTITION);
    Image$$TFM_SP_SECURE_TEST_PARTITION$$RO$$Limit = ADDR(.TFM_SP_SECURE_TEST_PARTITION) + SIZEOF(.TFM_SP_SECURE_TEST_PARTITION);
    Image$$TFM_SP_SECURE_TEST_PARTITION$$Base = ADDR(.TFM_SP_SECURE_TEST_PARTITION);
    Image$$TFM_SP_SECURE_TEST_PARTITION$$Limit = ADDR(.TFM_SP_SECURE_TEST_PARTITION) + SIZEOF(.TFM_SP_SECURE_TEST_PARTITION);

#endif /* TFM_PARTITION_TEST_SECURE_SERVICES */

    .ARM.extab :
    {
        *(.ARM.extab* .gnu.linkonce.armextab.*)
    } > FLASH

    __exidx_start = .;
    .ARM.exidx :
    {
        *(.ARM.exidx* .gnu.linkonce.armexidx.*)
    } > FLASH
    __exidx_end = .;

#endif /* TFM_LVL == 1 */

    .ER_TFM_CODE :
    {
        *(.text*)

        KEEP(*(.init))
        KEEP(*(.fini))


        /* .ctors */
        *crtbegin.o(.ctors)
        *crtbegin?.o(.ctors)
        *(EXCLUDE_FILE(*crtend?.o *crtend.o) .ctors)
        *(SORT(.ctors.*))
        *(.ctors)

        /* .dtors */
         *crtbegin.o(.dtors)
         *crtbegin?.o(.dtors)
         *(EXCLUDE_FILE(*crtend?.o *crtend.o) .dtors)
         *(SORT(.dtors.*))
         *(.dtors)

        *(.rodata*)

        KEEP(*(.eh_frame*))
    } > FLASH

#if TFM_LVL == 1

    .TFM_SECURE_STACK : ALIGN(128)
    {
        . += 0x4000;
    } > RAM AT> FLASH
    Image$$TFM_SECURE_STACK$$ZI$$Base = ADDR(.TFM_SECURE_STACK);
    Image$$TFM_SECURE_STACK$$ZI$$Limit = ADDR(.TFM_SECURE_STACK) + SIZEOF(.TFM_SECURE_STACK);

    .TFM_UNPRIV_SCRATCH : ALIGN(32)
    {
        . += 0x400;
    } > RAM AT> FLASH
    Image$$TFM_UNPRIV_SCRATCH$$ZI$$Base = ADDR(.TFM_UNPRIV_SCRATCH);
    Image$$TFM_UNPRIV_SCRATCH$$ZI$$Limit = ADDR(.TFM_UNPRIV_SCRATCH) + SIZEOF(.TFM_UNPRIV_SCRATCH);

#else /* TFM_LVL == 1 */
    .TFM_UNPRIV_RO_DATA :
    {
        */tfm_unpriv_api.o(.data*)
        */tfm_sst_secure_api.o(.data*)
        */dummy_crypto_keys.o(.data*)
        */platform_retarget_dev.o(.data*)
        . = ALIGN(32);
    } > RAM AT> FLASH
    Image$$TFM_UNPRIV_RO_DATA$$RW$$Base = ADDR(.TFM_UNPRIV_RO_DATA);
    Image$$TFM_UNPRIV_RO_DATA$$RW$$Limit = ADDR(.TFM_UNPRIV_RO_DATA) + SIZEOF(.TFM_UNPRIV_RO_DATA);

    .TFM_UNPRIV_RO_BSS : ALIGN(32)
    {
        */tfm_unpriv_api.o(.bss*)
        */tfm_sst_secure_api.o(.bss*)
        */platform_retarget_dev.o(.bss*)
        */dummy_crypto_keys.o(.bss*)
        */tfm_unpriv_api.o(COMMON)
        */tfm_sst_secure_api.o(COMMON)
        */platform_retarget_dev.o(COMMON)
        */dummy_crypto_keys.o(COMMON)
        . = ALIGN(32);
    } > RAM AT> FLASH
    Image$$TFM_UNPRIV_RO_DATA$$ZI$$Base = ADDR(.TFM_UNPRIV_RO_BSS);
    Image$$TFM_UNPRIV_RO_DATA$$ZI$$Limit = ADDR(.TFM_UNPRIV_RO_BSS) + SIZEOF(.TFM_UNPRIV_RO_BSS);

    .TFM_UNPRIV_SCRATCH : ALIGN(32)
    {
        . += 0x400;
    } > RAM AT> FLASH
    Image$$TFM_UNPRIV_SCRATCH$$ZI$$Base = ADDR(.TFM_UNPRIV_SCRATCH);
    Image$$TFM_UNPRIV_SCRATCH$$ZI$$Limit = ADDR(.TFM_UNPRIV_SCRATCH) + SIZEOF(.TFM_UNPRIV_SCRATCH);

    .TFM_SP_STORAGE_DATA : ALIGN(32)
    {
        *tfm_storage*:*(.data*)
        . = ALIGN(32);
    } > RAM AT> FLASH
    Image$$TFM_SP_STORAGE_DATA$$RW$$Base = ADDR(.TFM_SP_STORAGE_DATA);
    Image$$TFM_SP_STORAGE_DATA$$RW$$Limit = ADDR(.TFM_SP_STORAGE_DATA) + SIZEOF(.TFM_SP_STORAGE_DATA);

    .TFM_SP_STORAGE_BSS : ALIGN(32)
    {
        *tfm_storage*:*(.bss*)
        *tfm_storage*:*(COMMON)
        . = ALIGN(32);
    } > RAM AT> FLASH
    Image$$TFM_SP_STORAGE_DATA$$ZI$$Base = ADDR(.TFM_SP_STORAGE_BSS);
    Image$$TFM_SP_STORAGE_DATA$$ZI$$Limit = ADDR(.TFM_SP_STORAGE_BSS) + SIZEOF(.TFM_SP_STORAGE_BSS);

    .TFM_SP_STORAGE_STACK : ALIGN(128)
    {
        . += 0x2000;
    } > RAM AT> FLASH
    Image$$TFM_SP_STORAGE_STACK$$ZI$$Base = ADDR(.TFM_SP_STORAGE_STACK);
    Image$$TFM_SP_STORAGE_STACK$$ZI$$Limit = ADDR(.TFM_SP_STORAGE_STACK) + SIZEOF(.TFM_SP_STORAGE_STACK);

    .TFM_SP_AUDIT_LOG_DATA : ALIGN(32)
    {
        *tfm_audit*:*(.data*)
        . = ALIGN(32);
    } > RAM AT> FLASH
    Image$$TFM_SP_AUDIT_LOG_DATA$$RW$$Base = ADDR(.TFM_SP_AUDIT_LOG_DATA);
    Image$$TFM_SP_AUDIT_LOG_DATA$$RW$$Limit = ADDR(.TFM_SP_AUDIT_LOG_DATA) + SIZEOF(.TFM_SP_AUDIT_LOG_DATA);

    .TFM_SP_AUDIT_LOG_BSS : ALIGN(32)
    {
        *tfm_audit*:*(.bss*)
        *tfm_audit*:*(COMMON)
        . = ALIGN(32);
    } > RAM AT> FLASH
    Image$$TFM_SP_AUDIT_LOG_DATA$$ZI$$Base = ADDR(.TFM_SP_AUDIT_LOG_BSS);
    Image$$TFM_SP_AUDIT_LOG_DATA$$ZI$$Limit = ADDR(.TFM_SP_AUDIT_LOG_BSS) + SIZEOF(.TFM_SP_AUDIT_LOG_BSS);

    .TFM_SP_AUDIT_LOG_STACK : ALIGN(128)
    {
        . += 0x1000;
    } > RAM AT> FLASH
    Image$$TFM_SP_AUDIT_LOG_STACK$$ZI$$Base = ADDR(.TFM_SP_AUDIT_LOG_STACK);
    Image$$TFM_SP_AUDIT_LOG_STACK$$ZI$$Limit = ADDR(.TFM_SP_AUDIT_LOG_STACK) + SIZEOF(.TFM_SP_AUDIT_LOG_STACK);

#ifdef TFM_PARTITION_TEST_CORE
    .TFM_SP_CORE_TEST_DATA : ALIGN(32)
    {
        *tfm_ss_core_test.*(.data*)
        . = ALIGN(32);
    } > RAM AT> FLASH
    Image$$TFM_SP_CORE_TEST_DATA$$RW$$Base = ADDR(.TFM_SP_CORE_TEST_DATA);
    Image$$TFM_SP_CORE_TEST_DATA$$RW$$Limit = ADDR(.TFM_SP_CORE_TEST_DATA) + SIZEOF(.TFM_SP_CORE_TEST_DATA);

    .TFM_SP_CORE_TEST_BSS : ALIGN(32)
    {
        *tfm_ss_core_test.*(.bss*)
        *tfm_ss_core_test.*(COMMON)
        . = ALIGN(32);
    } > RAM AT> FLASH
    Image$$TFM_SP_CORE_TEST_DATA$$ZI$$Base = ADDR(.TFM_SP_CORE_TEST_BSS);
    Image$$TFM_SP_CORE_TEST_DATA$$ZI$$Limit = ADDR(.TFM_SP_CORE_TEST_BSS) + SIZEOF(.TFM_SP_CORE_TEST_BSS);

    .TFM_SP_CORE_TEST_STACK : ALIGN(128)
    {
        . += 0x2000;
    } > RAM AT> FLASH
    Image$$TFM_SP_CORE_TEST_STACK$$ZI$$Base = ADDR(.TFM_SP_CORE_TEST_STACK);
    Image$$TFM_SP_CORE_TEST_STACK$$ZI$$Limit = ADDR(.TFM_SP_CORE_TEST_STACK) + SIZEOF(.TFM_SP_CORE_TEST_STACK);

#endif /* TFM_PARTITION_TEST_CORE */
#ifdef TFM_PARTITION_TEST_CORE
    .TFM_SP_CORE_TEST_2_DATA : ALIGN(32)
    {
        *tfm_ss_core_test_2.*(.data*)
        . = ALIGN(32);
    } > RAM AT> FLASH
    Image$$TFM_SP_CORE_TEST_2_DATA$$RW$$Base = ADDR(.TFM_SP_CORE_TEST_2_DATA);
    Image$$TFM_SP_CORE_TEST_2_DATA$$RW$$Limit = ADDR(.TFM_SP_CORE_TEST_2_DATA) + SIZEOF(.TFM_SP_CORE_TEST_2_DATA);

    .TFM_SP_CORE_TEST_2_BSS : ALIGN(32)
    {
        *tfm_ss_core_test_2.*(.bss*)
        *tfm_ss_core_test_2.*(COMMON)
        . = ALIGN(32);
    } > RAM AT> FLASH
    Image$$TFM_SP_CORE_TEST_2_DATA$$ZI$$Base = ADDR(.TFM_SP_CORE_TEST_2_BSS);
    Image$$TFM_SP_CORE_TEST_2_DATA$$ZI$$Limit = ADDR(.TFM_SP_CORE_TEST_2_BSS) + SIZEOF(.TFM_SP_CORE_TEST_2_BSS);

    .TFM_SP_CORE_TEST_2_STACK : ALIGN(128)
    {
        . += 0x2000;
    } > RAM AT> FLASH
    Image$$TFM_SP_CORE_TEST_2_STACK$$ZI$$Base = ADDR(.TFM_SP_CORE_TEST_2_STACK);
    Image$$TFM_SP_CORE_TEST_2_STACK$$ZI$$Limit = ADDR(.TFM_SP_CORE_TEST_2_STACK) + SIZEOF(.TFM_SP_CORE_TEST_2_STACK);

#endif /* TFM_PARTITION_TEST_CORE */
#ifdef TFM_PARTITION_TEST_SST
    .TFM_SP_SST_TEST_PARTITION_DATA : ALIGN(32)
    {
        *sst_test_service.*(.data*)
        . = ALIGN(32);
    } > RAM AT> FLASH
    Image$$TFM_SP_SST_TEST_PARTITION_DATA$$RW$$Base = ADDR(.TFM_SP_SST_TEST_PARTITION_DATA);
    Image$$TFM_SP_SST_TEST_PARTITION_DATA$$RW$$Limit = ADDR(.TFM_SP_SST_TEST_PARTITION_DATA) + SIZEOF(.TFM_SP_SST_TEST_PARTITION_DATA);

    .TFM_SP_SST_TEST_PARTITION_BSS : ALIGN(32)
    {
        *sst_test_service.*(.bss*)
        *sst_test_service.*(COMMON)
        . = ALIGN(32);
    } > RAM AT> FLASH
    Image$$TFM_SP_SST_TEST_PARTITION_DATA$$ZI$$Base = ADDR(.TFM_SP_SST_TEST_PARTITION_BSS);
    Image$$TFM_SP_SST_TEST_PARTITION_DATA$$ZI$$Limit = ADDR(.TFM_SP_SST_TEST_PARTITION_BSS) + SIZEOF(.TFM_SP_SST_TEST_PARTITION_BSS);

    .TFM_SP_SST_TEST_PARTITION_STACK : ALIGN(128)
    {
        . += 0x2000;
    } > RAM AT> FLASH
    Image$$TFM_SP_SST_TEST_PARTITION_STACK$$ZI$$Base = ADDR(.TFM_SP_SST_TEST_PARTITION_STACK);
    Image$$TFM_SP_SST_TEST_PARTITION_STACK$$ZI$$Limit = ADDR(.TFM_SP_SST_TEST_PARTITION_STACK) + SIZEOF(.TFM_SP_SST_TEST_PARTITION_STACK);

#endif /* TFM_PARTITION_TEST_SST */
#ifdef TFM_PARTITION_TEST_SECURE_SERVICES
    .TFM_SP_SECURE_TEST_PARTITION_DATA : ALIGN(32)
    {
        *tfm_secure_client_service.*(.data*)
        . = ALIGN(32);
    } > RAM AT> FLASH
    Image$$TFM_SP_SECURE_TEST_PARTITION_DATA$$RW$$Base = ADDR(.TFM_SP_SECURE_TEST_PARTITION_DATA);
    Image$$TFM_SP_SECURE_TEST_PARTITION_DATA$$RW$$Limit = ADDR(.TFM_SP_SECURE_TEST_PARTITION_DATA) + SIZEOF(.TFM_SP_SECURE_TEST_PARTITION_DATA);

    .TFM_SP_SECURE_TEST_PARTITION_BSS : ALIGN(32)
    {
        *tfm_secure_client_service.*(.bss*)
        *tfm_secure_client_service.*(COMMON)
        . = ALIGN(32);
    } > RAM AT> FLASH
    Image$$TFM_SP_SECURE_TEST_PARTITION_DATA$$ZI$$Base = ADDR(.TFM_SP_SECURE_TEST_PARTITION_BSS);
    Image$$TFM_SP_SECURE_TEST_PARTITION_DATA$$ZI$$Limit = ADDR(.TFM_SP_SECURE_TEST_PARTITION_BSS) + SIZEOF(.TFM_SP_SECURE_TEST_PARTITION_BSS);

    .TFM_SP_SECURE_TEST_PARTITION_STACK : ALIGN(128)
    {
        . += 0x2000;
    } > RAM AT> FLASH
    Image$$TFM_SP_SECURE_TEST_PARTITION_STACK$$ZI$$Base = ADDR(.TFM_SP_SECURE_TEST_PARTITION_STACK);
    Image$$TFM_SP_SECURE_TEST_PARTITION_STACK$$ZI$$Limit = ADDR(.TFM_SP_SECURE_TEST_PARTITION_STACK) + SIZEOF(.TFM_SP_SECURE_TEST_PARTITION_STACK);

#endif /* TFM_PARTITION_TEST_SECURE_SERVICES */
#endif /* TFM_LVL == 1 */

    .TFM_DATA :
    {
        *(.data*)

        . = ALIGN(4);
        /* preinit data */
        PROVIDE_HIDDEN (__preinit_array_start = .);
        KEEP(*(.preinit_array))
        PROVIDE_HIDDEN (__preinit_array_end = .);

        . = ALIGN(4);
        /* init data */
        PROVIDE_HIDDEN (__init_array_start = .);
        KEEP(*(SORT(.init_array.*)))
        KEEP(*(.init_array))
        PROVIDE_HIDDEN (__init_array_end = .);

        . = ALIGN(4);
        /* finit data */
        PROVIDE_HIDDEN (__fini_array_start = .);
        KEEP(*(SORT(.fini_array.*)))
        KEEP(*(.fini_array))
        PROVIDE_HIDDEN (__fini_array_end = .);

        KEEP(*(.jcr*))
        . = ALIGN(4);

    } > RAM AT> FLASH
    Image$$TFM_DATA$$RW$$Base = ADDR(.TFM_DATA);
    Image$$TFM_DATA$$RW$$Limit = ADDR(.TFM_DATA) + SIZEOF(.TFM_DATA);

    .TFM_BSS : ALIGN(4)
    {
        __bss_start__ = .;
        *(.bss*)
        *(COMMON)
        . = ALIGN(4);
        __bss_end__ = .;
    } > RAM AT> FLASH
    Image$$TFM_DATA$$ZI$$Base = ADDR(.TFM_BSS);
    Image$$TFM_DATA$$ZI$$Limit = ADDR(.TFM_BSS) + SIZEOF(.TFM_BSS);

    .psp_stack : ALIGN(128)
    {
        . += __psp_stack_size__;
    } > RAM AT> FLASH
    __initial_sp = ADDR(.psp_stack) + SIZEOF(.psp_stack);
    Stack_Mem = ADDR(.psp_stack);

    .msp_stack : ALIGN(128)
    {
        . += __msp_stack_size__;
    } > RAM AT> FLASH
    __initial_msp = ADDR(.msp_stack) + SIZEOF(.msp_stack);

    .heap : ALIGN(8)
    {
        __end__ = .;
        PROVIDE(end = .);
        __HeapBase = .;
        . += __heap_size__;
        __HeapLimit = .;
        __heap_limit = .; /* Add for _sbrk */
    } > RAM AT> FLASH

    /*
     * Place the CMSE Veneers (containing the SG instruction) after the code, in a
     * separate 32 bytes aligned region so that the SAU can programmed to just set
     * this region as Non-Secure Callable.
     */
    .gnu.sgstubs : ALIGN(32)
    {
        *(.gnu.sgstubs*)
        . = ALIGN(32);
    } > VENEERS AT> VENEERS
    Load$$LR$$LR_VENEER$$Base = ADDR(.gnu.sgstubs);
    Load$$LR$$LR_VENEER$$Limit = ADDR(.gnu.sgstubs) + SIZEOF(.gnu.sgstubs);

    Load$$LR$$LR_NS_PARTITION$$Base = NS_PARTITION_START;
    Load$$LR$$LR_SECONDARY_PARTITION$$Base = SECONDARY_PARTITION_START;

    PROVIDE(__stack = __initial_sp);
    PROVIDE(Stack_top = __initial_sp);
}
