Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A429F3B8B8E
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jul 2021 03:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbhGABDh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Jun 2021 21:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238317AbhGABD0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jun 2021 21:03:26 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D242DC0617A8;
        Wed, 30 Jun 2021 18:00:55 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id f13so2985169qtb.6;
        Wed, 30 Jun 2021 18:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UuHr7m+N9MiuddW4ua5pFfmrMFxnaeCwG/Hr0n7vYAs=;
        b=Ht3rlYP4hKjOtlhb1rDlxaiWGVQJN5YExnDSZfiLiwYW2U9XBoolmpJOPXb9m3P3l6
         3u0He6Gc6U4yJVuPNIXTGg4z6DIJr+WmVFXypk1zxFCNPNCgbWhtMidZuSxqndiOVhAY
         MOH8xnoumgjVuh3RNo/tNWQUXKb8MUmQyXn4/5loEgmnp2BDivGZ9Mm5ByGa9qYZaXh7
         7JA84cM9RUVJAP4vAFm4+IbpatiDsKlpe3vsB7yTNEdwYZ0jwHHU7aAPnqIIZUWzAEwz
         IzWy0dxfSzF372rlx9NdBD8StgGJbQyiO/RoSmY4bnABKqGIKD9ZsqNTupXzgmJJB2ou
         SChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UuHr7m+N9MiuddW4ua5pFfmrMFxnaeCwG/Hr0n7vYAs=;
        b=aNz8cEqKl0lozhuL0j9FgRxLaUfEouUnSIbnu0xk+XeRh7Ac3ly1MutRfptYRUQmaR
         3XxwV23U2hG93wxbWAw0c8/ZPf6I1qICCyej3J1dyvnxGvyEf0ZzJvE+YcLHtuhd/7OG
         4idCWlvBY7ksMbQyoLlQStaPU55NqAtcUiYvNmbJGy4kPzkIEjbU2Ya8OZ8Z0TWyQDEJ
         n7YXCHkXH4VMbbBS9FHcTcvlWBUu+TCDnoZ54ivx3QBZzreIScYY84kuIf55qtlD2ofL
         /4UeTF7piPcn4+Xv1ETQQ2aZ6sm4msC9K2d2xiouPl85ckakaNde2ZlA2dcy4fT4PmS/
         PtEA==
X-Gm-Message-State: AOAM533WCr8xvWOk6nospaCGVlkGqDPvGV1rrsDM24mPRtL8M6eFdLVd
        pT8TR5wAEn2ZxNwrwCs8gnE=
X-Google-Smtp-Source: ABdhPJxoEsfZ6DQeMJhoyQf/hrbMEKvzWPFjQ3Od+PbcvBVZEze+pyUpIAhBLfaSpxuICie0Tq0p8w==
X-Received: by 2002:ac8:51c3:: with SMTP id d3mr19923467qtn.320.1625101255036;
        Wed, 30 Jun 2021 18:00:55 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id l127sm14087782qkc.64.2021.06.30.18.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 18:00:54 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v3 09/10] dt-bindings: iio: afe: add bindings for temperature-sense-rtd
Date:   Wed, 30 Jun 2021 21:00:33 -0400
Message-Id: <20210701010034.303088-10-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210701010034.303088-1-liambeguin@gmail.com>
References: <20210701010034.303088-1-liambeguin@gmail.com>
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
 MAINTAINERS                                   |   7 ++
 2 files changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml

diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
new file mode 100644
index 000000000000..e23e74e63ec5
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
+    const: 1
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
+        #io-channel-cells = <1>;
+        io-channels = <&temp_adc1 0>;
+
+        excitation-current-microamp = <1000>; /* i = U/R = 5 / 5000 */
+        alpha-ppm-per-celsius = <3908>;
+        r-naught-ohms = <1000>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 9bf553e53f0f..ed80e671a16a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8897,6 +8897,13 @@ F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
 F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
 F:	drivers/iio/afe/iio-rescale.c
 
+IIO UNIT CONVERTER (TEMPERATURE)
+M:	Liam Beguin <liambeguin@gmail.com>
+R:	Peter Rosin <peda@axentia.se>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
+
 IKANOS/ADI EAGLE ADSL USB DRIVER
 M:	Matthieu Castet <castet.matthieu@free.fr>
 M:	Stanislaw Gruszka <stf_xl@wp.pl>
-- 
2.30.1.489.g328c10930387

