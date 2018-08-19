#-------------------------------------------------------------------------------
# Copyright (c) 2017-2018, Arm Limited. All rights reserved.
#
# SPDX-License-Identifier: BSD-3-Clause
#
#-------------------------------------------------------------------------------

#This file contains settings to specify how GCC shall be used

#Include some dependencies
Include(Common/CompilerGNUARMCommon)
Include(Common/Utils)

check_gnuarm_input_vars("7.3")

if(NOT DEFINED ARM_CPU_ARHITECTURE)
	set(_NO_ARM_CPU_ARHITECTURE true)
elseif (${ARM_CPU_ARHITECTURE} STREQUAL "ARM8-M-BASE")
	string_append_unique_item(STRING CMAKE_C_FLAGS_CPU KEY "-march=" VAL "-march=armv8-m.base")
	string_append_unique_item(STRING CMAKE_CXX_FLAGS_CPU KEY "-march=" VAL "-march=armv8-m.base")
	string_append_unique_item(STRING CMAKE_ASM_FLAGS_CPU KEY "-march=" VAL "-march=armv8-m.base")
	string_append_unique_item(STRING CMAKE_LINK_FLAGS_CPU KEY "-march=" VAL "-march=armv8-m.base")
elseif(${ARM_CPU_ARHITECTURE} STREQUAL "ARM8-M-MAIN")
	string_append_unique_item(STRING CMAKE_C_FLAGS_CPU KEY "-march=" VAL "-march=armv8-m.main")
	string_append_unique_item(STRING CMAKE_CXX_FLAGS_CPU KEY "-march=" VAL "-march=armv8-m.main")
	string_append_unique_item(STRING CMAKE_ASM_FLAGS_CPU KEY "-march=" VAL "-march=armv8-m.main")
	string_append_unique_item(STRING CMAKE_LINK_FLAGS_CPU KEY "-march=" VAL "-march=armv8-m.main")
elseif(${ARM_CPU_ARHITECTURE} STREQUAL "V7-M")
	string_append_unique_item(STRING CMAKE_C_FLAGS_CPU KEY "-march=" VAL "-march=armv7-m")
	string_append_unique_item(STRING CMAKE_CXX_FLAGS_CPU KEY "-march=" VAL "-march=armv7-m")
	string_append_unique_item(STRING CMAKE_ASM_FLAGS_CPU KEY "-march=" VAL "-march=armv7-m")
	string_append_unique_item(STRING CMAKE_LINK_FLAGS_CPU KEY "-march=" VAL "-march=armv7-m")
else()
	message(FATAL_ERROR "Unknown or unsupported ARM cpu architecture setting.")
endif()

#Prefer arhitecture definition over cpu type.
if(NOT DEFINED ARM_CPU_ARHITECTURE)
	if(NOT DEFINED ARM_CPU_TYPE)
		string_append_unique_item(_NO_ARM_CPU_TYPE true)
	elseif(${ARM_CPU_TYPE} STREQUAL "Cortex-M3")
		string_append_unique_item (CMAKE_C_FLAGS_CPU "-mcpu=cortex-m3")
		string_append_unique_item (CMAKE_CXX_FLAGS_CPU "-mcpu=cortex-m3")
		string_append_unique_item (CMAKE_ASM_FLAGS_CPU "--cpu=Cortex-M3")
		string_append_unique_item (CMAKE_LINK_FLAGS_CPU "--cpu=Cortex-M3")
	elseif(${ARM_CPU_TYPE} STREQUAL "Cortex-M33")
		string_append_unique_item (CMAKE_C_FLAGS_CPU "-mcpu=cortex-m33")
		string_append_unique_item (CMAKE_CXX_FLAGS_CPU "-mcpu=cortex-m33")
		string_append_unique_item (CMAKE_ASM_FLAGS_CPU "--cpu=Cortex-M33")
		string_append_unique_item (CMAKE_LINK_FLAGS_CPU "--cpu=Cortex-M33")
	elseif(${ARM_CPU_TYPE} STREQUAL "Cortex-M23")
		string_append_unique_item (CMAKE_C_FLAGS_CPU "-mcpu=cortex-m23")
		string_append_unique_item (CMAKE_CXX_FLAGS_CPU "-mcpu=cortex-m23")
		string_append_unique_item (CMAKE_ASM_FLAGS_CPU "--cpu=Cortex-M23")
		string_append_unique_item (CMAKE_LINK_FLAGS_CPU "--cpu=Cortex-M23")
	else()
		message(FATAL_ERROR "Unknown ARM cpu setting.")
	endif()
endif()

if (_NO_ARM_CPU_TYPE AND _NO_ARM_CPU_ARHITECTURE)
	message(FATAL_ERROR "Cannot set CPU specific compiler flags: neither the ARM CPU type nor the architecture is set.")
endif()