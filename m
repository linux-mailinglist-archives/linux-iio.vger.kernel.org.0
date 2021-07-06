Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA8E3BDB1A
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jul 2021 18:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhGFQMl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jul 2021 12:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhGFQMj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jul 2021 12:12:39 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74548C0613E5;
        Tue,  6 Jul 2021 09:09:58 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id x6so10016490qvx.4;
        Tue, 06 Jul 2021 09:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KwXBVtI+9gXL1KcaxYC+sUfxFdgMKyzQHOJfsem+2V8=;
        b=I8GBmY85Up2c4hSp6F9B5hB8T0RYCf47vzNFSk+1HjbFpIzoe9+x3ctM6fPA4Ktlu2
         xC2UEVnRZ38ZWu/RuF2Az24msT6YCcc2LjX0QZWWNdbIQowzNLlic9eHf/D0sASsn3XZ
         pdTAICHzxzBeu/OXFPIrBMUJf/BPSamXcvh2+YBvv1LEzgVPVc6ZjuCD1phYzGq6yJ58
         vMClu8eefO7/Y9cFl3S5CtpJAIGv8VEMj8AxnQp4meKzA8DC9VtXKWsTOHjYjGbkljQf
         ATd8PF6YZ4+qMjZ4Q4QMSuD6j4rjWS/9pyXvYJ1eQLfnqo56Y07UntvvGQlvurltuQTR
         9iQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KwXBVtI+9gXL1KcaxYC+sUfxFdgMKyzQHOJfsem+2V8=;
        b=dDqvAeyR/yJZKgodpmkXQR5xSzr4yLBFGQ5s7ofC7wLh1oFMxcwtJgEuiQecNE/YP0
         0/tz/cFxwkwU3a1YjkUtDTGeYjGlgAxER8ooJZ+YMdwXET686OA6Cihy+naSgniYbvt3
         drFMHr72n+c5UnSE0fb/z69r6tnz0BevNDxPJF+VokbNExE0QwCbpTRo5z60tpiRBV+u
         Lj70ZBHTE+mEbca4EztrQucFUekWe7WmM1btcPZtcu41RSqyrMwaNeVhf/vAvzBW8riI
         2OwHLVlkB08Dp9EBry3kwPOI/fL+CgE3/5f5rTNCJaUB6bMDvPM44NAdmu9Auzli32XG
         75FA==
X-Gm-Message-State: AOAM533msVg8WBaTm/KK/49wiH+Idy7XiIyetHDTJva7FOMAIZtvAXFC
        gbaaENRNKEHInohv+JCdgaA=
X-Google-Smtp-Source: ABdhPJycgHPndGqm6OYTLv+aqFlKWV3QgxzD1RYcUdhjYYE7tYorAGAyuruuG+unrHKjtmY6ZHx7tw==
X-Received: by 2002:a0c:cd10:: with SMTP id b16mr18496070qvm.21.1625587797721;
        Tue, 06 Jul 2021 09:09:57 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id n64sm6995371qkd.79.2021.07.06.09.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 09:09:57 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v4 09/10] dt-bindings: iio: afe: add bindings for temperature-sense-rtd
Date:   Tue,  6 Jul 2021 12:09:41 -0400
Message-Id: <20210706160942.3181474-10-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210706160942.3181474-1-liambeguin@gmail.com>
References: <20210706160942.3181474-1-liambeguin@gmail.com>
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
---
 .../iio/afe/temperature-sense-rtd.yaml        | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml

diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
new file mode 100644
index 000000000000..11a3d4bd3065
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
+  - Liam Beguin <lvb@xiphos.com>
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

