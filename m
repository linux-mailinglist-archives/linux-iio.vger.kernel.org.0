Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B626728CEFD
	for <lists+linux-iio@lfdr.de>; Tue, 13 Oct 2020 15:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgJMNQI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Oct 2020 09:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgJMNQI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Oct 2020 09:16:08 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEADC0613D2
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2020 06:16:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e17so23965692wru.12
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2020 06:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VU2ZxqifLVfdvXSsHtiP10MIVpWQnhcB7qzC0l8n27Q=;
        b=UufO7gbvHGhekdd1ajNHDbaSed4SdIC7Spgf6zXceCSYOf/ADkjmmkC9V23bqUMbB1
         ZsrrCkmtKhTx4DbLS4KY8QwRW2CIP8POGiUetpNpMGWyvu2xayQN3CmH/y6R+UkzFZOk
         y8YrUg4kpIWXTd2gNzWGuF0gER7c7i3EQnJexjIkYzTIZnfAxw8SehnLQOBDKkmNdeFk
         NXrJ3liIsKToDluLopfwwND95b7h+vHBVPoOKOYPmhOTpJspfjGU4ZUip8DoRN4/k4yZ
         BKICBEMee6dlz2O01Gebr2Y2B/VhlrIQKrfs/AgiXMR+TqUbTk7P30Fiu+WgLznCVNAU
         YGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VU2ZxqifLVfdvXSsHtiP10MIVpWQnhcB7qzC0l8n27Q=;
        b=PTzYX9E5NeQjKspNReXjyuT97WNshg59jJ7VHS2a25MnaBUlAr/lbLo+FB3yMfjNJl
         zAScLCsqhhRR33nr0S628xEFN/vbyi406o+LH0PwZbEefgC+kH6wsI8aBFSrvQcpsR5q
         vvMtRnxRl1/eKNbTY0EHZb6ldJ38FwkW2TJbBuwwlArkyhM8FV2X60xUeSOV6RO//gV1
         3tKj+F2HJRsQBBWRFY3Sio2/nvpzK/8woDIGJIEx4+MD5X48JYRkmfDrjrsm/tKv1fxm
         DBgHTmye3/1DD91ZMvhj01U06/Z3yfjgpuCqh55VQoDzouYRjbrMLhUEOcKJyzpBDihj
         VI2Q==
X-Gm-Message-State: AOAM530ziePjGIbhZk3fnKocSJOy56EkmSgaXzTRNS4LxNlEv4OX5Grp
        aguZO7KUd6vCsqXKvCYwrb6q+w==
X-Google-Smtp-Source: ABdhPJyrMGbPezIyjxdtuy1W66p9EYHvfNv74EcrgGuUCuA1A4K2B3PooNGWh648/iYuSDfIvVd8pQ==
X-Received: by 2002:a5d:480a:: with SMTP id l10mr34477948wrq.238.1602594966785;
        Tue, 13 Oct 2020 06:16:06 -0700 (PDT)
Received: from arch-thunder.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id u63sm27362883wmb.13.2020.10.13.06.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 06:16:04 -0700 (PDT)
From:   Rui Miguel Silva <rui.silva@linaro.org>
X-Google-Original-From: Rui Miguel Silva <rmfrfs@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rui Miguel Silva <rmfrfs@gmail.com>
Subject: [PATCH] dt-bindings: fxas21002c: convert bindings to yaml
Date:   Tue, 13 Oct 2020 14:15:45 +0100
Message-Id: <20201013131545.503434-1-rmfrfs@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert fxas21002c gyroscope sensor bindings documentation to
yaml schema and remove the textual bindings document.

Signed-off-by: Rui Miguel Silva <rmfrfs@gmail.com>
---
 .../bindings/iio/gyroscope/nxp,fxas21002c.txt | 31 --------
 .../iio/gyroscope/nxp,fxas21002c.yaml         | 77 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 78 insertions(+), 32 deletions(-)
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
index 000000000000..7680e97cf1d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/gyroscope/nxp,fxas21002c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP FXAS21002C Gyroscope Unit
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
+    enum:
+      - nxp,fxas21002c
+
+  reg:
+    maxItems: 1
+    description: base address of the device
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
+    description: device support 2 interrupts, INT1 and INT2, the interrupts can
+                 be triggered on rising or falling edges.
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - INT1
+        - INT2
+    description: gyroscope interrupt line in use.
+
+  drive-open-drain:
+    type: boolean
+    description: the interrupt/data ready line will be configured as open drain,
+                 which is useful if several sensors share the same interrupt
+                 line.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vddio-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
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

