Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0703E89A9
	for <lists+linux-iio@lfdr.de>; Wed, 11 Aug 2021 07:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbhHKFUO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Aug 2021 01:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbhHKFUN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Aug 2021 01:20:13 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976D8C061765;
        Tue, 10 Aug 2021 22:19:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso2795708pjy.5;
        Tue, 10 Aug 2021 22:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZnzuTMhe0sJYiExJGf6O2qvTS9kXatqXyWoBI5OGEM8=;
        b=U/KbECTJgvX4NsoYwXWEQU11r7wvEdO7qD/4BSc1XsJhOgxfreKgrJusaqCaVBx7pd
         45BLlc9FSR2jDiAzWo/fuvHxkJVMXiev+e2istdQyStecWe0OoDX8ES+jZMiWUKGBTlo
         YSMPj7aqW0MZR5Uwkyr/A6zCMTyRJTuG4GxskmllKoLZ7H339zvrooxXn5dlaweJDfBK
         0I86HnVuAmbVuVWbTRgWiTYJtttwqaIy8izUkALNWXI6lZVkLWl2ylnlUdgTmdxenP2V
         +Qgsu3zrGRlk/p+wwlktnQ+ZwLMWITjs2Rxs8PXhIkkU8Xj1mVQ1TEANLrH8JWz7t9uo
         OxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZnzuTMhe0sJYiExJGf6O2qvTS9kXatqXyWoBI5OGEM8=;
        b=ZFlkP9uuiqfz+gZeqkKG6CCgsJxtL/3TLS8txw1P/a93eNPSAJDJHMLeIywelfUddx
         oxrxcq7W+TODC5Z7chbg8I/y+ICphCJAI+JUiDDfaHbjg1PHc9U6+rRyNjj2x/JqFnFB
         05fRnPcxUYPdeJz/5rnr2QrI0CTrjXLWPkNCcRnajvz7nMzX8MziFEen6qL5rEzcURe0
         nffKUtF4v6eQATTe8gOl5vNMvIEUZUXEdFXne9fKgvD7Zog0doA4di4FBaRN724EWj4H
         65pNMIEmjxjWABugfMZtiALZJvtsPwS9YsFbts0c6v/X8xHOBN5zU5YxeHKyFCTc6ICJ
         IC1g==
X-Gm-Message-State: AOAM532k0NdHn5H7ey3yX4ry0CDJpEJpK8ylF/RNw98le6jVL+TxxAt7
        hk6YV/LP2ULpZkZQpM31KmU=
X-Google-Smtp-Source: ABdhPJzVxwuf2QT3qQYgtUc+X3KgRn9Amqte9UnJ9GBp/QKzREmo7GiA3imvQcmCUV5njVrTdLBCPg==
X-Received: by 2002:a65:4107:: with SMTP id w7mr607067pgp.115.1628659190163;
        Tue, 10 Aug 2021 22:19:50 -0700 (PDT)
Received: from localhost.localdomain ([49.156.64.163])
        by smtp.googlemail.com with ESMTPSA id y20sm13055924pfb.54.2021.08.10.22.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 22:19:49 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com,
        andy.shevchenko@gmail.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v11 1/2] dt-bindings: iio: accel: Add DT binding doc for ADXL355
Date:   Wed, 11 Aug 2021 10:49:37 +0530
Message-Id: <20210811051938.111191-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210811051938.111191-1-puranjay12@gmail.com>
References: <20210811051938.111191-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree binding document for ADXL355, a 3-Axis MEMS Accelerometer.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 .../bindings/iio/accel/adi,adxl355.yaml       | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
new file mode 100644
index 000000000..ba54d6998
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/adi,adxl355.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADXL355 3-Axis, Low noise MEMS Accelerometer
+
+maintainers:
+  - Puranjay Mohan <puranjay12@gmail.com>
+
+description: |
+  Analog Devices ADXL355 3-Axis, Low noise MEMS Accelerometer that supports
+  both I2C & SPI interfaces
+    https://www.analog.com/en/products/adxl355.html
+
+properties:
+  compatible:
+    enum:
+      - adi,adxl355
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 3
+    description: |
+      Type for DRDY should be IRQ_TYPE_EDGE_RISING.
+      Three configurable interrupt lines exist.
+
+  interrupt-names:
+    description: Specify which interrupt line is in use.
+    items:
+      enum:
+        - INT1
+        - INT2
+        - DRDY
+    minItems: 1
+    maxItems: 3
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor
+
+  vddio-supply:
+    description: Regulator that provides power to the bus
+
+  spi-max-frequency: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+        #include <dt-bindings/gpio/gpio.h>
+        #include <dt-bindings/interrupt-controller/irq.h>
+        i2c {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                /* Example for a I2C device node */
+                accelerometer@1d {
+                        compatible = "adi,adxl355";
+                        reg = <0x1d>;
+                        interrupt-parent = <&gpio>;
+                        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+                        interrupt-names = "DRDY";
+                };
+        };
+  - |
+        #include <dt-bindings/gpio/gpio.h>
+        #include <dt-bindings/interrupt-controller/irq.h>
+        spi {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                accelerometer@0 {
+                        compatible = "adi,adxl355";
+                        reg = <0>;
+                        spi-max-frequency = <1000000>;
+                        interrupt-parent = <&gpio>;
+                        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+                        interrupt-names = "DRDY";
+                };
+        };
-- 
2.30.1

