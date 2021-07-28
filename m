Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A129D3D87FF
	for <lists+linux-iio@lfdr.de>; Wed, 28 Jul 2021 08:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbhG1Geq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Jul 2021 02:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbhG1Gep (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Jul 2021 02:34:45 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D7DC061764;
        Tue, 27 Jul 2021 23:34:44 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b6so3632288pji.4;
        Tue, 27 Jul 2021 23:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h2kTaN2ZN+1aitcGUZWKuCfydNUJBNibgDoSMPYfMtw=;
        b=vWmngJW6lp+PS5eH7EyyPyW2jYZsrh3/ZkBfCGYG4amyPonJrznGvesgZdbVpgWsUl
         OI+tq/TCHdGe9qT4J3z2PEMrCkRvXR/p8J7ml4aVEEnMcSEnz6ymUzHs7cC2qvouiZq3
         YWLxpRT+zBejgJIF2s4J9Dw4eox2HYQRoPCcTrlolFUcZ7Aex1GZcN3tpJTNjIIfWVXw
         o7nFVEMYecy6Y4zZ5jIZ/ZH+NwbCjXNSUJjVxG++hcEg1uQSXwPsPhao7Vn2XCGcYPme
         yaJPcU23F5c0GRg20fp5KZN3vWn8EIsxk63IvhvWWio101YMmHLwq78aig4Yixp9QKwl
         kI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h2kTaN2ZN+1aitcGUZWKuCfydNUJBNibgDoSMPYfMtw=;
        b=mqO1WJQZbRxFjKf25dLaeYMT225pnDwgKDHhx26JHbsBnenNkEhj8vTEPG6NOUbXgl
         Uw/9yoWys2yRwCf7AwYd84K+XYTLiGXx9Ak5B4x0y7nqJDCqnb85Rv0ElqIvWra4LGAj
         vVVeXciUPDtt/KGP9kImjIA0uHjO9ww3eNbkmQqmWtF/oAcHkr8OsWCRnIrt7WFM8m8P
         1m7+US+XHcxQWpyLzU9W2BNNCH7fXMuPtL3YRDeEQs+GUk2vRnPUTI5ogZs9I6jd4y8V
         zzH6wzjlFtWnHW05EunGB7fIYsrjMPGWnTNyIDmy9IvOGKlTl3PXonM7Ury0rC4fkwhQ
         VZaA==
X-Gm-Message-State: AOAM533eW5XbXEZNxI52ZMe8KvoY1MT88rputs/th4v+bp6baKIK2b6a
        YU5UT38Yr5oQEUI+xADA+gE=
X-Google-Smtp-Source: ABdhPJxL+NygaWRxR1XSwodWLLiKrxRRJT4HeiGXYrSAGx/zAmDRHWEu4I3qorbWO9yk4VrgUe8acg==
X-Received: by 2002:aa7:8148:0:b029:31b:10b4:f391 with SMTP id d8-20020aa781480000b029031b10b4f391mr26371284pfn.69.1627454084179;
        Tue, 27 Jul 2021 23:34:44 -0700 (PDT)
Received: from localhost.localdomain ([27.255.220.51])
        by smtp.googlemail.com with ESMTPSA id e30sm6698882pga.63.2021.07.27.23.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 23:34:43 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v6 1/2] dt-bindings: iio: accel: Add DT binding doc for ADXL355
Date:   Wed, 28 Jul 2021 12:04:29 +0530
Message-Id: <20210728063430.258199-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210728063430.258199-1-puranjay12@gmail.com>
References: <20210728063430.258199-1-puranjay12@gmail.com>
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

