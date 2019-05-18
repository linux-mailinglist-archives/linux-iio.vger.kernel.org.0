Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17FB72254F
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 23:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfERVzy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 17:55:54 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39053 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbfERVzy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 17:55:54 -0400
Received: by mail-qt1-f194.google.com with SMTP id y42so12121111qtk.6;
        Sat, 18 May 2019 14:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F7kGZLgsWFNccN5jm5MJgbPyqpoPp4bIUgv86OI6qys=;
        b=oMMpz9hUX7vJmNX9AE2o21KSXo7niJiVpqmbhL9LG4Mb5BeaP063SbLMRT3gqm2kB7
         vnLdx8kymi9/1KuZxsnObcusD+lDqYXxFRvdW/AFELqa7Mvcx9CMsPzHOZT+0sgEPuHy
         PI4a4pVE+o+WZ8VqTHktsq9lfrb3LBGEklBkA/h+I+Z7WkoCP/whENTGO53FIiKAYiYn
         EoPf4k1ZcVEzGrQX6ohldCkTBpMpnij84eqNNPipken+aZN49pyD08igbt/zPbkSoa/L
         1e8ykPmeca0cq6M3IdZQZCJ2yrDgRL82506jB/us59kiQdaDuLi8fQH8Lz9TMVNE6Nmx
         hH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F7kGZLgsWFNccN5jm5MJgbPyqpoPp4bIUgv86OI6qys=;
        b=IcVVCmPnECyTfMXvltYVkzXfS6TO1kjIyJf5PR5KBO0wNYugc+6OmDcIdqEcccg3/4
         NpxZauZaA3d2eBvYric2krq2GM0gV1Rzx278YMwIw5N0pZ/6+wZQAq050YUWu343iB/F
         PHetzjJvWQKwpgPlQjnVvp0FXhmdJIJM0B1XQUBsW/HBlVO2lpomX581Z61ESPJ3DqfA
         I3o5+fPxE6A+S6Y1bYhRtFXE6lrsqRJZMXkTNm5FZTc3zrYzy85841TbIoa4SaJvXAer
         6Zud5OiyHqrXoR7ZS8Lagz5zdF2iVadphE1XhKq9lq1ttLea1VTKrdItFVe2/M4ihFEv
         IGMA==
X-Gm-Message-State: APjAAAXSa0Jr38xi0dxzYJBypqA0Q5KSLmXcp3QRBUausUbRC+hIO6aD
        qILe5bT7to5iGkzRRZktna0oQF5ncqc=
X-Google-Smtp-Source: APXvYqw3IA1BdawiLxSPcOk5SXMAHPsatl/On2nn+iBayvDG3T48bV+8tmD1hCNUNfiYytYnermx5A==
X-Received: by 2002:ac8:2da8:: with SMTP id p37mr56526209qta.180.1558216553105;
        Sat, 18 May 2019 14:55:53 -0700 (PDT)
Received: from wall-e.ime.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id i7sm6239964qkk.35.2019.05.18.14.55.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 18 May 2019 14:55:52 -0700 (PDT)
From:   Lucas Oshiro <lucasseikioshiro@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stefan Popa <stefan.popa@analog.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Rodrigo Ribeiro <rodrigorsdc@gmail.com>
Subject: [PATCH] dt-bindings: iio: accel: adxl372: switch to YAML bindings
Date:   Sat, 18 May 2019 18:55:42 -0300
Message-Id: <20190518215542.25140-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert the old device tree documentation to yaml format.

Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
Co-developed-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
---

Hello,
We've added Stefan Popa as maintainer of the yaml documentation of this driver
because we found through git that he was the author of the older documentation.

 .../bindings/iio/accel/adi,adxl372.yaml       | 66 +++++++++++++++++++
 .../devicetree/bindings/iio/accel/adxl372.txt | 33 ----------
 2 files changed, 66 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
new file mode 100644
index 000000000000..a6e2893d2ab1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accelerometers/adi,adxl372.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
+
+maintainers:
+  - Stefan Popa <stefan.popa@analog.com>
+
+description: |
+  Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer that supports
+  both I2C & SPI interfaces
+    https://www.analog.com/en/products/adxl372.html
+
+properties:
+  compatible:
+    enum:
+      - adi,adxl372
+
+  reg:
+    description: the I2C address or SPI chip select number for the device
+    maxItems: 1
+
+  interrupts:
+    description:
+      interrupt mapping for IRQ as documented in
+      Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+        #include <dt-bindings/gpio/gpio.h>
+        #include <dt-bindings/interrupt-controller/irq.h>
+        i2c0 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                /* Example for a I2C device node */
+                accelerometer@53 {
+                        compatible = "adi,adxl372";
+                        reg = <0x53>;
+                        interrupt-parent = <&gpio>;
+                        interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+                };
+        };
+  - |
+        #include <dt-bindings/gpio/gpio.h>
+        #include <dt-bindings/interrupt-controller/irq.h>
+        spi0 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                accelerometer@0 {
+                        compatible = "adi,adxl372";
+                        reg = <0>;
+                        spi-max-frequency = <1000000>;
+                        interrupt-parent = <&gpio>;
+                        interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+                };
+        };
diff --git a/Documentation/devicetree/bindings/iio/accel/adxl372.txt b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
deleted file mode 100644
index a289964756a7..000000000000
--- a/Documentation/devicetree/bindings/iio/accel/adxl372.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
-
-http://www.analog.com/media/en/technical-documentation/data-sheets/adxl372.pdf
-
-Required properties:
- - compatible : should be "adi,adxl372"
- - reg: the I2C address or SPI chip select number for the device
-
-Required properties for SPI bus usage:
- - spi-max-frequency: Max SPI frequency to use
-
-Optional properties:
- - interrupts: interrupt mapping for IRQ as documented in
-   Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-
-Example for a I2C device node:
-
-	accelerometer@53 {
-		compatible = "adi,adxl372";
-		reg = <0x53>;
-		interrupt-parent = <&gpio>;
-		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
-	};
-
-Example for a SPI device node:
-
-	accelerometer@0 {
-		compatible = "adi,adxl372";
-		reg = <0>;
-		spi-max-frequency = <1000000>;
-		interrupt-parent = <&gpio>;
-		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
-	};
-- 
2.21.0

