Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A8E440880
	for <lists+linux-iio@lfdr.de>; Sat, 30 Oct 2021 13:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhJ3LVI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Oct 2021 07:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhJ3LVI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Oct 2021 07:21:08 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F32DC061570
        for <linux-iio@vger.kernel.org>; Sat, 30 Oct 2021 04:18:38 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id x5so2624931pgk.11
        for <linux-iio@vger.kernel.org>; Sat, 30 Oct 2021 04:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rcGiGmzUiomdmtWUDW3gtMvTfqQEceobhZWYpvePNMs=;
        b=iqb9mAicN15oEUxxLhSFYKDgvKUuHCDCC96ZFBLlNE2DFrsaLvU/qcGvgq36QjJ0Mc
         yDrDz5NXlKD5QSEdRn7E86YaV0A4mQhwJ4CVdAkonYFWtuZ/jejPy362hRM2N/OtIsxF
         HuLx6SmB1fYYDR2mbhMaQc3F4ouA0x4xsxTYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rcGiGmzUiomdmtWUDW3gtMvTfqQEceobhZWYpvePNMs=;
        b=BLA/04JIdaYI1wKuXSc1kuFK2C15aw9WfN1sJtrYtvT2QNOq2RfZlH/m6xHzBsPPnV
         WutjJZj4CgTL2tdEeLNfxf62DH9WEjYB8SPRA4aQOphUlBfsvLsa4sJYlnPtbjt8gHZo
         ECVJS8ZosMHaNoKgXinSIL3baTkwia6+9xIoS19Rjk3gtalMmgqcvRwy22qy92QyIgPz
         qly6++NJfzEfpNA6uhgKav43bbJPraaLfhM893J+p6ty8c1oiFlovo6TL7ZWXcTrBiJ6
         xu2rwvRkB8j4d0xJUx4W1+hNkAHYzdVX2wJJVf9//MkdzfN8CaTJjea31EnUVaIkSV9I
         TpcQ==
X-Gm-Message-State: AOAM531+8Y3QBS+bWTiJb2GDBXS+W76OnMwcFOXOz2ld2Y7ZY0Aa58PB
        k+ZxWRAZfXnqYuk/VKghixqytw==
X-Google-Smtp-Source: ABdhPJzbUlId+7k5vX+4SggF02lpN+w0HxZzejcJyFQKrY9ZPsOMH+vyZflkMgbsfzy0aepiftREtA==
X-Received: by 2002:a05:6a00:cd2:b0:47e:57fc:43b4 with SMTP id b18-20020a056a000cd200b0047e57fc43b4mr13437210pfv.7.1635592717906;
        Sat, 30 Oct 2021 04:18:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:71f1:234f:bb3d:6ccf])
        by smtp.gmail.com with UTF8SMTPSA id w7sm10435850pfu.147.2021.10.30.04.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Oct 2021 04:18:37 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 4/5] dt-bindings: iio: Add sx9324 binding
Date:   Sat, 30 Oct 2021 04:18:26 -0700
Message-Id: <20211030111827.1494139-5-gwendal@chromium.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
In-Reply-To: <20211030111827.1494139-1-gwendal@chromium.org>
References: <20211030111827.1494139-1-gwendal@chromium.org>
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
 .../iio/proximity/semtech,sx9324.yaml         | 141 ++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
new file mode 100644
index 0000000000000..fe9edf15c16d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
@@ -0,0 +1,141 @@
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
+      The sole interrupt generated by the device used to announce the
+      preceding reading request has finished and that data is
+      available or that a close/far proximity event has happened.
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
+    enum: [0, 1, 2, 3, 4, 5, 6, 7]
+    description:
+      Capacitance measurement resolution. For phase 0 and 1.
+      Higher the number, higher the resolution.
+    default: 4
+
+  semtech,resolution23
+    $ref: /schemas/types.yaml#definitions/uint32
+    enum: [0, 1, 2, 3, 4, 5, 6, 7]
+    description:
+      Capacitance measurement resolution. For phase 2 and 3
+    default: 4
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
+    enum: [0, 1, 2, 3, 4, 5, 6, 7]
+    default: 1
+    description:
+      PROXRAW filter strength for phase 0 and 1. A value of 0 represents off,i
+      and other values represent 1-1/N.
+
+  semtech,proxraw-strength23:
+    $ref: /schemas/types.yaml#definitions/uint32
+    enum: [0, 1, 2, 3, 4, 5, 6, 7]
+    default: 1
+    description:
+      PROXRAW filter strength for phase 2 and 3. A value of 0 represents off,i
+      and other values represent 1-1/N.
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
2.33.1.1089.g2158813163f-goog

