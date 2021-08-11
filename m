Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAEA3E8B10
	for <lists+linux-iio@lfdr.de>; Wed, 11 Aug 2021 09:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbhHKHbJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Aug 2021 03:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbhHKHbE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Aug 2021 03:31:04 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E30FC061765;
        Wed, 11 Aug 2021 00:30:40 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so4217993pje.0;
        Wed, 11 Aug 2021 00:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZnzuTMhe0sJYiExJGf6O2qvTS9kXatqXyWoBI5OGEM8=;
        b=jCYyRVH631J28Vwx03B9jug82/wNb02i0tB5EesCdKoP0G+h91SPUaNN5psmH6OTiY
         QEHSE7f9zsLr5Cxjzi+pBO1ikhDnsCmD76KISO5GahEn351tNQoEnguoVbEjGgj9HQwP
         9B6OrEzO0Gf/8/l+8bNBEaYBxatW640OkeA14kBGZ80HKBlOWb0jZZzH6g+WEhyUbyiu
         +3UfGWIj+eGWedxUF3kJ8vM34KQ1FDhOTKcqnav4P5i4YdGZYWxUNiIpHhpOVEd5aGCV
         o0tjy3W/xWzol5mgE4wl4DnQca8dy9AuD0eOZkaotzVQuUYLGScHxgGUjfkGBP1L3idp
         9zRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZnzuTMhe0sJYiExJGf6O2qvTS9kXatqXyWoBI5OGEM8=;
        b=XqHjE6Cx7vnaOQIaKs/Xb58WqGNE0+AKaY7DgscQLQ+dVvlSyv0VSfZkHZYDdWg0MX
         h+yg2EJHPQN8PY6R8iDdX2WWKR9wXG1pdYYtfAX7YBVbr2iEMW3La1JtWMxTEHYTaqZd
         MMKBncllOnTYQlGa/zXmso+DevajoexvkaWI7hkIZrQ22q78WP2gOxmftRULr3gfiZeb
         X8afuoIevlvu0Q7qu13DDX/R9A+Cg/ec8OzL/q7dsEyK7gfmH4+P6TXuArIoccuFeAvO
         asJXgYdgY6343GfrCrC7MxYwWsFjjR5YKvD5TFrEiyps4cHmPVCZPHZAUimglfO5VXjz
         m9bQ==
X-Gm-Message-State: AOAM533/KkSz3Mg1spcCwGdHW+MyIIX6tw977zbOx6j9073l3UHtmk7/
        tNwPgg+WFRbFmgxay1LPZaQ=
X-Google-Smtp-Source: ABdhPJwjCBaOXsZhVzT1a6G30ro+CYlsfiWxzRl8QrSnywR/9hfuFh899hMTJZ5ashPRusmDTLVfwQ==
X-Received: by 2002:a17:902:e80a:b029:12c:58eb:1c8f with SMTP id u10-20020a170902e80ab029012c58eb1c8fmr571107plg.59.1628667039984;
        Wed, 11 Aug 2021 00:30:39 -0700 (PDT)
Received: from localhost.localdomain ([124.253.244.73])
        by smtp.googlemail.com with ESMTPSA id c21sm26042284pfo.193.2021.08.11.00.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 00:30:39 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com,
        andy.shevchenko@gmail.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v12 1/2] dt-bindings: iio: accel: Add DT binding doc for ADXL355
Date:   Wed, 11 Aug 2021 13:00:26 +0530
Message-Id: <20210811073027.124619-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210811073027.124619-1-puranjay12@gmail.com>
References: <20210811073027.124619-1-puranjay12@gmail.com>
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

