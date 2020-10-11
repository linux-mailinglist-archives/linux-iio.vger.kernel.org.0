Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027AC28A859
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 19:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgJKRKH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 13:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729634AbgJKRKH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:10:07 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B44D22248;
        Sun, 11 Oct 2020 17:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602436207;
        bh=+XViQVUu1L+LaAxp5/gTa2zkwf7auuDUqAlEskEprIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wWTANEmiUGCgbrnoWFXsfOZTgoI/Tt6bwzi7spw15XBiIw0S3urpOKBIecr9+nL0l
         SogFX2J9TCLIs578eXKX435BKYrHhJ4yFILEWM+Lj+V28vs3ChTOix5RqNJUbnNzKg
         Q6iiUuwoeQO3Leo2Bj+C0e6Ow7fm5W1dRd5Iz+x4=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 06/29] dt-bindings:iio:pressure:murata,zpa2326 yaml conversion
Date:   Sun, 11 Oct 2020 18:07:26 +0100
Message-Id: <20201011170749.243680-7-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201011170749.243680-1-jic23@kernel.org>
References: <20201011170749.243680-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple conversion with a few minor tweaks:
* I added 1MHz max for spi-max-frequency
* I have give myself as the maintainer.  This driver was written by
  Gregor Boirie but I don't have an up to date email address for Gregor.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../bindings/iio/pressure/murata,zpa2326.yaml | 62 +++++++++++++++++++
 .../bindings/iio/pressure/zpa2326.txt         | 29 ---------
 2 files changed, 62 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/murata,zpa2326.yaml b/Documentation/devicetree/bindings/iio/pressure/murata,zpa2326.yaml
new file mode 100644
index 000000000000..d6103be03460
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/murata,zpa2326.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/murata,zpa2326.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Murata ZPA2326 pressure sensor
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+description: |
+  Pressure sensor from Murata with SPI and I2C bus interfaces.
+
+
+properties:
+  compatible:
+    const: murata,zpa2326
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+  vref-supply: true
+
+  interrupts:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 1000000
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pressure@5c {
+            compatible = "murata,zpa2326";
+            reg = <0x5c>;
+            interrupt-parent = <&gpio>;
+            interrupts = <12>;
+            vdd-supply = <&ldo_1v8_gnss>;
+        };
+    };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pressure@0 {
+            compatible = "murata,zpa2326";
+            reg = <0>;
+            spi-max-frequency = <500000>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/pressure/zpa2326.txt b/Documentation/devicetree/bindings/iio/pressure/zpa2326.txt
deleted file mode 100644
index a36ab3e0c3f7..000000000000
--- a/Documentation/devicetree/bindings/iio/pressure/zpa2326.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Murata ZPA2326 pressure sensor
-
-Pressure sensor from Murata with SPI and I2C bus interfaces.
-
-Required properties:
-- compatible: "murata,zpa2326"
-- reg: the I2C address or SPI chip select the device will respond to
-
-Recommended properties for SPI bus usage:
-- spi-max-frequency: maximum SPI bus frequency as documented in
-  Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Optional properties:
-- vref-supply: an optional regulator that needs to be on to provide VREF
-  power to the sensor
-- vdd-supply: an optional regulator that needs to be on to provide VDD
-  power to the sensor
-- interrupts: interrupt mapping for IRQ as documented in
-  Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-
-Example:
-
-zpa2326@5c {
-	compatible = "murata,zpa2326";
-	reg = <0x5c>;
-	interrupt-parent = <&gpio>;
-	interrupts = <12>;
-	vdd-supply = <&ldo_1v8_gnss>;
-};
-- 
2.28.0

