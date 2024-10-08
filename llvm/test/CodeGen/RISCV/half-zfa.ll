; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -target-abi ilp32f -mattr=+zfa,+zfh < %s \
; RUN:     | FileCheck %s
; RUN: llc -mtriple=riscv64 -target-abi lp64f -mattr=+zfa,+zfh < %s \
; RUN:     | FileCheck %s
; RUN: llc -mtriple=riscv32 -target-abi ilp32f -mattr=+zfa,+zfhmin < %s \
; RUN:     | FileCheck %s --check-prefix=ZFHMIN
; RUN: llc -mtriple=riscv64 -target-abi lp64f -mattr=+zfa,+zfhmin < %s \
; RUN:     | FileCheck %s --check-prefix=ZFHMIN

declare half @llvm.minimum.f16(half, half)

define half @fminm_h(half %a, half %b) nounwind {
; CHECK-LABEL: fminm_h:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fminm.h fa0, fa0, fa1
; CHECK-NEXT:    ret
;
; ZFHMIN-LABEL: fminm_h:
; ZFHMIN:       # %bb.0:
; ZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; ZFHMIN-NEXT:    fcvt.s.h fa4, fa0
; ZFHMIN-NEXT:    fminm.s fa5, fa4, fa5
; ZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; ZFHMIN-NEXT:    ret
  %1 = call half @llvm.minimum.f16(half %a, half %b)
  ret half %1
}

declare half @llvm.maximum.f16(half, half)

define half @fmaxm_h(half %a, half %b) nounwind {
; CHECK-LABEL: fmaxm_h:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmaxm.h fa0, fa0, fa1
; CHECK-NEXT:    ret
;
; ZFHMIN-LABEL: fmaxm_h:
; ZFHMIN:       # %bb.0:
; ZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; ZFHMIN-NEXT:    fcvt.s.h fa4, fa0
; ZFHMIN-NEXT:    fmaxm.s fa5, fa4, fa5
; ZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; ZFHMIN-NEXT:    ret
  %1 = tail call half @llvm.maximum.f16(half %a, half %b)
  ret half %1
}

define half @fround_h_1(half %a) nounwind {
; CHECK-LABEL: fround_h_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fround.h fa0, fa0, rmm
; CHECK-NEXT:    ret
;
; ZFHMIN-LABEL: fround_h_1:
; ZFHMIN:       # %bb.0:
; ZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZFHMIN-NEXT:    fround.s fa5, fa5, rmm
; ZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; ZFHMIN-NEXT:    ret
  %call = tail call half @llvm.round.f16(half %a) nounwind readnone
  ret half %call
}

declare half @llvm.round.f16(half) nounwind readnone


define half @fround_h_2(half %a) nounwind {
; CHECK-LABEL: fround_h_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fround.h fa0, fa0, rdn
; CHECK-NEXT:    ret
;
; ZFHMIN-LABEL: fround_h_2:
; ZFHMIN:       # %bb.0:
; ZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZFHMIN-NEXT:    fround.s fa5, fa5, rdn
; ZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; ZFHMIN-NEXT:    ret
  %call = tail call half @llvm.floor.f16(half %a) nounwind readnone
  ret half %call
}

declare half @llvm.floor.f16(half) nounwind readnone


define half @fround_h_3(half %a) nounwind {
; CHECK-LABEL: fround_h_3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fround.h fa0, fa0, rup
; CHECK-NEXT:    ret
;
; ZFHMIN-LABEL: fround_h_3:
; ZFHMIN:       # %bb.0:
; ZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZFHMIN-NEXT:    fround.s fa5, fa5, rup
; ZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; ZFHMIN-NEXT:    ret
  %call = tail call half @llvm.ceil.f16(half %a) nounwind readnone
  ret half %call
}

declare half @llvm.ceil.f16(half) nounwind readnone


define half @fround_h_4(half %a) nounwind {
; CHECK-LABEL: fround_h_4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fround.h fa0, fa0, rtz
; CHECK-NEXT:    ret
;
; ZFHMIN-LABEL: fround_h_4:
; ZFHMIN:       # %bb.0:
; ZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZFHMIN-NEXT:    fround.s fa5, fa5, rtz
; ZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; ZFHMIN-NEXT:    ret
  %call = tail call half @llvm.trunc.f16(half %a) nounwind readnone
  ret half %call
}

declare half @llvm.trunc.f16(half) nounwind readnone


