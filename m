Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E27E318D206
	for <lists+linux-iio@lfdr.de>; Fri, 20 Mar 2020 15:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgCTO45 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Mar 2020 10:56:57 -0400
Received: from mx-out2.startmail.com ([145.131.90.155]:45571 "EHLO
        mx-out2.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgCTO45 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2020 10:56:57 -0400
From:   Alexandru Lazar <alazar@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1584716215;
        bh=BDMdTrRlnXEyFmyRKV7vZNwqmtPAlf9h0jxHDoYIymc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXtuA5rXX2SpDi9VENihjyQADPuvVTNyQeb98aVeSgI32XnjfHx8LuPcxJKNjGDZO
         9T+N4aa2FzvvCKkwrVeuHnD3O2eaOJCHxYagUnDrRk0MuWyXtKhZG3NI0jFHWHy5sZ
         1xvMqwKL/7KROWothBrdY0mDLUVXLpssVOezYV5HpyKYQQwMJuP3T2y4bPtU+NPsOS
         fmCr+T7Tzh6lzibUB/haqt4AvwtM3ETMlQlyt0Gq0BPVu0xQkX969Tf8isNFpn8k1A
         8sz7FCNY8rmkASZLqdZQ4gxYyQ4K/JXcjn2J8Axgy1PtN3AFxVxWZI6mCA0ZRIEU7M
         g8kkOFGAciEMA==
To:     linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, Alexandru Lazar <alazar@startmail.com>
Subject: [PATCH v4 1/2] dt-bindings: iio: adc: Add MAX1241 device tree bindings in documentation
Date:   Fri, 20 Mar 2020 17:01:14 +0200
Message-Id: <20200320150114.9297-2-alazar@startmail.com>
In-Reply-To: <20200320150114.9297-1-alazar@startmail.com>
References: <20200320150114.9297-1-alazar@startmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device-tree bindings documentation for the MAX1241 device driver.

Signed-off-by: Alexandru Lazar <alazar@startmail.com>
---
 .../bindings/iio/adc/maxim,max1241.yaml       | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
new file mode 100644
index 000000000000..de41d422ce3b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
@@ -0,0 +1,61 @@
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

