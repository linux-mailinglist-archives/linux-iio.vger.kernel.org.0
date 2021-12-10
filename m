Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0EE470A51
	for <lists+linux-iio@lfdr.de>; Fri, 10 Dec 2021 20:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343608AbhLJT1R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Dec 2021 14:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343602AbhLJT1Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Dec 2021 14:27:16 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97892C0617A1
        for <linux-iio@vger.kernel.org>; Fri, 10 Dec 2021 11:23:41 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id l18so4167302pgj.9
        for <linux-iio@vger.kernel.org>; Fri, 10 Dec 2021 11:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=etxDL5haa8nIZ936iLe2ncvHEN0iLLjyv3DM0pP4dBI=;
        b=Ibojl1fjOh/PEb5o6ZFzE6TMtVuXe0EVqoXpHh5EZC4RX0PGcBIYf56Efjzy11RleK
         h/5eYg67vbkLRwQ3WQKb756a8ak0sOLfEqzuh0vD4keyC42PWNN+DIjNSZ3IIQEH4dbM
         Q7Fv0RBD8/L1UP/FISvzt+1WcQ2CbFfFmbZz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=etxDL5haa8nIZ936iLe2ncvHEN0iLLjyv3DM0pP4dBI=;
        b=Kef69s+7Cn1HnnLSVdK5r8g6st8HxeUsFIxlTUajk3fX0uVHtvHFF+UPcaeYGsOu6a
         s+Ax/ZaaxwhslKp+ziwl09fjDUeRagycwZwcyU4GuN8KDkSeSwkhHJtgNPDP4MrZolAI
         /5VbGQBHOgTDFvPgWRDCT3tlPgcaI2QyXUN5KDaJe8a8NyiAa+ZSYYeJe3piiZdI1dd6
         FOlR9YuQbcZBJ7o0NOLVqG/d5M7dsR92mLvX3Fe9j3sOLykWPn5h3c9i6GDxObPqQJ+M
         wFqJ3hyVHyC8Ez5XE+BrkkESNT++RISgapQ1hdzDVBjs/RflSur/sStEfHdxX3XyMhA6
         2egg==
X-Gm-Message-State: AOAM531ZTQ7n5rLzGx0La1ozePIcgK4vuk0pV8hoyDM1H/ggNGLvPNrC
        +fLt4frVithBXTZouK0lOi6q8A==
X-Google-Smtp-Source: ABdhPJw0UjEiO274G2mQZl0s9ylwT/MJxpdWMeTMD3Up8KxDDLztzbMc8cTi+C7+DbChA+4Ch6ZMqQ==
X-Received: by 2002:a63:5c0a:: with SMTP id q10mr40240350pgb.213.1639164221070;
        Fri, 10 Dec 2021 11:23:41 -0800 (PST)
Received: from localhost ([2620:15c:202:201:16de:af23:a52f:63b])
        by smtp.gmail.com with UTF8SMTPSA id g15sm5076705pfj.144.2021.12.10.11.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 11:23:40 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     robh+dt@kernel.org, jic23@kernel.org, lars@metafoo.de,
        swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 4/5] dt-bindings: iio: Add sx9324 binding
Date:   Fri, 10 Dec 2021 11:23:27 -0800
Message-Id: <20211210192328.2844060-5-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211210192328.2844060-1-gwendal@chromium.org>
References: <20211210192328.2844060-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Similar to SX9310, add biddings to setup sx9324 hardware properties.
SX9324 is a little different, introduce 4 phases to be configured in 2
pairs over 3 antennas.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v7:
- Fix 2 remaining syntax error in example.

Changes in v6:
- Fix syntax errors in device tree binding documentation.
- Run 'make dt_binding_check' to make fix errors.

Changes in v5:
- Use consistent field naming, prefixed with phX.

Changes in v4:
- Use const instead of single enum
- Specify ph0-pin better
- Recopy type information for phX-pin
- Fix cut and paste errors.

Changes in v3:
- Remove duplicate information.
- Use intervals instead of enum.
- Fix filter description.

Changes in v2:
- Fix interrupt documentation wording.

 .../iio/proximity/semtech,sx9324.yaml         | 161 ++++++++++++++++++
 1 file changed, 161 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
