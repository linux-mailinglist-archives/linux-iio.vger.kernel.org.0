Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2665F2A194D
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgJaSO6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:14:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbgJaSO5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:14:57 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AAF6206E3;
        Sat, 31 Oct 2020 18:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604168096;
        bh=bX04u/UP18oPfs0/Vp3t8E9k8/QrJPuuttCk4PPr5J4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E8vC0Z5neJjY0l4CnOJAp65Ddgj0HD8vZHUqoCsxNEJMK9GlPHLGH49BR+4yraMDU
         PC47wZAzxCpUV0+DmMxWFFsbjnh+4DWora9j+RfDOAW2ab0JMDIxFrYaluEH0VGgFd
         LKnoe+tDn7LASUbbPo90/N0Cl93O43MSbdQEo6CU=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH 03/10] dt-bindings:iio:potentiometer: give microchip,mcp4531 its own binding
Date:   Sat, 31 Oct 2020 18:12:35 +0000
Message-Id: <20201031181242.742301-4-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031181242.742301-1-jic23@kernel.org>
References: <20201031181242.742301-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

We use this part in an example for the envelope detector. That showed
that we need to allow for the #io-channel-cells property which
trivial-devices.yaml does not.

It doesn't make sense to add that property to trivial-devices as
it only applies for those devices that can provide some sort of
DAC or ADC service to another device driver.  Hence solution will
be to pull some IIO devices out to have their own file on a case
by case basis.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Rosin <peda@axentia.se>
---
 .../iio/potentiometer/microchip,mcp4531.yaml  | 116 ++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  | 128 ------------------
 2 files changed, 116 insertions(+), 128 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4531.yaml b/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4531.yaml
