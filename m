Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19972188EDF
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 21:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgCQUVs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 16:21:48 -0400
Received: from mx-out1.startmail.com ([145.131.90.139]:51429 "EHLO
        mx-out1.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgCQUVs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 16:21:48 -0400
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Mar 2020 16:21:47 EDT
From:   Alexandru Lazar <alazar@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1584476030;
        bh=vGBkf+Y2lmq/6qzf1u8avZbI0A7lT5WeE7030PlcaOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FEMWitdK48NeDtE+2yBuGTtZI76PmxkfM0qqGNODBquYJweJmAjx45UZ5kZBft9+M
         Mk41F2Ttz/ClmGH6ZyLIm2cNpZGVGW9ZIC1zgKZejc+0SiDtcGwGrQW/qiVaHdeoZW
         sS7NgkhN7YDcz1geFIRZQ6ljBoSSIB5n4kp6Z51ACz3ML/7hr5NT30d792n13JrG15
         BJtuqzVI6E1Fcwe+4JIpF73JoWWdeGg0TxdmNUyn3FV9aZY4oo3/TZ4oHlWakzeg3w
         4J4WS54IVoH/X2fOSn93W51QxZfvMmxq7NG+zhEC2SC7Tz/MwrKqdV4D5PUo3jsNaG
         gxsfPyTWMTOXA==
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        Alexandru Lazar <alazar@startmail.com>
Subject: [PATCH 2/2] dt-bindings: iio: adc: Add MAX1241 device tree bindings in documentation
Date:   Tue, 17 Mar 2020 22:17:10 +0200
Message-Id: <20200317201710.23180-3-alazar@startmail.com>
In-Reply-To: <20200317201710.23180-1-alazar@startmail.com>
References: <20200317201710.23180-1-alazar@startmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device-tree bindings documentation for the MAX1241 device driver.

Signed-off-by: Alexandru Lazar <alazar@startmail.com>
---
 .../bindings/iio/adc/maxim,max1241.yaml       | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
new file mode 100644
index 000000000000..abb90d382067
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7780.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX1241 12-bit, single-channel analog to digital converter
+
+maintainers:
+  - Ioan-Alexandru Lazar <alazar@startmail.com>
+
+description: |
+  Bindings for the max1241 12-bit, single-channel ADC device. This
+  driver supports voltage reading and can optionally be configured for
+  power-down mode operation. The datasheet can be found at:
+    https://datasheets.maximintegrated.com/en/ds/MAX1240-MAX1241.pdf
+
+properties:
+  compatible:
+    enum:
+      -maxim,max1241
+
+  reg:
+    maxItems: 1
+
+  vref-supply:
+    description:
+      Device tree identifier of the regulator that provides the external
+      reference voltage.
+    maxItems: 1
+
+  spi-max-frequency:
+    maxItems: 1
+
+  shdn-gpios:
+    description:
+      GPIO spec for the GPIO pin connected to the ADC's /SHDN pin. If
+      specified, the /SHDN pin will be asserted between conversions,
+      thus enabling power-down mode.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vref-supply
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi0 {
+        adc@0 {
+            compatible = "maxim,max1241";
+            reg = <0>;
+            vref-supply = <&vdd_3v3_reg>;
+            spi-max-frequency = <1000000>;
+            shdn-gpios = <&gpio 26 1>;
+        };
+    };
+
+
-- 
2.25.1

