Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFBF122E29
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2019 15:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfLQOKT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Dec 2019 09:10:19 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56826 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbfLQOKT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Dec 2019 09:10:19 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBHE9xmV126814;
        Tue, 17 Dec 2019 08:09:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576591799;
        bh=39XSBHslFW4qLVK93KPUqercQvzcryx8huumV5amdlk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DOWO4hY7XL5knYI8O2w7n3QgXg6vxPdE966QMAD6TikiudS1nxMCubKsHWiXEteQg
         /rr/NUj43wlPsHtpmvFPLsziQKeGbERS4pIeF2n3S8LTJIQm2t9NmoDziO8ZzvfaR9
         F/5eAIE34NIXmUpoKb3JBnipIQHuMB1SUya61xNs=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHE9xfd123765;
        Tue, 17 Dec 2019 08:09:59 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 08:09:58 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 08:09:58 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHE9wKj121002;
        Tue, 17 Dec 2019 08:09:58 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/2] dt-binding: iio: dac8771: Add TI DAC8771 binding
Date:   Tue, 17 Dec 2019 08:07:30 -0600
Message-ID: <20191217140731.30504-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217140731.30504-1-dmurphy@ti.com>
References: <20191217140731.30504-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the TI DAC8771 DT binding.

Datasheet:
http://www.ti.com/lit/ds/symlink/dac8771.pdf

Signed-off-by: Dan Murphy <dmurphy@ti.com>
CC: Rob Herring <robh+dt@kernel.org>
---
 .../bindings/iio/dac/ti,dac8771.yaml          | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac8771.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac8771.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac8771.yaml
new file mode 100644
index 000000000000..6aba6789d36c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac8771.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/bindings/iio/dac/ti,dac8771.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Texas Instruments DAC8771
+
+maintainers:
+  - Dan Murphy <dmurphy@ti.com>
+
+description: |
+  The DAC8771 is a single channel, precision, fully integrated 16-bit digital
+  to analog converter (DAC) with adaptive power management, and is designed to
+  meet the requirements of industrial control applications.
+
+  Specifications can be found at:
+    http://www.ti.com/lit/ds/symlink/dac8771.pdf
+
+properties:
+  compatible:
+    enum:
+      - ti,dac8771
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    description: |
+       GPIO used for hardware reset.
+
+  loaddacs-gpios:
+    description: |
+       GPIO used to shift the data from the SPI FIFO to the processing engine.
+
+  spi-max-frequency:
+    maximum: 25000000
+
+  vref-supply:
+    description: Phandle to the external reference voltage supply.
+
+  ti,output-range:
+    description: Output range of the DAC
+       0 - Voltage output 0 to +5 V (default)
+       1 - Voltage output 0 to +10 V
+       2 - Voltage output ±5 V
+       3 - Voltage output ±10 V
+       4 - Current output 3.5 mA to 23.5 mA
+       5 - Current output 0 to 20 mA
+       6 - Current output 0 to 24 mA
+       7 - Current output ±24 mA
+       8 - Voltage output 0 to +6 V
+       9 - Voltage output 0 to +12 V
+       10 - Voltage output ±6 V
+       11 - Voltage output ±12 V
+       12 - Current output 4 mA to 20 mA
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint8
+      - enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
+
+  interrupts:
+    description: IRQ line for the DAC
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
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+  
+      dac@0 {
+        compatible = "ti,dac8771";
+        reg = <0>;
+        spi-max-frequency = <25000000>;
+        vref-supply = <&ldo3_reg>;
+        ti,output-range = <2>;
+        interrupts = <16>;
+        interrupt-parent = <&gpio1>;
+        loaddacs-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
+        reset-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
+      };
+    };
-- 
2.23.0

