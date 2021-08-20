Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199DA3F348B
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 21:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238784AbhHTTS4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 15:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238834AbhHTTSq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 15:18:46 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42652C061764;
        Fri, 20 Aug 2021 12:18:07 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id y144so11943241qkb.6;
        Fri, 20 Aug 2021 12:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ULLabupwpKZ9q0uzoJvIF5vhkAHSbV+6NawrmKl86jU=;
        b=vOxq6guuOESasXLTFsciWuL/8IsC33E6WqMuvMmKpi8j/CaQyQnWvBpiqi73GSmsv7
         VLWh8TZ+ZsW79yNPESMEP7aPe6SeLHI5E1g8IDHflKuzxTySRWU80BK+FPWKHgoyaYj2
         khtzh29vBCSxG6cWvXdVoGx1ms0Rp2z+WbkejEjXlh8zu1C839hQUy0OdBa8FZi4n/Mc
         YVIERs0X5xARMytVbUb+qwK2VzRL12ao3MiU3uKitobZeTE/8dDRQL2Tr5A+K4zecNKb
         3UEMjbe2JcfI0QBoGPnX+hGIJK9/Mot7kmwzmUd8VGtS60iSt/DyfS0sZxI9bwYtLQ61
         ngmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ULLabupwpKZ9q0uzoJvIF5vhkAHSbV+6NawrmKl86jU=;
        b=mpooq+lOQm6ypyRj41+JyfLHlwZq/ktdkXsgqurhdr/ZSqcWDcsKXb4g/mYzQTF8OV
         bcUdGOxjulDIxYw7+YFua4iRWAlnW5SidgjE0sgBxE/OO6nbn/oV8Znfqx/mVlVPq6Qq
         Bx06bhROMClWk6U4WdbozbBPsZaPbYNIvihM5W5FqG9n75t6FvE8I2tfzms4LqHQv43l
         mWc6FQd46Q0EnnZHDxz3VLR3qQlXgbQWho5Pbn6LmdDDDl4iR4XfinXX5sudwfTtTKcZ
         EpfkW6PrI9qQgXPnlsSQB7diZyE0DfzEP5GKAkcU+p3aRyL1TEdCnSl7ZiJUbeVVmVxc
         LsEg==
X-Gm-Message-State: AOAM533OkemHeagR6JyjUK4xzqtgvPObsx+WQZeU2rDtf0hflfacxOLg
        rXOG6Xzy60+cKI40FYbxwlI=
X-Google-Smtp-Source: ABdhPJznSPycGbedrlQKmPvJfkRYfeDeksvk/8oXo4aQfgJe/E0SVUmAp5ijmgjXWe9ArQuDXFQ0cg==
X-Received: by 2002:a37:6c43:: with SMTP id h64mr10502944qkc.362.1629487086476;
        Fri, 20 Aug 2021 12:18:06 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id o6sm3603869qkp.111.2021.08.20.12.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:18:06 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v8 14/14] dt-bindings: iio: afe: add bindings for temperature transducers
Date:   Fri, 20 Aug 2021 15:17:14 -0400
Message-Id: <20210820191714.69898-15-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20210820191714.69898-1-liambeguin@gmail.com>
References: <20210820191714.69898-1-liambeguin@gmail.com>
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
2.32.0.452.g940fe202adcb