new file mode 100644
index 000000000000..5c4b9b9181ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4531.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/potentiometer/microchip,mcp4531.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip mcp4531 and similar potentiometers.
+
+maintainers:
+  - Peter Rosin <peda@axentia.se>
+
+description: |
+  Family of I2C digital potentiometer
+  Datasheets at:
+  * volatile https://ww1.microchip.com/downloads/en/DeviceDoc/22096b.pdf
+  * non-volatile https://ww1.microchip.com/downloads/en/DeviceDoc/22107B.pdf
+  Part numbers as follows: mcp4ABC-XXX where
+  A =   5 (1 wiper), 6 (2 wipers)
+  B =   3 (7-bit, volatile), 4 (7-bit, non-volatile),
+        5 (8-bit, volatile), 6 (8-bit, non-volatile),
+  C:    1 (potentiometer), 2 (rheostat)
+  XXX = 502 (5 kOhms), 103 (10 kOhms), 503 (50 kOhms), 104 (100 kOhms)
+
+properties:
+  compatible:
+    enum:
+        # Ordering reflects part number + range, so 502 < 103 etc
+      - microchip,mcp4531-502
+      - microchip,mcp4531-103
+      - microchip,mcp4531-503
+      - microchip,mcp4531-104
+      - microchip,mcp4532-502
+      - microchip,mcp4532-103
+      - microchip,mcp4532-503
+      - microchip,mcp4532-104
+      - microchip,mcp4541-502
+      - microchip,mcp4541-103
+      - microchip,mcp4541-503
+      - microchip,mcp4541-104
+      - microchip,mcp4542-502
+      - microchip,mcp4542-103
+      - microchip,mcp4542-503
+      - microchip,mcp4542-104
+      - microchip,mcp4551-502
+      - microchip,mcp4551-103
+      - microchip,mcp4551-503
+      - microchip,mcp4551-104
+      - microchip,mcp4552-502
+      - microchip,mcp4552-103
+      - microchip,mcp4552-503
+      - microchip,mcp4552-104
+      - microchip,mcp4561-502
+      - microchip,mcp4561-103
+      - microchip,mcp4561-503
+      - microchip,mcp4561-104
+      - microchip,mcp4562-502
+      - microchip,mcp4562-103
+      - microchip,mcp4562-503
+      - microchip,mcp4562-104
+      - microchip,mcp4631-502
+      - microchip,mcp4631-103
+      - microchip,mcp4631-503
+      - microchip,mcp4631-104
+      - microchip,mcp4632-502
+      - microchip,mcp4632-103
+      - microchip,mcp4632-503
+      - microchip,mcp4632-104
+      - microchip,mcp4641-502
+      - microchip,mcp4641-103
+      - microchip,mcp4641-503
+      - microchip,mcp4641-104
+      - microchip,mcp4642-502
+      - microchip,mcp4642-103
+      - microchip,mcp4642-503
+      - microchip,mcp4642-104
+      - microchip,mcp4651-502
+      - microchip,mcp4651-103
+      - microchip,mcp4651-503
+      - microchip,mcp4651-104
+      - microchip,mcp4652-502
+      - microchip,mcp4652-103
+      - microchip,mcp4652-503
+      - microchip,mcp4652-104
+      - microchip,mcp4661-502
+      - microchip,mcp4661-103
+      - microchip,mcp4661-503
+      - microchip,mcp4661-104
+      - microchip,mcp4662-502
+      - microchip,mcp4662-103
+      - microchip,mcp4662-503
+      - microchip,mcp4662-104
+
+  reg:
+    maxItems: 1
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        dpot: dpot@28 {
+            compatible = "microchip,mcp4651-104";
+            reg = <0x28>;
+            #io-channel-cells = <1>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index cb4fd8f29675..d154ea97e30d 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -186,134 +186,6 @@ properties:
           - microchip,mcp4019-503
             # Microchip 7-bit Single I2C Digital POT (100k)
           - microchip,mcp4019-104
-            # Microchip 7-bit Single I2C Digital Potentiometer (5k)
-          - microchip,mcp4531-502
-            # Microchip 7-bit Single I2C Digital Potentiometer (10k)
-          - microchip,mcp4531-103
-            # Microchip 7-bit Single I2C Digital Potentiometer (50k)
-          - microchip,mcp4531-503
-            # Microchip 7-bit Single I2C Digital Potentiometer (100k)
-          - microchip,mcp4531-104
-            # Microchip 7-bit Single I2C Digital Potentiometer (5k)
-          - microchip,mcp4532-502
-            # Microchip 7-bit Single I2C Digital Potentiometer (10k)
-          - microchip,mcp4532-103
-            # Microchip 7-bit Single I2C Digital Potentiometer (50k)
-          - microchip,mcp4532-503
-            # Microchip 7-bit Single I2C Digital Potentiometer (100k)
-          - microchip,mcp4532-104
-            # Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (5k)
-          - microchip,mcp4541-502
-            # Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (10k)
-          - microchip,mcp4541-103
-            # Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (50k)
-          - microchip,mcp4541-503
-            # Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (100k)
-          - microchip,mcp4541-104
-            # Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (5k)
-          - microchip,mcp4542-502
-            # Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (10k)
-          - microchip,mcp4542-103
-            # Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (50k)
-          - microchip,mcp4542-503
-            # Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (100k)
-          - microchip,mcp4542-104
-            # Microchip 8-bit Single I2C Digital Potentiometer (5k)
-          - microchip,mcp4551-502
-            # Microchip 8-bit Single I2C Digital Potentiometer (10k)
-          - microchip,mcp4551-103
-            # Microchip 8-bit Single I2C Digital Potentiometer (50k)
-          - microchip,mcp4551-503
-            # Microchip 8-bit Single I2C Digital Potentiometer (100k)
-          - microchip,mcp4551-104
-            # Microchip 8-bit Single I2C Digital Potentiometer (5k)
-          - microchip,mcp4552-502
-            # Microchip 8-bit Single I2C Digital Potentiometer (10k)
-          - microchip,mcp4552-103
-            # Microchip 8-bit Single I2C Digital Potentiometer (50k)
-          - microchip,mcp4552-503
-            # Microchip 8-bit Single I2C Digital Potentiometer (100k)
-          - microchip,mcp4552-104
-            # Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (5k)
-          - microchip,mcp4561-502
-            # Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (10k)
-          - microchip,mcp4561-103
-            # Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (50k)
-          - microchip,mcp4561-503
-            # Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (100k)
-          - microchip,mcp4561-104
-            # Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (5k)
-          - microchip,mcp4562-502
-            # Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (10k)
-          - microchip,mcp4562-103
-            # Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (50k)
-          - microchip,mcp4562-503
-            # Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (100k)
-          - microchip,mcp4562-104
-            # Microchip 7-bit Dual I2C Digital Potentiometer (5k)
-          - microchip,mcp4631-502
-            # Microchip 7-bit Dual I2C Digital Potentiometer (10k)
-          - microchip,mcp4631-103
-            # Microchip 7-bit Dual I2C Digital Potentiometer (50k)
-          - microchip,mcp4631-503
-            # Microchip 7-bit Dual I2C Digital Potentiometer (100k)
-          - microchip,mcp4631-104
-            # Microchip 7-bit Dual I2C Digital Potentiometer (5k)
-          - microchip,mcp4632-502
-            # Microchip 7-bit Dual I2C Digital Potentiometer (10k)
-          - microchip,mcp4632-103
-            # Microchip 7-bit Dual I2C Digital Potentiometer (50k)
-          - microchip,mcp4632-503
-            # Microchip 7-bit Dual I2C Digital Potentiometer (100k)
-          - microchip,mcp4632-104
-            # Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (5k)
-          - microchip,mcp4641-502
-            # Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (10k)
-          - microchip,mcp4641-103
-            # Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (50k)
-          - microchip,mcp4641-503
-            # Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (100k)
-          - microchip,mcp4641-104
-            # Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (5k)
-          - microchip,mcp4642-502
-            # Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (10k)
-          - microchip,mcp4642-103
-            # Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (50k)
-          - microchip,mcp4642-503
-            # Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (100k)
-          - microchip,mcp4642-104
-            # Microchip 8-bit Dual I2C Digital Potentiometer (5k)
-          - microchip,mcp4651-502
-            # Microchip 8-bit Dual I2C Digital Potentiometer (10k)
-          - microchip,mcp4651-103
-            # Microchip 8-bit Dual I2C Digital Potentiometer (50k)
-          - microchip,mcp4651-503
-            # Microchip 8-bit Dual I2C Digital Potentiometer (100k)
-          - microchip,mcp4651-104
-            # Microchip 8-bit Dual I2C Digital Potentiometer (5k)
-          - microchip,mcp4652-502
-            # Microchip 8-bit Dual I2C Digital Potentiometer (10k)
-          - microchip,mcp4652-103
-            # Microchip 8-bit Dual I2C Digital Potentiometer (50k)
-          - microchip,mcp4652-503
-            # Microchip 8-bit Dual I2C Digital Potentiometer (100k)
-          - microchip,mcp4652-104
-            # Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (5k)
-          - microchip,mcp4661-502
-            # Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (10k)
-          - microchip,mcp4661-103
-            # Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (50k)
-          - microchip,mcp4661-503
-            # Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (100k)
-          - microchip,mcp4661-104
-            # Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (5k)
-          - microchip,mcp4662-502
-            # Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (10k)
-          - microchip,mcp4662-103
-            # Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (50k)
-          - microchip,mcp4662-503
-            # Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (100k)
-          - microchip,mcp4662-104
             # PWM Fan Speed Controller With Fan Fault Detection
           - microchip,tc654
             # PWM Fan Speed Controller With Fan Fault Detection
-- 
2.28.0

