Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182002A1A13
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgJaSw1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:52:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728475AbgJaSw0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:52:26 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D8FE2071A;
        Sat, 31 Oct 2020 18:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170346;
        bh=w/JP463PBTxpEqz/QATAd4Hh7N8EcveM++zge7NlHKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DYeur7FXGr4tBH586epLHcw6Bufm2qf0fZ9BmCTDGDO6VeTKO9WbFfltraXotqIsZ
         NWjiBuGyig6eDN2LFSe88vZadHUS3vKfdPyOLzYWH+JFrEytXZzpJ+7h910x51Dj2P
         KQ18CGzVLr0GpLj7OpRoEX51kG5nvIc8DYVYLoCg=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: [PATCH 40/46] dt-bindings:iio:accel:bosch,bma180: txt to yaml format conversion.
Date:   Sat, 31 Oct 2020 18:48:48 +0000
Message-Id: <20201031184854.745828-41-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

One question in here is whether we want to constrain the number of
interrupts.  Some parts definitely only have 1 such pin, and others
2 pins but I can not find information on the bma254.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
---
 .../devicetree/bindings/iio/accel/bma180.txt  | 35 -----------
 .../bindings/iio/accel/bosch,bma180.yaml      | 62 +++++++++++++++++++
 2 files changed, 62 insertions(+), 35 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/bma180.txt b/Documentation/devicetree/bindings/iio/accel/bma180.txt
deleted file mode 100644
index 33da4a6fdb39..000000000000
--- a/Documentation/devicetree/bindings/iio/accel/bma180.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-* Bosch BMA023 / BMA150/ BMA180 / BMA25x / SMB380 triaxial acceleration sensor
-
-https://media.digikey.com/pdf/Data%20Sheets/Bosch/BMA150.pdf
-http://omapworld.com/BMA180_111_1002839.pdf
-http://ae-bst.resource.bosch.com/media/products/dokumente/bma250/bst-bma250-ds002-05.pdf
-
-Required properties:
-
-  - compatible : should be one of:
-    "bosch,bma023"
-    "bosch,bma150"
-    "bosch,bma180"
-    "bosch,bma250"
-    "bosch,bma254"
-    "bosch,smb380"
-  - reg : the I2C address of the sensor
-  - vdd-supply : regulator phandle connected to the VDD pin
-  - vddio-supply : regulator phandle connected to the VDDIO pin
-
-Optional properties:
-
-  - interrupts : interrupt mapping for GPIO IRQ, it should by configured with
-		flags IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_EDGE_RISING
-		For the bma250 the first interrupt listed must be the one
-		connected to the INT1 pin, the second (optional) interrupt
-		listed must be the one connected to the INT2 pin.
-
-Example:
-
-bma180@40 {
-	compatible = "bosch,bma180";
-	reg = <0x40>;
-	interrupt-parent = <&gpio6>;
-	interrupts = <18 (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_EDGE_RISING)>;
-};
diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma180.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma180.yaml
new file mode 100644
index 000000000000..14e48290ffe3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma180.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/bosch,bma180.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch BMA023 / BMA150/ BMA180 / BMA25x / SMB380 triaxial accelerometers
+
+maintainers:
+  - Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
+
+description: |
+  https://media.digikey.com/pdf/Data%20Sheets/Bosch/BMA150.pdf
+  http://omapworld.com/BMA180_111_1002839.pdf
+  http://ae-bst.resource.bosch.com/media/products/dokumente/bma250/bst-bma250-ds002-05.pdf
+
+properties:
+  compatible:
+    enum:
+      - bosch,bma023
+      - bosch,bma150
+      - bosch,bma180
+      - bosch,bma250
+      - bosch,bma254
+      - bosch,smb380
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  vddio-supply: true
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+    description: |
+      Type should be either IRQ_TYPE_LEVEL_HIGH or IRQ_TYPE_EDGE_RISING.
+      For the bma250 the first interrupt listed must be the one
+      connected to the INT1 pin, the second (optional) interrupt
+      listed must be the one connected to the INT2 pin.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        accel@40 {
+            compatible = "bosch,bma180";
+            reg = <0x40>;
+            interrupt-parent = <&gpio6>;
+            interrupts = <18 (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_EDGE_RISING)>;
+        };
+    };
+...
-- 
2.28.0

