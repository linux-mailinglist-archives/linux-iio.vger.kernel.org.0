Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B5245EBBD
	for <lists+linux-iio@lfdr.de>; Fri, 26 Nov 2021 11:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347163AbhKZKjW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Nov 2021 05:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377250AbhKZKhU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Nov 2021 05:37:20 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A436AC061A15;
        Fri, 26 Nov 2021 02:23:09 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x6so36694219edr.5;
        Fri, 26 Nov 2021 02:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dHzdgLlDcS+YP8TdhEA+UJi4RDESh0ZO338QAL0QIKE=;
        b=NxVhdgd0LrCBq7+LIRy2i9UQXzfeirrP0b6rgtZhXPseiJ8MVNS/rqfOBB3EEC0B5Z
         uQfLFENv7kUJxQP61B+uWyIDcj7IQREdGnCWdEBkAGNScHxKha90SyZiOB71zBqQjmnz
         9kbmPzFnI4mwZwL336Zpy+A5IlBlrxS+KRA31gkiEfk2v7D0tgnz/6mhHQ17F2lAivh4
         s980tdDXJTGc5pvtgCM63BC3JuyHTTfzSpQf4YVc5bTwUrMDyigvy9VfAPC7/EKH5QQp
         JbBMGBFpHPT2YP1dZUeS/viCWzHciLiULHy4Ndr4sYlWZ+/AvBhw+G8UqXOnymx5kisg
         pZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dHzdgLlDcS+YP8TdhEA+UJi4RDESh0ZO338QAL0QIKE=;
        b=mOeD4L+5n1ZRdiA0LRGDVVWAVcOPe/JLrcoSZIUiMxz1rOpYFGSCwfTdMYDdz4ivYr
         psaWgp6fudnX+KFHJ3DVq6OS54XgSG8w3KZUIWZTjrGoAvIrtUeT2WeJtn/TOSt4rPHP
         ydA6SPKXvy79XHgWPEio2Q3qkM046ct5NQsBv4bi3QpSen2Lso6vR7dvFVNYv9jjqHRN
         ro+asP+YIkx+mwEnZ9sce8AjMyz/vVZP1oIGfyeJeZmF8KLnPBgookJwQL/QWgKbIP54
         P+wx1uDiJ6LkFKcEjWr5awWyLFtjF7/skTD0jksZQLkBh0rwHOHn4I2tFsx/SCxa4Ptk
         ARlw==
X-Gm-Message-State: AOAM532cZW8bnAXqX2pYykS20lYS0xUuTVg4m2skOvnzK4qVp2XwMwse
        c6sF/a7ZbsVvAcBiEJ6uEuk=
X-Google-Smtp-Source: ABdhPJwusvBELCcovCNxZw/z1wZQx1bXU3wWSSNFTS4DY2vN3CPrYP+EpP6+iZVp2m9mzD3BRY+Lyg==
X-Received: by 2002:aa7:c78f:: with SMTP id n15mr47154541eds.344.1637922188257;
        Fri, 26 Nov 2021 02:23:08 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id w24sm2866019ejk.0.2021.11.26.02.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 02:23:07 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     demonsingur@gmail.com, cosmin.tanislav@analog.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH v5 2/3] dt-bindings: iio: add AD74413R
Date:   Fri, 26 Nov 2021 12:22:45 +0200
Message-Id: <20211126102246.289491-3-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211126102246.289491-1-demonsingur@gmail.com>
References: <20211126102246.289491-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The AD74412R and AD74413R are quad-channel software configurable input/output
solutions for building and process control applications. They contain
functionality for analog output, analog input, digital input, resistance
temperature detector, and thermocouple measurements integrated
into a single chip solution with an SPI interface.
The devices feature a 16-bit ADC and four configurable 13-bit DACs to provide
four configurable input/output channels and a suite of diagnostic functions.
The AD74413R differentiates itself from the AD74412R by being HART-compatible.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 .../bindings/iio/addac/adi,ad74413r.yaml      | 157 ++++++++++++++++++
 include/dt-bindings/iio/addac/adi,ad74413r.h  |  21 +++
 2 files changed, 178 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
 create mode 100644 include/dt-bindings/iio/addac/adi,ad74413r.h

diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
new file mode 100644
index 000000000000..a6d6b5ef13b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
@@ -0,0 +1,157 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/addac/adi,ad74413r.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD74412R/AD74413R device
+
+maintainers:
+  - Cosmin Tanislav <cosmin.tanislav@analog.com>
+
+description: |
+  The AD74412R and AD74413R are quad-channel software configurable input/output
+  solutions for building and process control applications. They contain
+  functionality for analog output, analog input, digital input, resistance
+  temperature detector, and thermocouple measurements integrated
+  into a single chip solution with an SPI interface.
+  The devices feature a 16-bit ADC and four configurable 13-bit DACs to provide
+  four configurable input/output channels and a suite of diagnostic functions.
+  The AD74413R differentiates itself from the AD74412R by being HART-compatible.
+
+properties:
+  compatible:
+    enum:
+      - adi,ad74412r
+      - adi,ad74413r
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  spi-max-frequency:
+    maximum: 1000000
+
+  spi-cpol: true
+
+  interrupts:
+    maxItems: 1
+
+  refin-supply: true
+
+  adi,rsense-resistance-ohms:
+    description:
+      RSense resistance values in Ohms.
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+  - spi-cpol
+  - refin-supply
+  - adi,rsense-resistance-ohms
+
+additionalProperties: false
+
+patternProperties:
+  "^channel@[0-3]$":
+    type: object
+    description: Represents the external channels which are connected to the device.
+
+    properties:
+      reg:
+        description: |
+          The channel number. It can have up to 4 channels numbered from 0 to 3.
+        minimum: 0
+        maximum: 3
+
+      adi,ch-func:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          Channel function.
+          HART functions are not supported on AD74412R.
+          0 - CH_FUNC_HIGH_IMPEDANCE
+          1 - CH_FUNC_VOLTAGE_OUTPUT
+          2 - CH_FUNC_CURRENT_OUTPUT
+          3 - CH_FUNC_VOLTAGE_INPUT
+          4 - CH_FUNC_CURRENT_INPUT_EXT_POWER
+          5 - CH_FUNC_CURRENT_INPUT_LOOP_POWER
+          6 - CH_FUNC_RESISTANCE_INPUT
+          7 - CH_FUNC_DIGITAL_INPUT_LOGIC
+          8 - CH_FUNC_DIGITAL_INPUT_LOOP_POWER
+          9 - CH_FUNC_CURRENT_INPUT_EXT_POWER_HART
+          10 - CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART
+        minimum: 0
+        maximum: 10
+        default: 0
+
+      adi,gpo-comparator:
+        type: boolean
+        description: |
+          Whether to configure GPO as a comparator or not.
+          When not configured as a comparator, the GPO will be treated as an
+          output-only GPIO.
+
+    required:
+      - reg
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/iio/addac/adi,ad74413r.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      cs-gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
+      status = "okay";
+
+      ad74413r@0 {
+        compatible = "adi,ad74413r";
+        reg = <0>;
+        spi-max-frequency = <1000000>;
+        spi-cpol;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        interrupt-parent = <&gpio>;
+        interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+
+        refin-supply = <&ad74413r_refin>;
+        adi,rsense-resistance-ohms = <100>;
+
+        channel@0 {
+          reg = <0>;
+
+          adi,ch-func = <CH_FUNC_VOLTAGE_OUTPUT>;
+        };
+
+        channel@1 {
+          reg = <1>;
+
+          adi,ch-func = <CH_FUNC_CURRENT_OUTPUT>;
+        };
+
+        channel@2 {
+          reg = <2>;
+
+          adi,ch-func = <CH_FUNC_DIGITAL_INPUT_LOGIC>;
+          adi,gpo-comparator;
+        };
+
+        channel@3 {
+          reg = <3>;
+
+          adi,ch-func = <CH_FUNC_CURRENT_INPUT_EXT_POWER>;
+        };
+      };
+    };
+...
diff --git a/include/dt-bindings/iio/addac/adi,ad74413r.h b/include/dt-bindings/iio/addac/adi,ad74413r.h
new file mode 100644
index 000000000000..a43b010f974f
--- /dev/null
+++ b/include/dt-bindings/iio/addac/adi,ad74413r.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _DT_BINDINGS_ADI_AD74413R_H
+#define _DT_BINDINGS_ADI_AD74413R_H
+
+#define CH_FUNC_HIGH_IMPEDANCE					0x0
+#define CH_FUNC_VOLTAGE_OUTPUT					0x1
+#define CH_FUNC_CURRENT_OUTPUT					0x2
+#define CH_FUNC_VOLTAGE_INPUT					0x3
+#define CH_FUNC_CURRENT_INPUT_EXT_POWER			0x4
+#define CH_FUNC_CURRENT_INPUT_LOOP_POWER		0x5
+#define CH_FUNC_RESISTANCE_INPUT				0x6
+#define CH_FUNC_DIGITAL_INPUT_LOGIC				0x7
+#define CH_FUNC_DIGITAL_INPUT_LOOP_POWER		0x8
+#define CH_FUNC_CURRENT_INPUT_EXT_POWER_HART	0x9
+#define CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART	0xA
+
+#define CH_FUNC_MIN		CH_FUNC_HIGH_IMPEDANCE
+#define CH_FUNC_MAX		CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART
+
+#endif /* _DT_BINDINGS_ADI_AD74413R_H */
-- 
2.34.1

