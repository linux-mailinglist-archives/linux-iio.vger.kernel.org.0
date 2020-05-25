Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FAE1E12EE
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 18:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391174AbgEYQrw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 12:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391128AbgEYQrw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 12:47:52 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDF3C061A0E;
        Mon, 25 May 2020 09:47:50 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id v15so8257119qvr.8;
        Mon, 25 May 2020 09:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kYPOBvUz2cZfQlHaw++XU6nzT3LZCLQVWMfDnD7/6D0=;
        b=e5MDmmWiSAVy0jPTnVmv6jUtKzElCyhCVXrS8KLffM89ZlURNo+5k94jVRaUDOIZIC
         VnQOUoLtVFl+tWeGP3jjCv3ddXEPq+sY+JyI5G/CUfmFO2/d0B97X352lvqnQGN7q985
         GKOrLn6AJOJnYjgRZqrQuj4CzYiEvyilLg5xL77mJIVxxLeBVEs2o4TXdHrENmD9S2na
         i3sou5INi6tX5gXUx3QVQu/6YDo3jy9fx1wqf7CL3F31XGLF5clb80dgxtDEKE3mx9ay
         rNQhprDPEkua2dHchW3GF62Ipw6ntSKbVVG74xNBRVZTh+RR4F7OmdMKUngxeVMiMKlx
         PP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kYPOBvUz2cZfQlHaw++XU6nzT3LZCLQVWMfDnD7/6D0=;
        b=Gbswn+hYtTSzBFP3qUskochRpy1xeXWsNSa8oFezzmCVjAS5G0Q+e0CxzYhTOptDMj
         FFEydHs0lpthBQfi5o1qDrxPh8erjg4bc+t8AdHBCSXxkGjB3CBjGJ3FzEndfXM5aS2e
         IUoifCfUjohu0qLI0icsmSYu8/6yrnxpCj0Ev/Y/ydqL0HgDeU06l52xoBJrwpeKyeUh
         flJ5nMeH1mOaY251P50jmrqM4AuyGQR7/l7q/b8IqFVOtxgR3ipbPbHd3SU1msqkxB1+
         v3kTDGvErfZCvpkJJ1uIYJMGVwWemedIwcyUcXLlxsL/606EJmWFZfco+uyHDGfel5Ug
         N0ow==
X-Gm-Message-State: AOAM531rDL75Q9OYuxMaBTVWmT8Fk6QrGLwLO0Ii0/B9sLtwP2cNRvCF
        Lcf37HEvk0AMzqyh5AS3deq9v49c4hE=
X-Google-Smtp-Source: ABdhPJwXzWCFaanpmwp3aILi6QP/uEeXT1/PEY3iToe0bTQogx5UL2Kiz7M46BkF9gtJfb1ho3ZQmg==
X-Received: by 2002:a0c:b354:: with SMTP id a20mr16623609qvf.205.1590425269171;
        Mon, 25 May 2020 09:47:49 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id g5sm15559618qti.87.2020.05.25.09.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 09:47:48 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, daniel.baluta@gmail.com,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 1/5] dt-bindings: iio: imu: bmi160: convert format to yaml, add maintainer
Date:   Mon, 25 May 2020 18:46:00 +0200
Message-Id: <20200525164615.14962-2-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525164615.14962-1-jonathan.albrieux@gmail.com>
References: <20200525164615.14962-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Converts documentation from txt format to yaml.

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
---
 .../devicetree/bindings/iio/imu/bmi160.txt    | 37 ---------
 .../bindings/iio/imu/bosch,bmi160.yaml        | 75 +++++++++++++++++++
 2 files changed, 75 insertions(+), 37 deletions(-)
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
index 000000000000..0d0ef84e22b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/bosch,bmi160.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch BMI160
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        bmi160@68 {
+                compatible = "bosch,bmi160";
+                reg = <0x68>;
+                interrupt-parent = <&gpio4>;
+                interrupts = <12 IRQ_TYPE_EDGE_RISING>;
+                interrupt-names = "INT1";
+        };
+    };
+  - |
+    // Example for SPI
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        bmi160@0 {
+                compatible = "bosch,bmi160";
+                reg = <0>;
+                spi-max-frequency = <10000000>;
+                interrupt-parent = <&gpio2>;
+                interrupts = <12 IRQ_TYPE_EDGE_RISING>;
+                interrupt-names = "INT2";
+        };
+    };
-- 
2.17.1

