Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E594F25E957
	for <lists+linux-iio@lfdr.de>; Sat,  5 Sep 2020 19:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgIERcm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Sep 2020 13:32:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbgIERci (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Sep 2020 13:32:38 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1373420760;
        Sat,  5 Sep 2020 17:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599327158;
        bh=yVzMrl68x91g4MIaNHgNpaL4VqCsGXD9sO86U7mJ/wY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BFRor7VH2/K61atCVGhCPrdsE7kmjg6CCeB7T1oD4TxG2N/ESCiPfnN6lgCAJKfhv
         RDd5ou0JPLlJWhl67YlTH+9aEoAluk8vRy/2Q9Z3KJ5/pnGWHjj8lkTojBigBXdNQC
         xcpz0es0ikJ73hG6b+Z/O7ajeKaQnGB+tqHgHPJ4=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH 08/20] dt-bindings:iio:adc:nuvoton,npcm750-adc yaml conversion
Date:   Sat,  5 Sep 2020 18:29:52 +0100
Message-Id: <20200905173004.216081-9-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905173004.216081-1-jic23@kernel.org>
References: <20200905173004.216081-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Renamed the file to reflect the only compatible.
Added #io-channel-cells to make it easier to support consumers of the
ADC channels this device provides.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tomer Maimon <tmaimon77@gmail.com>
---
 .../bindings/iio/adc/nuvoton,npcm-adc.txt     | 26 --------
 .../bindings/iio/adc/nuvoton,npcm750-adc.yaml | 64 +++++++++++++++++++
 2 files changed, 64 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
deleted file mode 100644
index ef8eeec1a997..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Nuvoton NPCM Analog to Digital Converter (ADC)
-
-The NPCM ADC is a 10-bit converter for eight channel inputs.
-
-Required properties:
-- compatible: "nuvoton,npcm750-adc" for the NPCM7XX BMC.
-- reg: specifies physical base address and size of the registers.
-- interrupts: Contain the ADC interrupt with flags for falling edge.
-- resets : phandle to the reset control for this device.
-
-Optional properties:
-- clocks: phandle of ADC reference clock, in case the clock is not
-		  added the ADC will use the default ADC sample rate.
-- vref-supply: The regulator supply ADC reference voltage, in case the
-			   vref-supply is not added the ADC will use internal voltage
-			   reference.
-
-Example:
-
-adc: adc@f000c000 {
-	compatible = "nuvoton,npcm750-adc";
-	reg = <0xf000c000 0x8>;
-	interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&clk NPCM7XX_CLK_ADC>;
-	resets = <&rstc NPCM7XX_RESET_IPSRST1 NPCM7XX_RESET_ADC>;
-};
diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm750-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm750-adc.yaml
new file mode 100644
index 000000000000..59382e2805d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,npcm750-adc.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/nuvoton,npcm750-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM BMC Analog to Digital Converter (ADC)
+
+maintainers:
+  - Tomer Maimon <tmaimon77@gmail.com>
+
+description:
+  The NPCM ADC is a 10-bit converter for eight channel inputs.
+
+properties:
+  compatible:
+    const: nuvoton,npcm750-adc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: ADC interrupt, should be set for falling edge.
+
+  resets:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: If not provided the defulat ADC sample rate will be used.
+
+  vref-supply:
+    description: If not supplied, the internal voltage reference will be used.
+
+  "#io-channel-cells":
+    const: 1
+      
+required:
+  - compatible
+  - reg
+  - interrupts
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
+    #include <dt-bindings/reset/nuvoton,npcm7xx-reset.h>
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        adc@f000c000 {
+            compatible = "nuvoton,npcm750-adc";
+            reg = <0xf000c000 0x8>;
+            interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clk NPCM7XX_CLK_ADC>;
+            resets = <&rstc NPCM7XX_RESET_IPSRST1 NPCM7XX_RESET_ADC>;
+        };
+    };
+...
-- 
2.28.0

