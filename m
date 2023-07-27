Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA10C764D90
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jul 2023 10:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbjG0IgU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Jul 2023 04:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbjG0If5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Jul 2023 04:35:57 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 982FF6E8C;
        Thu, 27 Jul 2023 01:19:22 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,234,1684767600"; 
   d="scan'208";a="174688931"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 27 Jul 2023 17:19:05 +0900
Received: from localhost.localdomain (unknown [10.226.93.33])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 05FF141C9E93;
        Thu, 27 Jul 2023 17:19:00 +0900 (JST)
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
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Pavel Machek <pavel@denx.de>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/5] dt-bindings: timer: renesas,rz-mtu3: Improve documentation
Date:   Thu, 27 Jul 2023 09:18:45 +0100
Message-Id: <20230727081848.100834-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230727081848.100834-1-biju.das.jz@bp.renesas.com>
References: <20230727081848.100834-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
Closes: https://lore.kernel.org/all/ZH79%2FUjgYg+0Ruiu@duo.ucw.cz
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
v2->v3:
 * Updated the link to lore for Closes tag.
v1->v2:
 * Added Ack by Conor Dooley
---
 .../bindings/timer/renesas,rz-mtu3.yaml       | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
index fbac40b958dd..670a2ebaacdb 100644
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

