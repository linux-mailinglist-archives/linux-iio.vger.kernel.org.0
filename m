Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5162A1A1F
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgJaSwd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:52:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728506AbgJaSwc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:52:32 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9AD52076D;
        Sat, 31 Oct 2020 18:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170351;
        bh=q+9qFioQStB85n5E27SelRkE1z+NinrYgWML/HvCCJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cToFJa6by7oqPN8jKK2ihTuKLDzx7PVtM3uzgcF+dnJyspjDFpH7c1H+lge6CKwU3
         nMFMKlmXW/KajfonmC6cxcWVuJMv0JoGkmqJ4MfJei2XYcpLGo21BtzIi274m9mRgn
         8LBnE0veLugBTlOO7I6YpEEPHuN23AMw6J7HrNAY=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 44/46] dt-bindings:iio:st,st-sensors: txt to yaml conversion.
Date:   Sat, 31 Oct 2020 18:48:52 +0000
Message-Id: <20201031184854.745828-45-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This binding document covers a very large number of different sensors.
As such the existing documentation is less specific than it could
be (such as which devices have 2 interrupt pin options).
That can be improved later.

Denis, are you happy to be listed as maintainer for this one?
If not feel free to suggestion someone else.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Denis Ciocca <denis.ciocca@st.com>
---
 .../bindings/iio/st,st-sensors.yaml           | 123 ++++++++++++++++++
 .../devicetree/bindings/iio/st-sensors.txt    |  82 ------------
 2 files changed, 123 insertions(+), 82 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
new file mode 100644
index 000000000000..db291a9390b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/st,st-sensors.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics MEMS sensors
+
+description: |
+  Note that whilst this covers many STMicro MEMs sensors, some more complex
+  IMUs need their own bindings.
+  The STMicroelectronics sensor devices are pretty straight-forward I2C or
+  SPI devices, all sharing the same device tree descriptions no matter what
+  type of sensor it is.
+
+maintainers:
+  - Denis Ciocca <denis.ciocca@st.com>
+
+properties:
+  compatible:
+    description: |
+      Some values are deprecated.
+      st,lis3lv02d (deprecated, use st,lis3lv02dl-accel)
+      st,lis302dl-spi (deprecated, use st,lis3lv02dl-accel)
+    enum:
+        # Accelerometers
+      - st,lis3lv02d
+      - st,lis302dl-spi
+      - st,lis3lv02dl-accel
+      - st,lsm303dlh-accel
+      - st,lsm303dlhc-accel
+      - st,lis3dh-accel
+      - st,lsm330d-accel
+      - st,lsm330dl-accel
+      - st,lsm330dlc-accel
+      - st,lis331dl-accel
+      - st,lis331dlh-accel
+      - st,lsm303dl-accel
+      - st,lsm303dlm-accel
+      - st,lsm330-accel
+      - st,lsm303agr-accel
+      - st,lis2dh12-accel
+      - st,h3lis331dl-accel
+      - st,lng2dm-accel
+      - st,lis3l02dq
+      - st,lis2dw12
+      - st,lis3dhh
+      - st,lis3de
+      - st,lis2de12
+      - st,lis2hh12
+        # Gyroscopes
+      - st,l3g4200d-gyro
+      - st,lsm330d-gyro
+      - st,lsm330dl-gyro
+      - st,lsm330dlc-gyro
+      - st,l3gd20-gyro
+      - st,l3gd20h-gyro
+      - st,l3g4is-gyro
+      - st,lsm330-gyro
+      - st,lsm9ds0-gyro
+        # Magnetometers
+      - st,lsm303agr-magn
+      - st,lsm303dlh-magn
+      - st,lsm303dlhc-magn
+      - st,lsm303dlm-magn
+      - st,lis3mdl-magn
+      - st,lis2mdl
+      - st,lsm9ds1-magn
+        # Pressure sensors
+      - st,lps001wp-press
+      - st,lps25h-press
+      - st,lps331ap-press
+      - st,lps22hb-press
+      - st,lps33hw
+      - st,lps35hw
+      - st,lps22hh
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+
+  vdd-supply: true
+  vddio-supply: true
+
+  st,drdy-int-pin:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Some sensors have multiple possible pins via which they can provide
+      a data ready interrupt.  This selects which one.
+    enum:
+      - 1
+      - 2
+
+  drive-open-drain:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      The interrupt/data ready line will be configured as open drain, which
+      is useful if several sensors share the same interrupt line.
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        accelerometer@1d {
+            compatible = "st,lis3lv02dl-accel";
+            reg = <0x1d>;
+            interrupt-parent = <&gpio2>;
+            interrupts = <18 IRQ_TYPE_EDGE_RISING>;
+            pinctrl-0 = <&lis3lv02dl_nhk_mode>;
+            pinctrl-names = "default";
+        };
+    };
+...
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
-- 
2.28.0

