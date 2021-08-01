Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412353DCD6B
	for <lists+linux-iio@lfdr.de>; Sun,  1 Aug 2021 21:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhHATkk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Aug 2021 15:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbhHATkb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Aug 2021 15:40:31 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FF0C061799;
        Sun,  1 Aug 2021 12:40:23 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id m11so10321970qtx.7;
        Sun, 01 Aug 2021 12:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R5EJ5Gnotkd7ffF8IJqFhFOyVW3BEMA9J80b/3joIJo=;
        b=khCOP/CAZUFPUggKGpoFL2EBdz3UXIPUwp7FrRee7+IvmWLmGshoYcRazovwO/0bIR
         HoVVLLjZqaZnBdkoaOuQ76mRFC4KxexnGYfaSw+oC52SbTccU1/FKYpYlO8Fgbnj+C++
         JuJE9dB2OeIjVtyRm9X9MpCXDp7oChAmCTfgAGz5ce1jFEukaxLmYu2glBrLDygCGKXG
         LJglGdScgDzRqSzMs1GLNfL56kchOsYVvKqoH1/PcYqNwVNd74LPAZEhpcDtpeOXsIT7
         2xtkGIl8KSpMdVzsdI9O/G2QckA7KHiIYQadHVuZOv9XJ5X6NKrYC9B089B4kqMORwq6
         C3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R5EJ5Gnotkd7ffF8IJqFhFOyVW3BEMA9J80b/3joIJo=;
        b=AvEbb67VQ0wT9putbLrdlPjcZ98jUtQMsJIrN12cnwYZyY5uHMRu9shufWq8oNdVNa
         8fjD5KOUU83ptCi5AIaID6t+X/1rm8dp2X5t0HYbW5eart3qO2s6oJMEReE558tA+Fcd
         hOeyJWZM3KQ8QTNucR6qqr3ApdJSX9sByHJR+5Ot1B4SAHldJPVOFVEP01GMz91SvLHw
         Du/D68YFjDZtA4WJUYMoZXtj53+LRxuAah5/AY9UGxV85lfoK+H1fyx1aut/fU9z6z99
         Kb1nwlYZmW3Z2HjTBCYpoPAhwX2V8H1SH4WZT8+SKPbzEqT6GW4+v8Hj6vjf13DL3G3N
         MG5A==
X-Gm-Message-State: AOAM533DeHDrOjeci8UAnVx2tK64iup48EB2aB1qq2zWG+Rsk+392hQa
        PEhvpZkgMc2Kin4WhkGIH+0=
X-Google-Smtp-Source: ABdhPJyc3xX/ss1pVYBdk0wigqmT67Ms891lDBijJPr/6O0UQ+cBpw7QnOhPurWBb3LXEkHKvRXALQ==
X-Received: by 2002:ac8:7545:: with SMTP id b5mr11272072qtr.297.1627846822332;
        Sun, 01 Aug 2021 12:40:22 -0700 (PDT)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id f10sm3621606qto.31.2021.08.01.12.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:40:21 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v7 12/13] dt-bindings: iio: afe: add bindings for temperature-sense-rtd
Date:   Sun,  1 Aug 2021 15:39:59 -0400
Message-Id: <20210801194000.3646303-13-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210801194000.3646303-1-liambeguin@gmail.com>
References: <20210801194000.3646303-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

An ADC is often used to measure other quantities indirectly. This
binding describe one case, the measurement of a temperature through the
voltage across an RTD resistor such as a PT1000.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../iio/afe/temperature-sense-rtd.yaml        | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml

diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
new file mode 100644
index 000000000000..336ce96371db
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/afe/temperature-sense-rtd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Temperature Sense RTD
+
+maintainers:
+  - Liam Beguin <liambeguin@gmail.com>
+
+description: |
+  RTDs (Resistance Temperature Detectors) are a kind of temperature sensors
+  used to get a linear voltage to temperature reading within a give range
+  (usually 0 to 100 degrees Celsius).
+
+  When an io-channel measures the output voltage across an RTD such as a
+  PT1000, the interesting measurement is almost always the corresponding
+  temperature, not the voltage output. This binding describes such a circuit.
+
+  The general transfer function here is (using SI units)
+
+    V = R(T) * iexc
+    R(T) = r0 * (1 + alpha * T)
+    T = 1 / (alpha * r0 * iexc) * (V - r0 * iexc)
+
+  The following circuit matches what's in the examples section.
+
+           5V0
+          -----
+            |
+        +---+----+
+        |  R 5k  |
+        +---+----+
+            |
+            V 1mA
+            |
+            +---- Vout
+            |
+        +---+----+
+        | PT1000 |
+        +---+----+
+            |
+          -----
+           GND
+
+properties:
+  compatible:
+    const: temperature-sense-rtd
+
+  io-channels:
+    maxItems: 1
+    description: |
+      Channel node of a voltage io-channel.
+
+  '#io-channel-cells':
+    const: 0
+
+  excitation-current-microamp:
+    description: The current fed through the RTD sensor.
+
+  alpha-ppm-per-celsius:
+    description: |
+      alpha can also be expressed in micro-ohms per ohm Celsius. It's a linear
+      approximation of the resistance versus temperature relationship
+      between 0 and 100 degrees Celsius.
+
+      alpha = (R_100 - R_0) / (100 * R_0)
+
+      Where, R_100 is the resistance of the sensor at 100 degrees Celsius, and
+      R_0 (or r-naught-ohms) is the resistance of the sensor at 0 degrees
+      Celsius.
+
+      Pure platinum has an alpha of 3925. Industry standards such as IEC60751
+      and ASTM E-1137 specify an alpha of 3850.
+
+  r-naught-ohms:
+    description: |
+      Resistance of the sensor at 0 degrees Celsius.
+      Common values are 100 for PT100, 500 for PT500, and 1000 for PT1000
+
+additionalProperties: false
+required:
+  - compatible
+  - io-channels
+  - excitation-current-microamp
+  - alpha-ppm-per-celsius
+  - r-naught-ohms
+
+examples:
+  - |
+    pt1000_1: temperature-sensor0 {
+        compatible = "temperature-sense-rtd";
+        #io-channel-cells = <0>;
+        io-channels = <&temp_adc1 0>;
+
+        excitation-current-microamp = <1000>; /* i = U/R = 5 / 5000 */
+        alpha-ppm-per-celsius = <3908>;
+        r-naught-ohms = <1000>;
+    };
+...
-- 
2.30.1.489.g328c10930387

