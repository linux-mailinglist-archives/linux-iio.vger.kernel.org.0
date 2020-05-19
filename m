Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E12C1D9073
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 08:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgESG6f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 02:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgESG6f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 02:58:35 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D7CC05BD09;
        Mon, 18 May 2020 23:58:35 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id f13so1831501wmc.5;
        Mon, 18 May 2020 23:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NelqWN4DVZYy525kVaNQdwoOLRrWijttmX4yjSOk4TQ=;
        b=pJZeFjDDmF0Hwc489EH9MdK0NI1hdcSSzTItrlZpAAMqIB6AePhn6kkk/0SjKc3r6X
         uS/OWa0zSebw54mQlf7dpK9Ro+CV6rVpYTi3uhfgLZInFJKp4o2OZ9EEDPqAxr7SUns3
         GsA8FDMhsx02mSPu3aoiYhKwl754yDy069/vcQQOtcNXY/K1ilBVSCTFCXPjE5XUMwSW
         MFvRm6bVon/HVlXmr5+csIbtkK33DkGbeUxVkZ3nqTVEagDW2OFFO+svZCf5nvPLo3gD
         ygfDNBDySjSRwCubFDg0qeuv4zAt/Lyrw5nG055k/oVSljPnCVfWaUUSlxiQ+Hg9vsqo
         pxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NelqWN4DVZYy525kVaNQdwoOLRrWijttmX4yjSOk4TQ=;
        b=XQesakZpDolI1CV5f7Inwf/5aGRj2S+OPWduyz6uynBdXZZrrgmdvdnfY0RLn8pozi
         lfspeUiWwXC9u2ZyzleRrU/fe6lxSDsvw3u0LxQkYNYHYbwfYlfraGHeywsjZwvCWENZ
         sntRv9BZGoaOOTsq6KnsKtBHv8I6vdVeQ6Ex3D/IPInsAyMiMm8EbE/EKh3NnmojjpY7
         2brCsIjg9jy+trpf4d2fT57j1/FfYqbr+6R9uOZVWV0XEGEcfDvmagzVjgsPUbGAv5CF
         7T89geD56wWqDyoJKQJlcBbRE3FDaca2grCemzHji5vlktnq4fnB6F2xdfI4FwG7zxZl
         U2mw==
X-Gm-Message-State: AOAM530ciJbF0ApVYbZiVfQCdP8C8QqLDADurgwKM6UXUw27ruXPEC3T
        f8Y9t+HL2886gxbik+qkI/kFCyzE8S78Eg==
X-Google-Smtp-Source: ABdhPJxZ37RZkNrYqL5WauyNN8HMIZLHyRzsIGBVssL0crdhUU1geEPsmsiDcC8bRlLmjW8AcdtLtg==
X-Received: by 2002:a05:600c:21c1:: with SMTP id x1mr3501921wmj.173.1589871513384;
        Mon, 18 May 2020 23:58:33 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id p7sm2597550wmc.24.2020.05.18.23.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 23:58:32 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: iio: magnetometer: ak8975: convert txt format to yaml
Date:   Tue, 19 May 2020 08:57:41 +0200
Message-Id: <20200519065749.4624-2-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519065749.4624-1-jonathan.albrieux@gmail.com>
References: <20200519065749.4624-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Converts documentation from txt format to yaml

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

