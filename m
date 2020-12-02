Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2262CC8BB
	for <lists+linux-iio@lfdr.de>; Wed,  2 Dec 2020 22:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgLBVOv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 16:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbgLBVOv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2020 16:14:51 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEF1C061A47
        for <linux-iio@vger.kernel.org>; Wed,  2 Dec 2020 13:14:04 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id q8so12909ljc.12
        for <linux-iio@vger.kernel.org>; Wed, 02 Dec 2020 13:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q7NYbtygyTG1IxGitcusZU9KV5ZRKQvC8eHatcLLmcQ=;
        b=lm0uI04I6ie4yuEnn9qyEEMy0ecFrzKrgmaqVCQ5QyOgefZdlHK/dLfrAjtZbmyvH9
         Sh5PZZhrqq+4jXXem32D7ofYM/6XW4IfqZZxivpbdc3JZO56akstmP10GCZK2ARXwlJ3
         1o5T2PU1BzaIW2lS6e+24K0N3ynRCYANv03c4UyN+R3WGgMw6PvwhL8o/xAm6DGecpkX
         IJlGxmXCshuA8E/KmVTIOnKWbqA5Mg5sowSbvouyBO+JLgtW12NNcLn+GUz/UsjOk4dD
         w+tnBCEGIbjK7xcX4owu8y9lK/O20fYQszYMik3wAiGDntgqwhU1hHbmX34wvijDGBJJ
         ETIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q7NYbtygyTG1IxGitcusZU9KV5ZRKQvC8eHatcLLmcQ=;
        b=EfM3uoFiqEEBj0GqtpuirUpO8hLYMwHeqpSr6BuprlVZMkQb45Ib7tHIqHMdXk9juK
         ZtO0R4nLX8ql06GjLL/reWTio8if0a0D6KQ+R1quZSHWE1rleAjiudNkfP7C6ObXwK1k
         FShKJxizGMPVJsKCi03r4DKNE6GXkyJMCbq974wSXjooGAWgIGZHzocxMZdP8wuwFXMt
         pM0VhAE0WDBC+Wx+WEjCkliqxHrPVa19L9ucL4RJ6HUUedKUr1RGY0PI1Y5iP0N8wGw+
         6tUQYhfMsKsuw0PW5BrGLWlPrKdRduB6ITs7XMpFVzHmzxE9NiW60kYA5/WCXPdc8WNd
         5i1g==
X-Gm-Message-State: AOAM532FSEGd1tdVwIshXt7CCX9FTEd5VDjNxB+qEvLQC8nBaEN7K5So
        vz7MdQ5vz55OC4DJ9SxNQ2YdkA==
X-Google-Smtp-Source: ABdhPJxMm2Yjz1PLVYDFsrPz3j7SrUUgM32bdxWKBrQDdDkqC5yjxnKCGU81tBt4g/8xpJ7gbj43rQ==
X-Received: by 2002:a2e:87cc:: with SMTP id v12mr2205830ljj.458.1606943643339;
        Wed, 02 Dec 2020 13:14:03 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id z16sm960637ljc.27.2020.12.02.13.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 13:14:02 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH] iio: st-sensors: Convert bindings to YAML
Date:   Wed,  2 Dec 2020 22:13:58 +0100
Message-Id: <20201202211358.1517554-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert this large binding to YAML. It is pretty simple
in it's basic form but the devil is in the details.
Some -if restrictions painstakingly created by reading through
all the datasheets.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/iio/st-sensors.txt    |  82 -------
 .../devicetree/bindings/iio/st-sensors.yaml   | 213 ++++++++++++++++++
 2 files changed, 213 insertions(+), 82 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/st-sensors.txt
 create mode 100644 Documentation/devicetree/bindings/iio/st-sensors.yaml

diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
deleted file mode 100644
index 3213599c5071..000000000000
--- a/Documentation/devicetree/bindings/iio/st-sensors.txt
+++ /dev/null
@@ -1,82 +0,0 @@
-STMicroelectronics MEMS sensors
-
-The STMicroelectronics sensor devices are pretty straight-forward I2C or
-SPI devices, all sharing the same device tree descriptions no matter what
-type of sensor it is.
-
-Required properties:
-- compatible: see the list of valid compatible strings below
-- reg: the I2C or SPI address the device will respond to
-
-Optional properties:
-- vdd-supply: an optional regulator that needs to be on to provide VDD
-  power to the sensor.
-- vddio-supply: an optional regulator that needs to be on to provide the
-  VDD IO power to the sensor.
-- st,drdy-int-pin: the pin on the package that will be used to signal
-  "data ready" (valid values: 1 or 2). This property is not configurable
-  on all sensors.
-- drive-open-drain: the interrupt/data ready line will be configured
-  as open drain, which is useful if several sensors share the same
-  interrupt line. (This binding is taken from pinctrl/pinctrl-bindings.txt)
-  This is a boolean property.
-
-Sensors may also have applicable pin control settings, those use the
-standard bindings from pinctrl/pinctrl-bindings.txt.
-
-Valid compatible strings:
-
-Accelerometers:
-- st,lis3lv02d (deprecated, use st,lis3lv02dl-accel)
-- st,lis302dl-spi (deprecated, use st,lis3lv02dl-accel)
-- st,lis3lv02dl-accel
-- st,lsm303dlh-accel
-- st,lsm303dlhc-accel
-- st,lis3dh-accel
-- st,lsm330d-accel
-- st,lsm330dl-accel
-- st,lsm330dlc-accel
-- st,lis331dl-accel
-- st,lis331dlh-accel
-- st,lsm303dl-accel
-- st,lsm303dlm-accel
-- st,lsm330-accel
-- st,lsm303agr-accel
-- st,lis2dh12-accel
-- st,h3lis331dl-accel
-- st,lng2dm-accel
-- st,lis3l02dq
-- st,lis2dw12
-- st,lis3dhh
-- st,lis3de
-- st,lis2de12
-- st,lis2hh12
-
-Gyroscopes:
-- st,l3g4200d-gyro
-- st,lsm330d-gyro
-- st,lsm330dl-gyro
-- st,lsm330dlc-gyro
-- st,l3gd20-gyro
-- st,l3gd20h-gyro
-- st,l3g4is-gyro
-- st,lsm330-gyro
-- st,lsm9ds0-gyro
-
-Magnetometers:
-- st,lsm303agr-magn
-- st,lsm303dlh-magn
-- st,lsm303dlhc-magn
-- st,lsm303dlm-magn
-- st,lis3mdl-magn
-- st,lis2mdl
-- st,lsm9ds1-magn
-
-Pressure sensors:
-- st,lps001wp-press
-- st,lps25h-press
-- st,lps331ap-press
-- st,lps22hb-press
-- st,lps33hw
-- st,lps35hw
-- st,lps22hh
diff --git a/Documentation/devicetree/bindings/iio/st-sensors.yaml b/Documentation/devicetree/bindings/iio/st-sensors.yaml
new file mode 100644
index 000000000000..6435bbedfd9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/st-sensors.yaml
@@ -0,0 +1,213 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/st-sensors.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics MEMS Sensors
+
+description: The STMicroelectronics sensor devices are pretty straight-forward
+  I2C or SPI devices, all sharing the same device tree descriptions no matter
+  what type of sensor it is.
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+properties:
+  compatible:
+    oneOf:
+      - description: STMicroelectronics Accelerometers
+        enum:
+          - st,h3lis331dl-accel
+          - st,lis2de12
+          - st,lis2dw12
+          - st,lis2hh12
+          - st,lis2dh12-accel
+          - st,lis331dl-accel
+          - st,lis331dlh-accel
+          - st,lis3de
+          - st,lis3dh-accel
+          - st,lis3dhh
+          - st,lis3l02dq
+          - st,lis3lv02dl-accel
+          - st,lng2dm-accel
+          - st,lsm303agr-accel
+          - st,lsm303dl-accel
+          - st,lsm303dlh-accel
+          - st,lsm303dlhc-accel
+          - st,lsm303dlm-accel
+          - st,lsm330-accel
+          - st,lsm330d-accel
+          - st,lsm330dl-accel
+          - st,lsm330dlc-accel
+      - description: STMicroelectronics Gyroscopes
+        enum:
+          - st,l3g4200d-gyro
+          - st,l3g4is-gyro
+          - st,l3gd20-gyro
+          - st,l3gd20h-gyro
+          - st,lsm330-gyro
+          - st,lsm330d-gyro
+          - st,lsm330dl-gyro
+          - st,lsm330dlc-gyro
+          - st,lsm9ds0-gyro
+      - description: STMicroelectronics Magnetometers
+        enum:
+          - st,lis2mdl
+          - st,lis3mdl-magn
+          - st,lsm303agr-magn
+          - st,lsm303dlh-magn
+          - st,lsm303dlhc-magn
+          - st,lsm303dlm-magn
+          - st,lsm9ds1-magn
+      - description: STMicroelectronics Pressure Sensors
+        enum:
+          - st,lps001wp-press
+          - st,lps22hb-press
+          - st,lps22hh
+          - st,lps25h-press
+          - st,lps331ap-press
+          - st,lps33hw
+          - st,lps35hw
+      - description: Deprecated bindings
+        enum:
+          - st,lis302dl-spi
+          - st,lis3lv02d
+        deprecated: true
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: interrupt line(s) connected to the DRDY line(s) and/or the
+      Intertial interrupt lines INT1 and INT2 if these exist. This means up to
+      three interrupts, and the DRDY must be the first one if it exists on
+      the package. The trigger edge of the interrupts is sometimes software
+      configurable in the hardware so the operating system should parse this
+      flag and set up the trigger edge as indicated in the device tree.
+    minItems: 1
+    maxItems: 2
+
+  vdd-supply: true
+  vddio-supply: true
+
+  st,drdy-int-pin:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maxItems: 1
+    description: the pin on the package that will be used to signal
+      "data ready" (valid values 1 or 2). This property is not configurable
+      on all sensors.
+    items:
+      minimum: 1
+      maximum: 2
+
+  drive-open-drain:
+    type: boolean
+    description: the interrupt/data ready line will be configured
+      as open drain, which is useful if several sensors share the same
+      interrupt line. (This binding is taken from pinctrl.)
+
+  mount-matrix:
+    description: an optional 3x3 mounting rotation matrix.
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            # These have no interrupts
+            - st,lps001wp
+    then:
+      properties:
+        interrupts: false
+        st,drdy-int-pin: false
+        drive-open-drain: false
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            # These have only DRDY
+            - st,lis2mdl
+            - st,lis3l02dq
+            - st,lis3lv02dl-accel
+            - st,lps22hb-press
+            - st,lps22hh
+            - st,lps25h-press
+            - st,lps33hw
+            - st,lps35hw
+            - st,lsm303agr-magn
+            - st,lsm303dlh-magn
+            - st,lsm303dlhc-magn
+            - st,lsm303dlm-magn
+    then:
+      properties:
+        interrupts:
+          maxItems: 1
+        st,drdy-int-pin: false
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            # Two intertial interrupts i.e. accelerometer/gyro interrupts
+            - st,h3lis331dl-accel
+            - st,l3g4200d-gyro
+            - st,l3g4is-gyro
+            - st,l3gd20-gyro
+            - st,l3gd20h-gyro
+            - st,lis2de12
+            - st,lis2dw12
+            - st,lis2hh12
+            - st,lis2dh12-accel
+            - st,lis331dl-accel
+            - st,lis331dlh-accel
+            - st,lis3de
+            - st,lis3dh-accel
+            - st,lis3dhh
+            - st,lis3mdl-magn
+            - st,lng2dm-accel
+            - st,lps331ap-press
+            - st,lsm303agr-accel
+            - st,lsm303dlh-accel
+            - st,lsm303dlhc-accel
+            - st,lsm303dlm-accel
+            - st,lsm330-accel
+            - st,lsm330-gyro
+            - st,lsm330d-accel
+            - st,lsm330d-gyro
+            - st,lsm330dl-accel
+            - st,lsm330dl-gyro
+            - st,lsm330dlc-accel
+            - st,lsm330dlc-gyro
+            - st,lsm9ds0-gyro
+            - st,lsm9ds1-magn
+    then:
+      properties:
+        interrupts:
+          maxItems: 2
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
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      accelerometer@1c {
+        compatible = "st,lis331dl-accel";
+        reg = <0x1c>;
+        st,drdy-int-pin = <1>;
+        vdd-supply = <&ldo1>;
+        vddio-supply = <&ldo2>;
+        interrupt-parent = <&gpio>;
+        interrupts = <18 IRQ_TYPE_EDGE_RISING>, <19 IRQ_TYPE_EDGE_RISING>;
+      };
+    };
-- 
2.26.2

