Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB36D1D915A
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 09:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgESHv6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 03:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgESHv5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 03:51:57 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534C6C061A0C;
        Tue, 19 May 2020 00:51:56 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u188so2307952wmu.1;
        Tue, 19 May 2020 00:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g2sU/s3ZSgjmLzLMit0zw8xym5bMpksqrVvGb7EuMnM=;
        b=afDBTXdVkIaS0Jh4uTRhUhaav27upBE5ZgSJ8qVeFA5EmHbOelxEJW1raIen3J9Jja
         6A8Db77ULrxBx6nRzJKpYZgOHHEsZdiOAlNY5nMejusIX9Pz7heZhdMxNHsnOTf7c2mp
         iEUKPFj5E4U1JWGdKNFacRqlewyyAh3uncTsJc6zM4TKvmTuJPsjJ6bxUmK4cwE18q42
         9fUTyBp/jFv3LLwRk9ftSbuKRUK/XtWX+DNVVXjjmyW5kqUh/SnhBJmwX4h4J023z0/v
         NiM1ltErl2etOCambA5cVaRAb8b3L5ivoECwXMYimPgJEg1M0wQzk8HkVRPHVsxgbf00
         TQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g2sU/s3ZSgjmLzLMit0zw8xym5bMpksqrVvGb7EuMnM=;
        b=MR/nqjgVNy2SiFvOWFABUMp61iXdjketGZFAiNqoCaz2n5fAkazFRoWOWgD4lmXXXO
         u6eEAv53VZKLw275NoHkBSfxFehvf/iACWRWzxjA12NH2xmiJNO3SkT3I2BZDUdrexQc
         2h61me8bZYgrTs0SlCjmkvdgQ7a0LjXjAgzY9VZdKuJLuPagoCIeXc3LEHnjuXPy7+5O
         PNtDqoACXScR3cBe0ZTPzR/RuSXspbpqzpBFH3RN0gY20CDHWGVg2U1o92goQ3uICjOb
         friQVScXos70RuJKGOtCvdpTT5NKigbS69aWiPb2QozU26xyWz6CR6A6YeCbHjFixC6A
         Eabw==
X-Gm-Message-State: AOAM532FP5azNVSaWJdsOnTciwz0OCAqvUAqD3JvimKDsbB+J1ZG3t3Z
        JHNTu3uUdOmQ4gjEfoXeHTbc5hL0ecs=
X-Google-Smtp-Source: ABdhPJwTzc1wazYnIQwgBVGvzyYXxFBP+pNKLJ/5+5Z3ROPzayYdlv33R1Lm5OW9qfTy7EgFqyOuog==
X-Received: by 2002:a1c:2e46:: with SMTP id u67mr3789884wmu.156.1589874714499;
        Tue, 19 May 2020 00:51:54 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id w18sm20019697wro.33.2020.05.19.00.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 00:51:53 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: iio: imu: bmi160: convert txt format to yaml
Date:   Tue, 19 May 2020 09:50:57 +0200
Message-Id: <20200519075111.6356-2-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
References: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Converts documentation from txt format to yaml 

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
---
 .../devicetree/bindings/iio/imu/bmi160.txt    | 37 --------
 .../devicetree/bindings/iio/imu/bmi160.yaml   | 84 +++++++++++++++++++
 2 files changed, 84 insertions(+), 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.txt
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.yaml

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
diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.yaml b/Documentation/devicetree/bindings/iio/imu/bmi160.yaml
new file mode 100644
index 000000000000..6b464ce5ed0b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/bmi160.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/bmi160.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch BMI160
+
+maintainers:
+  - can't find a mantainer, author is Daniel Baluta <daniel.baluta@intel.com>
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
+    description: the I2C address or SPI chip select number of the sensor
+
+  spi-max-frequency:
+    maxItems: 1
+    description: set maximum clock frequency (required only for SPI)
+
+  interrupts:
+    maxItems: 1
+    description: interrupt mapping for IRQ
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 1
+    items:
+      enum:
+        - INT1
+        - INT2
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
+    i2c@78b7000 {
+        reg = <0x78b6000 0x600>;
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
+  - |
+    // Example for SPI
+    spi@78b7000 {
+        reg = <0x78b7000 0x600>,
+              <0x7884000 0x23000>;
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

