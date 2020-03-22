Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B318118E943
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 14:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgCVN6I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 09:58:08 -0400
Received: from mx-out2.startmail.com ([145.131.90.155]:35559 "EHLO
        mx-out2.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgCVN6I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 09:58:08 -0400
From:   Alexandru Lazar <alazar@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1584885486;
        bh=wa2Y0MIXlls6E5o//nIoKjWkRbAq9t0erBM3EHKdZLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MjhU1bc7qaVjzCXILL/6+yyhxG/YTf4sfknYRe35uL01XpW/5U67OfVjoSjEKeAGH
         dPj+MxVkdgCjKm7PlQgR4PqOr/nTCn2Ut5kGR57AcdqDh9/hA6EgzwpYW7t36ffocU
         IFxMQJJUHJzKmKxBj0/n3Ex9KBazIKDr/3HkV4V/X7OU3V/qVZvq5dt1UOBIsKhvoU
         aoEVDjR/C4tIRwUTSX8J7zc4oxpSE3YFsJ5hRQbOjUhA+qA2j4PH56r1wjSuEcFEGb
         5roZ/qVpFvD9ARfn1pnvPVxY8DlpcRpM9IZOIX8xlk78fZV9Tmpm+9JfCc6odoxrnh
         0HMcQrQNDBEig==
To:     linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, Alexandru Lazar <alazar@startmail.com>
Subject: [PATCH v5 1/2] dt-bindings: iio: adc: Add MAX1241 bindings
Date:   Sun, 22 Mar 2020 16:02:36 +0200
Message-Id: <20200322140237.211347-2-alazar@startmail.com>
In-Reply-To: <20200322140237.211347-1-alazar@startmail.com>
References: <20200322140237.211347-1-alazar@startmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device-tree bindings documentation for the MAX1241 device driver.

Signed-off-by: Alexandru Lazar <alazar@startmail.com>
---
 .../bindings/iio/adc/maxim,max1241.yaml       | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
new file mode 100644
index 000000000000..a9c419629af5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: GPL-2.0
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
+  - vdd-supply
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
+            vdd-supply = <&adc_vdd>;
+            vref-supply = <&adc_vref>;
+            spi-max-frequency = <1000000>;
+            shdn-gpios = <&gpio 26 1>;
+        };
+    };
-- 
2.25.2

