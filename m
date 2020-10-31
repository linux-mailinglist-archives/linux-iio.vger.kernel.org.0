Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8D22A1A0C
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgJaSwX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:52:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728487AbgJaSwW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:52:22 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEDF020720;
        Sat, 31 Oct 2020 18:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170341;
        bh=iHy3qiKeE26nqQxdj2SbGtb4ptFCdtFFFG/BnMSMSc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPA1W63LH8K1ePeMW9h9fQ30TK7lJtTQgLNOnCDbNYnHvgSc35rYRPq0Q6roTu4Gd
         DunoxfdnLz8h04sv6Rdt2xliPlOVMeoM7999cfXxtx8kAj8T+dHzWTINxMGJ5zxRJ0
         hG7+TCyDxBldEifPufVzj/XHW4mNTj2pf4tjbwe0=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 37/46] dt-binding:iio:adc:ti,ads124s08: txt to yaml format conversion.
Date:   Sat, 31 Oct 2020 18:48:45 +0000
Message-Id: <20201031184854.745828-38-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple binding so straight forward format conversion.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Murphy <dmurphy@ti.com>
---
 .../bindings/iio/adc/ti,ads124s08.yaml        | 52 +++++++++++++++++++
 .../bindings/iio/adc/ti-ads124s08.txt         | 25 ---------
 2 files changed, 52 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads124s08.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads124s08.yaml
new file mode 100644
index 000000000000..5912a52953fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads124s08.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads124s08.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments' ads124s08 and ads124s06 ADC chip
+
+maintainers:
+  - Dan Murphy <dmurphy@ti.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,ads124s06
+      - ti,ads124s08
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  spi-cpha: true
+
+  reset-gpios:
+    maxItems: 1
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,ads124s08";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            spi-cpha;
+            reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt b/Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt
deleted file mode 100644
index ecf807bb32f7..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-* Texas Instruments' ads124s08 and ads124s06 ADC chip
-
-Required properties:
- - compatible :
-	"ti,ads124s08"
-	"ti,ads124s06"
- - reg : spi chip select number for the device
-
-Recommended properties:
- - spi-max-frequency : Definition as per
-		Documentation/devicetree/bindings/spi/spi-bus.txt
- - spi-cpha : Definition as per
-		Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Optional properties:
- - reset-gpios : GPIO pin used to reset the device.
-
-Example:
-adc@0 {
-	compatible = "ti,ads124s08";
-	reg = <0>;
-	spi-max-frequency = <1000000>;
-	spi-cpha;
-	reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
-};
-- 
2.28.0

