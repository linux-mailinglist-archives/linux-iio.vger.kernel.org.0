Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5B13BDB1D
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jul 2021 18:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhGFQMn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jul 2021 12:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhGFQMl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jul 2021 12:12:41 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66903C0613E6;
        Tue,  6 Jul 2021 09:09:59 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id cz7so6424129qvb.9;
        Tue, 06 Jul 2021 09:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=38gNgVCGdXWK7a3Ll4EpO6MNFOAWFuNGKoxsxeutofU=;
        b=KUu3/z23XigRBfcZ+IG20t/DAhg0dnUkIbXzoXl11zTfE4nt6shBqdJ5f2WEarPqer
         flnEp6Bjq0asBMhO+fj4OJGh9oGKttFCVfEOfejmW1CQ4fmdvdTOxnTwBpsp9n5X962h
         pTWXMwjBbDwiy/xBgPithW4Suv79Tb990FCxL/awwzfhZRvB/xD4ZSA0EU6n+HJOb1zf
         kNMP0lk1102zSS763t+/eXaxzpUEXKSJWhXKHsuVvj7d0oNpe2P6Kb0rz7Tlj5XUj5Ip
         9aF8oN0CEzTzmXFwUILi0YCGpHKBxFdgmHaJftPT1B1KlpS1q0PPt+1bP2/2fQPj+noh
         jECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=38gNgVCGdXWK7a3Ll4EpO6MNFOAWFuNGKoxsxeutofU=;
        b=dpAWTJ8jo7GU/8+fTXoLgnR8RpM7b7Y4ebterLQpS0NThVfimEx7aAjx6G9rtavOc6
         FO/kWizyTU/nfr0iWCnzymZVdMroTq+XxSSTw5lE8xq+HdsDDpst2VLV/gAmsP9Z0h/t
         njiD8tcrlVqdDwuoMGhuIbKsOtePVrO2oePak2TB6eWhDtmsXFwAky7LZPXLGi7BTQ0F
         GWuYFllYLFl11YiiKCph3g2UUH66QbPus8Zd4Aw4Sv82RamgdEM+Nab3mrla+vwpHAPX
         pW3f9r10Pb/fPklRbQmdv3hOzxxXXyByMuOe6UThboufBBDMkDYqbmTN1YqUeFytZP3H
         65dw==
X-Gm-Message-State: AOAM532h4iqpioNczy7QKi/7n7r3nhpZJmel0JdbEGoftURjvwlDw909
        cjq6J2HkE5w2RQIgU7gpP0g=
X-Google-Smtp-Source: ABdhPJw6ckwglMmg611576TJqIy8AEw6bxIX32H6R+mdPkS41MgGAMvON2hkDgX4YecMarFFiScslQ==
X-Received: by 2002:ad4:5012:: with SMTP id s18mr19056714qvo.42.1625587798632;
        Tue, 06 Jul 2021 09:09:58 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id n64sm6995371qkd.79.2021.07.06.09.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 09:09:58 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v4 10/10] dt-bindings: iio: afe: add bindings for temperature transducers
Date:   Tue,  6 Jul 2021 12:09:42 -0400
Message-Id: <20210706160942.3181474-11-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210706160942.3181474-1-liambeguin@gmail.com>
References: <20210706160942.3181474-1-liambeguin@gmail.com>
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
 .../iio/afe/temperature-transducer.yaml       | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml

diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
new file mode 100644
index 000000000000..b5a4fbfe75e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
@@ -0,0 +1,111 @@
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
+      Temperature offset. The default is <0>.
+      This offset is commonly used to convert from Kelvins to degrees Celsius.
+      In that case, sense-offset-millicelsius would be set to <(-273150)>.
+
+  sense-resistor-ohms:
+    description: |
+      The sense resistor. Defaults to <1>.
+      Set sense-resistor-ohms to <1> when using a temperature to voltage
+      transducer.
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

