Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4955E263566
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 20:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgIISEy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 14:04:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730154AbgIISCe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Sep 2020 14:02:34 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73CD3221E5;
        Wed,  9 Sep 2020 18:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599674553;
        bh=32NlETNlgjAzx6DtnmnvP+RC6sufGpUZINDy8r4BguE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KRnrnE7cUb7c++rgCOkITTPpXd8gpk6o7WtRG2aJ5VLTdBCRWThfAbLm2ckBAeVuF
         SsGwnmtIk9Vbob3ISwr8R44zPjKxrUzUNUV4KfZs/sItX62aDO2Q1cTjQ+cVXy5unp
         Va2VSYYsJqPE/3NwZmqDlSCcClnvfnaJWnia3d1Q=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Joachim Eastwood <manabian@gmail.com>
Subject: [PATCH v2 09/20] dt-bindings:iio:adc:nxp,lpc1850-adc yaml conversion
Date:   Wed,  9 Sep 2020 18:59:35 +0100
Message-Id: <20200909175946.395313-10-jic23@kernel.org>
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

Most of the description in the original doc is effectively boilerplate
and does not bring much value so I have not carried it over into the yaml.

Added #io-channel-cells to simplify use of channels on this ADC by
consumer drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Joachim Eastwood <manabian@gmail.com>
---
 .../bindings/iio/adc/lpc1850-adc.txt          | 20 ------
 .../bindings/iio/adc/nxp,lpc1850-adc.yaml     | 61 +++++++++++++++++++
 2 files changed, 61 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/lpc1850-adc.txt b/Documentation/devicetree/bindings/iio/adc/lpc1850-adc.txt
deleted file mode 100644
index 9ada5abd45fa..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/lpc1850-adc.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-NXP LPC1850 ADC bindings
-
-Required properties:
-- compatible: Should be "nxp,lpc1850-adc"
-- reg: Offset and length of the register set for the ADC device
-- interrupts: The interrupt number for the ADC device
-- clocks: The root clock of the ADC controller
-- vref-supply: The regulator supply ADC reference voltage
-- resets: phandle to reset controller and line specifier
-
-Example:
-
-adc0: adc@400e3000 {
-	compatible = "nxp,lpc1850-adc";
-	reg = <0x400e3000 0x1000>;
-	interrupts = <17>;
-	clocks = <&ccu1 CLK_APB3_ADC0>;
-	vref-supply = <&reg_vdda>;
-	resets = <&rgu 40>;
-};
diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,lpc1850-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,lpc1850-adc.yaml
new file mode 100644
index 000000000000..6404fb73f8ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nxp,lpc1850-adc.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/nxp,lpc1850-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC1850 ADC bindings
+
+maintainers:
+  - Joachim Eastwood <manabian@gmail.com>
+
+description:
+  Supports the ADC found on the LPC1850 SoC.
+
+properties:
+  compatible:
+    const: nxp,lpc1850-adc
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
+  "#io-channel-cells":
+    const: 1
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
+        adc@400e3000 {
+            compatible = "nxp,lpc1850-adc";
+            reg = <0x400e3000 0x1000>;
+            interrupts = <17>;
+            clocks = <&ccu1 CLK_APB3_ADC0>;
+            vref-supply = <&reg_vdda>;
+            resets = <&rgu 40>;
+         };
+    };
+...
-- 
2.28.0

