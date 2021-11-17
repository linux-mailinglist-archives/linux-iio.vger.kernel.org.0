Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FD84542E1
	for <lists+linux-iio@lfdr.de>; Wed, 17 Nov 2021 09:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbhKQItn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Nov 2021 03:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbhKQItj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Nov 2021 03:49:39 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FEDC061746
        for <linux-iio@vger.kernel.org>; Wed, 17 Nov 2021 00:46:40 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id o4so1972318pfp.13
        for <linux-iio@vger.kernel.org>; Wed, 17 Nov 2021 00:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ICsjiUP+T4soB7oPCizIPcOexWSchUn4+VSdho8cFc=;
        b=jTDFd4K06av2/I1C6TxVpAFl/7UKRqC1/vavdRMg79fYzNffO3Nv+pPqwVMbecl7xw
         3+tn3sTfjojB1OfzEgZaMJNMOVde2xwLskgOlmOtAHfPOAPIClCxXRMlKhBKYu8vPftZ
         UVlpVYvFi9Rv9tFLy6crvJC+U70kOVAxvExT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ICsjiUP+T4soB7oPCizIPcOexWSchUn4+VSdho8cFc=;
        b=qBeQiVmrFSmKIkSkycd3a/hS/0xzYy/qZL4EReEyFMdOURSjLDi+rzqXUlFXo1Z8cs
         8PgNR2WfhBiLzSS7pc0P962IpuKlG5Q1U9rIhidZQj5xDrWpqOwoZ7xHKjdIJtbsEUXn
         97SJXD3JWGDxRmXM3lvk8eHELdPCj9CaVkiNallWWrvYp/D8T1fZ5MzHq3B4Z15uZH1u
         B461aGG9NNg4ox2lnFXbqxMLKk3DAAg8T4kzQQJrLnaMYiWCC4Gqx1PP8go2rHtd04Ld
         VugYfR+94KDJSMNB1Fr17Y7wMqWE8khUhzVamwPQLI+myjX/LCWmxKXbNwuXNYqpwjaO
         dq1Q==
X-Gm-Message-State: AOAM531BHOyKKYyjzh6YYyNw1K7wVB7Upi4DdQlwatOTxOs9JKVZ1IzY
        ubJNsyB8dXhMA+xc/a9D5yfwOw==
X-Google-Smtp-Source: ABdhPJzXgfY9yOgjeeZsOVQ/drLxqGzbh17jFSx376oHXXJ5SYaeB/7QZaaPEhfGZ5AEjAY5pnMkVA==
X-Received: by 2002:a63:1862:: with SMTP id 34mr4095908pgy.239.1637138800386;
        Wed, 17 Nov 2021 00:46:40 -0800 (PST)
Received: from localhost ([2620:15c:202:201:327f:7baa:380e:33a3])
        by smtp.gmail.com with UTF8SMTPSA id o9sm11686112pfh.37.2021.11.17.00.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 00:46:40 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 4/5] dt-bindings: iio: Add sx9324 binding
Date:   Wed, 17 Nov 2021 00:46:30 -0800
Message-Id: <20211117084631.2820014-5-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
In-Reply-To: <20211117084631.2820014-1-gwendal@chromium.org>
References: <20211117084631.2820014-1-gwendal@chromium.org>
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
Changes in v3:
- Remove duplicate information.
- Use intervals instead of enum.
- Fix filter description.

Changes in v2:
- Fix interrupt documentation wording.

 .../iio/proximity/semtech,sx9324.yaml         | 136 ++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
new file mode 100644
index 00000000000000..5e2e684400e35a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/semtech,sx9310.yaml#
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
+    enum:
+      - semtech,sx9324
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
+      Indicates how each CS pin is used during phase 0.
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
+  semtech,ph2-pin:
+  semtech,ph3-pin:
+    Same as ph0-pin
+
+  semtech,resolution01
+    $ref: /schemas/types.yaml#definitions/uint32
+    enum: [8, 16, 32, 64, 128, 256, 512, 1024]
+    description:
+      Capacitance measurement resolution. For phase 0 and 1.
+      Higher the number, higher the resolution.
+    default: 128
+
+  semtech,resolution23
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
+    description:
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
+    Same as proxraw-strength01, for phase 2 and 3.
+
+  semtech,avg-pos-strength:
+    $ref: /schemas/types.yaml#definitions/uint32
+    enum: [0, 16, 64, 128, 256, 512, 1024, 4294967295]
+    default: 16
+    description:
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
+        compatible = "semtech,sx9310";
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
2.34.0.rc1.387.gb447b232ab-goog

