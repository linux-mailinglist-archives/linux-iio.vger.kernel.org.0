Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0772420CA5E
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 22:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgF1UeK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 16:34:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgF1UeK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 16:34:10 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 833EA206E9;
        Sun, 28 Jun 2020 20:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593376449;
        bh=f150PUxzlRF1ro795mRP6yAR7C3HpuYBEnqGNJDwC94=;
        h=From:To:Cc:Subject:Date:From;
        b=NFikk0dlPhNRJb7iSJhvodRnuuH6Pze6PBIwYW9dszhVTYvZIoWukiCzTGv/CFS+n
         pg7GhsWWsAD+KIXSgFtBa/BPbRYvaA1a5RAue/zCsRB7byjRaUDlZ+3GxHClCxz0Vl
         7mfBAL2VyCeaOfRtvJ3Pm75o+48MFN7GTm2FcxZ4=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] dt-bindings: iio: accel: kionix,kxsd9 yaml conversion.
Date:   Sun, 28 Jun 2020 21:32:05 +0100
Message-Id: <20200628203205.49915-1-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Convert and flesh out a bit the binding docs for this simple 3 axis
accelerometer.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

Sorry, typo in iio mailing list in first try at sending this out.

.../bindings/iio/accel/kionix,kxsd9.txt       | 22 -------
 .../bindings/iio/accel/kionix,kxsd9.yaml      | 65 +++++++++++++++++++
 2 files changed, 65 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.txt
 create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.txt b/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.txt
deleted file mode 100644
index b25bf3a77e0f..000000000000
--- a/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Kionix KXSD9 Accelerometer device tree bindings
-
-Required properties:
- - compatible: 		should be set to "kionix,kxsd9"
- - reg:			i2c slave address
-
-Optional properties:
- - vdd-supply:		The input supply for VDD
- - iovdd-supply:	The input supply for IOVDD
- - interrupts:		The movement detection interrupt
- - mount-matrix:	See mount-matrix.txt
-
-Example:
-
-kxsd9@18 {
-	compatible = "kionix,kxsd9";
-	reg = <0x18>;
-	interrupt-parent = <&foo>;
-	interrupts = <57 IRQ_TYPE_EDGE_FALLING>;
-	iovdd-supply = <&bar>;
-	vdd-supply = <&baz>;
-};
diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml b/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml
new file mode 100644
index 000000000000..d61ab4fa3d71
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/kionix,kxsd9.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kionix KXSD9 Accelerometer
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+description: |
+  3 axis 12 bit accelerometer with +-8G range on all axes. Also has a
+  12 bit auxiliary ADC channel. Interface is either SPI or I2C.
+
+properties:
+  compatible:
+    const: kionix,kxsd9
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+  iovdd-supply: true
+
+  interrupts:
+    maxItems: 1
+
+  mount-matrix:
+    description: an optional 3x3 mounting rotation matrix.
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    # include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        accel@18 {
+            compatible = "kionix,kxsd9";
+            reg = <0x18>;
+            iovdd-supply = <&iovdd>;
+            vdd-supply = <&vdd>;
+            interrupts = <57 IRQ_TYPE_EDGE_FALLING>;
+            mount-matrix = "-0.984807753012208", "0",  "-0.173648177666930",
+                           "0",                  "-1", "0",
+                           "-0.173648177666930", "0",  "0.984807753012208";
+        };
+    };
+  - |
+    # include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        accel@0 {
+            compatible = "kionix,kxsd9";
+            reg = <0>;
+            spi-max-frequency = <10000000>;
+        };
+    };
+...
-- 
2.27.0

