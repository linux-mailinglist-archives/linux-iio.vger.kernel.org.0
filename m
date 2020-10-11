Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4113128A869
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 19:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388241AbgJKRKc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 13:10:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387984AbgJKRKb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:10:31 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 271862222A;
        Sun, 11 Oct 2020 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602436231;
        bh=g0YORaSxtIPdQBNa5bHIWnm0aV4bZMa5vqmsikKLSd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=blXuek3LRSkGgW4aFekHrKpm2kj996lH3aMR8WdduIPjDBgFxlqHNRuQjoiW4kRYF
         zflZd80D59yWYrlcgrdOdLi1v686qark3HjQXzdiDzGpxKexzxFj9wmHLfIWjWxRSx
         deNUwwRJMS7JwkYNyezHT53ocvo5nvjkCe8GfgOk=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Joachim Eastwood <manabian@gmail.com>
Subject: [PATCH 22/29] dt-bindings:iio:dac:nxp,lpc1850-dac yaml conversion.
Date:   Sun, 11 Oct 2020 18:07:42 +0100
Message-Id: <20201011170749.243680-23-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201011170749.243680-1-jic23@kernel.org>
References: <20201011170749.243680-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Very similar binding to that for the ADC on the same device.
Conversion from txt to yaml format.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Joachim Eastwood <manabian@gmail.com>
---
 .../bindings/iio/dac/lpc1850-dac.txt          | 19 ------
 .../bindings/iio/dac/nxp,lpc1850-dac.yaml     | 58 +++++++++++++++++++
 2 files changed, 58 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/lpc1850-dac.txt b/Documentation/devicetree/bindings/iio/dac/lpc1850-dac.txt
deleted file mode 100644
index 42db783c4e75..000000000000
--- a/Documentation/devicetree/bindings/iio/dac/lpc1850-dac.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-NXP LPC1850 DAC bindings
-
-Required properties:
-- compatible: Should be "nxp,lpc1850-dac"
-- reg: Offset and length of the register set for the ADC device
-- interrupts: The interrupt number for the ADC device
-- clocks: The root clock of the ADC controller
-- vref-supply: The regulator supply ADC reference voltage
-- resets: phandle to reset controller and line specifier
-
-Example:
-dac: dac@400e1000 {
-	compatible = "nxp,lpc1850-dac";
-	reg = <0x400e1000 0x1000>;
-	interrupts = <0>;
-	clocks = <&ccu1 CLK_APB3_DAC>;
-	vref-supply = <&reg_vdda>;
-	resets = <&rgu 42>;
-};
diff --git a/Documentation/devicetree/bindings/iio/dac/nxp,lpc1850-dac.yaml b/Documentation/devicetree/bindings/iio/dac/nxp,lpc1850-dac.yaml
new file mode 100644
index 000000000000..2728ec3433e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/nxp,lpc1850-dac.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/nxp,lpc1850-dac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC1850 DAC bindings
+
+maintainers:
+  - Joachim Eastwood <manabian@gmail.com>
+
+description:
+  Supports the DAC found on the LPC1850 SoC.
+
+properties:
+  compatible:
+    const: nxp,lpc1850-dac
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
+  vref-supply: true
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - vref-supply
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/lpc18xx-ccu.h>
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        dac: dac@400e1000 {
+            compatible = "nxp,lpc1850-dac";
+            reg = <0x400e1000 0x1000>;
+            interrupts = <0>;
+            clocks = <&ccu1 CLK_APB3_DAC>;
+            vref-supply = <&reg_vdda>;
+            resets = <&rgu 42>;
+        };
+    };
+...
-- 
2.28.0

