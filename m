Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAECC3D6DE7
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jul 2021 07:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbhG0FQv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 01:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbhG0FQt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 01:16:49 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFA0C061757;
        Mon, 26 Jul 2021 22:16:49 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d17so14409482plh.10;
        Mon, 26 Jul 2021 22:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h2kTaN2ZN+1aitcGUZWKuCfydNUJBNibgDoSMPYfMtw=;
        b=DL+7n5wZM9cNmgmgeb21atb7oVE9bdhQIgqUwIX4nqeJuug1wBbE3wCgMEg5tym6l5
         SXHEAKyqrFAnAyRwEBtHSV99cqK/KVoJFP5izK77spQCYDXGox+28JJPDPrnAjKMFg3f
         Q8tK+/mCAH/ooJUNAwOXYITRvG/EsYWOLkG8vPlUrAh6FOtAjer9igkeyR+BOtSpH49k
         9CrrzzLs4T9IAMwedYjWalCkSTx28pc+xSHUcIMB5I3lWKLKikaAppnkpvGYW5Hmpo2P
         5YfVYkaOOr+wN7CY2FkE4vUB+1tqOKxeUcDBF88qVLu2/mIfG35c2SISm/Rt9SUgrKPW
         bgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h2kTaN2ZN+1aitcGUZWKuCfydNUJBNibgDoSMPYfMtw=;
        b=SdkwiMjpTsh+FDw94Aavwy/3uom6WHSj/FS7iBeLUtazHC0CnmoyDiokRp8bdZLnYc
         H+DN7QAVd89BRKJDRF6POoVLT8d37D9e/066/nND3ct4Y0LAPQ/2T9CbcAkJzV6TmGhh
         DfuI9yVOLo3FBa4W7Mwz6X7cvrZdU2MusWtnvv3kyXQhSP0lqo7vhxIOCd8TI3sDyGQq
         uC/mPx26ZW2iJUvFDD29Tfygm5C4alDFmOQITRu976ulNHY9bv9Dwz2hp8iFNMgLNMSc
         tNLQov3rF/NqwFB5HnR9ITnx+e6GO3WSu37N07NYn1nENgKt+soxOdu90hJHbyYoUlVL
         BEfw==
X-Gm-Message-State: AOAM532d1y6TXovaP0yMy9KlYA28F23jmxTT+8Xblm1aogojgtc16ZWG
        8yGjQ/tnE9ZDCXaidpBkdvU=
X-Google-Smtp-Source: ABdhPJxnsAwx2FXBqY4orcApj3VO1Xjf+6Zw8O5WMDjJX6yVooENlf9cQWHpH/9Nx/FL2KAz2tjoxg==
X-Received: by 2002:a17:902:b093:b029:12c:843:b55a with SMTP id p19-20020a170902b093b029012c0843b55amr10578536plr.83.1627363008617;
        Mon, 26 Jul 2021 22:16:48 -0700 (PDT)
Received: from localhost.localdomain ([49.156.121.207])
        by smtp.googlemail.com with ESMTPSA id k198sm1870787pfd.148.2021.07.26.22.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 22:16:48 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: iio: accel: Add DT binding doc for ADXL355
Date:   Tue, 27 Jul 2021 10:46:26 +0530
Message-Id: <20210727051627.12234-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210727051627.12234-1-puranjay12@gmail.com>
References: <20210727051627.12234-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree binding document for ADXL355, a 3-Axis MEMS Accelerometer.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 .../bindings/iio/accel/adi,adxl355.yaml       | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
new file mode 100644
index 000000000..6e0652ce8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
@@ -0,0 +1,76 @@
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
+    items:
+      - description: DRDY PIN
+      - description: INT1 PIN
+      - description: INT2 PIN
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
+        i2c0 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                /* Example for a I2C device node */
+                accelerometer@1d {
+                        compatible = "adi,adxl355";
+                        reg = <0x1d>;
+                        interrupt-parent = <&gpio>;
+                        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
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
+                        compatible = "adi,adxl355";
+                        reg = <0>;
+                        spi-max-frequency = <1000000>;
+                        interrupt-parent = <&gpio>;
+                        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+                };
+        };
-- 
2.30.1

