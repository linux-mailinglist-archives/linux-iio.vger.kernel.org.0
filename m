Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4B71CDC92
	for <lists+linux-iio@lfdr.de>; Mon, 11 May 2020 16:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgEKOFd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 May 2020 10:05:33 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:54057 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730359AbgEKOFd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 May 2020 10:05:33 -0400
X-Originating-IP: 78.193.40.249
Received: from localhost (unknown [78.193.40.249])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id CC2522000F;
        Mon, 11 May 2020 14:05:29 +0000 (UTC)
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH v4 4/5] dt-bindings: counter: microchip-tcb-capture counter
Date:   Mon, 11 May 2020 16:05:04 +0200
Message-Id: <20200511140505.1649111-5-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200511140505.1649111-1-kamel.bouhara@bootlin.com>
References: <20200511140505.1649111-1-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Describe the devicetree binding for the Microchip TCB module.
Each counter blocks exposes three independent counters.

However, when configured in quadrature decoder, both channel <0> and <1>
are required for speed/position and rotation capture (yet only the
position is captured).

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
---
 .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 29 +++++++++++++++++--
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
index 38403760f64d..0bd7b14a1552 100644
--- a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
+++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
@@ -52,14 +52,20 @@ properties:
 
 patternProperties:
   "^timer@[0-2]$":
-    description: The timer block channels that are used as timers.
+    description: The timer block channels that are used as timers or counters.
     type: object
     properties:
       compatible:
-        const: atmel,tcb-timer
+        items:
+          - enum:
+              - atmel,tcb-timer
+              - microchip,tcb-capture
       reg:
         description:
-          List of channels to use for this particular timer.
+          List of channels to use for this particular timer. In Microchip TCB capture
+          mode channels are registered as a counter devices, for the qdec mode TCB0's
+          channel <0> and <1> are required.
+
         minItems: 1
         maxItems: 3
 
@@ -148,3 +154,20 @@ examples:
                         reg = <1>;
                 };
         };
+examples:
+  - |
+        /* TCB Capture with qdec mode: */
+        tcb0: timer@fff7c000 {
+                compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <0xfff7c000 0x100>;
+                interrupts = <18 4>;
+                clocks = <&tcb0_clk>, <&clk32k>;
+                clock-names = "t0_clk", "slow_clk";
+
+                timer@0 {
+                        compatible = "atmel,tcb-capture";
+                        reg = <0>, <1>;
+                };
+        };
-- 
2.25.0

