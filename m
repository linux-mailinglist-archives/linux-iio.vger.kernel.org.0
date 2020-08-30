Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBD2256F4B
	for <lists+linux-iio@lfdr.de>; Sun, 30 Aug 2020 18:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgH3QOi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Aug 2020 12:14:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgH3QOg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 30 Aug 2020 12:14:36 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 214922076D;
        Sun, 30 Aug 2020 16:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598804076;
        bh=zHXD/PCu82qJRWgV9nLv9wM61eKP2NkJ37PcGcCZ6k4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kzww6d5tORvl8RvGOs4hLlmTZMR/D0I4aOWsRZBlprjm5ySwT0KA3r69kQxDgy1Z0
         lQecCqzJP6dJS+81pyPPgDeLi8+GD9fKozCdO85WDLeQmSLV28WtL769RNOV6zwIMv
         B91PICzWkT/tDdlkqplhY4n2ZOp3rX9qiYZaTYRU=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        David Lechner <david@lechnology.com>
Subject: [PATCH v2 2/2] dt-bindings: iio: adc: ti,ads7950 binding conversion
Date:   Sun, 30 Aug 2020 17:11:54 +0100
Message-Id: <20200830161154.3201-3-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200830161154.3201-1-jic23@kernel.org>
References: <20200830161154.3201-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Conversion from txt to yaml.  The binding documents that
as not all boards will make use of the ADC channels via a consumer
driver.  It does no harm however, so we will leave it as required.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: David Lechner <david@lechnology.com>
---

Changes:
* Fix patch description to make sense.
* Fix a supplies instead of supply.
* Add maximum value for spi-bus-frequency

 .../bindings/iio/adc/ti,ads7950.yaml          | 65 +++++++++++++++++++
 .../bindings/iio/adc/ti-ads7950.txt           | 23 -------
 2 files changed, 65 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7950.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads7950.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7950.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7950.yaml
new file mode 100644
index 000000000000..5ab5027be97e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7950.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads7950.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADS7950 and similar ADCs
+
+maintainers:
+  - David Lechner <david@lechnology.com>
+
+description: |
+  Family of 4-16 channel, 8-12 bit ADCs with SPI interface.
+
+properties:
+  compatible:
+    enum:
+      - ti,ads7950
+      - ti,ads7951
+      - ti,ads7952
+      - ti,ads7953
+      - ti,ads7954
+      - ti,ads7955
+      - ti,ads7956
+      - ti,ads7957
+      - ti,ads7958
+      - ti,ads7959
+      - ti,ads7960
+      - ti,ads7961
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 20000000
+
+  vref-supply:
+    description: Supplies the 2.5V or 5V reference voltage
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - vref-supply
+  - "#io-channel-cells"
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
+            compatible = "ti,ads7957";
+            reg = <0>;
+            vref-supply = <&refin_supply>;
+            spi-max-frequency = <10000000>;
+            #io-channel-cells = <1>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/adc/ti-ads7950.txt b/Documentation/devicetree/bindings/iio/adc/ti-ads7950.txt
deleted file mode 100644
index e77a6f7e1001..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/ti-ads7950.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-* Texas Instruments ADS7950 family of A/DC chips
-
-Required properties:
- - compatible: Must be one of "ti,ads7950", "ti,ads7951", "ti,ads7952",
-   "ti,ads7953", "ti,ads7954", "ti,ads7955", "ti,ads7956", "ti,ads7957",
-   "ti,ads7958", "ti,ads7959", "ti,ads7960", or "ti,ads7961"
- - reg: SPI chip select number for the device
- - #io-channel-cells: Must be 1 as per ../iio-bindings.txt
- - vref-supply: phandle to a regulator node that supplies the 2.5V or 5V
-   reference voltage
-
-Recommended properties:
- - spi-max-frequency: Definition as per
-		Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Example:
-adc@0 {
-	compatible = "ti,ads7957";
-	reg = <0>;
-	#io-channel-cells = <1>;
-	vref-supply = <&refin_supply>;
-	spi-max-frequency = <10000000>;
-};
-- 
2.28.0

