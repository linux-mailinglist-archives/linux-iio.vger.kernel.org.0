Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3304B3E0E5B
	for <lists+linux-iio@lfdr.de>; Thu,  5 Aug 2021 08:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbhHEG36 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Aug 2021 02:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbhHEG35 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Aug 2021 02:29:57 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76325C061765;
        Wed,  4 Aug 2021 23:29:42 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id z3so5851033plg.8;
        Wed, 04 Aug 2021 23:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ovh+9av3YLloiIYSjbQzMTolkIbHdJEPW3itsRmaCB8=;
        b=YwdBsL/6rMMivGQ8J03xpHbzaDZ2ZS2+gR2p3oGC7cALn/txOaCTFRCBWAdelYrIX6
         NvsZgMaxHgBvRwCVXT6XtQJB7pFLP4kbyT4uInCyWFm3muBxomyneWm1Wlk3ycQR3hEk
         HwDawfSzMxNMeaOwd2TWdVcq/WVSQMTbIXdl4a8ZUZRG/77N+HXJSW3rkYIUdntaetmm
         O3TO6lQriccj1y7kPN8wZ70pYfVXxHEvLOHElcafaYTobJahGrY9msgy7IU46SZ9DXIM
         COE19Jj/9g+43RSssLccMIwivczsB6R381hDdZOEZe5HDtFCI5iIcNzPQW9e7bC131Kv
         CuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ovh+9av3YLloiIYSjbQzMTolkIbHdJEPW3itsRmaCB8=;
        b=Q65f2rhcIOG26OHKaTOeDpsi809t8XjudNz/0BgY4ZZDKwJonYU+ESknaXiegpN5v8
         k8cZgzKAXCK58a+Snc/GwMd/YzbvkeAwJL3oNCmxXvs2YVB6x3S+1lGANoKvQ8wEbiNP
         XxrU9+w+12Y54IqiVLq6Bvb9Ydb2JShJnehVq6+lIBm5tfu+Wy3njAMV0/iSJOEH9hKW
         qKJsWikCZyJLlFfm5Y+xy2T/y8h7CHNn6HXd9EvRvzg3IhDqwqcQ/OQZ2JC/ANBAgmzo
         cg5OLywmE/ezPs2SLwH1shrJc3MAQuedC1yuk9QrUAuIDkEFsEpIiyvREF2N0BIuacLs
         M34A==
X-Gm-Message-State: AOAM533YZPKjT9DFvK1qrrCEjBO8JC03KcmJZ6EAeNyX5sYS/Bl6L48S
        GF4xT4FuZZ1IT3jueZ3nswg=
X-Google-Smtp-Source: ABdhPJyxPJI2/YtZlvE1qDEduj8P/Z+q4yAkPjfxaW0D//7Wh0Khc/XBw9VBcpN82knKMNKxpme9rQ==
X-Received: by 2002:a63:4423:: with SMTP id r35mr189525pga.358.1628144982090;
        Wed, 04 Aug 2021 23:29:42 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01::1005])
        by smtp.gmail.com with ESMTPSA id s22sm4979767pfu.52.2021.08.04.23.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 23:29:41 -0700 (PDT)
Date:   Thu, 5 Aug 2021 03:29:37 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        robh+dt@kernel.org, Dragos.Bogdan@analog.com,
        Darius.Berghe@analog.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: accel: Add binding documentation
 for ADXL313
Message-ID: <ad64c93df8c43c66dcb64fe8ec0c0f6b91b3c697.1628143857.git.lucas.p.stankus@gmail.com>
References: <cover.1628143857.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1628143857.git.lucas.p.stankus@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree binding documentation for ADXL313 3-axis accelerometer.

Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
---
 .../bindings/iio/accel/adi,adxl313.yaml       | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
new file mode 100644
index 000000000000..fea03b6790f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
@@ -0,0 +1,90 @@
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
+  vs-supply:
+    description: Regulator that supplies power to the accelerometer
+
+  vdd-supply:
+    description: Regulator that supplies the digital interface supply voltage
+
+  interrupts:
+    maxItems: 2
+
+  interrupt-names:
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
+            spi-cpol;
+            spi-cpha;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "INT1";
+        };
+    };
-- 
2.32.0

