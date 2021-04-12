Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DF435C622
	for <lists+linux-iio@lfdr.de>; Mon, 12 Apr 2021 14:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbhDLMXz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Apr 2021 08:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239311AbhDLMXy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Apr 2021 08:23:54 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C17C061574
        for <linux-iio@vger.kernel.org>; Mon, 12 Apr 2021 05:23:35 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id n138so21097073lfa.3
        for <linux-iio@vger.kernel.org>; Mon, 12 Apr 2021 05:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GgNPdquwiiY3H+qGfGL7JXg3yCu/aryRNaErPvGJaSU=;
        b=VVDIY5BZmCz7d7dvRm5jwlinqvoDsO5mLSnyST90QfD4/Og9lgtMoy7t+YO7xRzfUV
         HtGSRGS9nPwKRiiGcK8n9o4UVpD3CEtXWQRkdX4P5cEYZGktywWmuYYL2Nav4j4qPPCX
         aiJ6rxHgNx68hSnhInFJTWBxkKyBdr1kTGck/GOJb3G55TJqyQcmczIRdbw/fMsn2vrk
         25CWUgH2/h1toE/P2Txk/gvcMqoYUZGqfflNxfbLYjBFUedWekHMNgQ055q393W0YtVP
         7/e/AV9Tlks+PjnmWQ9RzC+JeWef+9/1GAd37na2Erk+Jx+QCg+K4DlZlTC+tmr5b1z0
         TvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GgNPdquwiiY3H+qGfGL7JXg3yCu/aryRNaErPvGJaSU=;
        b=ogIZF4iDPeSxuJ+LyjgN59NIXUTGhqie/jxAG2ErHpFpA/jVdyCXtrlrMye7AURSrm
         Z1Xrs6LtEn388kBW2YqBLdzVj6UT9Z3/kfSMukfdf7ifZhzoWprtRl+IwNBYiebsSQSg
         YeEeO+Sw5P93jovJoXz4/Y5xObGH+KolPD4WHXsB8rs03VMjmRSdb7v1hdPWkwkEDJ6G
         Z7oBPIM/LtPO7CbdvSAHP6PR+0hdOm5rLiKpwwwFBhqNNVm7Y+w+wN79UgR2HEBXst3y
         GkJno7rw0zkRGWYCWr146a/zrhnl0lPLYXN/03u4bP/VxD3jGwQqhC4vWgCfvwpgzouH
         s/rA==
X-Gm-Message-State: AOAM530qGYUe+yX7noOH6JNPThxxGhplQUOaweOwRj2IZ7zFFvzZCqXZ
        AQ7loqGcYm5myRRidVLo2tX8kg==
X-Google-Smtp-Source: ABdhPJwm1GgKipGn2TfPp7jsVuKHUaZU3Sf3Utg1oBdYDs2i98ama6BJLtJRYoo5hCnk1cfUat6gGw==
X-Received: by 2002:a05:6512:238d:: with SMTP id c13mr18452988lfv.576.1618230213579;
        Mon, 12 Apr 2021 05:23:33 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id t15sm516664lfb.152.2021.04.12.05.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 05:23:33 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH] iio: st-sensors: Update ST Sensor bindings
Date:   Mon, 12 Apr 2021 14:23:31 +0200
Message-Id: <20210412122331.1631643-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Use enum for the st,drdy-int-pin property.
- Drop GPIO DT include.
- Add an SPI example.
---
 .../bindings/iio/st,st-sensors.yaml           | 261 ++++++++++++------
 1 file changed, 183 insertions(+), 78 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index 7e98f47987dc..497cb97042e0 100644
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
@@ -15,90 +17,178 @@ description: |
 
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
-      - st,iis2mdc
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
+    description: the pin on the package that will be used to signal
+      "data ready" (valid values 1 or 2). This property is not configurable
+      on all sensors.
     $ref: /schemas/types.yaml#/definitions/uint32
-    description:
-      Some sensors have multiple possible pins via which they can provide
-      a data ready interrupt.  This selects which one.
-    enum:
-      - 1
-      - 2
+    enum: [1, 2]
 
   drive-open-drain:
     $ref: /schemas/types.yaml#/definitions/flag
-    description: |
-      The interrupt/data ready line will be configured as open drain, which
-      is useful if several sensors share the same interrupt line.
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
@@ -110,15 +200,30 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
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
+    };
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      num-cs = <1>;
+
+      l3g4200d: gyroscope@0 {
+        compatible = "st,l3g4200d-gyro";
+        st,drdy-int-pin = <2>;
+        reg = <0>;
+        vdd-supply = <&vcc_io>;
+        vddio-supply = <&vcc_io>;
+      };
     };
-...
+
-- 
2.29.2

