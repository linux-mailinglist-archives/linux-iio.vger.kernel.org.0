Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7451D7A17
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 15:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgERNhT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 09:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgERNhS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 09:37:18 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFF8C061A0C;
        Mon, 18 May 2020 06:37:17 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u188so10445336wmu.1;
        Mon, 18 May 2020 06:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NelqWN4DVZYy525kVaNQdwoOLRrWijttmX4yjSOk4TQ=;
        b=etf5MMPEn4z8AHZdpZ7sc+hcohmCVEJmLOXvtHFdAQFE1DuQrKgV5tkYkDlizGkJH8
         oSWBTSovYT1ZRQZL1XTpnEd5TYPgwAhiK6k+wCG8rE0/BVDsnkIRnKlIWSq684etNstH
         6ty+ESXpcgBPHAd1kmC4d7zB3Rsv4YHp0LI9aIZw2kaoNh04fJBfxZXM6d2yt+bKADDJ
         CLkjF3u8DL7CS32wzg/aEOP9jg9rad1JEBgxvWb3dL3uH/6AW3PeeulcDd8gt3HiLLsV
         2zw48I51FhKv1PEAN5qeCeUQYZfur9qJCU+TwtvvfA6JPCUDjN9NrpaNpyclm/Nh+kOQ
         WOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NelqWN4DVZYy525kVaNQdwoOLRrWijttmX4yjSOk4TQ=;
        b=gPsPt3kl2HFcOWsT8aUvji0DKnvVWUnuSr5Gyc0+jttr/HKzq4x++J9DAYB7CgWJMx
         Un2vU6uQ9LyCy+uEoQMDW4fLwJagfb5Nq+rVZOwiT3EuyH1hpPhCIhEFdEZb9hlQ/0/+
         u3DRpgGslcLD0nvItU/2pKgAoGg5rlnkyF6RyjkveDLAmjxaqRvA1RReOsWdCUjgvV2U
         vsl8GboJOjWTeRxVa4WdAWtzEA/26VE6eqREWyj/Azhh2CX/xPPrQDFthL5iPTKCOCh2
         eIlfY++Yd9xv9PNmeMZDOhUezFoWP9ApsHJGOIOPpUSHM9lp9GqhzCM8/8z9azl9O3MW
         pa9g==
X-Gm-Message-State: AOAM532fNCuHhRt5agPRnSBu5H9fVpaTAS9nNb5HsTT43Ynt2B2OdMuV
        qRbo1LvGvyrIOdi3d5tvQbBg0NGDmgVAcA==
X-Google-Smtp-Source: ABdhPJxiuDzQMURyYKYTaTg35peXm3A8P8ECn083yX9dd5j0bhQ3NDoJ+IZRcXYmr1B5Aq9N19Z3tw==
X-Received: by 2002:a1c:98c9:: with SMTP id a192mr19357450wme.48.1589809034962;
        Mon, 18 May 2020 06:37:14 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id o26sm17054328wro.83.2020.05.18.06.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 06:37:14 -0700 (PDT)
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
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/3] dt-bindings: iio: magnetometer: ak8975: convert txt format to yaml
Date:   Mon, 18 May 2020 15:36:36 +0200
Message-Id: <20200518133645.19127-2-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518133645.19127-1-jonathan.albrieux@gmail.com>
References: <20200518133645.19127-1-jonathan.albrieux@gmail.com>
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

