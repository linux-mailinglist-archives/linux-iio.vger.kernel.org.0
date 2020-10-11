Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106F628A860
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 19:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388077AbgJKRKS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 13:10:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387984AbgJKRKR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:10:17 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B9B12222A;
        Sun, 11 Oct 2020 17:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602436217;
        bh=t/rQAc0cPJ+yJNUmPqUmSsVWSS7nRy1ThW30lYCmIws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mcOMwgRpRUrio5W9I2SYKzloo2O7NRZJLSW0ejjK+sFnxrDRj1aJmgPoWwUjAiw8Z
         Dy5knqof+0k1BUQ70fypFzX9lDvt+3n0QskIP3K1qLznon8OkEtDHa6zyVxVQHFaw3
         YFiYgaJmgBfWtDCUbOOwjMmSOmnJ24hBgmL3Hjy0=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Subject: [PATCH 13/29] dt-bindings:iio:dac:ti,dac7311 yaml conversion
Date:   Sun, 11 Oct 2020 18:07:33 +0100
Message-Id: <20201011170749.243680-14-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201011170749.243680-1-jic23@kernel.org>
References: <20201011170749.243680-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Very simple conversion of this binding from txt to yaml.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
---
 .../bindings/iio/dac/ti,dac7311.txt           | 23 ---------
 .../bindings/iio/dac/ti,dac7311.yaml          | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt b/Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
deleted file mode 100644
index e5a507db5e01..000000000000
--- a/Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-TI DAC7311 device tree bindings
-
-Required properties:
-- compatible: must be set to:
-	* "ti,dac7311"
-	* "ti,dac6311"
-	* "ti,dac5311"
-- reg: spi chip select number for the device
-- vref-supply: The regulator supply for ADC reference voltage
-
-Optional properties:
-- spi-max-frequency: Max SPI frequency to use
-
-Example:
-
-	spi_master {
-		dac@0 {
-			compatible = "ti,dac7311";
-			reg = <0>; /* CS0 */
-			spi-max-frequency = <1000000>;
-			vref-supply = <&vdd_supply>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7311.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac7311.yaml
new file mode 100644
index 000000000000..10be98d1f19c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7311.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/ti,dac7311.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments DAC5311 and similar SPI DACs
+
+maintainers:
+  - Charles-Antoine Couret <charles-antoine.couret@essensium.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,dac7311
+      - ti,dac6311
+      - ti,dac5311
+
+  reg:
+    maxItems: 1
+
+  vref-supply:
+    description:
+      Reference voltage must be supplied to establish the scaling of the
+      output voltage.
+
+  spi-max-frequency: true
+
+required:
+  - compatible
+  - reg
+  - vref-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "ti,dac7311";
+            reg = <0>; /* CS0 */
+            spi-max-frequency = <1000000>;
+            vref-supply = <&vdd_supply>;
+        };
+    };
+...
-- 
2.28.0

