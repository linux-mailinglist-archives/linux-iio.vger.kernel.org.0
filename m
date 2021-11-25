Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7AA45DAF2
	for <lists+linux-iio@lfdr.de>; Thu, 25 Nov 2021 14:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355395AbhKYNX4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Nov 2021 08:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354971AbhKYNVx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Nov 2021 08:21:53 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE36C061756;
        Thu, 25 Nov 2021 05:15:31 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id r25so25469681edq.7;
        Thu, 25 Nov 2021 05:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bTt7BTjOIC063HM6Q83mLDu728K9KdGbEgkcO7gQ3SA=;
        b=Mben5wGzqOwnwpVrhTbeUCfnqm+MxMj93LC21+vYvMoyowzBgaFFlvuhF6GHp6XYl9
         AHrxYTWpFnvgaq+7HW6hA69tmDe+fDyMNtIouvANoFLrxwK3BWxEnyEbW0BvCboKnB4Q
         pO7JVqbViKqCJyx3RAMfUY0GMpbelQ0Th/d7Yg4z5ZuNfNbs71i+XkdPEXBW4OLX62ly
         fBnHr39RELegXaYOK3zmL1edljD5ldkoj0QZ5bB3Tnqgm/UDnWwfiyRdnFHl0qhZYyjf
         aBFSTLnICuLh8pU3L+bz8i9jrYQH6GL5yffbtwkMkiaPhLRB1FvBZHaQcraTgBluoZHW
         qI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bTt7BTjOIC063HM6Q83mLDu728K9KdGbEgkcO7gQ3SA=;
        b=mP7q76aWziMdwF/IUuYOL+3c4knyzEHg6CinnWQPzV9bmBUyDQ6KRoC1waMaDk5FoW
         XtuPv0ja+JuH9GHa4+ZnCYwD0MOiXnQwFQMB++N3GMNcjKrk0ilMyD2TrTQZQ7dmpH7v
         xp0AiF5bIPfZ11I/n1BAjhVRNDaZ7Hhhfk3HWM2kxnXs92eWa/pYJpq/peDbfthr4z01
         pIkPD5gUPRq25gqMcGm/bWOVF04RFUlF0bxM/+L5cqGyOqUTHBil9NuHvBDkpRQ15ekD
         RRDjHl7O2Wa6celiOpWQdhGfvA0Oo9XdgnAAZwdbuGwiuBeigN+wuYiPbPI8MqxDerPZ
         cQWQ==
X-Gm-Message-State: AOAM530imdT+JEZrvlFNWiFX8xK5CE9XPuJKws5fgCUOzZ0bxTz1E+jK
        jVqTCIlwRj//RamN7DU074I=
X-Google-Smtp-Source: ABdhPJwuHopoSpRDONR2pKbkCajRHiCfeLfz2n08MZ9ZRDDy+zljf52iO16QEmopySfQZrRhIom3XQ==
X-Received: by 2002:a17:906:d96e:: with SMTP id rp14mr30663322ejb.104.1637846129948;
        Thu, 25 Nov 2021 05:15:29 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id g9sm2187770edb.52.2021.11.25.05.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 05:15:29 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     demonsingur@gmail.com, cosmin.tanislav@analog.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH v4 2/3] dt-bindings: iio: add AD74413R
Date:   Thu, 25 Nov 2021 15:14:21 +0200
Message-Id: <20211125131422.50657-3-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211125131422.50657-1-demonsingur@gmail.com>
References: <20211125131422.50657-1-demonsingur@gmail.com>
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
 .../bindings/iio/addac/adi,ad74413r.yaml      | 153 ++++++++++++++++++
 include/dt-bindings/iio/addac/adi,ad74413r.h  |  21 +++
 2 files changed, 174 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
 create mode 100644 include/dt-bindings/iio/addac/adi,ad74413r.h

diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
new file mode 100644
index 000000000000..d0134dd64b17
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
@@ -0,0 +1,153 @@
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
+  - adi,rsense-resistance-ohm
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
+    spi0 {
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
+        interrupts = <26 0>;
+
+        refin-supply = <&ad74413r_refin>;
+        adi,rsense-resistance-ohm = <100>;
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

