Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E493E415D
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 10:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhHIIIF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Aug 2021 04:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbhHIIIF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Aug 2021 04:08:05 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9D8C061798;
        Mon,  9 Aug 2021 01:07:44 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso5811932pjb.1;
        Mon, 09 Aug 2021 01:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZnzuTMhe0sJYiExJGf6O2qvTS9kXatqXyWoBI5OGEM8=;
        b=lGSKr4rGp7bwNZT4jQ5W1qJLN0pesMBmKw3tUnvIHtgtTLxOquGqiRhCZ1RE2YZt2r
         VZJuo2jgTY8Kdui9R74KYRJtVO/rS6JD2KcNSMSzOcKPg/43b5oCvGF/SpROfV/SVqj9
         si9PFEjEp5mDzAwFFNTQWRuwHjK2Bh2Px1Q32fXnMojDgiwlbJA1fYi5dAWWpZOq6NM4
         Emy3o9+W23lHj+2NbHFAZ9tnkP/OWLjMlGuUsDE7FuHG/K39Q/SuJTxEm58IHlSVljG5
         tGeI2oG1YugVVPrFCRT3Zak20CRL4INNpbnk87oGpxXhsvJMNNeUPS3RmB15uw56M4Pj
         gskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZnzuTMhe0sJYiExJGf6O2qvTS9kXatqXyWoBI5OGEM8=;
        b=ZlXihXROpwOWD+UwagWdHV1u2G2+Cv0A4T3e5dTyVOUsmA1QvZq1nyF+H3peLGOSEI
         xnhOZ/WQTiwYlgA9wXHCpff+CrDdiVLmxvqMpZwm8avgLEXlPKmN597CuOJbQuRsvzX7
         oU1IVWW0MXW0MJhx46WrdsFzmoArTzbVBPUQugJ3l6wGrLIRalKDTyNxiKhHjdkv9XP5
         Fi2ezo6jaaP6MR9hEmwJPHgIg7XNU/DGNkSpCQMp0v98K6yBXmmu/6bB7hJp2DrdeTo+
         AgFSqt8moNi3THEamStDqIomHMzdIULwaCb6xHfk0UXgxbqPUOyu5LGlRbfCb2CuDogI
         bsXQ==
X-Gm-Message-State: AOAM532GqUZTb480MRvuBzCC75LZt6vthd8uBeyhREYA6QJ/+aAprTwr
        TRkjjd+jsgm5XTwe7weaaew=
X-Google-Smtp-Source: ABdhPJwBdi7Q3aVbx9f2ZiLb+OaC9VP/ByMdWZSzbDyccXC1VEzolBIsuoGNBj5ydDrPmP1XRdKsyg==
X-Received: by 2002:a63:542:: with SMTP id 63mr131009pgf.359.1628496464033;
        Mon, 09 Aug 2021 01:07:44 -0700 (PDT)
Received: from localhost.localdomain ([27.255.251.44])
        by smtp.googlemail.com with ESMTPSA id n23sm20676796pgv.76.2021.08.09.01.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 01:07:43 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [RESEND PATCH v9 1/2] dt-bindings: iio: accel: Add DT binding doc for ADXL355
Date:   Mon,  9 Aug 2021 13:37:28 +0530
Message-Id: <20210809080729.57029-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210809080729.57029-1-puranjay12@gmail.com>
References: <20210809080729.57029-1-puranjay12@gmail.com>
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

