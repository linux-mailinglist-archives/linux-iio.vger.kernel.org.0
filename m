Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2C13DC8C0
	for <lists+linux-iio@lfdr.de>; Sun,  1 Aug 2021 00:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhGaWvI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Jul 2021 18:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbhGaWvH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 31 Jul 2021 18:51:07 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D28C0613D5;
        Sat, 31 Jul 2021 15:50:59 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id i10so15395060pla.3;
        Sat, 31 Jul 2021 15:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kkYno5k2Oj/w12pA+PO0ZF1OUj36pZFeWyQiTXky8BE=;
        b=RL+Z723nZCa1YekHfCYJiUZl081k8XF4+b8I7hYev1FjXtDmeJIQg/l21lA5yawzLr
         c/oYmL60crTe5HTDBuOOOFALjqfPmnJvByI26pHAUhmRuAvJ+tF5lkt/n2qHMAKIUYOp
         gIoiGeLigow2E6z4EdROsZCLXstXPvqdMLVz2dcNaKzXUeLkByRR9ygAsR7DNAYDcsdK
         dMWiBnjSkjDU9ONb70dtXYjcby3jFyXZr+q4MtCpP42rriVJkqGjDhYkTApt6k16pTrM
         biIv0pzmBMQD1xg63BbYrwetSJSEhwnnSzlmRSLIHEbvvDI/g0XLYsprctmgc3I5IwCQ
         8y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kkYno5k2Oj/w12pA+PO0ZF1OUj36pZFeWyQiTXky8BE=;
        b=MUznU5BjZTKX/UDRnjZ0QGz6S0b+i510F/BuuZZJtyt1K4qgOHKKYTD0q4sKYtIzb9
         FStB/b51zIzVQlxAezsaXB95SMI4KpfNb7T9lOuob3fPfY32DbkIyalIuO83beCGyyjF
         sSdN8lz7PsLTFwSXj3zwI6FPCVHiCf4oKT8HXUWWANWP7GIlTR4ENsvz6/E6/eJwknwA
         FZmFYOLM9MBoMkBKxI5LH12MIG7AvsqQyeBWbP0Oh08eojyGxEhpMLoQ3GKcNUYniGZc
         Ur70jfN8mhS61JbtH7tkHBu1lb5VGvY0SWciGCdgL+Au3SrOn11+q4uidWhfsn0bYtZp
         ZGCg==
X-Gm-Message-State: AOAM533Jf3psxKZJZxC4WVN3/G1+cSoTdGDkN0CGSEHw8HK0a5B1u4m0
        ysrxkklOtzfkTTNgm79BbEc=
X-Google-Smtp-Source: ABdhPJxbYvioZaHUsfEMPIQphMzWoS59wHNaCVUC7Uki14za22illxT+0Frn+dhpzwkyGVrnEsd3wQ==
X-Received: by 2002:a17:90a:9411:: with SMTP id r17mr9965132pjo.49.1627771859400;
        Sat, 31 Jul 2021 15:50:59 -0700 (PDT)
Received: from localhost.localdomain ([125.62.118.205])
        by smtp.googlemail.com with ESMTPSA id 20sm6980578pfi.170.2021.07.31.15.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 15:50:58 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v7 1/3] dt-bindings: iio: accel: Add DT binding doc for ADXL355
Date:   Sun,  1 Aug 2021 04:20:43 +0530
Message-Id: <20210731225045.399445-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210731225045.399445-1-puranjay12@gmail.com>
References: <20210731225045.399445-1-puranjay12@gmail.com>
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
index 000000000..5da3fd5ad
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
+      Type should be IRQ_TYPE_LEVEL_HIGH.
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

