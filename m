Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3E428A864
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 19:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388221AbgJKRKY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 13:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387984AbgJKRKX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:10:23 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30C9222258;
        Sun, 11 Oct 2020 17:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602436223;
        bh=19BZKdmFRfRaNbDS0kVg0gtj1YpJ/3z1moZU3C0MuD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WPEjagtvCnzrQK2anHw396/g/oaIjJfPKWwGo6wN3HU+K3+ZGBvd0ZIkqzthirQrt
         Nrdm3Oqp8HE7kFaohzsgnXGfijbmRkfWtdp5Un3h6znLITMOaNi4ioe8VfNov2RDrv
         NU8WBVtWpGskwInfnhfOejwIcHT3Yf5F2azvcyBI=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 17/29] dt-bindings:iio:dac:adi,ad7303 yaml conversion
Date:   Sun, 11 Oct 2020 18:07:37 +0100
Message-Id: <20201011170749.243680-18-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201011170749.243680-1-jic23@kernel.org>
References: <20201011170749.243680-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Converted to maintain the requirement for Vdd-supply as per original file.
It is possible we could relax this requirement to make it at least one
of Vdd-supply and REF-supply.  We need to establish the scaling of the
output channel and if REF-supply is provided that is used instead of
Vdd-supply, hence I cannot see why a dummy regulator cannot be used for
Vdd-supply if this happens.

For now, let us keep it simple.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 .../devicetree/bindings/iio/dac/ad7303.txt    | 23 ---------
 .../bindings/iio/dac/adi,ad7303.yaml          | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ad7303.txt b/Documentation/devicetree/bindings/iio/dac/ad7303.txt
deleted file mode 100644
index 914610f0556e..000000000000
--- a/Documentation/devicetree/bindings/iio/dac/ad7303.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Analog Devices AD7303 DAC device driver
-
-Required properties:
-	- compatible: Must be "adi,ad7303"
-	- reg: SPI chip select number for the device
-	- spi-max-frequency: Max SPI frequency to use (< 30000000)
-	- Vdd-supply: Phandle to the Vdd power supply
-
-Optional properties:
-	- REF-supply: Phandle to the external reference voltage supply. This should
-	  only be set if there is an external reference voltage connected to the REF
-	  pin. If the property is not set Vdd/2 is used as the reference voltage.
-
-Example:
-
-		ad7303@4 {
-			compatible = "adi,ad7303";
-			reg = <4>;
-			spi-max-frequency = <10000000>;
-			Vdd-supply = <&vdd_supply>;
-			adi,use-external-reference;
-			REF-supply = <&vref_supply>;
-		};
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad7303.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad7303.yaml
new file mode 100644
index 000000000000..f76c31bf6ee3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad7303.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad7303.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7303 DAC
+
+maintainers:
+  - Lars-Peter Clausen <lars@metafoo.de>
+
+properties:
+  compatible:
+    const: adi,ad7303
+
+  reg:
+    maxItems: 1
+
+  Vdd-supply:
+    description:
+      Used to calculate output channel scalling if REF-supply not specified.
+  REF-supply:
+    description:
+      If not provided, Vdd/2 is used as the reference voltage.
+
+  spi-max-frequency:
+    maximum: 30000000
+
+required:
+  - compatible
+  - reg
+  - Vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@4 {
+            compatible = "adi,ad7303";
+            reg = <4>;
+            spi-max-frequency = <10000000>;
+            Vdd-supply = <&vdd_supply>;
+            adi,use-external-reference;
+            REF-supply = <&vref_supply>;
+        };
+    };
+...
-- 
2.28.0

