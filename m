Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A773F348E
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 21:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239826AbhHTTS5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 15:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238779AbhHTTSq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 15:18:46 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4156BC0612A7;
        Fri, 20 Aug 2021 12:18:06 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g11so8296670qtk.5;
        Fri, 20 Aug 2021 12:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ilb3VJUZk+DYaeMxgADmJ12g/nNeM9ZFYvcv8BX2YiE=;
        b=Apa8StN2iontzQU7Cuy+bB9QQq9qPdJ9eUUs17DPN2YyY1/d68WgBvL36c2mF2Bx5/
         xSYhN4/S7y3jOU6VjFXTa4F37NmZ92/U8cRNSMiWzgpkGFllBpMnW+D/C9FoL5appbmV
         HS7SugYgy/em9RqrVhVGMPC1/c4Ie2Jse74kPslKoWjyuseduaKd/l5a4AvAbbGzyYtS
         W1cb/fk2PD4gTe603Jm5+WzgsiRqTzAgOK1SmDLt74mRq0zmtVJrEITNLd2K5t5vF+XS
         /VmsM0xUvcpW0FbMPGzC9cKGkJyCOMwlL9FKhEZx0cmEIPlTDwJPlEmjd+FYcgGgLLqJ
         u6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ilb3VJUZk+DYaeMxgADmJ12g/nNeM9ZFYvcv8BX2YiE=;
        b=d0mouuWIWT8U46UBwdkfkaaSNywtyBDn/E479aQOK0slJn83NPMaN3SfeeWwHAI+HD
         A+SpClagM9Jxh9gUnxCI91p6WwwBLsoqgzfM0KmtXu0rcUfAMNAjsfwiJb0UtWUZSmkP
         8M5Nma3P33QUDYkKcHLpGLKHiv2kqy9y4Fj8Sk1Ko2p5ikr4mxoB1mOo/DPYyytEmCRF
         CnqATLfIZxIbrPSve/ad5hnzcpKGiCm19scKDhbVJePZQ2YkjzUHkoJTufpGdDhV3exs
         QYUazGvSF61ImSyUzBlWMNinrTRnjNUqmG+C4iWNBflbMd+4EMy6xWG1o91zg/4jxffZ
         FaOw==
X-Gm-Message-State: AOAM533n2syblPEUZxf2qyxWajnPlZPwz+ampZNqePXDBHSDuPDt99vA
        /z3UZQjg+k3Oo6OXwSMj6Wo=
X-Google-Smtp-Source: ABdhPJxF7WRTH91+grSYbdLGDVqIewqkNzr24oHgWEldJHMXBWjDkmeDVbLXQegbzmWgzb0cLotDMw==
X-Received: by 2002:ac8:5194:: with SMTP id c20mr10526537qtn.68.1629487085489;
        Fri, 20 Aug 2021 12:18:05 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id o6sm3603869qkp.111.2021.08.20.12.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:18:05 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v8 13/14] dt-bindings: iio: afe: add bindings for temperature-sense-rtd
Date:   Fri, 20 Aug 2021 15:17:13 -0400
Message-Id: <20210820191714.69898-14-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20210820191714.69898-1-liambeguin@gmail.com>
References: <20210820191714.69898-1-liambeguin@gmail.com>
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
2.32.0.452.g940fe202adcb

