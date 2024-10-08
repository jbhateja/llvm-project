; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc < %s -march=nvptx64 -mcpu=sm_20 -verify-machineinstrs | FileCheck %s
; RUN: %if ptxas %{ llc < %s -march=nvptx64 -mcpu=sm_20 -verify-machineinstrs | %ptxas-verify %}

target triple = "nvptx64-nvidia-cuda"
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v32:32:32-v64:64:64-v128:128:128-n16:32:64"

define float @fcopysign_f(float %a, float %b) {
; CHECK-LABEL: fcopysign_f(
; CHECK:       {
; CHECK-NEXT:    .reg .f32 %f<4>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.f32 %f1, [fcopysign_f_param_0];
; CHECK-NEXT:    ld.param.f32 %f2, [fcopysign_f_param_1];
; CHECK-NEXT:    copysign.f32 %f3, %f2, %f1;
; CHECK-NEXT:    st.param.f32 [func_retval0+0], %f3;
; CHECK-NEXT:    ret;
  %val = call float @llvm.copysign.f32(float %a, float %b)
  ret float %val
}

define double @fcopysign_d(double %a, double %b) {
; CHECK-LABEL: fcopysign_d(
; CHECK:       {
; CHECK-NEXT:    .reg .f64 %fd<4>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.f64 %fd1, [fcopysign_d_param_0];
; CHECK-NEXT:    ld.param.f64 %fd2, [fcopysign_d_param_1];
; CHECK-NEXT:    copysign.f64 %fd3, %fd2, %fd1;
; CHECK-NEXT:    st.param.f64 [func_retval0+0], %fd3;
; CHECK-NEXT:    ret;
  %val = call double @llvm.copysign.f64(double %a, double %b)
  ret double %val
}

declare float @llvm.copysign.f32(float, float)
declare double @llvm.copysign.f64(double, double)
