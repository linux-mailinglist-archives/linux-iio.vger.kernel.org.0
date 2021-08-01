Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28C83DCD67
	for <lists+linux-iio@lfdr.de>; Sun,  1 Aug 2021 21:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhHATke (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Aug 2021 15:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbhHATkc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Aug 2021 15:40:32 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18207C0613D3;
        Sun,  1 Aug 2021 12:40:24 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id k7so14726341qki.11;
        Sun, 01 Aug 2021 12:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ia7RMXcuDJun2fDwzVlIawa2qDQplWBzZcO/n2ULYNU=;
        b=XtG8c331aXAFHWjU41FzyHNp9YISwpzSfKqlNYD2aqjgdsPL2xntY/MmEFnIa4k5lh
         zXKl/KCPUKbzLJzqR1M05Rce+iQ0tTLH0Nnp6PO9qfIvIALQnhHngOmNSruDGQys5y6U
         5ZO3n6zx6FajqGj4gY5pOSH2TK6lqotwmbmRFAgVRYVy3sM0lPk7fcbLba5w5bOYQSPb
         gfqdxCKxP0AAptr8biDgCOs7nr9DS6lgR0hkXQ3nVIGfr3OD/FTGrxrm4aWYDBmV3AI7
         38AoB4jyW0CE9zWSFh0pZHWF+mDaxP8pu70oAfLeznmp5zte35Tg5BFYYvGvYqXlhuNx
         gSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ia7RMXcuDJun2fDwzVlIawa2qDQplWBzZcO/n2ULYNU=;
        b=sZz/Ej3yXs01NWL3gQ0lKhhxSBjFMd1L2cAgqyEAPFSKmCGiWAOfY6c/+p9jWhQB8h
         He481p/vgvXRL+FaLFyeNEJaNTEwZPJ+q3i6vzAiitXpKrXaiJfdd0BftMSIcgiStENN
         nczbFX1fSUOVU5a9Dr01BNlT1T7PysKTAnZLJ5s3Mt+8tIRZ41gYAltZNNr7cRqvMtT5
         Q4lbEH345r6BSCp2/pmg+Zoh17myEGY9wkEwj45vljbS1IwN/+JhwsDWN5xY163Zv7ax
         OTu32iILj1Cz/w2KnodsJomtvofr+zqplZH9zVtUsHSq8qF/dC1yAjAOj7ykc9xDPmN3
         O7oA==
X-Gm-Message-State: AOAM531s/ZH7icaN2WJ2jDAKW7HFgx10Gh6A2gEcypPXVwY2WVAM4OhX
        8xUJd0faMbGAO9lzN3ocJas=
X-Google-Smtp-Source: ABdhPJwMBD/Z/a/+l7yLRWBNjfN7HM5cTgL9pAOUnYTkEFZqfTpDnPzG+QaPKEIZxQjnnWFMSM40Ig==
X-Received: by 2002:a05:620a:6ac:: with SMTP id i12mr12763298qkh.198.1627846823318;
        Sun, 01 Aug 2021 12:40:23 -0700 (PDT)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id f10sm3621606qto.31.2021.08.01.12.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:40:22 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v7 13/13] dt-bindings: iio: afe: add bindings for temperature transducers
Date:   Sun,  1 Aug 2021 15:40:00 -0400
Message-Id: <20210801194000.3646303-14-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210801194000.3646303-1-liambeguin@gmail.com>
References: <20210801194000.3646303-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

An ADC is often used to measure other quantities indirectly.
This binding describe one case, the measurement of a temperature
through a temperature transducer (either voltage or current).

Signed-off-by: Liam Beguin <lvb@xiphos.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../iio/afe/temperature-transducer.yaml       | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml

diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
new file mode 100644
index 000000000000..cfbf5350db27
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/afe/temperature-transducer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Temperature Transducer
+
+maintainers:
+  - Liam Beguin <liambeguin@gmail.com>
+
+description: |
+  A temperature transducer is a device that converts a thermal quantity
+  into any other physical quantity. This binding applies to temperature to
+  voltage (like the LTC2997), and temperature to current (like the AD590)
+  linear transducers.
+  In both cases these are assumed to be connected to a voltage ADC.
+
+  When an io-channel measures the output voltage of a temperature analog front
+  end such as a temperature transducer, the interesting measurement is almost
+  always the corresponding temperature, not the voltage output. This binding
+  describes such a circuit.
+
+  The general transfer function here is (using SI units)
+    V(T) = Rsense * Isense(T)
+    T = (Isense(T) / alpha) + offset
+    T = 1 / (Rsense * alpha) * (V + offset * Rsense * alpha)
+
+  When using a temperature to voltage transducer, Rsense is set to 1.
+
+  The following circuits show a temperature to current and a temperature to
+  voltage transducer that can be used with this binding.
+
+           VCC
+          -----
+            |
+        +---+---+
+        | AD590 |                               VCC
+        +---+---+                              -----
+            |                                    |
+            V proportional to T             +----+----+
+            |                          D+ --+         |
+            +---- Vout                      | LTC2997 +--- Vout
+            |                          D- --+         |
+        +---+----+                          +---------+
+        | Rsense |                               |
+        +---+----+                             -----
+            |                                   GND
+          -----
+           GND
+
+properties:
+  compatible:
+    const: temperature-transducer
+
+  io-channels:
+    maxItems: 1
+    description: |
+      Channel node of a voltage io-channel.
+
+  '#io-channel-cells':
+    const: 0
+
+  sense-offset-millicelsius:
+    description: |
+      Temperature offset.
+      This offset is commonly used to convert from Kelvins to degrees Celsius.
+      In that case, sense-offset-millicelsius would be set to <(-273150)>.
+    default: 0
+
+  sense-resistor-ohms:
+    description: |
+      The sense resistor.
+      By default sense-resistor-ohms cancels out the resistor making the
+      circuit behave like a temperature transducer.
+    default: 1
+
+  alpha-ppm-per-celsius:
+    description: |
+      Sometimes referred to as output gain, slope, or temperature coefficient.
+
+      alpha is expressed in parts per million which can be micro-amps per
+      degrees Celsius or micro-volts per degrees Celsius. The is the main
+      characteristic of a temperature transducer and should be stated in the
+      datasheet.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - io-channels
+  - alpha-ppm-per-celsius
+
+examples:
+  - |
+    ad950: temperature-sensor-0 {
+        compatible = "temperature-transducer";
+        #io-channel-cells = <0>;
+        io-channels = <&temp_adc 3>;
+
+        sense-offset-millicelsius = <(-273150)>; /* Kelvin to degrees Celsius */
+        sense-resistor-ohms = <8060>;
+        alpha-ppm-per-celsius = <1>; /* 1 uA/K */
+    };
+  - |
+    znq_tmp: temperature-sensor-1 {
+        compatible = "temperature-transducer";
+        #io-channel-cells = <0>;
+        io-channels = <&temp_adc 2>;
+
+        sense-offset-millicelsius = <(-273150)>; /* Kelvin to degrees Celsius */
+        alpha-ppm-per-celsius = <4000>; /* 4 mV/K */
+    };
+...
-- 
2.30.1.489.g328c10930387

