Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9348146DFE7
	for <lists+linux-iio@lfdr.de>; Thu,  9 Dec 2021 01:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241714AbhLIBBv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Dec 2021 20:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241701AbhLIBBt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Dec 2021 20:01:49 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB73C061A72
        for <linux-iio@vger.kernel.org>; Wed,  8 Dec 2021 16:58:17 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id g16so3615282pgi.1
        for <linux-iio@vger.kernel.org>; Wed, 08 Dec 2021 16:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VgpgLXSY3kvtIm93FzxopZGSXIfte8ltBoy1Frm0GRE=;
        b=R3S8bZf1O/rjZPr/Ak9/UBWF6837EI6s/6rQfX2QtwqrkNR11Vko7+d8OeFUnyDfYM
         u7QYmmT1l79/+V6/Spr9DVv5v9+Ki4Dg9BfQETk+35ICWBqtdlmYrGxyW4VNvfR/wZzQ
         nCSFVoA9XPYBu/pVz2J0olOM8vX1XkcpLYkIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VgpgLXSY3kvtIm93FzxopZGSXIfte8ltBoy1Frm0GRE=;
        b=r5v4WPG3Q1t4RnxitCj9ijwBuXuo7xL6W3zmI0eV2spgX2eAwdR9slZQRk1Da4iVcJ
         nqgvii/VFX2y9QdgMsw28WUh1BOL2dFE7+diyDNmFns/9idcwiOTXd3FGUTWgaqYS5QX
         4xQSq1fRJdv8K2kgYzVR/Rw5wEMPAJ+yDMF3yncB1RG8qjAySM2XJcy9KhfU4NcjNPuH
         VKZ/Dg1wLGhv20CE40svbUs0dM+h2tL+z7hrlOuOK9WGAGdfCNx+nusobX9IHP/q+Qu9
         uaVRQdumW0WDBL12jaND56/lsp1IllQvkd01HACPd4ghvwNO6Hrsq6rdfZSPARqA/2Td
         hTKQ==
X-Gm-Message-State: AOAM5313CIIWalmu/Gq2Av48xpyMzz5yHESBseuNKBvXVtJcz7kt20+M
        LwvEPpb6c9jbNITubc5ovDSsvw==
X-Google-Smtp-Source: ABdhPJx5isAMYX2Vjl+w6sG+ecHQNX3+Rwuj6W10aXTtWgA+sF+3FMoCKULyjJbwuXO8x53u2BCc/A==
X-Received: by 2002:a05:6a00:24c7:b0:4a0:41b:38f9 with SMTP id d7-20020a056a0024c700b004a0041b38f9mr8950174pfv.54.1639011496581;
        Wed, 08 Dec 2021 16:58:16 -0800 (PST)
Received: from localhost ([2620:15c:202:201:16e0:43f4:4e33:993b])
        by smtp.gmail.com with UTF8SMTPSA id m15sm3486864pgd.44.2021.12.08.16.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 16:58:16 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     robh+dt@kernel.org, jic23@kernel.org, lars@metafoo.de,
        swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v6 4/5] dt-bindings: iio: Add sx9324 binding
Date:   Wed,  8 Dec 2021 16:58:05 -0800
Message-Id: <20211209005806.3575399-5-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
In-Reply-To: <20211209005806.3575399-1-gwendal@chromium.org>
References: <20211209005806.3575399-1-gwendal@chromium.org>
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
index 00000000000000..1546adc9e2ecc1
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
+        semtech,ph01-resolution = <2>;
+        semtech,ph23-resolution = <2>;
+        semtech,startup-sensor = <1>;
+        semtech,ph01-proxraw-strength = <2>;
+        semtech,ph23-proxraw-strength = <2>;
+        semtech,avg-pos-strength = <64>;
+      };
+    };
-- 
2.34.1.400.ga245620fadb-goog

