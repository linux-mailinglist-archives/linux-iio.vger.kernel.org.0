Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3960328DF61
	for <lists+linux-iio@lfdr.de>; Wed, 14 Oct 2020 12:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgJNKvM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Oct 2020 06:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgJNKvL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Oct 2020 06:51:11 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C41C061755
        for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2020 03:51:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h7so3256445wre.4
        for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2020 03:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XWslSzgwelv3+t+krm1VmPXi1dB3IfoNZQoNEIRR3UI=;
        b=l422eKGq6wTqJuKldBvLXfh3ZD0AkCcFtDAx6mODJzIe6MEGj38yUcTkiXKkRbFn4L
         /8hzwCo+dNZQMNnT7LtnjvVPtchNaxNMhpERGIeCeBJDJL0i7oeG+KydaA7GhnYLSsGl
         ry/gxMcI6h62SffUTbmIj4TOUOfoQpZnVx5U44McEGWHubKhKK2YBvx+bv0I7J0KwQUr
         zKwFwPqwzFAdYpHwePK9DdKHzlu7sUu3Vv1gFCODIxsBcdqgiFQTcUM6XNsBWIp8i30y
         OuWxug/q56opCAm49bhEY/u5tQ41Gj7UDMNwLA4tFR36FsWBdtWhaZvUpbGrQ5D4c2No
         A6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XWslSzgwelv3+t+krm1VmPXi1dB3IfoNZQoNEIRR3UI=;
        b=HmRBzc5icrV7Q4pFtmcvMjWW/6+wZ4pM/cN2RFdugFCIUVhQv4FOyEK7Vt3pfVBb8A
         uxjRf30lPK1c7i+fqmRuJjWOBGubkmAyBsl3zB1BVUQrAPD7TdWHos0y3bVyvQhz5jrY
         xYTmhdmzodLkkjR0omOnoSOODNWs0CxC2gGJnG0bvV5+Cp7C9vp0Jr0gGbo+pcLSvzNL
         x6EwTxLfQ0iI7O3ccDKiL1sosEN3NEkA3BsF302t1T+8W6DAlx8uFQZdSz82HrMqzx/m
         rleI1sCi00TPCdEbTkBO/OUn6rC6HTVsA/2cxqwrgx1Qd7DimMJm4haJcqZZ3hdf3+gt
         A4Sw==
X-Gm-Message-State: AOAM533wYvXX63tNqec4u9GS97zxaSCZUL/OJnwtxJXYl+nqyTmthY1H
        rB840WVUfqnPrPEJac05OWlYTA==
X-Google-Smtp-Source: ABdhPJxwKx/HGtjgU9lsjFsHqEFOnDLNTLTvYwMdj29v6uzzin07cTpEr0O0/9kTmHBusRd7UGwdOw==
X-Received: by 2002:adf:ce01:: with SMTP id p1mr4519754wrn.33.1602672668770;
        Wed, 14 Oct 2020 03:51:08 -0700 (PDT)
Received: from arch-thunder.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id c1sm4416464wru.49.2020.10.14.03.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 03:51:08 -0700 (PDT)
From:   Rui Miguel Silva <rui.silva@linaro.org>
X-Google-Original-From: Rui Miguel Silva <rmfrfs@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rui Miguel Silva <rmfrfs@gmail.com>
Subject: [PATCH v2] dt-bindings: fxas21002c: convert bindings to yaml
Date:   Wed, 14 Oct 2020 11:49:26 +0100
Message-Id: <20201014104926.688666-1-rmfrfs@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert fxas21002c gyroscope sensor bindings documentation to
yaml schema, remove the textual bindings document and update MAINTAINERS entry.

