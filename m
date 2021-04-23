Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB3036903D
	for <lists+linux-iio@lfdr.de>; Fri, 23 Apr 2021 12:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhDWKVN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Apr 2021 06:21:13 -0400
Received: from first.geanix.com ([116.203.34.67]:42638 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236059AbhDWKVL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 23 Apr 2021 06:21:11 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id C101E465313;
        Fri, 23 Apr 2021 10:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1619173227; bh=yH3nB62gojQ8Bg1V7LeedQ5g6f7Pc2W3CcVgPh99OWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=IJmmRN0tcV62Jl7bHRQFPxG3vJP8LpltR30KYjFW4ALPQFBqKLR6UAlUHvbufmg4H
         vrsmgYUjy1tMZCQyRM70v//moiwNsFpAad386KBbBl4gYjgvEqqZHL4Q/Rk32DYUQt
         pzqK0go0ZUHK9McK/Sc22dR+1m+tCvqXD2CJtCWo1u8mZHQkgRti/AQnkwSBlH4GVF
         inEVGltFYF7EOaK7eNVVsMMBAMs1gdMHpe2EQqPwZfvcEMWG16Tv+MDRhGeRxii36R
         HOt3a2paXQBz8dnS36FqCr/pPqXP6iPVc4QkXMEm8yWYuaFNHA5KEFYnIOHfn1fnP5
         OBbaU3F1TfvDQ==
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de, Nuno.Sa@analog.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v2 2/2] dt-bindings: iio: accel: fxls8962af: add bindings
Date:   Fri, 23 Apr 2021 12:19:51 +0200
Message-Id: <20210423101951.2876009-2-sean@geanix.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210423101951.2876009-1-sean@geanix.com>
References: <20210423101951.2876009-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree binding for the NXP FXLS8962AF/FXLS8964AF
accelerometer sensor.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes for v2:
 - removed requirement for interrupt

 .../bindings/iio/accel/nxp,fxls8962af.yaml    | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
new file mode 100644
index 000000000000..d8ac25402979
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
@@ -0,0 +1,72 @@
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
+    enum:
+      - nxp,fxls8962af
+      - nxp,fxls8964af
+
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
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* Example for a I2C device node */
+        accelerometer@62 {
+            compatible = "nxp,fxls8962af";
+            reg = <0x62>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
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

