Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0C326356F
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 20:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgIISF2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 14:05:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729717AbgIISEa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Sep 2020 14:04:30 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17B2A221EE;
        Wed,  9 Sep 2020 18:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599674569;
        bh=/O5xMlBLoa1fQ2/9iy12YsyhTYvUp2gU+bzHqJg7V8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ABRS/D5Un37VX+NKCyrC9XXvtyXS5hROlQLoEOTpSMknd8DIN8JQX42P/8vDOlKHl
         GPF/NsokVNjhfRd7j6IPl6H8UTTn9Gk1Ex5ItiuFYdCdH9Rxf0LyOMBZ6gcqZrMbBL
         +Pk5PdzA9hOEnOV++4gvRWbOI0S4IYaTqqAjV2iE=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Haibo Chen <haibo.chen@freescale.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 19/20] dt-bindings:iio:adc:fsl,imx7d-adc yaml conversion
Date:   Wed,  9 Sep 2020 18:59:45 +0100
Message-Id: <20200909175946.395313-20-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200909175946.395313-1-jic23@kernel.org>
References: <20200909175946.395313-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

A nice simple binding.  Only real different from txt is that I dropped
some descriptions where the naming of the parameter was self explanatory

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Haibo Chen <haibo.chen@freescale.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 .../bindings/iio/adc/fsl,imx7d-adc.yaml       | 62 +++++++++++++++++++
 .../devicetree/bindings/iio/adc/imx7d-adc.txt | 24 -------
 2 files changed, 62 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/fsl,imx7d-adc.yaml b/Documentation/devicetree/bindings/iio/adc/fsl,imx7d-adc.yaml
new file mode 100644
index 000000000000..dc5eacb38046
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/fsl,imx7d-adc.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/fsl,imx7d-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale ADC found on the imx7d SoC
+
+maintainers:
+  - Haibo Chen <haibo.chen@freescale.com>
+
+properties:
+  compatible:
+    const: fsl,imx7d-adc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: adc
+
+  vref-supply: true
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
+    #include <dt-bindings/clock/imx7d-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        adc@30610000 {
+            compatible = "fsl,imx7d-adc";
+            reg = <0x30610000 0x10000>;
+            interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clks IMX7D_ADC_ROOT_CLK>;
+            clock-names = "adc";
+            vref-supply = <&reg_vcc_3v3_mcu>;
+            #io-channel-cells = <1>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt b/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
deleted file mode 100644
index f1f3a552459b..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Freescale imx7d ADC bindings
-
-The devicetree bindings are for the ADC driver written for
-imx7d SoC.
-
-Required properties:
-- compatible: Should be "fsl,imx7d-adc"
-- reg: Offset and length of the register set for the ADC device
-- interrupts: The interrupt number for the ADC device
-- clocks: The root clock of the ADC controller
-- clock-names: Must contain "adc", matching entry in the clocks property
-- vref-supply: The regulator supply ADC reference voltage
-- #io-channel-cells: Must be 1 as per ../iio-bindings.txt
-
-Example:
-adc1: adc@30610000 {
-	compatible = "fsl,imx7d-adc";
-	reg = <0x30610000 0x10000>;
-	interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&clks IMX7D_ADC_ROOT_CLK>;
-	clock-names = "adc";
-	vref-supply = <&reg_vcc_3v3_mcu>;
-	#io-channel-cells = <1>;
-};
-- 
2.28.0

