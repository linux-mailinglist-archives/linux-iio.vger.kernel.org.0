Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDEA3D77BC
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jul 2021 16:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbhG0OCS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 10:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbhG0OCM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 10:02:12 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F052C061757;
        Tue, 27 Jul 2021 07:02:12 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id k1so15759952plt.12;
        Tue, 27 Jul 2021 07:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h2kTaN2ZN+1aitcGUZWKuCfydNUJBNibgDoSMPYfMtw=;
        b=UZk91Xy/vxrmn3xJ3aCMxhwgGKJnuJSgAgzzzTY5E90yiAdf5bQuL/YAVKTdtmfqc7
         bL68V4QToheFm4O0RLvvi7wHUFJlRgsy4KxvWx6nlUpRba2eBgacZKhEmgDXNWY3G2aC
         FSlUpkR05D1L/8B40cx2hDPiR26EzxhyJxjmEP/CrDW+48MOOmrMMu5CyoofsfhxNiYW
         uQ3quPWoGd1BvOLQtMbqbOG8WTqAC7I1TcIfYJU6zsJDELux9xIOjoJN6CK/gLrhiy+k
         1itb9sCcZTrgpQW+XKZx/VqnuIQ1q0wjlqXHKwaF6imio1tASQ4XMNNjQbxX1qsYpMrh
         6trA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h2kTaN2ZN+1aitcGUZWKuCfydNUJBNibgDoSMPYfMtw=;
        b=KtY1u/VUMaaXnFRPCPpJlkGlQws1Oe4D7u0l8HKJ9PtvdAdoMW3IgA1hbwSVYa2l8B
         1nGBja3vwzCjsSKlimB883jt1MDgSXqmD7SJskQy1P9F1TKAQ4AU8PCYBEFZ+FDhuyuh
         hBuGqZl/ET3h5HclkOQzQIArt4M/lI0VK/KQpZFXPl0wdvRrrPuSofiN9H7QVq7FYPe4
         7tYGJ0weIMtOG640rGwa6oQU3oNPo4WXuuP8m2r2CMSq5Kc7XDRwvpoowGv0GkzHigRp
         S06b4ugpJE5vmgQz4TYRVPggnERvxhtqY/Dx7SwCnAxvsn9lY3UVb5upgYibmuCjXzJW
         sYEQ==
X-Gm-Message-State: AOAM531I2ZpLT2a4jTpxoZIXGBQPj0mrsoVrsg1W8wAhF37K6BXtbOMH
        zHh2tLi1oWixxEleVYL4VA4=
X-Google-Smtp-Source: ABdhPJyhtyANY1UDRMAf0/84KKbrlR2ACM6GM/Ih1WyCHHM7zLqlHV0q/+wyt0MgBjPfuJ6lyqxx8A==
X-Received: by 2002:a17:90a:29a4:: with SMTP id h33mr14071239pjd.98.1627394532002;
        Tue, 27 Jul 2021 07:02:12 -0700 (PDT)
Received: from localhost.localdomain ([49.156.66.102])
        by smtp.googlemail.com with ESMTPSA id o8sm3071563pjm.21.2021.07.27.07.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 07:02:11 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v5 1/2] dt-bindings: iio: accel: Add DT binding doc for ADXL355
Date:   Tue, 27 Jul 2021 19:31:57 +0530
Message-Id: <20210727140158.201188-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210727140158.201188-1-puranjay12@gmail.com>
References: <20210727140158.201188-1-puranjay12@gmail.com>
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

