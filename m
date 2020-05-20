Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7611DAC2E
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 09:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgETHby (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 03:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgETHbx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 03:31:53 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36D2C061A0E;
        Wed, 20 May 2020 00:31:53 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id p12so1773445qtn.13;
        Wed, 20 May 2020 00:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WKBpDTD43/1JUhixc7t1FITqiPa/wHci3Gf2DjHkB/4=;
        b=tDEvENcDMc0bDElhZiirOvkFTyUoHAQnShMpwos6MP8+NbYBH42x7ZotDklvsrr5+d
         lFZytsEf8oDgcVERmZLrQNxwnNKnStCurzlsJ5uph2tcIw7okpkzKDAoVYyEBZCHEzqb
         ei6KT2zHF4MVavG8qQU6yvUE/Tuy7OaYP1tddmu9nOQ+KpO+15OiNboz8zdCfCymbBLt
         Oz/1R+B0T2EnAAN7F4sYWucYx4DXOCLnCheEKssWiy2FjgP4glira8O1/lAv9OPPSz+g
         qIAknz1J1kHg6kigY83rXGRYRhUDnQwILaYk1tOqiecIQFUDtoElEujC93nHB3mhHTGV
         8NUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WKBpDTD43/1JUhixc7t1FITqiPa/wHci3Gf2DjHkB/4=;
        b=CtMbqylc1CIdqN7zy99HmXmkKcEyv96eOOgqRsKGHiKZjPgxoJuqF+owoRBow0vlEd
         /N0W+uSiN4nmV1UkMMNULteC6DpbbkbDb+BHJ//rB2ReBiCztTSqf5C8bVIgnlkKLlS/
         h1BAA7Kg+VJ8Lgm6MtM0YHb/mEmtsgIQrIOAe40u6O5bIUSnVUv/ldhbE35w64hKOvRL
         nN5yeYTdK6+BhBk7aW8exJvIoVyPVyGnMiNlTgAarLwSXXEZn5hXe+QqQZh0iJcWB2Qp
         RFoHAFAE5q2BKu2AsBbdbGF0u3T/5NzM/t24vYevUK3br+8TCv4P6/ECg7dg2AEZkfbT
         ddZA==
X-Gm-Message-State: AOAM532DepkoRhUJ9BiJbBJPe0PNDTjCtPtcOLyLygZpdP2FSHI/xTmw
        jiQV9BQZm1eUYhK/CMQOhvE8dvOKpUmeIQ==
X-Google-Smtp-Source: ABdhPJz9bXRj6o6XnePg1lqWh2aKqTxkMxwclqg1x+/MkVY4Pvazt2btlCZ+ldXRwHa/+DfXjnSUlQ==
X-Received: by 2002:ac8:2a3a:: with SMTP id k55mr3817837qtk.294.1589959912199;
        Wed, 20 May 2020 00:31:52 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id w9sm1702540qtn.29.2020.05.20.00.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 00:31:51 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: iio: magnetometer: ak8975: convert txt format to yaml
Date:   Wed, 20 May 2020 09:31:13 +0200
Message-Id: <20200520073125.30808-2-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520073125.30808-1-jonathan.albrieux@gmail.com>
References: <20200520073125.30808-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Converts documentation from txt format to yaml.

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
---
 .../bindings/iio/magnetometer/ak8975.txt      | 30 --------
 .../bindings/iio/magnetometer/ak8975.yaml     | 71 +++++++++++++++++++
 2 files changed, 71 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
deleted file mode 100644
index aa67ceb0d4e0..000000000000
--- a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* AsahiKASEI AK8975 magnetometer sensor
-
-Required properties:
-
-  - compatible : should be "asahi-kasei,ak8975"
-  - reg : the I2C address of the magnetometer
-
-Optional properties:
-
-  - gpios : should be device tree identifier of the magnetometer DRDY pin
-  - vdd-supply: an optional regulator that needs to be on to provide VDD
-  - mount-matrix: an optional 3x3 mounting rotation matrix
-
-Example:
-
-ak8975@c {
-        compatible = "asahi-kasei,ak8975";
-        reg = <0x0c>;
-        gpios = <&gpj0 7 0>;
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
diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
new file mode 100644
index 000000000000..9d5b1e6908d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/ak8975.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AsahiKASEI AK8975 magnetometer sensor
+
+maintainers:
+  - can't find a maintainer, author is Laxman Dewangan <ldewangan@nvidia.com>
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
+    description: the I2C address of the magnetometer
+
+  gpios:
+    description: should be device tree identifier of the magnetometer DRDY pin
+
+  vdd-supply:
+    maxItems: 1
+    description: |
+      an optional regulator that needs to be on to provide VDD power to
+      the sensor.
+
+  mount-matrix:
+    description: an optional 3x3 mounting rotation matrix
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c@78b7000 {
+        reg = <0x78b6000 0x600>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@c {
+            compatible = "asahi-kasei,ak8975";
+            reg = <0x0c>;
+            gpios = <&gpj0 7 GPIO_ACTIVE_HIGH>;
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

