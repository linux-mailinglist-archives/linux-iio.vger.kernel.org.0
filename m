Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3533229E37
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 19:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbgGVROl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 13:14:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731843AbgGVROc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Jul 2020 13:14:32 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 511F7207BB;
        Wed, 22 Jul 2020 17:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595438071;
        bh=IOWXQ0+Gcf0WPynRUbszW7WMZRxWBmRVXPa2pXzJin4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jjCF2fFUUww+UIt4vB7RiBe6GDO1s+x1JZbJLYdIX58+qe03sK+A9TW7NjIeKAXBR
         ECXosqEFK85Fe7clrfCygFUuhacfV9y0ZBbb9FidxnzHnnJUunNMQe4oROioq/x8/Q
         GZX1rthbo1O6dRY4QALNMhEOISzKUhrgsmkzmVv8=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/3] dt-bindings: iio: adc: maxim,max1118 yaml conversion
Date:   Wed, 22 Jul 2020 18:12:23 +0100
Message-Id: <20200722171224.989138-3-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722171224.989138-1-jic23@kernel.org>
References: <20200722171224.989138-1-jic23@kernel.org>
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
 .../devicetree/bindings/iio/adc/max1118.txt   | 21 -------
 .../bindings/iio/adc/maxim,max1118.yaml       | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 21 deletions(-)

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
index 000000000000..ca24b8b23cde
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1118.yaml
@@ -0,0 +1,59 @@
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
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+           const: maxim,max1118
+    then:
+      properties:
+        vref-supply:
+          description: External reference, needed to establish input scaling
+
+      required:
+        - vref-supply
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

