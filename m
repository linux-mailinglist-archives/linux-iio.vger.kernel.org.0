Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDEF25E953
	for <lists+linux-iio@lfdr.de>; Sat,  5 Sep 2020 19:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgIERcj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Sep 2020 13:32:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728387AbgIERcg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Sep 2020 13:32:36 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C22A5208C7;
        Sat,  5 Sep 2020 17:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599327155;
        bh=a8ctN4vLi4L4BOmXkKHNhXkcj6q2WOTNv5GAPASrTe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GufMpEaYIE5QZmoLM/aBo0l/8Bxaeo8TlJKHQnmVbrYNmSZtnfNnAZAO+BbnaxQu5
         MXhQ7LCcgQeDIYKjJPASPL9yG5Bb3y+sQVhOZ3eJljqeHZDQ+x6jB/mfpnyuIwwZIy
         wjne1IHhk7UTYGGKIjBJNSuJUZnl+lw7hHqkxyYs=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 06/20] dt-bindings:iio:adc:sprd,sc2720-adc yaml conversion.
Date:   Sat,  5 Sep 2020 18:29:50 +0100
Message-Id: <20200905173004.216081-7-jic23@kernel.org>
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

I changed the name to reflect a specific part in line with normal
naming conventions. If there is a particularly strong reason to
keep the wild cards let me know.

Otherwise this was a fairly simple conversion as part of converting
all the IIO bindings to yaml.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
---
 .../bindings/iio/adc/sprd,sc2720-adc.yaml     | 72 +++++++++++++++++++
 .../bindings/iio/adc/sprd,sc27xx-adc.txt      | 40 -----------
 2 files changed, 72 insertions(+), 40 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
new file mode 100644
index 000000000000..57df6439dd9d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/sprd,sc2720-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spreadtrum SC27XX series PMICs ADC binding
+
+maintainers:
+  - Baolin Wang <baolin.wang7@gmail.com>
+
+description:
+  Supports the ADC found on these PMICs.
+
+properties:
+  compatible:
+    enum:
+      - sprd,sc2720-adc
+      - sprd,sc2721-adc
+      - sprd,sc2723-adc
+      - sprd,sc2730-adc
+      - sprd,sc2731-adc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#io-channel-cells":
+    const: 1
+
+  hwlocks:
+    maxItems: 1
+
+  nvmem-cells:
+    maxItems: 2
+    
+  nvmem-cell-names:
+    items:
+      - const: big_scale_calib
+      - const: small_scale_calib
+      
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#io-channel-cells"
+  - hwlocks
+  - nvmem-cells
+  - nvmem-cell-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        adc@480 {
+            compatible = "sprd,sc2731-adc";
+            reg = <0x480>;
+            interrupt-parent = <&sc2731_pmic>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            #io-channel-cells = <1>;
+            hwlocks = <&hwlock 4>;
+            nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
+            nvmem-cell-names = "big_scale_calib", "small_scale_calib";
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt b/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
deleted file mode 100644
index b4daa15dcf15..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-adc.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-Spreadtrum SC27XX series PMICs ADC binding
-
-Required properties:
-- compatible: Should be one of the following.
-	"sprd,sc2720-adc"
-	"sprd,sc2721-adc"
-	"sprd,sc2723-adc"
-	"sprd,sc2730-adc"
-	"sprd,sc2731-adc"
-- reg: The address offset of ADC controller.
-- interrupt-parent: The interrupt controller.
-- interrupts: The interrupt number for the ADC device.
-- #io-channel-cells: Number of cells in an IIO specifier.
-- hwlocks: Reference to a phandle of a hwlock provider node.
-- nvmem-cells: A phandle to the calibration cells provided by eFuse device.
-- nvmem-cell-names: Should be "big_scale_calib", "small_scale_calib".
-
-Example:
-
-	sc2731_pmic: pmic@0 {
-		compatible = "sprd,sc2731";
-		reg = <0>;
-		spi-max-frequency = <26000000>;
-		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pmic_adc: adc@480 {
-			compatible = "sprd,sc2731-adc";
-			reg = <0x480>;
-			interrupt-parent = <&sc2731_pmic>;
-			interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
-			#io-channel-cells = <1>;
-			hwlocks = <&hwlock 4>;
-			nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
-			nvmem-cell-names = "big_scale_calib", "small_scale_calib";
-		};
-	};
-- 
2.28.0

