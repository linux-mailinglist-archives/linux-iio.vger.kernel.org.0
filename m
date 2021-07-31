Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3243DC829
	for <lists+linux-iio@lfdr.de>; Sat, 31 Jul 2021 22:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhGaUgo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Jul 2021 16:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhGaUgn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 31 Jul 2021 16:36:43 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28FBC0613D3;
        Sat, 31 Jul 2021 13:36:35 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j1so20079127pjv.3;
        Sat, 31 Jul 2021 13:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=atnFtE7xX7+Sg8u+FitNPEuZkMeNOMmKG1hNlTlDDEk=;
        b=U04ayExFF0IQzVB4k5QeYTjPEnXKBQzeOimsIs9y97eMt4EpL3wrT6eulWnk3ebruy
         poHHwrqQ5mEfedXh8uy3IpD+3xzP9hYEvzMQ2GX46BArksZ+HIsctbZXJ8RjwAnASxEF
         L5a96lon2H5W+/WvCvJ6/Xl+IanV2sFC3Y/Gk/E1z0KRxGik25XwX1efuuqZzSQmtiFx
         WbQyuTRpnMOxSMH49qLMoFbAhJiMKKcydD1jojD4QDbDgbz6TsoOrso7k0xC91MRj7kY
         RZMSXHf6Py/s2cURZ5CyOilsPEHZeqSaiq/WzLdfbMj79IIl99z4Ncq2YKHUn2m9O6on
         v9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=atnFtE7xX7+Sg8u+FitNPEuZkMeNOMmKG1hNlTlDDEk=;
        b=DLDSISkmy+qZRcCGnTmRaQigL/dHCM5vLdEy+sAcV5cgSQ4lT4ZUUKvoY33Kxs27uW
         bGALmRBhZB2A1RMWlmsQm7W4rHJrblUnMqtyRn8izGSSKyZ0e/S+eamPsfDXAZNyJD9s
         MrSowf5v5ZLox0JxKE9ViVWALaVptZwhQvAc2g+lgnR6LKpJIaqjTMRQhEADiEXDOnrk
         4SzH0q6LqsWqZcxaydzIoNq29s4pyTQIH9XFSSDiXaeIRY0E55jlAcwcB3UbhbS5ojZP
         +8T0WWY7mlsWZnPgyzr3DXllQVCULF1VLCyuLg5obNGskBIZri1tOydsuBVkNOfEG40e
         Lz0g==
X-Gm-Message-State: AOAM533IW0udeaILSPBdvr0I84ObMo6RW4BxR070vxmxFt+UiVltLfN1
        iOI/SQfCcDgIE9P0QtHxnSI=
X-Google-Smtp-Source: ABdhPJxZ6StsDAdlSxCWMYFJHQx8bsiEsCu2TfQYvg7NiAHByDyzQAfm7s2PWmuQmyVKxWgJEWJ9rQ==
X-Received: by 2002:a17:902:c9c3:b029:12c:8f2d:4235 with SMTP id q3-20020a170902c9c3b029012c8f2d4235mr8146668pld.9.1627763795459;
        Sat, 31 Jul 2021 13:36:35 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01::1000])
        by smtp.gmail.com with ESMTPSA id v15sm816094pja.53.2021.07.31.13.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 13:36:35 -0700 (PDT)
Date:   Sat, 31 Jul 2021 17:36:31 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        robh+dt@kernel.org, Dragos.Bogdan@analog.com,
        Darius.Berghe@analog.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: accel: Add binding documentation for
 ADXL313
Message-ID: <1e652b88a367824e58fb71896b4a660204bd7a88.1627709571.git.lucas.p.stankus@gmail.com>
References: <cover.1627709571.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1627709571.git.lucas.p.stankus@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree binding documentation for ADXL313 3-axis accelerometer.

Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
---
 .../bindings/iio/accel/adi,adxl313.yaml       | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
new file mode 100644
index 000000000000..31f11d7eaaae
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
@@ -0,0 +1,75 @@
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
+  spi-cpha: true
+
+  spi-cpol: true
+
+  spi-max-frequency: true
+
+  interrupts:
+    maxItems: 2
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
+            spi-cpol;
+            spi-cpha;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
-- 
2.32.0

