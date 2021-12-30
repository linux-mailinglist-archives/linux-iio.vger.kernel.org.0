Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE962481961
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 05:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbhL3Emw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Dec 2021 23:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbhL3Emw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Dec 2021 23:42:52 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BA8C061574
        for <linux-iio@vger.kernel.org>; Wed, 29 Dec 2021 20:42:52 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id j13so17433163plx.4
        for <linux-iio@vger.kernel.org>; Wed, 29 Dec 2021 20:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dXqHNB9lKKH8mrp5OyM6pHZ0FKpTxfLuH7e/Rvo8NPY=;
        b=XrnQSSR/i28ybwF9DG3/LZw5ZhOcRgHvGzgbU6Jxzez7HKPX8lW7RaoF7nd6VDKuYS
         qwDeBL/Tn37GzfhIU+zMrLPUd18Zy7Spb40sFHj8Giq3z3ivDYXm46338j7wo9GrBdJ3
         w41wylVFJrfZ4TY9a3mVUdmU5AEqD6JoQofiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dXqHNB9lKKH8mrp5OyM6pHZ0FKpTxfLuH7e/Rvo8NPY=;
        b=gbzGN9tLw3NN7HcUxwiZVVeTB/ZGWz0o4AD7/1O2a7ROXNk/nonuCwj+P91tGWMSQD
         NG9tZJy6Wr3c1aoosCRPdU42/fHrgdxswtsCTq6XCtjnKNpquV1AlyvKSpJ9YPuDGIa8
         jqPdIAGi1oL463tLUNVJeO3QznlDhNIV4ADORuhN4dsLkbvgE4ZfS7h5nEv4809aFpuA
         GEenW02ZMF2w+T3oZhN+30u6NB4yVaDdfMQESqDFOMEGl0xBVQVdWiAWZZA8Hgq1adhK
         cu5i+yMBrgqgPg4fghB57kxH+li2Ku/90sscEApZwbZASljXIYnPCAZg976ALWIC+xhz
         1ZnQ==
X-Gm-Message-State: AOAM531AzR0UhdS/qmcnL4w6Ej8kBSmHzuZAKu9mCYu3DoWV0qfOfSx0
        9bzY28MrmpquUUf0JsErO/Hxhg==
X-Google-Smtp-Source: ABdhPJxz0xqRgJKnFtiwmaXjLwU2zGVWKlTy4tao1LKc6hzvl6zjxMV67YDDTSOdpxkVhhxFv3w+dA==
X-Received: by 2002:a17:903:191:b0:148:a2f7:9d4a with SMTP id z17-20020a170903019100b00148a2f79d4amr29246651plg.105.1640839371627;
        Wed, 29 Dec 2021 20:42:51 -0800 (PST)
Received: from localhost ([2620:15c:202:201:f2cb:bddc:361b:5398])
        by smtp.gmail.com with UTF8SMTPSA id w9sm21059087pge.18.2021.12.29.20.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 20:42:51 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v9 4/5] dt-bindings: iio: Add sx9324 binding
Date:   Wed, 29 Dec 2021 20:42:41 -0800
Message-Id: <20211230044242.1024940-5-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20211230044242.1024940-1-gwendal@chromium.org>
References: <20211230044242.1024940-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Similar to SX9310, add biddings to setup sx9324 hardware properties.
SX9324 is a little different, introduce 4 phases to be configured in 2
pairs over 3 antennas.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
No Changes in v9.
No Changes in v8.
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
2.34.1.448.ga2b2bfdf31-goog

