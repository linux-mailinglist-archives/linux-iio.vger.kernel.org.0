Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76A0C18BC5F
	for <lists+linux-iio@lfdr.de>; Thu, 19 Mar 2020 17:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgCSQZS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 12:25:18 -0400
Received: from mx-out1.startmail.com ([145.131.90.139]:53285 "EHLO
        mx-out1.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgCSQZS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Mar 2020 12:25:18 -0400
From:   Alexandru Lazar <alazar@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1584635116;
        bh=XeWrEWWKkKuHxAE3Ufutfrlrgjivl1HEfR3mh9Il1og=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WBLKgWzaIUvA2WIS8hJd+xLGAkouvYuRStfGXlOJmYsgBDVXcbPqwQdYsYyqsYYL/
         OBxuotKU2q6gi865Hr4X2rWC6MgAwgh2PQmaqU9Ayk2J2KI4k9VGNYin56R5rjphub
         Kk9MpIt0Fe19Z9XzzkEvVR6x6eghJrbR3oGi97QmLSmnpYCrYCEcdfE0QjyOq41Ala
         x0CcpCGeOigvgO9gZHkDpFzLckQkV2fiZN7QYUrTZC4upjUToBQUiHKXdxlV/ewzyB
         rQOQD/kKxvf1WWEPKse98JjONAa7nO3bi2Hbr/McT5tX1rQKmGkWJ/N2SMPSDQm+sN
         U9OcNUyhO+vdA==
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        Alexandru Lazar <alazar@startmail.com>
Subject: [PATCH v3 2/2] dt-bindings: iio: adc: Add MAX1241 device tree bindings in documentation
Date:   Thu, 19 Mar 2020 18:29:37 +0200
Message-Id: <20200319162937.34664-3-alazar@startmail.com>
In-Reply-To: <20200319162937.34664-1-alazar@startmail.com>
References: <20200319162937.34664-1-alazar@startmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device-tree bindings documentation for the MAX1241 device driver.

Signed-off-by: Alexandru Lazar <alazar@startmail.com>
---
 .../bindings/iio/adc/maxim,max1241.yaml       | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
new file mode 100644
index 000000000000..28c73ed795aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2020 Ioan-Alexandru Lazar
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/maxim,max1241.yaml#
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
+      - maxim,max1241
+
+  reg:
+    description: SPI chip select number for this device
+    maxItems: 1
+
+  vref-supply:
+    description:
+      Device tree identifier of the regulator that provides the external
+      reference voltage.
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
+      #address-cells = <1>;
+      #size-cells = <0>;
+
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
2.25.2

