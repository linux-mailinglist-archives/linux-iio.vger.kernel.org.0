Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8271A315E8
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2019 22:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfEaULf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 May 2019 16:11:35 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43579 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfEaULe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 May 2019 16:11:34 -0400
Received: by mail-qt1-f194.google.com with SMTP id z24so2406877qtj.10;
        Fri, 31 May 2019 13:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+nW8Gk7aK/+PpkxvfcOlGRxnTY8kzQWb3W7fjQx3LtQ=;
        b=TZOm1a+982i30pDZqtTkQKkCFlPtQa/kVW/OUB69CbUDuYIncW/Uasa2/v8zVwlfO5
         prurC9PM0vVI/kUu89u7lkKsxcC7Cw1ofUl9WgvNcTpLtFwxwgQ65MwitIBkIhy3j2bk
         q+z5NWmA3vjTrK8cES9qMSqazR2TXhq8uj9TCahOEl2mmkKmE2wUWsz7MgW2ovfk9WHl
         Qo6EG3kewhspqqUBi9t5exkinS5Ev0lZ5XPc+PIrgKdVtDlozMdIFNH2m2UlFTJsqL0p
         nDkfCdzwI+EObGTKDq8UigTrtjBEq4/xYEQY354jnN6M3zUUPZ2mLTMSpAp8eHmEAytA
         8m7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+nW8Gk7aK/+PpkxvfcOlGRxnTY8kzQWb3W7fjQx3LtQ=;
        b=sz4tOLAQuGdwULnTdiZbd7R7zoOpQpxziw1lERt2Q8+qTis2JVw5sL3sJ9tB3ME+MP
         r+YCBumG7SN2WZs7KG6iD8/9j0cuVtaehtzJLhoVEgklh4grHd3nBhZTnEZDs3JRUQ55
         goZBJ/MWrbLp43a9jBtC+Az08dMmbyhytRnqYe9256Av+8xZD8BW9CXSJ3OJWZ0YgyhB
         M0H/YYbvoszgtsL27e6kQoKvkN90zc6YKV2k5X/LRbZUH5/PSK1VCWcJ1yFR8eUeCC96
         0EsvgqL6EMYoCD6nfPWtixzAlhrS+ttEh62pu8kcwFCf0tlcroVppYxfC0aiChf1riAk
         aRag==
X-Gm-Message-State: APjAAAVLzC/JPjqs7SewiwBAP8YqJ6TkwVodest3pMYdChEVqlTuBrR3
        VdO9SSk4M2oZx+aFE0TJlUVKgp/r
X-Google-Smtp-Source: APXvYqwptPVN9l3oK9MueGaAJsNbAZAIE6j2h5N+lfCPlfAwn/XgLl2LrRrvwBWjVsLi6cupwWcVaQ==
X-Received: by 2002:ad4:45a6:: with SMTP id y6mr4786433qvu.72.1559333493791;
        Fri, 31 May 2019 13:11:33 -0700 (PDT)
Received: from wall-e.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id p15sm1915814qkg.59.2019.05.31.13.11.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 13:11:33 -0700 (PDT)
From:   Lucas Oshiro <lucasseikioshiro@gmail.com>
To:     stefan.popa@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rodrigo Ribeiro <rodrigorsdc@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2] dt-bindings: iio: accel: adxl372: switch to YAML bindings
Date:   Fri, 31 May 2019 17:11:14 -0300
Message-Id: <20190531201114.2973-1-lucasseikioshiro@gmail.com>
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
Reviewed-by: Matheus Tavares <matheus.bernardino@usp.br>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
V2:
    - Update MAINTAINERS file
    - Remove description field for reg and interrupts properties
    - Add interrupts as a required property

 .../bindings/iio/accel/adi,adxl372.yaml       | 63 +++++++++++++++++++
 .../devicetree/bindings/iio/accel/adxl372.txt | 33 ----------
 MAINTAINERS                                   |  2 +-
 3 files changed, 64 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
new file mode 100644
index 000000000000..a7fafb9bf5c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
@@ -0,0 +1,63 @@
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
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 43a9cebb2c19..06cca7cd9627 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -559,7 +559,7 @@ S:	Supported
 F:	drivers/iio/accel/adxl372.c
 F:	drivers/iio/accel/adxl372_spi.c
 F:	drivers/iio/accel/adxl372_i2c.c
-F:	Documentation/devicetree/bindings/iio/accel/adxl372.txt
+F:	Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
 
 AF9013 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
-- 
2.21.0

