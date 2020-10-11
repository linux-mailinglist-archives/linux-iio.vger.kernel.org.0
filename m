Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DCC28A86B
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 19:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388243AbgJKRKf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 13:10:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387984AbgJKRKf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:10:35 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32EB12222F;
        Sun, 11 Oct 2020 17:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602436234;
        bh=+5Ja9jEOJIU53upi4o7CwBb5NI0WghHNGhYp7Kpyck4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GzqHqpOMxj3UWUhUYaUmA/kUG74fBktX23oDDNPO/KEpOILpcstoy1qbeoQ4mxDNG
         ZB01vG56BW44IKayw06kmqvAL/gujXHaiyiZbQY0T/RWxtr5ZR0RAegcO7eF7Ax5eQ
         eJqDy4jEiCIOKou+GF0EEy70CT/oOzhYfRZr5Fd8=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?= 
        <vianney.leclement@essensium.com>, Crt Mori <cmo@melexis.com>
Subject: [PATCH 24/29] dt-bindings:iio:temperature:melexis,mlx90614 yaml conversion
Date:   Sun, 11 Oct 2020 18:07:44 +0100
Message-Id: <20201011170749.243680-25-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201011170749.243680-1-jic23@kernel.org>
References: <20201011170749.243680-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple conversion from txt to yaml.
I've listed all 3 authors of the driver as maintainers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
Cc: Crt Mori <cmo@melexis.com>
---
 .../iio/temperature/melexis,mlx90614.yaml     | 51 +++++++++++++++++++
 .../bindings/iio/temperature/mlx90614.txt     | 24 ---------
 2 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml
new file mode 100644
index 000000000000..dcda203b2ba5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/melexis,mlx90614.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Melexis MLX90614 contactless IR temperature sensor
+
+maintainers:
+  - Peter Meerwald <pmeerw@pmeerw.net>
+  - Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
+  - Crt Mori <cmo@melexis.com>
+
+description: |
+  http://melexis.com/Infrared-Thermometer-Sensors/Infrared-Thermometer-Sensors/MLX90614-615.aspx
+
+properties:
+  compatible:
+    const: melexis,mlx90614
+
+  reg:
+    maxItems: 1
+
+  wakeup-gpios:
+    description:
+      GPIO connected to the SDA line to hold low in order to wake up the
+      device.  In normal operation, the GPIO is set as input and will
+      not interfere in I2C communication.  There is no need for a GPIO
+      driving the SCL line.  If no GPIO is given, power management is disabled.
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        temp-sensor@5a {
+            compatible = "melexis,mlx90614";
+            reg = <0x5a>;
+            wakeup-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt b/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
deleted file mode 100644
index 9be57b036092..000000000000
--- a/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-* Melexis MLX90614 contactless IR temperature sensor
-
-http://melexis.com/Infrared-Thermometer-Sensors/Infrared-Thermometer-Sensors/MLX90614-615.aspx
-
-Required properties:
-
-  - compatible: should be "melexis,mlx90614"
-  - reg: the I2C address of the sensor
-
-Optional properties:
-
-  - wakeup-gpios: device tree identifier of the GPIO connected to the SDA line
-      to hold low in order to wake up the device.  In normal operation, the
-      GPIO is set as input and will not interfere in I2C communication.  There
-      is no need for a GPIO driving the SCL line.  If no GPIO is given, power
-      management is disabled.
-
-Example:
-
-mlx90614@5a {
-	compatible = "melexis,mlx90614";
-	reg = <0x5a>;
-	wakeup-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
-};
-- 
2.28.0

