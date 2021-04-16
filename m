Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EFB361D69
	for <lists+linux-iio@lfdr.de>; Fri, 16 Apr 2021 12:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240513AbhDPJbi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Apr 2021 05:31:38 -0400
Received: from first.geanix.com ([116.203.34.67]:43654 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240059AbhDPJbi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 16 Apr 2021 05:31:38 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 1F9C74639EB;
        Fri, 16 Apr 2021 09:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1618565468; bh=QCByfvtsxKT+s8x24KZK2bhje184vKscRlyLKCz62nM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KSjBPyJXbAZT1GJ/XyxLTJBkoAvdrxTGzNq65aV2kQcaJxo760hgsvM4XwUgHP+yf
         RDJ6Ys7kJEylZJZOforzDkFB85IoamBofZwHyxkrMnlFOzKxs6lvGmuSt/PcMTvT9m
         wQQ0iWkZIfyG4ICCsqfbE0mTIKcwwjk7v3oxNeGDIK/sifNNR8lyqn/e3CY/tFDjDm
         LtD19UVoFGyKNI2RZO6Kwlus6a91zWjWksHVEeawOVtU/GDxODRZkOJbxJzpTf1Q8T
         MuGHLbUQZmeQi1GPINFWRh9uZPQE5v/ztHnI80POnbg/cC7w4XDt4Zwm3inZn+3nu3
         x14Qdnik1oTLA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org, lars@metafoo.de,
        Nuno.Sa@analog.com, robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH 2/2] dt-bindings: iio: accel: fxls8962af: add bindings
Date:   Fri, 16 Apr 2021 11:30:39 +0200
Message-Id: <20210416093039.1424135-2-sean@geanix.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210416093039.1424135-1-sean@geanix.com>
References: <20210416093039.1424135-1-sean@geanix.com>
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
Changes:
 - Checked with 'make DT_CHECKER_FLAGS=-m dt_binding_check'

 .../bindings/iio/accel/nxp,fxls8962af.yaml    | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
new file mode 100644
index 000000000000..57322ec8df81
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
@@ -0,0 +1,73 @@
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
+  - interrupts
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

