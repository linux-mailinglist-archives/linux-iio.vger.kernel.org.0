Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C119343E2D2
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 15:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhJ1N7d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 09:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhJ1N70 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 09:59:26 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A007AC061767;
        Thu, 28 Oct 2021 06:56:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z20so25506158edc.13;
        Thu, 28 Oct 2021 06:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Io+fzT/3ns2XqoDsP4IFv/GKd+WL+h+b3kvGosuxSzI=;
        b=UEVjuB3YX1yRMG8eTSNfZzEENNJ0pZFwTfoC4HtK+j/1mdigp3QCWFjP7bd9bg7DBW
         I+IbaYHzP8jv57cP+ZOOazp80D8EE//dYXImHQGkdR6aasE9O6+RrZnMGOTV7Ofl8Hoo
         Ih3bQiHIcB/wJOxeGpSjgcteSQ1E8rRInrR+++XQSug4nzivAw5BhdU+nW9+rXpNK6jP
         OEOKveowMtU+C4DweFhka3GBmgy9NmKLp1/xvNUosGVgLmX+9UJiKL2oaXiye2wRVUu1
         DATFJYMMCYps++J/qFWQvn54MIpEuanYu/jTT1WK1DQ5ORL4tK4cgY3qodkagPBrOe0w
         8kSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Io+fzT/3ns2XqoDsP4IFv/GKd+WL+h+b3kvGosuxSzI=;
        b=cR92pzq84KJUipxRf43B447WbmmRDMzxmVTWevisI9rg2KN9dFnVJJucH6a32/bZt+
         W/Lku4geeJ4GbqJZx73MMDB3jWBjnvLAO+Emq718LU5bWjJxxVHPeaBj8XXxqiThaeMB
         wqNtlvuIzp8qnj1vHo3RkKLiXnsSbavkf1W/1fUAULXYj4U1abDvDeMqAAcvWSYmK7sV
         LvvW6PJknDzV3GGQXhYr+IDsYXNcJC1mBfGX0SmQS/7rcemcGAdToRlDeW43iedhdwqG
         7jxS5TRt+jFq23If0QHXgIXAWaWItIUyEMOMLO3oQY5dJTkiNjM4h6XhpMqlZveyfozi
         QDVg==
X-Gm-Message-State: AOAM532bNPXhG1n8jVgbBacoMx434dCihuFBJkmu7hINj+2UOS985hjy
        +vgmoE2m219HZPPoS1QYGz8=
X-Google-Smtp-Source: ABdhPJy04TJllH1xTfjAgj+XeYFKZKZTqiwpp1qj8qcj3ccCXP+qV89w4+ZNyD3bd4+OiZtYILZgyg==
X-Received: by 2002:aa7:cd05:: with SMTP id b5mr6388003edw.58.1635429417771;
        Thu, 28 Oct 2021 06:56:57 -0700 (PDT)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id gn24sm651039ejc.78.2021.10.28.06.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 06:56:57 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     demonsingur@gmail.com, cosmin.tanislav@analog.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: iio: add AD74413R
Date:   Thu, 28 Oct 2021 16:56:04 +0300
Message-Id: <20211028135608.3666940-2-demonsingur@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211028135608.3666940-1-demonsingur@gmail.com>
References: <20211028134849.3664969-1-demonsingur@gmail.com>
 <20211028135608.3666940-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

Add device tree bindings for AD74413R.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 .../bindings/iio/addac/adi,ad74413r.yaml      | 163 ++++++++++++++++++
 include/dt-bindings/iio/addac/adi,ad74413r.h  |  30 ++++
 2 files changed, 193 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
 create mode 100644 include/dt-bindings/iio/addac/adi,ad74413r.h

diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
new file mode 100644
index 000000000000..ed4ee3047fbe
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
@@ -0,0 +1,163 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/addac/adi,ad74413r.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD74413R/AD74412R device driver
+
+maintainers:
+  - Cosmin Tanislav <cosmin.tanislav@analog.com>
+
+description: |
+  The AD74413R and AD74412R are quad-channel software configurable input/output
+  solutions for building and process control applications. They contain
+  functionality for analog output, analog input, digital input, resistance
+  temperature detector, and thermocouple measurements integrated
+  into a single chip solution with an SPI interface.
+  The devices feature a 16-bit ADC and four configurable 13-bit DACs to provide
+  four configurable input/output channels and a suite of diagnostic functions.
+
+properties:
+  compatible:
+    enum:
+      - adi,ad74413r
+      - adi,ad74412r
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
+  refin-supply:
+    description:
+      Reference voltage regulator.
+
+  adi,rsense-resistance-ohms:
+    $ref: /schemas/types.yaml#/definitions/uint32
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
+        maxItems: 1
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
+        maxItems: 1
+        minimum: 0
+        maximum: 10
+
+      adi,gpo-config:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          GPO config.
+          0 - GPO_CONFIG_100K_PULL_DOWN
+          1 - GPO_CONFIG_LOGIC
+          3 - GPO_CONFIG_DEBOUNCED_COMPARATOR
+          4 - GPO_CONFIG_HIGH_IMPEDANCE
+        maxItems: 1
+        enum: [0, 1, 3, 4]
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
+          adi,gpo-config = <GPO_CONFIG_LOGIC>;
+        };
+
+        channel@1 {
+          reg = <1>;
+
+          adi,ch-func = <CH_FUNC_CURRENT_OUTPUT>;
+          adi,gpo-config = <GPO_CONFIG_LOGIC>;
+        };
+
+        channel@2 {
+          reg = <2>;
+
+          adi,ch-func = <CH_FUNC_VOLTAGE_INPUT>;
+          adi,gpo-config = <GPO_CONFIG_DEBOUNCED_COMPARATOR>;
+        };
+
+        channel@3 {
+          reg = <3>;
+
+          adi,ch-func = <CH_FUNC_CURRENT_INPUT_EXT_POWER>;
+          adi,gpo-config = <GPO_CONFIG_DEBOUNCED_COMPARATOR>;
+        };
+      };
+    };
+...
diff --git a/include/dt-bindings/iio/addac/adi,ad74413r.h b/include/dt-bindings/iio/addac/adi,ad74413r.h
new file mode 100644
index 000000000000..bde558d9731c
--- /dev/null
+++ b/include/dt-bindings/iio/addac/adi,ad74413r.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _DT_BINDINGS_ADI_AD74413R_H
+#define _DT_BINDINGS_ADI_AD74413R_H
+
+#define GPO_CONFIG_100K_PULL_DOWN		0x0
+#define GPO_CONFIG_LOGIC				0x1
+#define GPO_CONFIG_LOGIC_PARALLEL		0x2
+#define GPO_CONFIG_DEBOUNCED_COMPARATOR	0x3
+#define GPO_CONFIG_HIGH_IMPEDANCE		0x4
+
+#define GPO_CONFIG_MIN		GPO_CONFIG_100K_PULL_DOWN
+#define GPO_CONFIG_MAX		GPO_CONFIG_HIGH_IMPEDANCE
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
2.33.0

