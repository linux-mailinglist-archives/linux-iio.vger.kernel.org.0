Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8681843E28E
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 15:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhJ1NwH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 09:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhJ1Nv4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 09:51:56 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F701C06122B;
        Thu, 28 Oct 2021 06:49:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ee16so12155241edb.10;
        Thu, 28 Oct 2021 06:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ce+4++vM2nMn8JiMDvYZpZSZKn5WNDeTKykHl4yeAS8=;
        b=WqhoRDIiNTPnSfLhHCxB4k7OM5ZTGidY52vVSMqOxncuJeaf2UjsNCPodbMD5u7+PV
         5xQztFyHONq7HOBI52JxIqOTOshged4K/oJQV+4kZ6N7w/MOxDA0PTFthL1CwZ4k3fbh
         GPiE8uTHqMpaJMGNIaD7ROHFoJtownmhJNFq75wmPwNokEMDtbe1SyhsdoXVHZpXIWWM
         u+g/H1pGuwsKylGjIQzOHqzEOem3XlBj2hnZrwqF2Sr1Ag9QlLp6xNzIIl8jRNSUpcYl
         apB2zMhmmZkJ/AeeJUnGtj383ztxBC2jZZIJUND/recl6foc6ao7KAnMVtYkV/VSLd8p
         9ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ce+4++vM2nMn8JiMDvYZpZSZKn5WNDeTKykHl4yeAS8=;
        b=coZb+ADxbcQTYeRbvc6kI2R2swysEwIpOTSOTF9jEOTTt9/ilGS3h3Vk8F2J6TH7Ur
         Mo1ws3Djf1yDVybWr6HFYKCp1jbDeYGvdhufmLtITu55xg+g2acOADFI3xQa4i4LN3/V
         yhOXpCLY0MAN4bc7yAVYIlpOvYJP85i/fMZOXDAufgOaVWMwBR4CBrPP0lmzybhjfq2w
         +iBbd6i4XGpBEVkT5e/4uc287BVWUIeAvmaHexcTW+WV3t6RSEu9NZHGWrASoZWn4ruh
         UI2iV7Bs8oNKhqqqzlTz3ttewF36Jz9neBGGz+nTLhMbCbFQ5i4+KXAuVXCPY3fCLHjk
         DZlw==
X-Gm-Message-State: AOAM530LcOhqTroi5M4WFtcD1gusOtxdPoPZwUrxe9qv0QePNLxSypHe
        R6gu7C7s+ChVW0jSv/VF27A=
X-Google-Smtp-Source: ABdhPJwnFCTfXLZL7UiIuZ779wo+UJuyhjRfJ+FOxEOx2MjASRDB4bgibKBJh5fHMTX2rAO9/CGTHw==
X-Received: by 2002:a17:906:e85:: with SMTP id p5mr5682267ejf.159.1635428958251;
        Thu, 28 Oct 2021 06:49:18 -0700 (PDT)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id x3sm1941934edd.67.2021.10.28.06.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 06:49:17 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     demonsingur@gmail.com, cosmin.tanislav@analog.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: iio: add AD74413R
Date:   Thu, 28 Oct 2021 16:48:44 +0300
Message-Id: <20211028134849.3664969-2-demonsingur@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211028134849.3664969-1-demonsingur@gmail.com>
References: <20211028134849.3664969-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

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

