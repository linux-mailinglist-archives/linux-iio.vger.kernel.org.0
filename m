Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29D14B391E
	for <lists+linux-iio@lfdr.de>; Sun, 13 Feb 2022 03:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiBMC6E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Feb 2022 21:58:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbiBMC6D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Feb 2022 21:58:03 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0419460A8A;
        Sat, 12 Feb 2022 18:57:55 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id de39so2081823qkb.13;
        Sat, 12 Feb 2022 18:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QJ4snz0cur4JK5tD6GVF0n87Yz4vTpK9iTHizeDj3iE=;
        b=lbKvlU++Cq7nnOV+kVFGRozFMarRJ2iWkaGWPDqPDswsVVpLrspBYNTte4XljdqxG3
         hyRwTKuF281EXu6BKNJFUglFL0iKVuNcT6YLdDcvndAgQ306iIFnRBeUgPlaHDeYe3IU
         gX1rk5QByxDTrUhFhcHeThTRTYgtMDmxdoP/Q2j0CKsXgZD7QRMqNPP1MBvJkqxY88ve
         XewXKYztkINm457uMhtufBDfD/5LdKt3UgcfF5VIgLO9k5UcgsDfqqinleJWwz0+9ID8
         eebnGY7dX0PDKl6E5trozXtin3rle+qJCy6r+f6PdI9eHlhhZJtmxxk7mC6Lg/rZVhdn
         XMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QJ4snz0cur4JK5tD6GVF0n87Yz4vTpK9iTHizeDj3iE=;
        b=3cAYwmY9sYw81+u0efMLAXgqgRyltlYbtgOzK/IY0pPXZDawmfo5EGvQuJKznYW7fY
         eE86VZVYBITd8iqi/+PTad8omssTmcXu3iGzTizd5Ol4U7ANzyyyTTjAEaffIN9Z37Fv
         LuG4vLsygcQfjSxP4eQAuJtY4fXVG+6Y0zsRRjv2tLAkIUlr9k5divSa92vqyFexRO7B
         PAyZqMPLDJpgocgS6Tv313BTqp1Ho6f3Np63l0JSc/y8Xl/thWB2dTKr22Ct3OXRpHZO
         3Sen8zdkxSDIGoWi62hcCL4wOFU/6ACPHZ1nBPXYgumDLBUdcqAe8IC0xw3DZq8tpNoG
         QFQA==
X-Gm-Message-State: AOAM5337LUmVjXgkYQvsL6AttHGcdHafDyxLEN9cfDOsnC/+0I1/H0Xq
        /ldlufn+a2Rvw4PdtDqminQ=
X-Google-Smtp-Source: ABdhPJy3YJp21eaSkvum9GHIhiIybHHgJTRN8AUGcCQ5Kr4O7rPrMYEZWcdNLnWKdqCn9lsbtS+vTw==
X-Received: by 2002:a37:6c06:: with SMTP id h6mr4109949qkc.627.1644721074166;
        Sat, 12 Feb 2022 18:57:54 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id y15sm14551106qkp.22.2022.02.12.18.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 18:57:53 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v15 09/10] dt-bindings: iio: afe: add bindings for temperature-sense-rtd
Date:   Sat, 12 Feb 2022 21:57:38 -0500
Message-Id: <20220213025739.2561834-10-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
In-Reply-To: <20220213025739.2561834-1-liambeguin@gmail.com>
References: <20220213025739.2561834-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

An ADC is often used to measure other quantities indirectly. This
binding describe one case, the measurement of a temperature through the
voltage across an RTD resistor such as a PT1000.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Peter Rosin <peda@axentia.se>
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
2.35.1.4.g5d01301f2b86

