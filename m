Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CF91E1164
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 17:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391100AbgEYPNt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 11:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390911AbgEYPNt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 11:13:49 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB82C061A0E;
        Mon, 25 May 2020 08:13:47 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i68so13973069qtb.5;
        Mon, 25 May 2020 08:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ONUvX5nfhwjam7it4NTQUc8WRuAIpoShkHVzxyWlR1Q=;
        b=SB8c3hIz52rTP5Bjs6HVmw7oqPBecGfl3+hgPAwD6hbTJ8BEASDakrKZLPmIrFCKDV
         /shysHxitLQ2WEcsOcgS+6c7kzmNuIrtAbW7h9B2P+HenuAMeVaSrivVu1vUK1lZq4+B
         uBZ9Mn6XhTGI+Ddqxcqb+pxKDsITzc4MWQRM+hMKnuGvr+lL+kkDQ1HJNbJwiHwOdRWb
         SIemIqHzQ/5ZvO/ANHOVjp87RstRH/S90oJ5RJqk9d36TdXOv0yT463dIo6dWOyZIlj7
         l9ak0F/u6/xahcdPu9DpVhHk9cXkk1oe2z5tWwY0HGf11L/2jDJeYd9sBEYwxzvMadSq
         d1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ONUvX5nfhwjam7it4NTQUc8WRuAIpoShkHVzxyWlR1Q=;
        b=CZCMktbCPe1qTAWfYdz6EtQi/HuvJED8EWU6oC39FfL5FEa1NsEIMj7ZvvY7DsMNtL
         AWLJfDGtNZZkMeO6M0fD7li7YfbnEroVmaMXzzPSUKkZHgz2/SVbtudmjfg9jacfDkiL
         ru6aZamgKkEFdcRTNTRp5GmAWfU0Mx/vhCrRO7JdmIK92h3YQ2sFCXLpeq0UvFLUbp+Z
         LJMLa1cPN6VgxP8L6dn5Ow69r7fZZcOBK5tXp/4o4/ffHmG7Df6UVSrdcU3iNHslrjaw
         m3M/fZenUThXL87VYWF8YeBxnOS3SnFTF2mrKk4dH+xgrjBv9vjhq3dhbux0JoLccXWA
         jiXA==
X-Gm-Message-State: AOAM533abVfolYkLXw0YeibDcME2GrR9ZvPHBr9vebTKf9vDC1xBerRc
        J7XL1NtU9kTKIiPWxRiQv83mFu6mDHM=
X-Google-Smtp-Source: ABdhPJw/DXeQ6+lok+kYQFpo2WpjKPnnnlWzcGZMUHSB5ci4aEENUGDhbFvPKD279sNm6Ro4+M2XoA==
X-Received: by 2002:ac8:5253:: with SMTP id y19mr6200880qtn.291.1590419625291;
        Mon, 25 May 2020 08:13:45 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id m59sm15161709qtd.46.2020.05.25.08.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 08:13:44 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v6 2/5] dt-bindings: iio: magnetometer: ak8975: convert format to yaml, add maintainer
Date:   Mon, 25 May 2020 17:10:36 +0200
Message-Id: <20200525151117.32540-3-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525151117.32540-1-jonathan.albrieux@gmail.com>
References: <20200525151117.32540-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Converts documentation from txt format to yaml.

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
---
 .../bindings/iio/magnetometer/ak8975.txt      | 37 ---------
 .../iio/magnetometer/asahi-kasei,ak8975.yaml  | 78 +++++++++++++++++++
 2 files changed, 78 insertions(+), 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
deleted file mode 100644
index 0576b9df0bf2..000000000000
--- a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-* AsahiKASEI AK8975 magnetometer sensor
-
-Required properties:
-
-  - compatible : should be "asahi-kasei,ak8975".
-  - reg : the I2C address of the magnetometer.
-
-Optional properties:
-
-  - gpios : AK8975 has a "Data ready" pin (DRDY) which informs that data
-      is ready to be read and is possible to listen on it. If used,
-      this should be active high. Prefer interrupt over this.
-
-  - interrupts : interrupt for DRDY pin. Triggered on rising edge.
-
-  - vdd-supply: an optional regulator that needs to be on to provide VDD.
-
-  - mount-matrix: an optional 3x3 mounting rotation matrix.
-
-Example:
-
-ak8975@c {
-        compatible = "asahi-kasei,ak8975";
-        reg = <0x0c>;
-        interrupt-parent = <&gpio6>;
-        interrupts = <15 IRQ_TYPE_EDGE_RISING>;
-        vdd-supply = <&ldo_3v3_gnss>;
-        mount-matrix = "-0.984807753012208",  /* x0 */
-                       "0",                   /* y0 */
-                       "-0.173648177666930",  /* z0 */
-                       "0",                   /* x1 */
-                       "-1",                  /* y1 */
-                       "0",                   /* z1 */
-                       "-0.173648177666930",  /* x2 */
-                       "0",                   /* y2 */
-                       "0.984807753012208";   /* z2 */
-};
diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
new file mode 100644
index 000000000000..a603659d5fa5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/asahi-kasei,ak8975.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AsahiKASEI AK8975 magnetometer sensor
+
+maintainers:
+  - Jonathan Albrieux <jonathan.albrieux@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: asahi-kasei,ak8975
+      - const: asahi-kasei,ak8963
+      - const: asahi-kasei,ak09911
+      - const: asahi-kasei,ak09912
+      - const: ak8975
+        deprecated: true
+      - const: ak8963
+        deprecated: true
+      - const: ak09911
+        deprecated: true
+      - const: ak09912
+        deprecated: true
+
+  reg:
+    maxItems: 1
+    description: the I2C address of the magnetometer.
+
+  gpios:
+    description: |
+      AK8975 has a "Data ready" pin (DRDY) which informs that data
+      is ready to be read and is possible to listen on it. If used,
+      this should be active high. Prefer interrupt over this.
+
+  interrupts:
+    maxItems: 1
+    description: interrupt for DRDY pin. Triggered on rising edge.
+
+  vdd-supply:
+    maxItems: 1
+    description: |
+      an optional regulator that needs to be on to provide VDD power to
+      the sensor.
+
+  mount-matrix:
+    description: an optional 3x3 mounting rotation matrix.
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@c {
+            compatible = "asahi-kasei,ak8975";
+            reg = <0x0c>;
+            interrupt-parent = <&gpio6>;
+            interrupts = <15 IRQ_TYPE_EDGE_RISING>;
+            vdd-supply = <&ldo_3v3_gnss>;
+            mount-matrix = "-0.984807753012208",  /* x0 */
+                           "0",                   /* y0 */
+                           "-0.173648177666930",  /* z0 */
+                           "0",                   /* x1 */
+                           "-1",                  /* y1 */
+                           "0",                   /* z1 */
+                           "-0.173648177666930",  /* x2 */
+                           "0",                   /* y2 */
+                           "0.984807753012208";   /* z2 */
+        };
+    };
-- 
2.17.1