Signed-off-by: Rui Miguel Silva <rmfrfs@gmail.com>
---
v1 -> v2:
   Jonathan Cameron:
       https://lore.kernel.org/linux-iio/20201013153431.000052c9@huawei.com/
       - remove Unit from tittle
       - reword interrupts description
       - drop interrupt-name description
       - add spi example and bindings
       - remove vddxx from required list

 .../bindings/iio/gyroscope/nxp,fxas21002c.txt | 31 ------
 .../iio/gyroscope/nxp,fxas21002c.yaml         | 95 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 96 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
deleted file mode 100644
index 465e104bbf14..000000000000
--- a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-* NXP FXAS21002C Gyroscope device tree bindings
-
-http://www.nxp.com/products/sensors/gyroscopes/3-axis-digital-gyroscope:FXAS21002C
-
-Required properties:
-  - compatible : should be "nxp,fxas21002c"
-  - reg : the I2C address of the sensor or SPI chip select number for the
-          device.
-  - vdd-supply: phandle to the regulator that provides power to the sensor.
-  - vddio-supply: phandle to the regulator that provides power to the bus.
-
-Optional properties:
-  - reset-gpios : gpio used to reset the device, see gpio/gpio.txt
-  - interrupts : device support 2 interrupts, INT1 and INT2,
-                 the interrupts can be triggered on rising or falling edges.
-                 See interrupt-controller/interrupts.txt
-  - interrupt-names: should contain "INT1" or "INT2", the gyroscope interrupt
-                     line in use.
-  - drive-open-drain: the interrupt/data ready line will be configured
-                      as open drain, which is useful if several sensors share
-                      the same interrupt line. This is a boolean property.
-                      (This binding is taken from pinctrl/pinctrl-bindings.txt)
-
-Example:
-
-gyroscope@20 {
-	compatible = "nxp,fxas21002c";
-	reg = <0x20>;
-	vdd-supply = <&reg_peri_3p15v>;
-	vddio-supply = <&reg_peri_3p15v>;
-};
diff --git a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
new file mode 100644
index 000000000000..2560458dc50b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/gyroscope/nxp,fxas21002c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP FXAS21002C Gyroscope
+
+maintainers:
+  - Rui Miguel Silva <rmfrfs@gmail.com>
+
+description: |
+  3 axis digital gyroscope device with an I2C and SPI interface.
+  http://www.nxp.com/products/sensors/gyroscopes/3-axis-digital-gyroscope:FXAS21002C
+
+properties:
+  compatible:
+    const: nxp,fxas21002c
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor
+
+  vddio-supply:
+    description: Regulator that provides power to the bus
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO connected to reset
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+    description: Either interrupt may be triggered on rising or falling edges.
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - INT1
+        - INT2
+
+  drive-open-drain:
+    type: boolean
+    description: the interrupt/data ready line will be configured as open drain,
+                 which is useful if several sensors share the same interrupt
+                 line.
+
+  spi-max-frequency:
+    maximum: 2000000
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        gyroscope@20 {
+          compatible = "nxp,fxas21002c";
+          reg = <0x20>;
+
+          vdd-supply = <&reg_peri_3p15v>;
+          vddio-supply = <&reg_peri_3p15v>;
+
+          interrupt-parent = <&gpio1>;
+          interrupts = <7 IRQ_TYPE_EDGE_RISING>;
+          interrupt-names = "INT1";
+        };
+    };
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        gyroscope@0 {
+          compatible = "nxp,fxas2102c";
+          reg = <0x0>;
+
+          spi-max-frequency = <2000000>;
+
+          interrupt-parent = <&gpio2>;
+          interrupts = <7 IRQ_TYPE_EDGE_RISING>;
+          interrupt-names = "INT2";
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 6594f0966716..2e85e114c9c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12469,7 +12469,7 @@ NXP FXAS21002C DRIVER
 M:	Rui Miguel Silva <rmfrfs@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
+F:	Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
 F:	drivers/iio/gyro/fxas21002c.h
 F:	drivers/iio/gyro/fxas21002c_core.c
 F:	drivers/iio/gyro/fxas21002c_i2c.c
-- 
2.28.0

