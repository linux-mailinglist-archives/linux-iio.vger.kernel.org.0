Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523F73FE2CD
	for <lists+linux-iio@lfdr.de>; Wed,  1 Sep 2021 21:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245632AbhIATPb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Sep 2021 15:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhIATPa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2021 15:15:30 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAABC061575;
        Wed,  1 Sep 2021 12:14:33 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id a66so639893qkc.1;
        Wed, 01 Sep 2021 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R70u0IPJv7HzqCX3tGojwzYofZ2KzZxw/usGxiNohl4=;
        b=ddVMI8aGc3IUMoAsp3XjetWNN5lrFQZ1pmQOtXskEwgwgIn5DkUzG/g5Sr6i0QGNTE
         SLoo/Evg+oIE7WYdJzR2ZikzIIVlSaZ1wBEEmo5qt483zggaFkXaSzHdLwdVxXh6BwZI
         SnSOBQDd0yqLp0frk1zlnP/NaqFhV7hNrihs1eCypMc+6YMv3GrbBhEowlkl58KeTpWE
         ALYAM0FXGbkrks0EsEvp/CLD5ZF1TAvMkDjWjdzzaMqdFnmVgwzFtE/+U+UMbQt2svkg
         9VsZsUNDxoTmvbj5HNBYV8yRbx9DC006OpBQJgCm71sv42104rMlk4PDP9GDZ8gZWqrX
         upUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R70u0IPJv7HzqCX3tGojwzYofZ2KzZxw/usGxiNohl4=;
        b=kwcoa7/+Qrkr4vFp11K3A6ckJB9FuqKDRMinEhDM+0zidtV3LXCGyXBiUuZY//NZAB
         4C40z2RBrZ8tygajuRfQMY9BSJSMir7ex5q7tfAX5gAxS5BCYfqLX4NTE8WHZK98/xqi
         KvFnAhkVMJIMWfxC/kbzqiKnAmUlqIWPId969RbnBQcQ0Bii/8uUjsF118CAtBQpTO4i
         r/8Lo47pIzi+HWv/zbXULNZ/WvNA3+jD8QjXeETn4B2QcvbfIQ3Vqj9pPKeXNDmFCAzn
         RaYULjHyy0CDsqmU39iOmd1HwMyZ4Pguga9MCcwnU4ayoMsMWHSXnLZXPBSIQTN91T+6
         UEwA==
X-Gm-Message-State: AOAM530tL9OeG3/ivY3BcpTjtpxtve81UjjoQLfyiUjJa9hwD9k7iDnF
        4PCM3uC/tOtKYQJn4wv5O7ePo3C5J6uwOzl3
X-Google-Smtp-Source: ABdhPJxqrCUCIrzxhf5OsRMHQhSZXXK3tLn40/VhOUEJZwbmTNMjqCRuf1jrjnkiVcIxAOG3G5AaUw==
X-Received: by 2002:a05:620a:2297:: with SMTP id o23mr1156738qkh.405.1630523672631;
        Wed, 01 Sep 2021 12:14:32 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01::1002])
        by smtp.gmail.com with ESMTPSA id u189sm316328qkh.14.2021.09.01.12.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 12:14:32 -0700 (PDT)
Date:   Wed, 1 Sep 2021 16:14:28 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        robh+dt@kernel.org, Dragos.Bogdan@analog.com,
        Darius.Berghe@analog.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: iio: accel: Add binding documentation
 for ADXL313
Message-ID: <2eff22d1d22f7e72efdabdc681d02e922682c434.1630523106.git.lucas.p.stankus@gmail.com>
References: <cover.1630523106.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1630523106.git.lucas.p.stankus@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree binding documentation for ADXL313 3-axis accelerometer.

Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/accel/adi,adxl313.yaml       | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
new file mode 100644
index 000000000000..d6afc1b8c272
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/adi,adxl313.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADXL313 3-Axis Digital Accelerometer
+
+maintainers:
+  - Lucas Stankus <lucas.p.stankus@gmail.com>
+
+description: |
+  Analog Devices ADXL313 3-Axis Digital Accelerometer that supports
+  both I2C & SPI interfaces.
+    https://www.analog.com/en/products/adxl313.html
+
+properties:
+  compatible:
+    enum:
+      - adi,adxl313
+
+  reg:
+    maxItems: 1
+
+  spi-3wire: true
+
+  spi-max-frequency: true
+
+  vs-supply:
+    description: Regulator that supplies power to the accelerometer
+
+  vdd-supply:
+    description: Regulator that supplies the digital interface supply voltage
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - INT1
+        - INT2
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* Example for a I2C device node */
+        accelerometer@53 {
+            compatible = "adi,adxl313";
+            reg = <0x53>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "INT1";
+        };
+    };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* Example for a SPI device node */
+        accelerometer@0 {
+            compatible = "adi,adxl313";
+            reg = <0>;
+            spi-max-frequency = <5000000>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "INT1";
+        };
+    };
-- 
2.33.0

