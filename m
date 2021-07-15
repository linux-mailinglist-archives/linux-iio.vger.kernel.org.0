Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36773C9648
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 05:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbhGODPu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 23:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbhGODPl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 23:15:41 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96461C061764;
        Wed, 14 Jul 2021 20:12:47 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id i4so2148081qvq.10;
        Wed, 14 Jul 2021 20:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aE1V8QRfi8n6sF30lMvTx95RKdAsIa59F0QLZHJ2zOc=;
        b=m0qFAw1m0kNwdNacHFNTF36k2HELiH8XJ81F8hZMnBvE0tR7vpIbe4pkRLhtVUuc4C
         QsuMbYCpXTCt20+yduDxtsb6nCKF1O5e+xu9OBgPR5WIGtzFsGKJ5td9I9T2YeD74suq
         F4g6zU0+1n2NdSEV4xJh+3PL0liOs3mSSkh2BCloqtCoQ0Ks9aXKYv9xf0YFoiIX5PE2
         i5qkbIK1zOjet3p1e/1GbqchhsnHV/JLSGODIUu72dKpWZLjwJGTWvnJVzpnVaw9d+fm
         /Wmc9niXw+M5SX9ypa4rt/dQyB5RQzl92bZt/nuLFWIyt//0AROZA6sOWo/ILP792Yqt
         ILng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aE1V8QRfi8n6sF30lMvTx95RKdAsIa59F0QLZHJ2zOc=;
        b=KQsCDcMEggbE9gPQjgmZ2Ds+i5H61J0jMjcXmyu5zIYcpO4WswPQjWTK8t55dc8VWs
         M/aimTo6aY4fwQQE5XwnbKsk8um/O3Z+2k4cvJjJiS2i+HN+W1tupyX7R+kyvVR3EZox
         HcqLMWmC7I7kyj89hYQ3PJu7sz0V5pBsekInhPom3cq99yfjGjMT/fQNlH/lf30hY46I
         e+PZ8YcvDO/EOJcOA0OHmOa+8VJz6f0b7ILM3Rwi9GDBfYj1W8/4aYTYHxTYZBYCCG7b
         yYzJ4A/t0g9TSXJku7c+q/pGvPG7OG5d4P1m7aKcKFXGpaEEce1UfkGKv6iG9l97JZ9g
         UZNg==
X-Gm-Message-State: AOAM533v33B1EL0xMaHk62w3dVS3SX86CW4napim4IbqCMcTcUY8FDjl
        mCRgCmUFV3rtx3R7f6qPRd4=
X-Google-Smtp-Source: ABdhPJzqjXQ0AVrEApOwNga/whINVfmKLmbLmX3gNSLkmbXvS9XTMyqE7+miZ/AQ7v5MOeF2A3+Lbw==
X-Received: by 2002:a0c:ea31:: with SMTP id t17mr1753088qvp.17.1626318766735;
        Wed, 14 Jul 2021 20:12:46 -0700 (PDT)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id t125sm1932847qkf.41.2021.07.14.20.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 20:12:46 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v5 10/10] dt-bindings: iio: afe: add bindings for temperature transducers
Date:   Wed, 14 Jul 2021 23:12:15 -0400
Message-Id: <20210715031215.1534938-11-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210715031215.1534938-1-liambeguin@gmail.com>
References: <20210715031215.1534938-1-liambeguin@gmail.com>
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
---
 .../iio/afe/temperature-transducer.yaml       | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml

diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
new file mode 100644
index 000000000000..41411514aee0
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
+  - Liam Beguin <lvb@xiphos.com>
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

