Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9F51D9229
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 10:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgESIh3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 04:37:29 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:7373 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgESIh3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 04:37:29 -0400
X-Originating-IP: 78.193.40.249
Received: from localhost (unknown [78.193.40.249])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id B85EA240003;
        Tue, 19 May 2020 08:37:26 +0000 (UTC)
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
Subject: [PATCH v5 4/5] dt-bindings: counter: microchip-tcb-capture counter
Date:   Tue, 19 May 2020 10:37:15 +0200
Message-Id: <20200519083716.938384-5-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200519083716.938384-1-kamel.bouhara@bootlin.com>
References: <20200519083716.938384-1-kamel.bouhara@bootlin.com>
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
 .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 32 +++++++++++++++++--
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
index 38403760f64d..e3319c4501c1 100644
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
 
@@ -148,3 +154,23 @@ examples:
                         reg = <1>;
                 };
         };
+    /* TCB0 Capture with QDEC: */
+        timer@f800c000 {
+                compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <0xfff7c000 0x100>;
+                interrupts = <18 4>;
+                clocks = <&tcb0_clk>, <&clk32k>;
+                clock-names = "t0_clk", "slow_clk";
+
+                timer@0 {
+                        compatible = "microchip,tcb-capture";
+                        reg = <0>, <1>;
+                };
+
+                timer@2 {
+                        compatible = "atmel,tcb-timer";
+                        reg = <2>;
+                };
+        };
-- 
2.25.0

