Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956332A1A01
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgJaSwR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728459AbgJaSwP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:52:15 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 865B82071A;
        Sat, 31 Oct 2020 18:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170334;
        bh=rOdJDd+LJuwod0XrZrCl2cCPfz8HWsCPRSOYhfgmjyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RldDUS9kMTVbc0c8tyg9XvP0uDO6OwnSja+ddr3j5oO/Iou5DyRXr5gsmZgDe/U+B
         oiDpQEq2Xvy394AwQsuISMXlAgdLsq0IUGVCe1JD8Z43/1qBE6w7HaFBUaiXhXTmPR
         xmBsFEYtv6wbybM08wxUP7URwgWiJXRUZH2N/Kxw=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Subject: [PATCH 32/46] dt-bindings:iio:adc:brcm,iproc-static-adc: txt to yaml conversion
Date:   Sat, 31 Oct 2020 18:48:40 +0000
Message-Id: <20201031184854.745828-33-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

A few questions came up in this one.
1) Why does the txt file document io-channel-ranges as a required property.
   That property is for iio-channel consumers, and this is a provider.
   I have dropped it.
2) The example had an @180a6000 for the ADC but given it uses syscon for
   all access, it doesn't have its own reg etc.  I've dropped that from
   the binding example.

Note this example was lifted directly from bcm-cygnus.dtsi so both
issues are present there as well.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
---
 .../iio/adc/brcm,iproc-static-adc.txt         | 40 -----------
 .../iio/adc/brcm,iproc-static-adc.yaml        | 70 +++++++++++++++++++
 2 files changed, 70 insertions(+), 40 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt b/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
deleted file mode 100644
index 7b1b1e4086d4..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-* Broadcom's IPROC Static ADC controller
-
-Broadcom iProc ADC controller has 8 channels 10bit ADC.
-Allows user to convert analog input voltage values to digital.
-
-Required properties:
-
-- compatible: Must be "brcm,iproc-static-adc"
-
-- adc-syscon: Handler of syscon node defining physical base address of the
-  controller and length of memory mapped region.
-
-- #io-channel-cells = <1>; As ADC has multiple outputs
-  refer to Documentation/devicetree/bindings/iio/iio-bindings.txt for details.
-
-- io-channel-ranges:
-  refer to Documentation/devicetree/bindings/iio/iio-bindings.txt for details.
-
-- clocks: Clock used for this block.
-
-- clock-names: Clock name should be given as tsc_clk.
-
-- interrupts: interrupt line number.
-
-For example:
-
-	ts_adc_syscon: ts_adc_syscon@180a6000 {
-		compatible = "brcm,iproc-ts-adc-syscon","syscon";
-		reg = <0x180a6000 0xc30>;
-	};
-
-	adc: adc@180a6000 {
-		compatible = "brcm,iproc-static-adc";
-		adc-syscon = <&ts_adc_syscon>;
-		#io-channel-cells = <1>;
-		io-channel-ranges;
-		clocks = <&asiu_clks BCM_CYGNUS_ASIU_ADC_CLK>;
-		clock-names = "tsc_clk";
-		interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
-	};
diff --git a/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.yaml b/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.yaml
new file mode 100644
index 000000000000..c562d25bee3b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/brcm,iproc-static-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom's IPROC Static ADC controller
+
+maintainers:
+  - Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
+
+description: |
+  Broadcom iProc ADC controller has 8 10bit channels
+
+properties:
+  compatible:
+    const: brcm,iproc-static-adc
+
+  adc-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      syscon node defining physical base address of the controller and length
+      of memory mapped region.
+
+  "#io-channel-cells":
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: tsc_clk
+
+  interrupts:
+    maxItems: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - adc-syscon
+  - "#io-channel-cells"
+  - clocks
+  - clock-names
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/clock/bcm-cygnus.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        ts_adc_syscon: ts_adc_syscon@180a6000 {
+            compatible = "brcm,iproc-ts-adc-syscon","syscon";
+            reg = <0x180a6000 0xc30>;
+        };
+
+        adc {
+            compatible = "brcm,iproc-static-adc";
+            adc-syscon = <&ts_adc_syscon>;
+            #io-channel-cells = <1>;
+            clocks = <&asiu_clks BCM_CYGNUS_ASIU_ADC_CLK>;
+            clock-names = "tsc_clk";
+            interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+...
-- 
2.28.0

