Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370B42E92A3
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jan 2021 10:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbhADJe2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Jan 2021 04:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbhADJe2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jan 2021 04:34:28 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BDCC061574
        for <linux-iio@vger.kernel.org>; Mon,  4 Jan 2021 01:33:47 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id h22so62874375lfu.2
        for <linux-iio@vger.kernel.org>; Mon, 04 Jan 2021 01:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sp2ZVVsfaRn48/FhBoaoMwI8s72Iim60HIepCXCqUd0=;
        b=EoSoBjXHKV33QXrS65xXQT0RSqjSjwTnNxzldDSo0hu2nRScEvP8o+tQlz0zhorHJU
         raQkPU4N+O8uP/XNRFqx9nIV05dScIhm/xiFGwkB86RNgppiFdLjtmBhbGnOd+xzLs79
         lr5fbjB++iJVRxgldiFtjOm/KmYnpHtCavLYQTVeCj3fq/WvCe2QvGNAiBRTptfTTnkc
         jzt7b00qxYKXU6mkaOXVURVJ8l4oRtTWF6sqdhV9QQczEJas/a1gsroHrih+NzkY8I6J
         nVZY36xpjC3o4kNffXP7sfJvyt3NHE1ZPu7itIZWgM93CNJdbh3SDZqoz25SEnGUq//h
         tJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sp2ZVVsfaRn48/FhBoaoMwI8s72Iim60HIepCXCqUd0=;
        b=cqToj9KvSAoGJJjyGmcmMQxR8VnxgKBpN3ksSr3SS2oypcTO9OoYoOfpH71kk1eMEe
         VFLSNR54o7yI11TCCYXYQ5QeI8m5jNuUgVLB1ycf8ePHeOhwS8kNLzXa3HMDraZWXJ9p
         BCY4hvHUGsmu+Fp2ZbS9aK6vkB2Sw8luD9uiFs5mt1FtNnUTfJXZBgOoe51XxGi78d35
         6NkPEulIxiKfWRWKAU49FZbQrsck6S8KlL3HBKPRtJ5cHu+p2Qzl71BFYKSjYJfKFRvV
         x5xZPYXHN5Q4w6Wc6K1uMvQYW1mmndBUWjkkftphquuTGCLiqvoC97oZX+I0fEEjdMIM
         zhvg==
X-Gm-Message-State: AOAM530CT3JvtAJSO+sU/qsy4z6SyNhdxLKQlOxxUIJlD1uLy/vvRx7J
        R+1QM7mSk9Ou0dzmPCsuAwKBaRXhYZfZZg==
X-Google-Smtp-Source: ABdhPJx0vk3dGfUUqxvExVYAxjJ3DEG6DFIe3wrs3/mJ+TqV79yXsU9+dPQfduEHNfmxHORoSKe16w==
X-Received: by 2002:a05:651c:2101:: with SMTP id a1mr29304029ljq.322.1609752825999;
        Mon, 04 Jan 2021 01:33:45 -0800 (PST)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id o21sm7234066lfc.153.2021.01.04.01.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 01:33:45 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH] iio: st-sensors: Update ST Sensor bindings
Date:   Mon,  4 Jan 2021 10:33:43 +0100
Message-Id: <20210104093343.2134410-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adjusts the ST Sensor bindings with the more fine-grained
syntax checks that were proposed late in the last kernel cycle
and colliding with parallel work.

Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/iio/st,st-sensors.yaml           | 252 ++++++++++++------
 1 file changed, 174 insertions(+), 78 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index db291a9390b7..aba8dc4275a9 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -6,7 +6,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: STMicroelectronics MEMS sensors
 
-description: |
+description: The STMicroelectronics sensor devices are pretty straight-forward
+  I2C or SPI devices, all sharing the same device tree descriptions no matter
+  what type of sensor it is.
   Note that whilst this covers many STMicro MEMs sensors, some more complex
   IMUs need their own bindings.
   The STMicroelectronics sensor devices are pretty straight-forward I2C or
