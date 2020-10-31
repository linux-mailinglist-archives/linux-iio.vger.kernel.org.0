Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB7E2A19D8
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgJaSvq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:51:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbgJaSvp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:51:45 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A213D2076D;
        Sat, 31 Oct 2020 18:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170304;
        bh=DstVnFbZayPbgyMcQkevxdRm5qMfbFamaSpzD3oG09U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KVQoUuL34G0doJzs3BXZaVhS6sS//3ZdlmLul+a7s7RVoMl/zFD2AQVcGuSpy4Lzk
         SgAZYA1GShByw8JLVMhpKALP4l3NXGhx/HSIM1RCXuMZc6zPmjpjRiaEe96CzFZWaf
         j7HO7p5EK8V05PoBYBljtleCCK8zkci60CWrWTQU=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH 12/46] dt-bindings:iio:imu:st,lsm6dsx: txt to yaml conversion
Date:   Sat, 31 Oct 2020 18:48:20 +0000
Message-Id: <20201031184854.745828-13-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Straight forward conversion, but there are a few generic properties
in here like wakeup-source which should probably have schema in a
more generic location.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/iio/imu/st,lsm6dsx.yaml          | 86 +++++++++++++++++++
 .../bindings/iio/imu/st_lsm6dsx.txt           | 49 -----------
 2 files changed, 86 insertions(+), 49 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
new file mode 100644
index 000000000000..49d0687e0c06
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/st,lsm6dsx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STM 6-axis (acc + gyro) IMU Mems sensors
+
+maintainers:
+  - Lorenzo Bianconi <lorenzo@kernel.org>
+
+description:
+  Devices have both I2C and SPI interfaces.
+
+properties:
+  compatible:
+    enum:
+      - st,lsm6ds3
+      - st,lsm6ds3h
+      - st,lsm6dsl
+      - st,lsm6dsm
+      - st,ism330dlc
+      - st,lsm6dso
+      - st,asm330lhh
+      - st,lsm6dsox
+      - st,lsm6dsr
+      - st,lsm6ds3tr-c
+      - st,ism330dhcx
+      - st,lsm9ds1-imu
+      - st,lsm6ds0
+      - st,lsm6dsrx
+      - st,lsm6dst
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+    description:
+      Supports up to 2 interrupt lines via the INT1 and INT2 pins.
+
+  spi-max-frequency: true
+
+  st,drdy-int-pin:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: |
+      The pin on the package that will be used to signal data ready
+    enum:
+      - 1
+      - 2
+
+  st,pullups:
+    type: boolean
+    description: enable/disable internal i2c controller pullup resistors.
+
+  drive-open-drain:
+    type: boolean
+    description:
+      The interrupt/data ready line will be configured as open drain, which
+      is useful if several sensors share the same interrupt line.
+
+  wakeup-source:
+    $ref: /schemas/types.yaml#/definitions/flag
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        imu@6b {
+            compatible = "st,lsm6dsm";
+            reg = <0x6b>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_EDGE_RISING>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
deleted file mode 100644
index 7c6742d3e992..000000000000
--- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-* ST_LSM6DSx driver for STM 6-axis (acc + gyro) imu Mems sensors
-
-Required properties:
-- compatible: must be one of:
-  "st,lsm6ds3"
-  "st,lsm6ds3h"
-  "st,lsm6dsl"
-  "st,lsm6dsm"
-  "st,ism330dlc"
-  "st,lsm6dso"
-  "st,asm330lhh"
-  "st,lsm6dsox"
-  "st,lsm6dsr"
-  "st,lsm6ds3tr-c"
-  "st,ism330dhcx"
-  "st,lsm9ds1-imu"
-  "st,lsm6ds0"
-  "st,lsm6dsrx"
-  "st,lsm6dst"
-- reg: i2c address of the sensor / spi cs line
-
-Optional properties:
-- st,drdy-int-pin: the pin on the package that will be used to signal
-  "data ready" (valid values: 1 or 2).
-- st,pullups : enable/disable internal i2c controller pullup resistors.
-- drive-open-drain: the interrupt/data ready line will be configured
-  as open drain, which is useful if several sensors share the same
-  interrupt line. This is a boolean property.
-  (This binding is taken from pinctrl/pinctrl-bindings.txt)
-  If the requested interrupt is configured as IRQ_TYPE_LEVEL_HIGH or
-  IRQ_TYPE_EDGE_RISING a pull-down resistor is needed to drive the line
-  when it is not active, whereas a pull-up one is needed when interrupt
-  line is configured as IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_EDGE_FALLING.
-- interrupts: interrupt mapping for IRQ. It should be configured with
-  flags IRQ_TYPE_LEVEL_HIGH, IRQ_TYPE_EDGE_RISING, IRQ_TYPE_LEVEL_LOW or
-  IRQ_TYPE_EDGE_FALLING.
-- wakeup-source: Enables wake up of host system on event.
-
-  Refer to interrupt-controller/interrupts.txt for generic interrupt
-  client node bindings.
-
-Example:
-
-lsm6dsm@6b {
-	compatible = "st,lsm6dsm";
-	reg = <0x6b>;
-	interrupt-parent = <&gpio0>;
-	interrupts = <0 IRQ_TYPE_EDGE_RISING>;
-};
-- 
2.28.0

