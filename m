Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9993D66EE
	for <lists+linux-iio@lfdr.de>; Mon, 26 Jul 2021 20:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhGZSJF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jul 2021 14:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbhGZSJE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jul 2021 14:09:04 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1FDC0613CF;
        Mon, 26 Jul 2021 11:49:31 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b1-20020a17090a8001b029017700de3903so689699pjn.1;
        Mon, 26 Jul 2021 11:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YrQR5IChKsj7ra02SDjn9It71/okibvkspgJt0isZQs=;
        b=AQZP6sKYDZbAK1/UNh2hnfGNzMjUlbHo7rVXYYrvulFlCXZ0x5bOhjkqco3uW5yQVf
         lcfwHT4h8/Ox8rTrTTreGgBB1ZjmCFno3g13d7Vtba2y8PdwNypQkwg6uW8lQi+uN9yq
         YOuQV0dpmYyCEGPA/CFYmJbuyJdeIMqZvJe4ZwS69PCaxygWkmTBAq23WAl/l1UXWjOG
         8WX3V9m9Kl71PHyjXzpui+nN5onGJTme/AS5mc1JZ4pWj9VKkqaK89eJ9nZx7d1zsvr+
         3YwmSkgju5ooqKwRAFhMFmK9tI+dpdRYQ92T2Qqw6RqGNtTxPpKguBuqHI0FgBLYShjO
         2Xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YrQR5IChKsj7ra02SDjn9It71/okibvkspgJt0isZQs=;
        b=bzZl6tYvh76vikmC2Gs5i0B1PPkXf3hUC/1k51YN1waMJZYw1iIH9qggvJLyOSYQep
         x0WzTldQOPmN0QdPi75709lAyVoehu8guiFgMpnELlR04spvt/6UOS5jzsME2+cPfq3D
         xqmBihnRJf/HbLOP/HEcEPAHmAK2LRCckSRP9jehv2m4eOK7nvvNps0Tx9er/tWPlxPW
         ZWAk+8EVjUwnlyAE8v3i/iFUZRZSsAEff8eHM8axFJS+OQdadlDmLXiuSaIGX/v9oBVl
         AMbRt9eFlu6GdnazJOIPhLv/uatKyYnqYNpMQa00KjSMC9kbxieitBbPileaElyU/Pz+
         R41g==
X-Gm-Message-State: AOAM532yVYnDdgxmmRcgE5EVrHxVzUu98+B21hdUCUXY89RyYBIIQeMi
        nOEwzavZNZAA/G+mrDpbIpv/Ocks1Z5OqQ==
X-Google-Smtp-Source: ABdhPJwq6R/6U+RswZ7h+4KS2NJoROBFxTrUlZZ39NxtrVQi1j40zwlqkAuTCjNwQUxRPq1daCkrUQ==
X-Received: by 2002:a17:90b:3581:: with SMTP id mm1mr382984pjb.98.1627325370783;
        Mon, 26 Jul 2021 11:49:30 -0700 (PDT)
Received: from localhost.localdomain ([125.62.116.66])
        by smtp.googlemail.com with ESMTPSA id o192sm774902pfd.78.2021.07.26.11.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 11:49:30 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: accel: Add DT binding doc for ADXL355
Date:   Tue, 27 Jul 2021 00:19:16 +0530
Message-Id: <20210726184917.301070-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210726184917.301070-1-puranjay12@gmail.com>
References: <20210726184917.301070-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree binding document for ADXL355, a 3-Axis MEMS Accelerometer.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 .../bindings/iio/accel/adi,adxl355.yaml       | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
new file mode 100644
index 000000000..e40899fe8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0
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
+                accelerometer@1D {
+                        compatible = "adi,adxl355";
+                        reg = <0x1D>;
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

