Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F183E832A
	for <lists+linux-iio@lfdr.de>; Tue, 10 Aug 2021 20:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhHJSqP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Aug 2021 14:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhHJSqN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Aug 2021 14:46:13 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31174C0613C1;
        Tue, 10 Aug 2021 11:45:50 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so470292pjb.3;
        Tue, 10 Aug 2021 11:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZnzuTMhe0sJYiExJGf6O2qvTS9kXatqXyWoBI5OGEM8=;
        b=cFAuqAcPvh5sFtFAzT1LCarX+GHIYlKojYHNAxZtSRPOn4SsTLrAb2DbcrfO9RJINJ
         v+lEJdHH8gFyJ6KiH2mEPNkEbY4Of8AP8beT1FXk0OvKHMRu1OE0NH2cASxA/aSqvCfZ
         takt4v3/LSPTisyU89tPoVNuLt/CEnScaADq/NDzmTIxVHohL5hwLrn/O+PR4PJj0zgJ
         /xMlHHRVpv6mrW6juLGIm74B25t1gWChJ5HDSv8Q2VvqRMWLX/WgXIL1xnB7Aq0uSoKp
         roDAKQATY9CWfi3O6cConBOlGsp2WuFMMQNus7F1+r0NuTmskUU7bmT/SK/oJNNN417L
         ZWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZnzuTMhe0sJYiExJGf6O2qvTS9kXatqXyWoBI5OGEM8=;
        b=b7NxHvBJAhduC3SSoITiXEK/l9QFVO6iBwvtIDZW4DQ0mr6z2MWJQBO5CemtEzcasN
         PbUhZq2ySeL/DNxeAwxcD/NpSE1CCGfzvRvHyTxA+rpiv1GfRcuTgpDu49/UONx5PAxt
         1xS5U3mgoVESkEJNFLfd6bRSEehUECrNx1dhb1DfTY0oHXff6t3tjBfn2BHScoYS9EYL
         XfW/+b91h1rnVEScQH8iAXHZcyCfXW3ldSukTH3TOWuSepVo9DUHFjhM5xZUsf1Pf3IJ
         yw3HG+I7WyPYZ1Dz1PEFI9Cm4OvwBB5GY1lGmrxUIdM/82VXYtv6M+2+mrbwHVLi9IDw
         mpMg==
X-Gm-Message-State: AOAM533CizOg87+9z4KhBhyiXHl6iXTPVd8pabY9psSjgWqv5sZNJzjU
        jQMR8dM0D48iMV/19fMsC0U=
X-Google-Smtp-Source: ABdhPJxQQOI6ne7COakA+ksCPAP6W+6AKy8A8yyziWkRqGf2Qq9di0sEOSxbnOgUTA1sScvrFK4vjw==
X-Received: by 2002:a17:902:b607:b029:12c:fd88:530b with SMTP id b7-20020a170902b607b029012cfd88530bmr879743pls.33.1628621149657;
        Tue, 10 Aug 2021 11:45:49 -0700 (PDT)
Received: from localhost.localdomain ([125.62.119.16])
        by smtp.googlemail.com with ESMTPSA id f4sm29933733pgi.68.2021.08.10.11.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 11:45:49 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com,
        andy.shevchenko@gmail.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v10 1/2] dt-bindings: iio: accel: Add DT binding doc for ADXL355
Date:   Wed, 11 Aug 2021 00:15:35 +0530
Message-Id: <20210810184536.34443-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210810184536.34443-1-puranjay12@gmail.com>
References: <20210810184536.34443-1-puranjay12@gmail.com>
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

