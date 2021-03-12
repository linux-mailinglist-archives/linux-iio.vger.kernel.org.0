Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1391A338AA2
	for <lists+linux-iio@lfdr.de>; Fri, 12 Mar 2021 11:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhCLKz5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Mar 2021 05:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbhCLKz0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Mar 2021 05:55:26 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E655C061574
        for <linux-iio@vger.kernel.org>; Fri, 12 Mar 2021 02:55:25 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lKfRt-0006gK-CG; Fri, 12 Mar 2021 11:55:17 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lKfRs-0008MK-ES; Fri, 12 Mar 2021 11:55:16 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 2/3] dt-bindings:iio:adc: add documentation for TI TSC2046 controller
Date:   Fri, 12 Mar 2021 11:55:14 +0100
Message-Id: <20210312105515.32055-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210312105515.32055-1-o.rempel@pengutronix.de>
References: <20210312105515.32055-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a binding documentation for the TI TSC2046 touchscreen controllers
ADC functionality.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../bindings/iio/adc/ti,tsc2046.yaml          | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml b/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
new file mode 100644
index 000000000000..4f705dc0f639
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
@@ -0,0 +1,115 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,tsc2046.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TSC2046 touch screen controller.
+
+maintainers:
+  - Oleksij Rempel <o.rempel@pengutronix.de>
+
+description: |
+  TSC2046 is a touch screen controller with 8 channels ADC.
+
+properties:
+  compatible:
+    enum:
+      - ti,tsc2046e-adc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  "#io-channel-cells":
+    const: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+patternProperties:
+  "^channel@[0-7]$":
+    $ref: "adc.yaml"
+    type: object
+
+    properties:
+      reg:
+        description: |
+          The channel number. It can have up to 8 channels
+        items:
+          minimum: 0
+          maximum: 7
+
+      settling-time-us: true
+      average-samples: true
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,tsc2046e-adc";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            interrupts-extended = <&gpio3 20 IRQ_TYPE_LEVEL_LOW>;
+            #io-channel-cells = <1>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+              reg = <0>;
+            };
+            channel@1 {
+              reg = <1>;
+              settling-time-us = <700>;
+              average-samples = <5>;
+            };
+            channel@2 {
+              reg = <2>;
+            };
+            channel@3 {
+              reg = <3>;
+              settling-time-us = <700>;
+              average-samples = <5>;
+            };
+            channel@4 {
+              reg = <4>;
+              settling-time-us = <700>;
+              average-samples = <5>;
+            };
+            channel@5 {
+              reg = <5>;
+              settling-time-us = <700>;
+              average-samples = <5>;
+            };
+            channel@6 {
+              reg = <6>;
+            };
+            channel@7 {
+              reg = <7>;
+            };
+        };
+    };
+...
-- 
2.29.2

