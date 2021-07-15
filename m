Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B43D3C9644
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 05:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbhGODPn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 23:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbhGODPk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 23:15:40 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86524C06175F;
        Wed, 14 Jul 2021 20:12:46 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id k3so3527361qtq.7;
        Wed, 14 Jul 2021 20:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F9vLD4GPyVlyvHJVO/zwQSRJTRKTzhxUyD5QpwjJ88Q=;
        b=BcHcrgBA9jlXJxHDrhGi3xf1uNZUgp218E0NjIAHAA8H2fYiuwQpoyOcUwqGG0wYfx
         yhbwXAF6coyVu4Zhn948cg0Xjqn44eiAgVx41xoSxYlvUFcD1bqcbdNgSlJvK1pbRXWz
         vtls9BdFE5NkIF6Eg5BjYzR0g5Jc+HGzZp+9ZBTEzCbwvJsegiLZco3YdIhMvhxFzNpb
         xmB/rcJYr+rbsVnUlcCqSxi1bTV47DkccPkq0HoHHYVL/tucuxy2+QM39tnn1blv/LZO
         NI+OYdV2LwTJyNmplC5GaBmuR1MHpMZcCjORw90i5o/BzMu5FHv5MpXoWcGGH6CpGJCo
         P3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F9vLD4GPyVlyvHJVO/zwQSRJTRKTzhxUyD5QpwjJ88Q=;
        b=FH1ssBLB65+KouMr0HzT6Jx1F7m2WqaNu5jl0PDFcFKzG7BcMrSHkWP+Dctjz7tb0r
         C3hlOVkLWAoeONtW59pw8M673rqbYPsy4J0SprKy4mszRvlbT1ckSGVXBUD2jSXerhQB
         uNDF2AW9TwglkP/cf67QOlfphlVIzMhfHONwV3A4iXISNS3tA52lB7xDdbwtfKiGYbkb
         q2/KSGZ/tuBodKgEL3jEeGe7kUu9UQCgnJlJUd2vlu77uTJvvc3ToTJORj24BzJV4vGh
         jmjosr7aiAXBkNGjbx38Keb4qZHK1EuKIoHb3r3rNpjT+0AWC82rb3zHNkSt1S7tmLDF
         5NwQ==
X-Gm-Message-State: AOAM5334Wn7l/ABA4dqhr6/G0Yzbktz6C32x38jW+QoOwK0bA0uDb+gQ
        FAmL9ZX+sA2Qw9WAUPPzopo=
X-Google-Smtp-Source: ABdhPJxR2eb1fELMTVHNRvaUMDi0VjVTMTXZRpslXndzVJN5q+Yl8JPniWg1s92/dUuxCzkFeZxZfQ==
X-Received: by 2002:ac8:5704:: with SMTP id 4mr1688880qtw.306.1626318765765;
        Wed, 14 Jul 2021 20:12:45 -0700 (PDT)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id t125sm1932847qkf.41.2021.07.14.20.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 20:12:45 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v5 09/10] dt-bindings: iio: afe: add bindings for temperature-sense-rtd
Date:   Wed, 14 Jul 2021 23:12:14 -0400
Message-Id: <20210715031215.1534938-10-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210715031215.1534938-1-liambeguin@gmail.com>
References: <20210715031215.1534938-1-liambeguin@gmail.com>
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

