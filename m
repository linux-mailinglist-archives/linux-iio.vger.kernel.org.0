Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A76A64CBB0
	for <lists+linux-iio@lfdr.de>; Wed, 14 Dec 2022 14:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238500AbiLNN6r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Dec 2022 08:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238314AbiLNN6q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Dec 2022 08:58:46 -0500
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E715C2018D;
        Wed, 14 Dec 2022 05:58:43 -0800 (PST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8BE0F20180D;
        Wed, 14 Dec 2022 14:58:42 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 53EF0201082;
        Wed, 14 Dec 2022 14:58:42 +0100 (CET)
Received: from local (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B67BA1820F59;
        Wed, 14 Dec 2022 21:58:40 +0800 (+08)
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        haibo.chen@nxp.com
Subject: [PATCH v2 2/3] dt-bindings: iio: adc: Add binding documentation for NXP IMX93 ADC
Date:   Wed, 14 Dec 2022 21:35:38 +0800
Message-Id: <1671024939-29322-2-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1671024939-29322-1-git-send-email-haibo.chen@nxp.com>
References: <1671024939-29322-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

The IMX93 SoC has a new ADC IP, so add binding documentation
for NXP IMX93 ADC.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 .../bindings/iio/adc/nxp,imx93-adc.yaml       | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
new file mode 100644
index 000000000000..229bb79e255c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/nxp,imx93-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP iMX93 ADC bindings
+
+maintainers:
+  - Haibo Chen <haibo.chen@nxp.com>
+
+description:
+  The ADC on iMX93 is a 8-channel 12-bit 1MS/s ADC with 4 channels
+  connected to pins. it support normal and inject mode, include
+  One-Shot and Scan (continuous) conversions. Programmable DMA
+  enables for each channel  Also this ADC contain alternate analog
+  watchdog thresholds, select threshold through input ports. And
+  also has Self-test logic and Software-initiated calibration.
+
+properties:
+  compatible:
+    const: nxp,imx93-adc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      line 0 for WDGnL (watchdog threshold) interrupt requests.
+      line 1 for WDGnH (watchdog threshold) interrupt requests.
+      line 2 for normal conversion, include EOC (End of Conversion)
+      interrupt request, ECH (End of Chain) interrupt request,
+      JEOC (End of Injected Conversion mode) interrupt request
+      and JECH (End of injected Chain) interrupt request.
+      line 3 for Self-testing Interrupts.
+    maxItems: 4
+
+  clocks:
+    maxItems: 1
+
+  vref-supply:
+    description:
+      The reference voltage which used to establish channel scaling.
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - vref-supply
+  - "#io-channel-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/imx93-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        adc@44530000 {
+            compatible = "nxp,imx93-adc";
+            reg = <0x44530000 0x10000>;
+            interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clk IMX93_CLK_ADC1_GATE>;
+            clock-names = "ipg";
+            vref-supply = <&reg_vref_1v8>;
+        };
+    };
+...
-- 
2.34.1

