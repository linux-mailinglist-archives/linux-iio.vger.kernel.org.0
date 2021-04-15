Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CB73608A3
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 13:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhDOLzt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 07:55:49 -0400
Received: from first.geanix.com ([116.203.34.67]:50684 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229943AbhDOLzs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 15 Apr 2021 07:55:48 -0400
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Apr 2021 07:55:47 EDT
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id B5066463503;
        Thu, 15 Apr 2021 11:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1618487188; bh=+kiZuFppmn4L51yyNJpKCMDy6SXekULcCuuEbjvZWow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Oo4SjmT2sTtuRopDLYMaGJ0FPLqzSfk6zbTfufhVt6IQEcBXebJKenPcJq8tvT8O8
         uVx+zhOmw19yDkD/S4QWPpsggtM2zO9V2lSr87m1sRDU7901H7fI0Mg5XReP/ryriD
         UW6gJzfVmUcMi2qQtQdBUAaWMF8Wi4u9XzwLH8fInY+TdjmS6mZ6HYmDie9ZsbcuyM
         TzmRFbBv/2d0H5r3avbDjb/gUmQBigU9EmZ2ZAWS4kVuIo4oMH+LheriHJV1ZL4EkJ
         NmEXNRFydQR7OT3WtOBzRmAw78SwjovyVr3QD0JjUOwDz1ONhd7oAK5rRMRXe/bJWi
         YL38+kuzixiHg==
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>
Subject: [RFC PATCH 2/2] dt-bindings: iio: accel: fxls8962af: add bindings
Date:   Thu, 15 Apr 2021 13:46:14 +0200
Message-Id: <20210415114614.1071928-2-sean@geanix.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210415114614.1071928-1-sean@geanix.com>
References: <20210415114614.1071928-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree binding for the NXP FXLS8962AF/FXLS8962AF
accelerometer sensor.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 .../bindings/iio/accel/nxp,fxls8962af.yaml    | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
new file mode 100644
index 000000000000..8cf099c75d1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/nxp,fxls8962af.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP FXLS8962AF/FXLS8964AF Accelerometer driver
+
+maintainers:
+  - Sean Nyekjaer <sean@geanix.com>
+
+description: |
+  NXP FXLS8962AF/FXLS8964AF Accelerometer driver that supports
+  SPI and I2C interface.
+    https://www.nxp.com/docs/en/data-sheet/FXLS8962AF.pdf
+    https://www.nxp.com/docs/en/data-sheet/FXLS8964AF.pdf
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: nxp,fxls8962af
+          - const: nxp,fxls8964af
+      - enum:
+          - nxp,fxls8962af
+          - nxp,fxls8964af
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: phandle to the regulator that provides power to the accelerometer
+
+  spi-max-frequency: true
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c0 {
+        /* Example for a I2C device node */
+        accelerometer@2a {
+            compatible = "nxp,fxls8962af";
+            reg = <0x62>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+  - |
+    spi0 {
+        /* Example for a SPI device node */
+        accelerometer@0 {
+            compatible = "nxp,fxls8962af";
+            reg = <0>;
+            spi-max-frequency = <4000000>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
-- 
2.31.0

