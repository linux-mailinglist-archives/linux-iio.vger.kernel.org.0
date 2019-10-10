Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 562EED2FD3
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2019 19:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfJJR4x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Oct 2019 13:56:53 -0400
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139]:50068
        "EHLO rjones.pdc.gateworks.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726679AbfJJR4x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Oct 2019 13:56:53 -0400
Received: by rjones.pdc.gateworks.com (Postfix, from userid 1002)
        id A327E1A42D74; Thu, 10 Oct 2019 10:56:50 -0700 (PDT)
From:   Robert Jones <rjones@gateworks.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Jones <rjones@gateworks.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: imu: add fxos8700 imu binding
Date:   Thu, 10 Oct 2019 10:56:47 -0700
Message-Id: <20191010175648.10830-2-rjones@gateworks.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20191010175648.10830-1-rjones@gateworks.com>
References: <20191010012523.14426-1-rjones@gateworks.com>
 <20191010175648.10830-1-rjones@gateworks.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds documentation for the Freescale FXOS8700 Inertial Measurement Unit
device-tree bindings.

Signed-off-by: Robert Jones <rjones@gateworks.com>
---
 .../devicetree/bindings/iio/imu/nxp,fxos8700.yaml  | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml b/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
new file mode 100644
index 0000000..d33a1cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/fxos8700.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale FXOS8700 Inertial Measurement Unit
+
+maintainers:
+  - Robert Jones <rjones@gateworks.com>
+
+description: |
+  Accelerometer and magnetometer combo device with an i2c and SPI interface.
+  https://www.nxp.com/products/sensors/motion-sensors/6-axis/digital-motion-sensor-3d-accelerometer-2g-4g-8g-plus-3d-magnetometer:FXOS8700CQ
+
+properties:
+  compatible:
+    enum:
+      - nxp,fxos8700
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 2
+
+  interrupt-names:
+    maxItems: 2
+    items:
+      - const: INT1
+      - const: INT2
+
+  drive-open-drain:
+    type: boolean
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        fxos8700@1e {
+          compatible = "nxp,fxos8700";
+          reg = <0x1e>;
+
+          interrupt-parent = <&gpio2>;
+          interrupts = <7 IRQ_TYPE_EDGE_RISING>;
+          interrupt-names = "INT1";
+        };
+    };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        fxos8700@1e {
+          compatible = "nxp,fxos8700";
+          reg = <0x1e>;
+
+          interrupt-parent = <&gpio2>;
+          spi-max-frequency = <1000000>
+          interrupts = <7 IRQ_TYPE_EDGE_RISING>;
+          interrupt-names = "INT1";
+        };
+    };
-- 
2.9.2