@@ -15,89 +17,181 @@ description: |
 
 maintainers:
   - Denis Ciocca <denis.ciocca@st.com>
+  - Linus Walleij <linus.walleij@linaro.org>
 
 properties:
   compatible:
-    description: |
-      Some values are deprecated.
-      st,lis3lv02d (deprecated, use st,lis3lv02dl-accel)
-      st,lis302dl-spi (deprecated, use st,lis3lv02dl-accel)
-    enum:
-        # Accelerometers
-      - st,lis3lv02d
-      - st,lis302dl-spi
-      - st,lis3lv02dl-accel
-      - st,lsm303dlh-accel
-      - st,lsm303dlhc-accel
-      - st,lis3dh-accel
-      - st,lsm330d-accel
-      - st,lsm330dl-accel
-      - st,lsm330dlc-accel
-      - st,lis331dl-accel
-      - st,lis331dlh-accel
-      - st,lsm303dl-accel
-      - st,lsm303dlm-accel
-      - st,lsm330-accel
-      - st,lsm303agr-accel
-      - st,lis2dh12-accel
-      - st,h3lis331dl-accel
-      - st,lng2dm-accel
-      - st,lis3l02dq
-      - st,lis2dw12
-      - st,lis3dhh
-      - st,lis3de
-      - st,lis2de12
-      - st,lis2hh12
-        # Gyroscopes
-      - st,l3g4200d-gyro
-      - st,lsm330d-gyro
-      - st,lsm330dl-gyro
-      - st,lsm330dlc-gyro
-      - st,l3gd20-gyro
-      - st,l3gd20h-gyro
-      - st,l3g4is-gyro
-      - st,lsm330-gyro
-      - st,lsm9ds0-gyro
-        # Magnetometers
-      - st,lsm303agr-magn
-      - st,lsm303dlh-magn
-      - st,lsm303dlhc-magn
-      - st,lsm303dlm-magn
-      - st,lis3mdl-magn
-      - st,lis2mdl
-      - st,lsm9ds1-magn
-        # Pressure sensors
-      - st,lps001wp-press
-      - st,lps25h-press
-      - st,lps331ap-press
-      - st,lps22hb-press
-      - st,lps33hw
-      - st,lps35hw
-      - st,lps22hh
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
 
   reg:
     maxItems: 1
 
   interrupts:
+    description: interrupt line(s) connected to the DRDY line(s) and/or the
+      Intertial interrupt lines INT1 and INT2 if these exist. This means up to
+      three interrupts, and the DRDY must be the first one if it exists on
+      the package. The trigger edge of the interrupts is sometimes software
+      configurable in the hardware so the operating system should parse this
+      flag and set up the trigger edge as indicated in the device tree.
     minItems: 1
+    maxItems: 2
 
   vdd-supply: true
   vddio-supply: true
 
   st,drdy-int-pin:
     $ref: /schemas/types.yaml#/definitions/uint32
-    description:
-      Some sensors have multiple possible pins via which they can provide
-      a data ready interrupt.  This selects which one.
-    enum:
-      - 1
-      - 2
+    maxItems: 1
+    description: the pin on the package that will be used to signal
+      "data ready" (valid values 1 or 2). This property is not configurable
+      on all sensors.
+    items:
+      minimum: 1
+      maximum: 2
 
   drive-open-drain:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description: |
-      The interrupt/data ready line will be configured as open drain, which
-      is useful if several sensors share the same interrupt line.
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
 
 required:
   - compatible
@@ -108,16 +202,18 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
     i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        accelerometer@1d {
-            compatible = "st,lis3lv02dl-accel";
-            reg = <0x1d>;
-            interrupt-parent = <&gpio2>;
-            interrupts = <18 IRQ_TYPE_EDGE_RISING>;
-            pinctrl-0 = <&lis3lv02dl_nhk_mode>;
-            pinctrl-names = "default";
-        };
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
     };
-...
-- 
2.29.2

