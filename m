Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A933B8B92
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jul 2021 03:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238367AbhGABDi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Jun 2021 21:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238314AbhGABD0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jun 2021 21:03:26 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DB7C0617AF;
        Wed, 30 Jun 2021 18:00:56 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 19so4418336qky.13;
        Wed, 30 Jun 2021 18:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uu5hiFy+Aqn229khLLdQXnhG+QuibP+/oNp4fvlu80s=;
        b=Agrx/33QED8t5YMdAFlBRvEKSuezKgi1c4h3+T7tSuOS7GeQic+51sqTznYG40Nqfz
         XpVVxEFDmsQPgMyiYhvQflBxjuG2im4DzOl7ivvJA7yKznAJ80wy5rvVAzdaHf9wHWLA
         dB0Oi0PnHyoQYTmBfQssKeg1ubJ6nHjiiBGdMD7hKBNc1dgBvjOag9ymR5cZ27zLNnFx
         n1HDfwNvo8dzO51pSbGs7xDRFb11M4fvqn4YMM72jDZxxf3rHEX8Zhc7BKRZ1BKO0k71
         W6ZIe6XpUDIGj6z7EmgjxaAxoyUiP7tXhx+zDCPC2yDJFI0PCYToSkjx0/+4pm0ab+m3
         ncFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uu5hiFy+Aqn229khLLdQXnhG+QuibP+/oNp4fvlu80s=;
        b=aOKkl07pxZMA7Fdrqv2mtMStISBquLa35sTATAy5ZP3Yq6HYkZM+DfYm3aQ8EgQIby
         htLWlLKegpko1BUYWMxc+3shkyzAkO/5Y2pJkaadobUt7PSRq3n0ZYyOnWNNU0/17ugo
         GAcY08mg3EjSKHmKEQGxZE0RsO7qzUXh+q7o8OQKaCjAAM61ps+OkIZUUeVCh9YX5qrG
         j8uN5dbsnEfNpeXqiiR1VE8TzCTVXGs3bMdTZlb/ueie9MBde+DENR0kxLSP92enk4yi
         WsZw+bRH1Ohe0yadhpNKBKcZaitOZA9b7BQFdx7joxKNZj8a5MhPNUM6us5eOBjW7Jm3
         kEmw==
X-Gm-Message-State: AOAM530nQzcpc75Zg/xeOmhGf8mWvhXWdwZGulgpjMwgeiZrsYQ6QwtO
        YpZMbTvA9mdwGAoO1UZFXAU=
X-Google-Smtp-Source: ABdhPJxD7NrbMr1RerXra44zha5hJ8pA4lYyChEgFHQ+tx49AU6pHMD1C1XuPHP5rn30HDqGjObwrQ==
X-Received: by 2002:ae9:f305:: with SMTP id p5mr22002272qkg.68.1625101256014;
        Wed, 30 Jun 2021 18:00:56 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id l127sm14087782qkc.64.2021.06.30.18.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 18:00:55 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v3 10/10] dt-bindings: iio: afe: add bindings for temperature transducers
Date:   Wed, 30 Jun 2021 21:00:34 -0400
Message-Id: <20210701010034.303088-11-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210701010034.303088-1-liambeguin@gmail.com>
References: <20210701010034.303088-1-liambeguin@gmail.com>
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
 MAINTAINERS                                   |   1 +
 2 files changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml

diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
new file mode 100644
index 000000000000..d16c0ade2271
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
+    const: 1
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
+        #io-channel-cells = <1>;
+        io-channels = <&temp_adc 3>;
+
+        sense-offset-millicelsius = <(-273150)>; /* Kelvin to degrees Celsius */
+        sense-resistor-ohms = <8060>;
+        alpha-ppm-per-celsius = <1>; /* 1 uA/K */
+    };
+  - |
+    znq_tmp: temperature-sensor-1 {
+        compatible = "temperature-transducer";
+        #io-channel-cells = <1>;
+        io-channels = <&temp_adc 2>;
+
+        sense-offset-millicelsius = <(-273150)>; /* Kelvin to degrees Celsius */
+        alpha-ppm-per-celsius = <4000>; /* 4 mV/K */
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index ed80e671a16a..e9e11c3ea4e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8903,6 +8903,7 @@ R:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
+F:	Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
 
 IKANOS/ADI EAGLE ADSL USB DRIVER
 M:	Matthieu Castet <castet.matthieu@free.fr>
-- 
2.30.1.489.g328c10930387

