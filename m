Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274EA756221
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jul 2023 13:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjGQL6H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Jul 2023 07:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGQL6G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jul 2023 07:58:06 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D50F5A6;
        Mon, 17 Jul 2023 04:58:03 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,211,1684767600"; 
   d="scan'208";a="173140507"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 17 Jul 2023 20:58:03 +0900
Received: from localhost.localdomain (unknown [10.226.92.210])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4D74C41EFC9F;
        Mon, 17 Jul 2023 20:57:59 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Pavel Machek <pavel@denx.de>
Subject: [PATCH] dt-bindings: timer: renesas,rz-mtu3: Improve documentation
Date:   Mon, 17 Jul 2023 12:57:57 +0100
Message-Id: <20230717115757.164284-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix the documentation issues pointed by Pavel while backporting
it to 6.1.y-cip.
 - Replace '32- bit'->'32-bit'
 - Consistently remove '.' at the end of line for the specifications
 - Replace '          (excluding MTU8)'-> '(excluding MTU8)'

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://patchwork.kernel.org/project/cip-dev/patch/20230606075235.183132-3-biju.das.jz@bp.renesas.com/
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/timer/renesas,rz-mtu3.yaml       | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
index bffdab0b0185..eb2d5ebe4df0 100644
--- a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
@@ -11,8 +11,8 @@ maintainers:
 
 description: |
   This hardware block consists of eight 16-bit timer channels and one
-  32- bit timer channel. It supports the following specifications:
-    - Pulse input/output: 28 lines max.
+  32-bit timer channel. It supports the following specifications:
+    - Pulse input/output: 28 lines max
     - Pulse input 3 lines
     - Count clock 11 clocks for each channel (14 clocks for MTU0, 12 clocks
       for MTU2, and 10 clocks for MTU5, four clocks for MTU1-MTU2 combination
@@ -23,11 +23,11 @@ description: |
         - Input capture function (noise filter setting available)
         - Counter-clearing operation
         - Simultaneous writing to multiple timer counters (TCNT)
-          (excluding MTU8).
+          (excluding MTU8)
         - Simultaneous clearing on compare match or input capture
-          (excluding MTU8).
+          (excluding MTU8)
         - Simultaneous input and output to registers in synchronization with
-          counter operations           (excluding MTU8).
+          counter operations (excluding MTU8)
         - Up to 12-phase PWM output in combination with synchronous operation
           (excluding MTU8)
     - [MTU0 MTU3, MTU4, MTU6, MTU7, and MTU8]
@@ -40,26 +40,26 @@ description: |
     - [MTU3, MTU4, MTU6, and MTU7]
         - Through interlocked operation of MTU3/4 and MTU6/7, the positive and
           negative signals in six phases (12 phases in total) can be output in
-          complementary PWM and reset-synchronized PWM operation.
+          complementary PWM and reset-synchronized PWM operation
         - In complementary PWM mode, values can be transferred from buffer
           registers to temporary registers at crests and troughs of the timer-
           counter values or when the buffer registers (TGRD registers in MTU4
-          and MTU7) are written to.
-        - Double-buffering selectable in complementary PWM mode.
+          and MTU7) are written to
+        - Double-buffering selectable in complementary PWM mode
     - [MTU3 and MTU4]
         - Through interlocking with MTU0, a mode for driving AC synchronous
           motors (brushless DC motors) by using complementary PWM output and
           reset-synchronized PWM output is settable and allows the selection
-          of two types of waveform output (chopping or level).
+          of two types of waveform output (chopping or level)
     - [MTU5]
-        - Capable of operation as a dead-time compensation counter.
+        - Capable of operation as a dead-time compensation counter
     - [MTU0/MTU5, MTU1, MTU2, and MTU8]
         - 32-bit phase counting mode specifiable by combining MTU1 and MTU2 and
-          through interlocked operation with MTU0/MTU5 and MTU8.
+          through interlocked operation with MTU0/MTU5 and MTU8
     - Interrupt-skipping function
         - In complementary PWM mode, interrupts on crests and troughs of counter
           values and triggers to start conversion by the A/D converter can be
-          skipped.
+          skipped
     - Interrupt sources: 43 sources.
     - Buffer operation:
         - Automatic transfer of register data (transfer from the buffer
@@ -68,9 +68,9 @@ description: |
         - A/D converter start triggers can be generated
         - A/D converter start request delaying function enables A/D converter
           to be started with any desired timing and to be synchronized with
-          PWM output.
+          PWM output
     - Low power consumption function
-        - The MTU3a can be placed in the module-stop state.
+        - The MTU3a can be placed in the module-stop state
 
     There are two phase counting modes. 16-bit phase counting mode in which
     MTU1 and MTU2 operate independently, and cascade connection 32-bit phase
-- 
2.25.1

