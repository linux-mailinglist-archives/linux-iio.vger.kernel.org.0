Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBD41D7A03
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 15:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgERNfy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 09:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgERNfy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 09:35:54 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4D3C061A0C;
        Mon, 18 May 2020 06:35:53 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h17so11869818wrc.8;
        Mon, 18 May 2020 06:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g2sU/s3ZSgjmLzLMit0zw8xym5bMpksqrVvGb7EuMnM=;
        b=eMjfb8BKGAZ1UmdHEm8O/cSaVyhnsH/i8E9JMXEmCfcyGud9ZXHioRN7RNFmlryNtV
         p5UV1Mupf+Qwo1Ifq3mKuIX1IRSaJ2CW78Sdy32L7+Uw1Vme7b/rdbPEJWg52q7dpZXa
         zsENe+BhhE4wSNT9kqQ6Z/LXG5Zh2WTcEOD70t/WrqlhdENVtO993DbLnt9hbTY7Syy3
         YLu/JpeqQB86hJ6qJp5gzUBYTwvbJ9HzGFHzSHSaFHEmFrXaTKEJ59rnbAqZjavO+dDQ
         U7mpevRGmDB7fCcW3kEFyo57eZDZK2+n4GnV3XxNQS5dRLOJpr2aIENhZnLdMNvxC1gd
         KavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g2sU/s3ZSgjmLzLMit0zw8xym5bMpksqrVvGb7EuMnM=;
        b=kRSSt5urvYF6nEkGiM9Gm3fY3lDJ/ZQaFk5c8UJW7H9xphTHX7APtSN+Pw/NNwh063
         C9/wHWt4tYAD2QdB8oH5Xca9qtJYi/bsZ3TY4s/9qrJ+c/KBHFko0zi4BUgOaZNPG97t
         UJZq5+hyyG5TTqUJqX38c0D6x0jx5pAVj0pdfD0zLOXfzEkPK67u3gAM8ZhfoCmfzYdy
         PMyf9Hdg9vYwJnfWiWMEgDi5audjR29CZeyvIrFbslbngZ2+c3MjIIHgPCzyxzhIRLFO
         q1UKl7P51S3+k463GVQy1YPZAuQepw+pWsalQtfUWaZxWAc27LfIpjuRgWK47Zwa5BGk
         Zmdw==
X-Gm-Message-State: AOAM530zf8QCSx7y4XG1U84RzEDK0HPs0idVYy/GlrUrViKbP6dw3fRq
        ubMQmc+9hvJVcGbvA7ZCFeIXS4naAuc=
X-Google-Smtp-Source: ABdhPJzNYw5WdYgdi00rZYY4RzTlzfhOnaEdN+KwkegHscxy/wtw06vVgm1+CrAPBJ8YcK37bCsbFQ==
X-Received: by 2002:adf:df12:: with SMTP id y18mr19055474wrl.94.1589808952095;
        Mon, 18 May 2020 06:35:52 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id l19sm17086772wmj.14.2020.05.18.06.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 06:35:51 -0700 (PDT)
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
Subject: [PATCH 1/4] dt-bindings: iio: imu: bmi160: convert txt format to yaml
Date:   Mon, 18 May 2020 15:33:45 +0200
Message-Id: <20200518133358.18978-2-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518133358.18978-1-jonathan.albrieux@gmail.com>
References: <20200518133358.18978-1-jonathan.albrieux@gmail.com>
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

