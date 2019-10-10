Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 767CBD1DFA
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2019 03:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732252AbfJJBZq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Oct 2019 21:25:46 -0400
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139]:46936
        "EHLO rjones.pdc.gateworks.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732412AbfJJBZp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Oct 2019 21:25:45 -0400
Received: by rjones.pdc.gateworks.com (Postfix, from userid 1002)
        id 4D11F1A44137; Wed,  9 Oct 2019 18:25:43 -0700 (PDT)
From:   Robert Jones <rjones@gateworks.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Jones <rjones@gateworks.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: imu: add fxos8700 imu binding
Date:   Wed,  9 Oct 2019 18:25:22 -0700
Message-Id: <20191010012523.14426-2-rjones@gateworks.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20191010012523.14426-1-rjones@gateworks.com>
References: <20190918012856.18963-1-rjones@gateworks.com>
 <20191010012523.14426-1-rjones@gateworks.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds documentation for the Freescale FXOS8700 Inertial Measurement Unit
device-tree bindings.

Signed-off-by: Robert Jones <rjones@gateworks.com>
---
 .../devicetree/bindings/iio/imu/fxos8700.yaml      | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/fxos8700.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/fxos8700.yaml b/Documentation/devicetree/bindings/iio/imu/fxos8700.yaml
new file mode 100644
index 0000000..f0dbf4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/fxos8700.yaml
@@ -0,0 +1,54 @@
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
+  Accelerometer and magnetometer combo device with an i2c interface.
+  https://www.nxp.com/products/sensors/motion-sensors/6-axis/digital-motion-sensor-3d-accelerometer-2g-4g-8g-plus-3d-magnetometer:FXOS8700CQ
+
+properties:
+  compatible:
+    enum:
+      - fsl,fxos8700
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    maxItems: 1
+
+  drive-open-drain:
+    maxItems: 1
+
+  spi-max-frequency:
+    maxItems: 1
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
+          compatible = "fsl,fxos8700";
+          reg = <0x1e>;
+
+          interrupt-parent = <&gpio2>;
+          interrupts = <7 IRQ_TYPE_EDGE_RISING>;
+          interrupt-names = "INT1";
+        };
+    };
-- 
2.9.2

