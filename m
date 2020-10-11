Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFDA28A867
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 19:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388239AbgJKRK2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 13:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387984AbgJKRK2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:10:28 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CBB020782;
        Sun, 11 Oct 2020 17:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602436228;
        bh=e62MvhY7mBDduYumuFSyGAwOusGVUYbFQapzMnGtJlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pPkoSK6XlFmPxD5HKjAZ2TgSSTDtVBLz+79YMPEB4q43GNfKfaHX9vg99Y9YKJurD
         p6B6e4fXhCkGJd5T10Fbm/iVszuWlvADU92cJp3M11mH86t/FH3c5rP6PnrjAfdu9H
         q6R4195tj711sZyc0NiLweNiLfvcAv2S+MefeF7g=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tomas Novotny <tomas@novotny.cz>
Subject: [PATCH 20/29] dt-bindings:iio:dac:microchip,mcp4725 yaml conversion
Date:   Sun, 11 Oct 2020 18:07:40 +0100
Message-Id: <20201011170749.243680-21-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201011170749.243680-1-jic23@kernel.org>
References: <20201011170749.243680-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'm not sure vdd-supply absolutely has to be provided if vref-supply
is, but as the previous binding docs stated it was required it seems
reasonable to leave it as such.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:  Tomas Novotny <tomas@novotny.cz>
---
 .../devicetree/bindings/iio/dac/mcp4725.txt   | 35 ---------
 .../bindings/iio/dac/microchip,mcp4725.yaml   | 71 +++++++++++++++++++
 2 files changed, 71 insertions(+), 35 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/mcp4725.txt b/Documentation/devicetree/bindings/iio/dac/mcp4725.txt
deleted file mode 100644
index 1bc6c093fbfe..000000000000
--- a/Documentation/devicetree/bindings/iio/dac/mcp4725.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-Microchip mcp4725 and mcp4726 DAC device driver
-
-Required properties:
-	- compatible: Must be "microchip,mcp4725" or "microchip,mcp4726"
-	- reg: Should contain the DAC I2C address
-	- vdd-supply: Phandle to the Vdd power supply. This supply is used as a
-	  voltage reference on mcp4725. It is used as a voltage reference on
-	  mcp4726 if there is no vref-supply specified.
-
-Optional properties (valid only for mcp4726):
-	- vref-supply: Optional phandle to the Vref power supply. Vref pin is
-	  used as a voltage reference when this supply is specified.
-	- microchip,vref-buffered: Boolean to enable buffering of the external
-	  Vref pin. This boolean is not valid without the vref-supply. Quoting
-	  the datasheet: This is offered in cases where the reference voltage
-	  does not have the current capability not to drop its voltage when
-	  connected to the internal resistor ladder circuit.
-
-Examples:
-
-	/* simple mcp4725 */
-	mcp4725@60 {
-		compatible = "microchip,mcp4725";
-		reg = <0x60>;
-		vdd-supply = <&vdac_vdd>;
-	};
-
-	/* mcp4726 with the buffered external reference voltage */
-	mcp4726@60 {
-		compatible = "microchip,mcp4726";
-		reg = <0x60>;
-		vdd-supply = <&vdac_vdd>;
-		vref-supply = <&vdac_vref>;
-		microchip,vref-buffered;
-	};
diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4725.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4725.yaml
new file mode 100644
index 000000000000..271998610ceb
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4725.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/microchip,mcp4725.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip mcp4725 and mcp4726 DAC
+
+maintainers:
+  - Tomas Novotny <tomas@novotny.cz>
+
+properties:
+  compatible:
+    enum:
+      - microchip,mcp4725
+      - microchip,mcp4726
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: |
+      Provides both power and acts as the reference supply on the mcp4725.
+      For the mcp4726 it will be used as the reference voltage if vref-supply
+      is not provided.
+
+  vref-supply:
+    description:
+      Vref pin is used as a voltage reference when this supply is specified.
+
+  microchip,vref-buffered:
+    type: boolean
+    description: |
+      Enable buffering of the external Vref pin. This boolean is not valid
+      without the vref-supply. Quoting the datasheet: This is offered in
+      cases where the reference voltage does not have the current
+      capability not to drop its voltage when connected to the internal
+      resistor ladder circuit.
+
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: microchip,mcp4726
+    then:
+      properties:
+        vref-supply: false
+        microchip,vref-buffered: false
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mcp4725@60 {
+            compatible = "microchip,mcp4725";
+            reg = <0x60>;
+            vdd-supply = <&vdac_vdd>;
+        };
+    };
+...
-- 
2.28.0

