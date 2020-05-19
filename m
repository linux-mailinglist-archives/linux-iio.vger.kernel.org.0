Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3C91D968B
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 14:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbgESMo1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 08:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgESMo0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 08:44:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608AAC08C5C0;
        Tue, 19 May 2020 05:44:26 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l18so15753381wrn.6;
        Tue, 19 May 2020 05:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UuE4oeDec9qAyVLiH4N3OcfTsRxRxFlH0npfYHPrt4k=;
        b=q7Bo0+s9nI4igCOHnkCwb3/zmKf12UlzXFRLoFul8bwBURBO+Ww4b5SG9kghNv8R5L
         6R1nMnEqhuMLAQhRvxeaYLG/hw+61CyfitZNyNONEPsEq5TO9B2wC+eQepBGN1948/K3
         eWT2AWswdXkDNE73Hr8OWouk2uQX+TvKy2uPwnFoKXJ5oek4qL1CMu8eyNocwhI0RaJX
         MXj6Va667RlHCYjUmniBOTgIdBfwq1h8z1UthiyOzPpBpsW2riXXOpMB2OQKBnftRxVs
         7UyOesvrMn+hoW9EI2K/EUJ98mFlJGu6m2U5hdviRJuwynpOfczohadulnrKNgCwuqXF
         QbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UuE4oeDec9qAyVLiH4N3OcfTsRxRxFlH0npfYHPrt4k=;
        b=KXul0WnKk58CJdHM9iTMV5PbFxBj3bkyZiLRQbxBgcziVV2Hy14eSW7DHx9IlRUKsJ
         5qi/B2bgAPHUfNB/k3hltye37Y/NvpQCzpVKvzPxVgk12XhYoNIRB6y4eCvbdHy4iy4o
         +E3qS4QOkdrTs/VntWBCppRt21mLijX7Z1vFT9nlgUknepY1vNee/kcc9ajsYATbTZao
         3sLflKY3A3NnuPETzYG3UpDHpL1SE6utIrGmy8dcOmHfxsNv54is7C+Of0KPP2dj+7Dc
         dCfzAfUJLk0L2Xf6mf5bBSgRzP6L2cOKHybAPIJFGmW9bjqSUVR3wk/DpXy/nEFUnLGC
         tOTQ==
X-Gm-Message-State: AOAM533+gXHlEiclSxsUrubOR2E0SDkdxelyKHLFHenvwysBTuFcUrCO
        kex3sunCejW2FHehjAovQzt8adA+19655w==
X-Google-Smtp-Source: ABdhPJw4Yho/CE6NxkMeZduHovxUmApdpUSgBaaZYQ48k+d/YkBDMkDAA8o1VYnGvoDeR1InX8807Q==
X-Received: by 2002:a05:6000:1009:: with SMTP id a9mr27638997wrx.403.1589892264209;
        Tue, 19 May 2020 05:44:24 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id b12sm3953870wmj.0.2020.05.19.05.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 05:44:23 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
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
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 1/4] dt-bindings: iio: magnetometer: ak8975: convert txt format to yaml
Date:   Tue, 19 May 2020 14:43:51 +0200
Message-Id: <20200519124402.26076-2-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519124402.26076-1-jonathan.albrieux@gmail.com>
References: <20200519124402.26076-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Converts documentation from txt format to yaml.

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
---
 .../bindings/iio/magnetometer/ak8975.txt      | 30 ---------
 .../bindings/iio/magnetometer/ak8975.yaml     | 66 +++++++++++++++++++
 2 files changed, 66 insertions(+), 30 deletions(-)
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
index 000000000000..86e3efa693a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/ak8975.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AsahiKASEI AK8975 magnetometer sensor
+
+maintainers:
+  - can't find a mantainer, author is Laxman Dewangan <ldewangan@nvidia.com>
+
+properties:
+  compatible:
+    enum:
+      - "asahi-kasei,ak8975"
+      - "ak8975"
+      - "asahi-kasei,ak8963"
+      - "ak8963"
+      - "asahi-kasei,ak09911"
+      - "ak09911"
+      - "asahi-kasei,ak09912"
+      - "ak09912"
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
+    i2c@78b7000 {
+        reg = <0x78b6000 0x600>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ak8975@c {
+            compatible = "asahi-kasei,ak8975";
+            reg = <0x0c>;
+            gpios = <&gpj0 7 0>;
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

