Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0003219D65C
	for <lists+linux-iio@lfdr.de>; Fri,  3 Apr 2020 14:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390922AbgDCMIe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Apr 2020 08:08:34 -0400
Received: from mx-out2.startmail.com ([145.131.90.155]:49367 "EHLO
        mx-out2.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390889AbgDCMIe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Apr 2020 08:08:34 -0400
From:   Alexandru Lazar <alazar@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1585915712;
        bh=7fnFSy+sEmwQpklZYylFDBkgyCMloNhpV7NmOpPWkAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uDXfxIm/BMlf5nIaoNHekluSo8u7ayM33BpNLEBh1Clv6+OhrwpzwgdzqXFTmybEf
         eR2iXv+SpemyHkQd/mMeYRG7ZAL1toT7asKu0gao8LtQ/IFOIAYJ/+FdB6s3zsCWTu
         4RINv6ecZfdypzzvY8V74kboYCftXFtREbkchMB0gXR2mUyS2+4bqRnSgcQqX1q/Jm
         49K6vXHTn2FCe2Lr68Qx1BbeUN5j0ON2XfT5Jkps6+VihdSrmtLPNY/kSWuylHTJR4
         8rvRvBgLV33qwDHc7RM64vwHAAYGrbeFTnXHvJ8sG1PxEfH08gJo6waIFyhFTEI+to
         PxWJG1/urJ7sQ==
To:     linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, Alexandru Lazar <alazar@startmail.com>
Subject: [PATCH v7 1/2] dt-bindings: iio: adc: Add MAX1241 bindings
Date:   Fri,  3 Apr 2020 15:13:22 +0300
Message-Id: <20200403121323.1742-2-alazar@startmail.com>
In-Reply-To: <20200403121323.1742-1-alazar@startmail.com>
References: <20200403121323.1742-1-alazar@startmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device-tree bindings documentation for the MAX1241 device driver.

Signed-off-by: Alexandru Lazar <alazar@startmail.com>
---
 .../bindings/iio/adc/maxim,max1241.yaml       | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
new file mode 100644
index 000000000000..7da9e4153ac1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2020 Alexandru Lazar
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/maxim,max1241.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX1241 12-bit, single-channel analog to digital converter
+
+maintainers:
+  - Alexandru Lazar <alazar@startmail.com>
+
+description: |
+  Bindings for the max1241 12-bit, single-channel ADC device. Datasheet
+  can be found at:
+    https://datasheets.maximintegrated.com/en/ds/MAX1240-MAX1241.pdf
+
+properties:
+  compatible:
+    enum:
+      - maxim,max1241
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description:
+      Device tree identifier of the regulator that powers the ADC.
+
+  vref-supply:
+    description:
+      Device tree identifier of the regulator that provides the external
+      reference voltage.
+    maxItems: 1
+
+  shutdown-gpios:
+    description:
+      GPIO spec for the GPIO pin connected to the ADC's /SHDN pin. If
+      specified, the /SHDN pin will be asserted between conversions,
+      thus enabling power-down mode.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vref-supply
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+        adc@0 {
+            compatible = "maxim,max1241";
+            reg = <0>;
+            vdd-supply = <&adc_vdd>;
+            vref-supply = <&adc_vref>;
+            spi-max-frequency = <1000000>;
+            shutdown-gpios = <&gpio 26 1>;
+        };
+    };
-- 
2.20.1

