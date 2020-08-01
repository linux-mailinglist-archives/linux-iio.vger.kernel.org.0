Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AA12353EA
	for <lists+linux-iio@lfdr.de>; Sat,  1 Aug 2020 20:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgHASBF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Aug 2020 14:01:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgHASBF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Aug 2020 14:01:05 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A16A2206E9;
        Sat,  1 Aug 2020 18:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596304864;
        bh=tT/luxSQGi0reuYFUc+RvZ6WJAsuKcxPjk/nasshXdk=;
        h=From:To:Cc:Subject:Date:From;
        b=usavGl+H6gUdnUUNT03XbpGRWHsG1IlpfZgnhrzKN5T381M+aXFpoKuaJyeAcVLBB
         vlpVDvVhu+B86rjbdXijhdu+wo6Kb+LQzKGWzTt7gCHaXDj4BwzSW9P3qG2Nmp/EML
         3n6tK7sdUtDYLsFC3lxSmT5DEMXh7/izRf9vYdms=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH V2] dt-bindings: iio: adc: maxim,max1118 yaml conversion
Date:   Sat,  1 Aug 2020 18:58:50 +0100
Message-Id: <20200801175850.1140006-1-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple device with a simple conversion.  Special handling needed
for the max1118 which is the only supported part that has an external
reference voltage.

Cc: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2:
* Added additionalProperties: false. Other changes are to make this work.
* Move the vref-supply definition up
* Add an else clause

.../devicetree/bindings/iio/adc/max1118.txt   | 21 -------
 .../bindings/iio/adc/maxim,max1118.yaml       | 62 +++++++++++++++++++
 2 files changed, 62 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/max1118.txt b/Documentation/devicetree/bindings/iio/adc/max1118.txt
deleted file mode 100644
index cf33d0b15a6d..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/max1118.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-* MAX1117/MAX1118/MAX1119 8-bit, dual-channel ADCs
-
-Required properties:
- - compatible: Should be one of
-	* "maxim,max1117"
-	* "maxim,max1118"
-	* "maxim,max1119"
- - reg: spi chip select number for the device
- - (max1118 only) vref-supply: The regulator supply for ADC reference voltage
-
-Recommended properties:
- - spi-max-frequency: Definition as per
-		Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Example:
-adc@0 {
-	compatible = "maxim,max1118";
-	reg = <0>;
-	vref-supply = <&vdd_supply>;
-	spi-max-frequency = <1000000>;
-};
diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1118.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1118.yaml
new file mode 100644
index 000000000000..e948b3e37b0c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1118.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/maxim,max1118.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX1118 and similar ADCs
+
+maintainers:
+  - Akinobu Mita <akinobu.mita@gmail.com>
+
+description: |
+    Dual channel 8bit ADCs.
+
+properties:
+  compatible:
+    enum:
+      - maxim,max1117
+      - maxim,max1118
+      - maxim,max1119
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 5000000
+
+  vref-supply:
+    description: External reference, needed to establish input scaling
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: maxim,max1118
+then:
+  required:
+    - vref-supply
+else:
+  properties:
+    vref-supply: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "maxim,max1118";
+            reg = <0>;
+            vref-supply = <&adc_vref>;
+            spi-max-frequency = <1000000>;
+        };
+    };
+...
-- 
2.27.0

