Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AE33B5443
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jun 2021 18:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhF0QdK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Jun 2021 12:33:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231243AbhF0QdK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Jun 2021 12:33:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0534619AD;
        Sun, 27 Jun 2021 16:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624811446;
        bh=o6mqFqi+WqcWA3TRryRMSDXpaSBg5G6W9BVGpW6lxXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mO0XnykA3KX/4yqBpTuRFrhjNBKZnf7/VAYhTXt5cCTibu+DpvpCm9CajqbZqTPDm
         ts7TeM1f1Bk67iN1QjDdUZsxLyv4/LKdSrH/RIyqY0aDSHQKQRE4HA3HkbzDIcEEim
         sghS2iEAsc823g5RDn/9CJUs1o2cKrFByRZmXFDmcolRSCGly1/GvEeOTUvGD/cM8D
         VmUxCbCGCOxVR4tX7NUmlvAEq3QB/ie/powMO97KZ9og+zf5RebbsFPi0Us+dROIr7
         ZmxffHqYWXIHjkCQZoFj5Fh7YdEsqa0v3TU+zYxJijIHImtQx3aV6KHOsPMkeTBYWc
         2gEEJ0AUlSrnw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/15] dt-bindings: iio: dac: ad5446: Add missing binding document
Date:   Sun, 27 Jun 2021 17:32:34 +0100
Message-Id: <20210627163244.1090296-6-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210627163244.1090296-1-jic23@kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Binding is a little stricter than the Linux driver.

It requires vcc-supply to be present for devices that don't have
an internal reference, whereas the driver just prints a message and
carries on.  Given this means that it is impossible to establish
a scaling of the output channel, let us make it required in the binding
schema.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 .../bindings/iio/dac/adi,ad5446.yaml          | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
new file mode 100644
index 000000000000..e0a0def20c8c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5446.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Single channel DACs similar to the AD5446
+
+maintainers:
+  - Lars-Peter Clausen <lars@metafoo.de>
+  - Jonathan Cameron <jic23@kernel.org>
+
+properties:
+  compatible:
+    oneOf:
+      - description: I2C devices
+        enum:
+          - adi,ad5602
+          - adi,ad5612
+          - adi,ad5622
+      - description: SPI devices
+        enum:
+          - adi,ad5300
+          - adi,ad5310
+          - adi,ad5320
+          - adi,ad5444
+          - adi,ad5446
+          - adi,ad5450
+          - adi,ad5451
+          - adi,ad5452
+          - adi,ad5453
+          - adi,ad5512a
+          - adi,ad5541a
+          - adi,ad5542a
+          - adi,ad5543
+          - adi,ad5553
+          - adi,ad5600
+          - adi,ad5601
+          - adi,ad5611
+          - adi,ad5621
+          - adi,ad5641
+          - adi,ad5620-2500
+          - adi,ad5620-1250
+          - adi,ad5640-2500
+          - adi,ad5640-1250
+          - adi,ad5660-2500
+          - adi,ad5660-1250
+          - adi,ad5662
+          - ti,dac081s101
+          - ti,dac101s101
+          - ti,dac121s101
+          - ti,dac7512
+
+  reg:
+    maxItems: 1
+
+  vcc-supply: true
+
+  spi-max-frequency: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+# Ensure the scaling can be established for devices with no internal reference.
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - adi,ad5620-2500
+                - adi,ad5620-1250
+                - adi,ad5640-2500
+                - adi,ad5640-1250
+                - adi,ad5660-2500
+                - adi,ad5660-1250
+    then:
+      required:
+        - vcc-supply
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        dac@0 {
+            reg = <0>;
+            compatible = "adi,ad5620-2500";
+        };
+    };
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        dac@42 {
+            reg = <0x42>;
+            compatible = "adi,ad5602";
+            vcc-supply = <&vcc_dac>;
+        };
+    };
+...
-- 
2.32.0

