Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B959434C4F6
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 09:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhC2HcF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 03:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhC2Hbm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Mar 2021 03:31:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056D8C061764
        for <linux-iio@vger.kernel.org>; Mon, 29 Mar 2021 00:31:42 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lQmN3-0001So-KL; Mon, 29 Mar 2021 09:31:33 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lQmN2-0000Ta-Ry; Mon, 29 Mar 2021 09:31:32 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v5 2/3] dt-bindings:iio:adc: add documentation for TI TSC2046 controller
Date:   Mon, 29 Mar 2021 09:31:30 +0200
Message-Id: <20210329073131.1759-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210329073131.1759-1-o.rempel@pengutronix.de>
References: <20210329073131.1759-1-o.rempel@pengutronix.de>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/adc/ti,tsc2046.yaml          | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml b/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
new file mode 100644
index 000000000000..601d69971d84
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
+      oversampling-ratio: true
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
+              oversampling-ratio = <5>;
+            };
+            channel@2 {
+              reg = <2>;
+            };
+            channel@3 {
+              reg = <3>;
+              settling-time-us = <700>;
+              oversampling-ratio = <5>;
+            };
+            channel@4 {
+              reg = <4>;
+              settling-time-us = <700>;
+              oversampling-ratio = <5>;
+            };
+            channel@5 {
+              reg = <5>;
+              settling-time-us = <700>;
+              oversampling-ratio = <5>;
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

