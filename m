Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EBF23FDCB
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 13:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgHILUB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 07:20:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgHILUB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 07:20:01 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61CFD206E9;
        Sun,  9 Aug 2020 11:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596972000;
        bh=v5q4uRk0HDMOm1sRyCARO2rfzcScDo6WU31sLgpF0sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hXUpfyjZEwoVX20nXwoTGr4MyiylW0Gkk+mHU+z/IYTYe8sUBXzQkIL8n+FIIa5YI
         cg7XDbM+5TysgypReB2+POwl9fib/cKeVF02VLzR8l2XtL1yVlpmlHsmd8n25x/DDR
         YBCIUeUytRpLZKSzrn9yYzPkIDpPRvdyLorCenZY=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oskar Andero <oskar.andero@gmail.com>
Subject: [PATCH 01/13] dt-bindings: iio: adc: microchip,mcp3201 yaml conversion.
Date:   Sun,  9 Aug 2020 12:17:41 +0100
Message-Id: <20200809111753.156236-2-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809111753.156236-1-jic23@kernel.org>
References: <20200809111753.156236-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Drops the deprecated compatibles without the vendor name.
Whilst the driver continues to support these for old dt blobs,
any dt bindings that are actuallly verified against this document should
be fixed to add the vendor name.

Enforces rule that spi-cpol == spi-cpha.  Is there a cleaner way to
do this?

Added the #io-channel-cells property to allow for consumers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Oskar Andero <oskar.andero@gmail.com>
---
 .../devicetree/bindings/iio/adc/mcp320x.txt   | 57 ------------
 .../bindings/iio/adc/microchip,mcp3201.yaml   | 93 +++++++++++++++++++
 2 files changed, 93 insertions(+), 57 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/mcp320x.txt b/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
deleted file mode 100644
index 56373d643f76..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
+++ /dev/null
@@ -1,57 +0,0 @@
-* Microchip Analog to Digital Converter (ADC)
-
-The node for this driver must be a child node of a SPI controller, hence
-all mandatory properties described in
-
-        Documentation/devicetree/bindings/spi/spi-bus.txt
-
-must be specified.
-
-Required properties:
-	- compatible:  	Must be one of the following, depending on the
-			model:
-				"mcp3001" (DEPRECATED)
-				"mcp3002" (DEPRECATED)
-				"mcp3004" (DEPRECATED)
-				"mcp3008" (DEPRECATED)
-				"mcp3201" (DEPRECATED)
-				"mcp3202" (DEPRECATED)
-				"mcp3204" (DEPRECATED)
-				"mcp3208" (DEPRECATED)
-				"mcp3301" (DEPRECATED)
-
-				"microchip,mcp3001"
-				"microchip,mcp3002"
-				"microchip,mcp3004"
-				"microchip,mcp3008"
-				"microchip,mcp3201"
-				"microchip,mcp3202"
-				"microchip,mcp3204"
-				"microchip,mcp3208"
-				"microchip,mcp3301"
-				"microchip,mcp3550-50"
-				"microchip,mcp3550-60"
-				"microchip,mcp3551"
-				"microchip,mcp3553"
-
-			NOTE: The use of the compatibles with no vendor prefix
-			is deprecated and only listed because old DT use them.
-
-	- spi-cpha, spi-cpol (boolean):
-			Either SPI mode (0,0) or (1,1) must be used, so specify
-			none or both of spi-cpha, spi-cpol.  The MCP3550/1/3
-			is more efficient in mode (1,1) as only 3 instead of
-			4 bytes need to be read from the ADC, but not all SPI
-			masters support it.
-
-	- vref-supply:	Phandle to the external reference voltage supply.
-
-Examples:
-spi_controller {
-	mcp3x0x@0 {
-		compatible = "microchip,mcp3002";
-		reg = <0>;
-		spi-max-frequency = <1000000>;
-		vref-supply = <&vref_reg>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.yaml
new file mode 100644
index 000000000000..38dfb856da62
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/microchip,mcp3201.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip mcp3201 and similar ADCs
+
+maintainers:
+  - Oskar Andero <oskar.andero@gmail.com>
+
+description: |
+   Family of simple ADCs with an I2C inteface.
+
+properties:
+  compatible:
+    enum:
+      - microchip,mcp3001
+      - microchip,mcp3002
+      - microchip,mcp3004
+      - microchip,mcp3008
+      - microchip,mcp3201
+      - microchip,mcp3202
+      - microchip,mcp3204
+      - microchip,mcp3208
+      - microchip,mcp3301
+      - microchip,mcp3550-50
+      - microchip,mcp3550-60
+      - microchip,mcp3551
+      - microchip,mcp3553
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+  spi-cpha: true
+  spi-cpol: true
+
+  vref-supply:
+    description: External reference.
+
+  "#io-channel-cells":
+    const: 1
+
+allOf:
+  - if:
+      required:
+        - spi-cpha
+    then:
+      required:
+        - spi-cpol
+    else:
+      properties:
+        spi-cpol: false
+  - if:
+      required:
+        - spi-cpol
+    then:
+      required:
+        - spi-cpha
+    else:
+      properties:
+        spi-cpha: false
+
+required:
+  - compatible
+  - reg
+  - vref-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "microchip,mcp3002";
+            reg = <0>;
+            vref-supply = <&vref_reg>;
+            spi-cpha;
+            spi-cpol;
+            #io-channel-cells = <1>;
+        };
+        adc@1 {
+            compatible = "microchip,mcp3002";
+            reg = <1>;
+            vref-supply = <&vref_reg>;
+            spi-max-frequency = <1500000>;
+        };
+    };
+...
-- 
2.28.0

