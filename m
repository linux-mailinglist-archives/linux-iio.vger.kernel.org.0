Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954A73E9A4F
	for <lists+linux-iio@lfdr.de>; Wed, 11 Aug 2021 23:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhHKVRg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Aug 2021 17:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhHKVRf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Aug 2021 17:17:35 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6498C061765;
        Wed, 11 Aug 2021 14:17:11 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id bo18so5738888pjb.0;
        Wed, 11 Aug 2021 14:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dq9qle9KNVNet0ZqVGi85G5uOJg25A9ZUVNWOZjwJrs=;
        b=saORioWU+B9brdT8F3uXM9fxhxNo1ZWHSZbTSL9+ZvIlQY2qqzx/rlVsN4O/NLMgHE
         p84rRdcSoD6VuvK06PAB6uvQCf8mInAN+NC5Cea6DetXCxBWmX6B4vReKhjUkW9nP41j
         8e4cHs88WKINEUO0P6G4IVOdgN73hxhrvd4DKC/2sN/wKFsZLD1FOELw5mDS3IZxjXsh
         SWhI9YeSwgueWrORb+gn/KaI7sr1ZL1xK0A+0qmgaGi8pKGF25JvNMvrFH3DBaK+ELas
         m/U4OjJKBquBoPGgNkz+s/2qYrd4EVt6PhNuyok5oanfpkvWjqPRRXzZ630SNYhotQtM
         RbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dq9qle9KNVNet0ZqVGi85G5uOJg25A9ZUVNWOZjwJrs=;
        b=mbuqkjYhmuCc4KB7nfhKbvjioAchKfrR2WEfaONpWUTa/GdQ7gC3ZXur+Eve0JHfyw
         7ehYscd8nrcDixvkZYZ2ARg0tACGvi9kHxRM+pgYF+FRDPjtRBGTw+EfAVXExQRQch9i
         7V7ZDyq/uUTthVJTal7CSiedhR7uDUFAuW/IXa4rvFHGMxG1vIwm1CjygMbsvCdQ58Kw
         TQ/KSZ7tB2AvQ2CebgND7uhtQRmJVv92Se30p+RJTHo8KkiV9shnnqZ+PbfAxq2LhbVB
         B9jE7my2+8GlLLo1yOAVINIuak+LlfB9GOI763qK5cyMHBzoc+v6RBLmIq8POx+DfOQU
         E90g==
X-Gm-Message-State: AOAM531009DZDfgnLVFoKzyJcvLFFYp0RYjCabGb395KTKBjBBguvmBV
        ukd9PN7IzSzA4XI9lgw5i5bUK6PNTTEnuEq5
X-Google-Smtp-Source: ABdhPJyFHff68pshnDXZmfi+XyMsYxR9toYzeoANQrP/ldh+KsR0Xk+Rmk5fuWUTZ3AayccnWVKwKQ==
X-Received: by 2002:a17:902:a604:b029:12c:dda2:30c4 with SMTP id u4-20020a170902a604b029012cdda230c4mr727906plq.73.1628716631538;
        Wed, 11 Aug 2021 14:17:11 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01::1001])
        by smtp.gmail.com with ESMTPSA id l15sm394504pjq.13.2021.08.11.14.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 14:17:11 -0700 (PDT)
Date:   Wed, 11 Aug 2021 18:17:07 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        robh+dt@kernel.org, Dragos.Bogdan@analog.com,
        Darius.Berghe@analog.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: iio: accel: Add binding documentation
 for ADXL313
Message-ID: <1b468b9d4b22f2715ff7e8de868614e533cf1f2a.1628713039.git.lucas.p.stankus@gmail.com>
References: <cover.1628713039.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1628713039.git.lucas.p.stankus@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree binding documentation for ADXL313 3-axis accelerometer.

Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
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
2.32.0