define half @fround_h_5(half %a) nounwind {
; CHECK-LABEL: fround_h_5:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fround.h fa0, fa0
; CHECK-NEXT:    ret
;
; ZFHMIN-LABEL: fround_h_5:
; ZFHMIN:       # %bb.0:
; ZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZFHMIN-NEXT:    fround.s fa5, fa5
; ZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; ZFHMIN-NEXT:    ret
  %call = tail call half @llvm.nearbyint.f16(half %a) nounwind readnone
  ret half %call
}

declare half @llvm.nearbyint.f16(half) nounwind readnone


define half @froundnx_h(half %a) nounwind {
; CHECK-LABEL: froundnx_h:
; CHECK:       # %bb.0:
; CHECK-NEXT:    froundnx.h fa0, fa0
; CHECK-NEXT:    ret
;
; ZFHMIN-LABEL: froundnx_h:
; ZFHMIN:       # %bb.0:
; ZFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZFHMIN-NEXT:    froundnx.s fa5, fa5
; ZFHMIN-NEXT:    fcvt.h.s fa0, fa5
; ZFHMIN-NEXT:    ret
  %call = tail call half @llvm.rint.f16(half %a) nounwind readnone
  ret half %call
}

declare half @llvm.rint.f16(half) nounwind readnone

declare i1 @llvm.experimental.constrained.fcmp.f16(half, half, metadata, metadata)

define i32 @fcmp_olt_q(half %a, half %b) nounwind strictfp {
; CHECK-LABEL: fcmp_olt_q:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fltq.h a0, fa0, fa1
; CHECK-NEXT:    ret
;
; ZFHMIN-LABEL: fcmp_olt_q:
; ZFHMIN:       # %bb.0:
; ZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; ZFHMIN-NEXT:    fcvt.s.h fa4, fa0
; ZFHMIN-NEXT:    fltq.s a0, fa4, fa5
; ZFHMIN-NEXT:    ret
  %1 = call i1 @llvm.experimental.constrained.fcmp.f16(half %a, half %b, metadata !"olt", metadata !"fpexcept.strict") strictfp
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_ole_q(half %a, half %b) nounwind strictfp {
; CHECK-LABEL: fcmp_ole_q:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fleq.h a0, fa0, fa1
; CHECK-NEXT:    ret
;
; ZFHMIN-LABEL: fcmp_ole_q:
; ZFHMIN:       # %bb.0:
; ZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; ZFHMIN-NEXT:    fcvt.s.h fa4, fa0
; ZFHMIN-NEXT:    fleq.s a0, fa4, fa5
; ZFHMIN-NEXT:    ret
  %1 = call i1 @llvm.experimental.constrained.fcmp.f16(half %a, half %b, metadata !"ole", metadata !"fpexcept.strict") strictfp
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_one_q(half %a, half %b) nounwind strictfp {
; CHECK-LABEL: fcmp_one_q:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fltq.h a0, fa0, fa1
; CHECK-NEXT:    fltq.h a1, fa1, fa0
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    ret
;
; ZFHMIN-LABEL: fcmp_one_q:
; ZFHMIN:       # %bb.0:
; ZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; ZFHMIN-NEXT:    fcvt.s.h fa4, fa0
; ZFHMIN-NEXT:    fltq.s a0, fa4, fa5
; ZFHMIN-NEXT:    fltq.s a1, fa5, fa4
; ZFHMIN-NEXT:    or a0, a1, a0
; ZFHMIN-NEXT:    ret
  %1 = call i1 @llvm.experimental.constrained.fcmp.f16(half %a, half %b, metadata !"one", metadata !"fpexcept.strict") strictfp
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_ueq_q(half %a, half %b) nounwind strictfp {
; CHECK-LABEL: fcmp_ueq_q:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fltq.h a0, fa0, fa1
; CHECK-NEXT:    fltq.h a1, fa1, fa0
; CHECK-NEXT:    or a0, a1, a0
; CHECK-NEXT:    xori a0, a0, 1
; CHECK-NEXT:    ret
;
; ZFHMIN-LABEL: fcmp_ueq_q:
; ZFHMIN:       # %bb.0:
; ZFHMIN-NEXT:    fcvt.s.h fa5, fa1
; ZFHMIN-NEXT:    fcvt.s.h fa4, fa0
; ZFHMIN-NEXT:    fltq.s a0, fa4, fa5
; ZFHMIN-NEXT:    fltq.s a1, fa5, fa4
; ZFHMIN-NEXT:    or a0, a1, a0
; ZFHMIN-NEXT:    xori a0, a0, 1
; ZFHMIN-NEXT:    ret
  %1 = call i1 @llvm.experimental.constrained.fcmp.f16(half %a, half %b, metadata !"ueq", metadata !"fpexcept.strict") strictfp
  %2 = zext i1 %1 to i32
  ret i32 %2
}
