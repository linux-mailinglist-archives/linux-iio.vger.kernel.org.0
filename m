Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E52E1DBE45
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 21:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgETTr5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 15:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgETTr5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 15:47:57 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0502DC061A0E;
        Wed, 20 May 2020 12:47:57 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i68so3605758qtb.5;
        Wed, 20 May 2020 12:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WUruQWSj4RCaoTshJ50aKQ9F0pxhc7c3vLi9K6KM9jU=;
        b=o2Z2LRskwA9Y54wL0tqiwnZtrTAzW+GaqE7/ELryIbQai52qWOruJoQFWcewMCcV3y
         mFsHkzOfvpq4CvzKj0kyszYbsKpbEHCHxog7Pew6rb4O8VP4btAz80aj9jWrntKd/3Xt
         8OshqIBxroSd0Lvy78Yj5by3xJWnZT8Lrm8JaQfce1l5f5WbxqwSVHLgKRPn17mclE7g
         8djbk7xjk5I0r15BoJa+UIHYaDQgcmQsOtonjDlzyauB4yrqiEgjv6sALON6tN98APJR
         siC9jbdDM0QUtfOkdmDqD6sDBzTtZK8KFkbqX/qfesQ8hppiQeaT/CFxWG/xCvYS/mOr
         1lAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WUruQWSj4RCaoTshJ50aKQ9F0pxhc7c3vLi9K6KM9jU=;
        b=r0J2yRkwr1ci1j8Gm25E/ApnPZ0Sy93NzJFoft9MmCV009hkJeDyPImuFRNjot5PGg
         5V3S4o9Pad8sfjonZTn/cJ+cWww7veKhBF6gNh9Gak2QEK+hTDTCSltjQv1LBbWfTRnT
         G1jxuAi1Ky9Xvmf2Sqr6QtE/o46HrTOR5ATtvZGXEO280PAugQpIdj/U8zmur1Tnux5i
         zl6aSWrDYGXAaTsQDpFDC9TfHSz1JqXhtxYfntnF67GUNgk36qmTzCskwOOYzizcWXx1
         sGxk20K4971vj9sX2xpfxyYctlRyQZWgbJEhQReFmWEvbNu2x6CghGMaM/TevvCZnWMO
         h+dQ==
X-Gm-Message-State: AOAM530z+zO8Xc04wtyLzBGFzudojcPPnppmYk9JqDNyDyMuAWDLCsv/
        YOYB049GKg/iVf5iUcKiTLbrLizY0nLPFQ==
X-Google-Smtp-Source: ABdhPJyOOzfjqe7HgDpXu2n2z1XdA8+Vk/4FzjNS/ZTm/br5GPh/9p2k0unuaMSSqmdpDodPfrTQMA==
X-Received: by 2002:ac8:a02:: with SMTP id b2mr6559002qti.95.1590004075580;
        Wed, 20 May 2020 12:47:55 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id m33sm3158419qte.17.2020.05.20.12.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 12:47:54 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, daniel.baluta@nxp.com,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 1/5] dt-bindings: iio: imu: bmi160: convert txt format to yaml
Date:   Wed, 20 May 2020 21:46:40 +0200
Message-Id: <20200520194656.16218-2-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520194656.16218-1-jonathan.albrieux@gmail.com>
References: <20200520194656.16218-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Converts documentation from txt format to yaml.

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
---
 .../devicetree/bindings/iio/imu/bmi160.txt    | 37 ---------
 .../bindings/iio/imu/bosch,bmi160.yaml        | 76 +++++++++++++++++++
 2 files changed, 76 insertions(+), 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.txt
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.txt b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
deleted file mode 100644
index 900c169de00f..000000000000
--- a/Documentation/devicetree/bindings/iio/imu/bmi160.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-Bosch BMI160 - Inertial Measurement Unit with Accelerometer, Gyroscope
-and externally connectable Magnetometer
-
-https://www.bosch-sensortec.com/bst/products/all_products/bmi160
-
-Required properties:
- - compatible : should be "bosch,bmi160"
- - reg : the I2C address or SPI chip select number of the sensor
- - spi-max-frequency : set maximum clock frequency (only for SPI)
-
-Optional properties:
- - interrupts : interrupt mapping for IRQ
- - interrupt-names : set to "INT1" if INT1 pin should be used as interrupt
-   input, set to "INT2" if INT2 pin should be used instead
- - drive-open-drain : set if the specified interrupt pin should be configured as
-   open drain. If not set, defaults to push-pull.
-
-Examples:
-
-bmi160@68 {
-	compatible = "bosch,bmi160";
-	reg = <0x68>;
-
-	interrupt-parent = <&gpio4>;
-	interrupts = <12 IRQ_TYPE_EDGE_RISING>;
-	interrupt-names = "INT1";
-};
-
-bmi160@0 {
-	compatible = "bosch,bmi160";
-	reg = <0>;
-	spi-max-frequency = <10000000>;
-
-	interrupt-parent = <&gpio2>;
-	interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
-	interrupt-names = "INT2";
-};
diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
new file mode 100644
index 000000000000..46cb4fde1165
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/bosch,bmi160.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch BMI160
+
+maintainers:
+  - Daniel Baluta <daniel.baluta@nxp.com> (?)
+
+description: |
+  Inertial Measurement Unit with Accelerometer, Gyroscope and externally
+  connectable Magnetometer
+  https://www.bosch-sensortec.com/bst/products/all_products/bmi160
+
+properties:
+  compatible:
+    const: bosch,bmi160
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    enum:
+      - INT1
+      - INT2
+    description: |
+      set to "INT1" if INT1 pin should be used as interrupt input, set
+      to "INT2" if INT2 pin should be used instead
+
+  drive-open-drain:
+    description: |
+      set if the specified interrupt pin should be configured as
+      open drain. If not set, defaults to push-pull.
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    // Example for I2C
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        bmi160@68 {
+                compatible = "bosch,bmi160";
+                reg = <0x68>;
+                interrupt-parent = <&gpio4>;
+                interrupts = <12 1>;
+                interrupt-names = "INT1";
+        };
+    };
+  - |
+    // Example for SPI
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        bmi160@0 {
+                compatible = "bosch,bmi160";
+                reg = <0>;
+                spi-max-frequency = <10000000>;
+                interrupt-parent = <&gpio2>;
+                interrupts = <12 1>;
+                interrupt-names = "INT2";
+        };
+    };
-- 
2.17.1