new file mode 100644
index 00000000000000..b8a6ee16854ff6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
@@ -0,0 +1,161 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/semtech,sx9324.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Semtech's SX9324 capacitive proximity sensor
+
+maintainers:
+  - Gwendal Grignou <gwendal@chromium.org>
+  - Daniel Campello <campello@chromium.org>
+
+description: |
+  Semtech's SX9324 proximity sensor.
+
+properties:
+  compatible:
+    const: semtech,sx9324
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Generated by device to announce preceding read request has finished
+      and data is available or that a close/far proximity event has happened.
+    maxItems: 1
+
+  vdd-supply:
+    description: Main power supply
+
+  svdd-supply:
+    description: Host interface power supply
+
+  "#io-channel-cells":
+    const: 1
+
+  semtech,ph0-pin:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Array of 3 entries. Index represent the id of the CS pin.
+      Value indicates how each CS pin is used during phase 0.
+      Each of the 3 pins have the following value -
+      0 : unused (high impedance)
+      1 : measured input
+      2 : dynamic shield
+      3 : grounded.
+      For instance, CS0 measured, CS1 shield and CS2 ground is [1, 2, 3]
+    items:
+      enum: [ 0, 1, 2, 3 ]
+    minItems: 3
+    maxItems: 3
+
+  semtech,ph1-pin:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: Same as ph0-pin for phase 1.
+    items:
+      enum: [ 0, 1, 2, 3 ]
+    minItems: 3
+    maxItems: 3
+
+  semtech,ph2-pin:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: Same as ph0-pin for phase 2.
+    items:
+      enum: [ 0, 1, 2, 3 ]
+    minItems: 3
+    maxItems: 3
+
+  semtech,ph3-pin:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: Same as ph0-pin for phase 3.
+    items:
+      enum: [ 0, 1, 2, 3 ]
+    minItems: 3
+    maxItems: 3
+
+
+  semtech,ph01-resolution:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [8, 16, 32, 64, 128, 256, 512, 1024]
+    description:
+      Capacitance measurement resolution. For phase 0 and 1.
+      Higher the number, higher the resolution.
+    default: 128
+
+  semtech,ph23-resolution:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [8, 16, 32, 64, 128, 256, 512, 1024]
+    description:
+      Capacitance measurement resolution. For phase 2 and 3
+    default: 128
+
+  semtech,startup-sensor:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    default: 0
+    description: |
+      Phase used for start-up proximity detection.
+      It is used when we enable a phase to remove static offset and measure
+      only capacitance changes introduced by the user.
+
+  semtech,ph01-proxraw-strength:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 7
+    default: 1
+    description:
+      PROXRAW filter strength for phase 0 and 1. A value of 0 represents off,
+      and other values represent 1-1/2^N.
+
+  semtech,ph23-proxraw-strength:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 7
+    default: 1
+    description:
+      Same as proxraw-strength01, for phase 2 and 3.
+
+  semtech,avg-pos-strength:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 16, 64, 128, 256, 512, 1024, 4294967295]
+    default: 16
+    description: |
+      Average positive filter strength. A value of 0 represents off and
+      UINT_MAX (4294967295) represents infinite. Other values
+      represent 1-1/N.
+
+required:
+  - compatible
+  - reg
+  - "#io-channel-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      proximity@28 {
+        compatible = "semtech,sx9324";
+        reg = <0x28>;
+        interrupt-parent = <&pio>;
+        interrupts = <5 IRQ_TYPE_LEVEL_LOW 5>;
+        vdd-supply = <&pp3300_a>;
+        svdd-supply = <&pp1800_prox>;
+        #io-channel-cells = <1>;
+        semtech,ph0-pin = <1 2 3>;
+        semtech,ph1-pin = <3 2 1>;
+        semtech,ph2-pin = <1 2 3>;
+        semtech,ph3-pin = <3 2 1>;
+        semtech,ph01-resolution = <256>;
+        semtech,ph23-resolution = <256>;
+        semtech,startup-sensor = <1>;
+        semtech,ph01-proxraw-strength = <2>;
+        semtech,ph23-proxraw-strength = <2>;
+        semtech,avg-pos-strength = <64>;
+      };
+    };
-- 
2.34.1.173.g76aa8bc2d0-goog

