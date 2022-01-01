Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2D248287A
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jan 2022 21:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiAAUi0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Jan 2022 15:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiAAUi0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Jan 2022 15:38:26 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E53C061574
        for <linux-iio@vger.kernel.org>; Sat,  1 Jan 2022 12:38:26 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l16-20020a17090a409000b001b2e9628c9cso530273pjg.4
        for <linux-iio@vger.kernel.org>; Sat, 01 Jan 2022 12:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hxLMEjbXbATqmApTo7RX9hEGtnWJq6vzEAVMg34/B8E=;
        b=cHnGAuE/5BmHz6uTMcXqgdblbq0DZln7NmOBVd31f3gESit1sMYOdzdXhmPtUg8hcu
         6hpYf2AmXGZCfRHHUXS/bZbHWWeld2ci/pQnPFfUsJDbEzOePhPJbQOz71my0ce7ST/Z
         6KeSuHkgVbfqPuSq3IVT4efJZa15bJYN+mW5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hxLMEjbXbATqmApTo7RX9hEGtnWJq6vzEAVMg34/B8E=;
        b=KhPEJs5/cTyvYM0Oh94CFbGWS2lDYEVdVixfCGr7a0G0EMliZGR3KDwqQQjidulT9X
         aZOIPG8fuU9PQ/3eGUdWNaZxZdDfTVR96hIiWmsl5+yRkBKQN3YDkY/BhnBc/hWnRsw4
         JzZH5ofjB9oUCaMM0eIW196wHLBRy8OB7RGrKhWRVkwNcR03aNY/CogxjA7qxUBcZWCt
         8Vuj/kC0hNFm3mc9we/iZjkfSGyof+kdD76pQLOfI7OtTHXISCWPiFMCI625QdGIcZTB
         0ixP6zDVBVbJUHGf9sZCjgP++A3QvDWxLEWrxu6zPNlFXf1n8jzVisxVI7mjIT8KirHa
         EfTA==
X-Gm-Message-State: AOAM5300Zo/iW4mONqCFwzKgw9X0oqG4BUa4J0OWZEFgNBrwqDXlYopU
        t4uxsKe1STLJVSvdmkAQhT23zVgTDXIpFw==
X-Google-Smtp-Source: ABdhPJzVUaNtf7HBK3HSbmfgMUSclnBQNxQWbWWzWUUYPmrF9NB6+9PKolRNIghZwltV2S1rqW+hkw==
X-Received: by 2002:a17:902:b189:b0:143:8079:3d3b with SMTP id s9-20020a170902b18900b0014380793d3bmr40055012plr.71.1641069505631;
        Sat, 01 Jan 2022 12:38:25 -0800 (PST)
Received: from localhost ([2620:15c:202:201:df49:1d3f:ae08:999])
        by smtp.gmail.com with UTF8SMTPSA id i17sm33056879pfk.44.2022.01.01.12.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jan 2022 12:38:25 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v10 4/5] dt-bindings: iio: Add sx9324 binding
Date:   Sat,  1 Jan 2022 12:38:16 -0800
Message-Id: <20220101203817.290512-5-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220101203817.290512-1-gwendal@chromium.org>
References: <20220101203817.290512-1-gwendal@chromium.org>
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
No Changes in v10.
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

