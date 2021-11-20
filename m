Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5578A457CCF
	for <lists+linux-iio@lfdr.de>; Sat, 20 Nov 2021 11:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbhKTKSQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Nov 2021 05:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237263AbhKTKSQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Nov 2021 05:18:16 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AA1C061574
        for <linux-iio@vger.kernel.org>; Sat, 20 Nov 2021 02:15:13 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id n85so11461172pfd.10
        for <linux-iio@vger.kernel.org>; Sat, 20 Nov 2021 02:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ivtOOyrnotxGJUaTso0MusVT4cGe4UgUIhUogPn7f1I=;
        b=mTuWYnXLfAujjCJnYXFluVHsZADeBDPJRsZdzYqXBm461WiDHUOMVqhKi4lNPQ3kxw
         l2prH8A6QuVM8kmXW9amP5xgTM1yJk4IS70gxB3Hk4KZegRFVhOvIm5msVzOAxcuuzd8
         siMYakuIdcHO7MCx836qPIEOV1eLJRB6ny25E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ivtOOyrnotxGJUaTso0MusVT4cGe4UgUIhUogPn7f1I=;
        b=b3uZFC3okBJC9qstLhHER+PKTo6DKVJ3p4aaQRZQvSFLwxGA5mEomxbFuEMUMGw3pT
         JmZ6qcBF0ZW1ERli7RGf+LoIC1O6PDoZeo7Of/cB2cY8xOWQW9fMkuc9ShaT8FCCE76z
         As0mTr01s4ko54edk4AMM4Vv84jNOKQ1LjBnq3N/SItfPVJARiQmaFvmOpIme45IIy9y
         RH0NLU54PB8SWARnJ6DQrxfkQMlAZ1KFdYSE0FuhO2iM7mn6qPW/7XipmWS5aE5vpofy
         UgsFTMXrTqRw69gZs7YU3K1vCcITudHooB6wI12W261jFzfIlRKGKWZ2oMbSWNU8soLt
         8jLw==
X-Gm-Message-State: AOAM531DEjnku3qK43Qz1FfxktcvuZHmlq/VQUWuPTYRDRKM9IhfROCK
        kW9bq7Uvd0+dF5s10CY1jWAJYw==
X-Google-Smtp-Source: ABdhPJyxyAWWPRerGLdUYsFymJLIehdl9Sy/K3wAzfgtZVUcEFw0yzj2u4a6rS2zk62VveGAqmjBLg==
X-Received: by 2002:a63:4e09:: with SMTP id c9mr22188954pgb.83.1637403312962;
        Sat, 20 Nov 2021 02:15:12 -0800 (PST)
Received: from localhost ([2620:15c:202:201:913f:8f64:e1fa:a751])
        by smtp.gmail.com with UTF8SMTPSA id k14sm2446721pff.6.2021.11.20.02.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Nov 2021 02:15:12 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 4/5] dt-bindings: iio: Add sx9324 binding
Date:   Sat, 20 Nov 2021 02:15:00 -0800
Message-Id: <20211120101501.1659549-5-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
In-Reply-To: <20211120101501.1659549-1-gwendal@chromium.org>
References: <20211120101501.1659549-1-gwendal@chromium.org>
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
index 00000000000000..70e4736fb1cc9a
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
+  semtech,resolution01:
+    $ref: /schemas/types.yaml#definitions/uint32
+    enum: [8, 16, 32, 64, 128, 256, 512, 1024]
+    description:
+      Capacitance measurement resolution. For phase 0 and 1.
+      Higher the number, higher the resolution.
+    default: 128
+
+  semtech,resolution23:
+    $ref: /schemas/types.yaml#definitions/uint32
+    enum: [8, 16, 32, 64, 128, 256, 512, 1024]
+    description:
+      Capacitance measurement resolution. For phase 2 and 3
+    default: 128
+
+  semtech,startup-sensor:
+    $ref: /schemas/types.yaml#definitions/uint32
+    enum: [0, 1, 2, 3]
+    default: 0
+    description: |
+      Phase used for start-up proximity detection.
+      It is used when we enable a phase to remove static offset and measure
+      only capacitance changes introduced by the user.
+
+  semtech,proxraw-strength01:
+    $ref: /schemas/types.yaml#definitions/uint32
+    min: 0
+    max: 7
+    default: 1
+    description:
+      PROXRAW filter strength for phase 0 and 1. A value of 0 represents off,
+      and other values represent 1-1/2^N.
+
+  semtech,proxraw-strength23:
+    $ref: /schemas/types.yaml#definitions/uint32
+    min: 0
+    max: 7
+    default: 1
+    description:
+      Same as proxraw-strength01, for phase 2 and 3.
+
+  semtech,avg-pos-strength:
+    $ref: /schemas/types.yaml#definitions/uint32
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
+        semtech,ph0-pin = <1, 2, 3>;
+        semtech,ph1-pin = <3, 2, 1>;
+        semtech,ph2-pin = <1, 2, 3>;
+        semtech,ph3-pin = <3, 2, 1>;
+        semtech,resolution01 = 2;
+        semtech,resolution23 = 2;
+        semtech,startup-sensor = <1>;
+        semtech,proxraw-strength01 = <2>;
+        semtech,proxraw-strength23 = <2>;
+        semtech,avg-pos-strength = <64>;
+      };
+    };
-- 
2.34.0.rc2.393.gf8c9666880-goog

