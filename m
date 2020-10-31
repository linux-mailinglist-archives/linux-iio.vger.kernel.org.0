Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA482A17D6
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 14:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgJaNoG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 09:44:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbgJaNoG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 09:44:06 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52E2920731;
        Sat, 31 Oct 2020 13:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604151845;
        bh=FzA+NFB7LCeyQ6pLZ6Aze0ObLTyfT6wWBWH0kqJicrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2HD55PN3aFJbN96Pq5rBDzHH545vfhktH4GXoX6K4RAEenC1uwzUspfnGr/754ptO
         38ACI2BMTYB9xKnDBKlRuWSEnLszem6EIgAs8fNigqncMQ2i1jaozbhY9udWquHLKC
         TwETohH5ArPDA+OVOPKRU3t7AtQ7wK6ueI1bC8sU=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v2 16/29] dt-bindings:iio:dac:ti,dac082s085 yaml conversion
Date:   Sat, 31 Oct 2020 13:40:57 +0000
Message-Id: <20201031134110.724233-17-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031134110.724233-1-jic23@kernel.org>
References: <20201031134110.724233-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Fairly simple conversion with the exception of the XOR between
spi-cpha and spi-cpol.

Is there a better way to specify that?

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lukas Wunner <lukas@wunner.de>
---
v2:
* Family typo
* Put back the reference regulator in example.
* Added checking of XOR of spi-cpha and spi-cpol
  (dropped Rob Herrings Reviewed-by due to this change)
  
 .../bindings/iio/dac/ti,dac082s085.yaml       | 79 +++++++++++++++++++
 .../bindings/iio/dac/ti-dac082s085.txt        | 34 --------
 2 files changed, 79 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml
new file mode 100644
index 000000000000..192b314c99d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/ti,dac082s085.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments DAC082s085 and similar DACs
+
+description:
+  A family of Texas Instruments 8/10/12-bit 2/4-channel DACs
+
+maintainers:
+  - Lukas Wunner <lukas@wunner.de>
+
+properties:
+  compatible:
+    enum:
+      - ti,dac082s085
+      - ti,dac102s085
+      - ti,dac122s085
+      - ti,dac084s085
+      - ti,dac104s085
+      - ti,dac124s085
+
+  reg:
+    maxItems: 1
+
+  spi-cpha: true
+  spi-cpol:
+    description:
+      Should be either spi-cpha, or spi-cpol but not both.
+
+  vref-supply:
+    description: Needed to provide output scaling.
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
+allOf:
+  - $ref: '#/definitions/cpolXORcpha'
+
+definitions:
+  cpolXORcpha:
+    not:
+      required: [spi-cpha, spi-cpol]
+    oneOf:
+      - required:
+          - spi-cpha
+      - required:
+          - spi-cpol
+
+examples:
+  - |
+    vref_2v5_reg: regulator-vref {
+        compatible = "regulator-fixed";
+        regulator-name = "2v5";
+        regulator-min-microvolt = <2500000>;
+        regulator-max-microvolt = <2500000>;
+        regulator-always-on;
+    };
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "ti,dac082s085";
+            reg = <0>;
+            spi-max-frequency = <40000000>;
+            spi-cpol;
+            vref-supply = <&vref_2v5_reg>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt b/Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt
deleted file mode 100644
index 9cb0e10df704..000000000000
--- a/Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-Texas Instruments 8/10/12-bit 2/4-channel DAC driver
-
-Required properties:
- - compatible:		Must be one of:
-			"ti,dac082s085"
-			"ti,dac102s085"
-			"ti,dac122s085"
-			"ti,dac084s085"
-			"ti,dac104s085"
-			"ti,dac124s085"
- - reg: 		Chip select number.
- - spi-cpha, spi-cpol:	SPI mode (0,1) or (1,0) must be used, so specify
-			either spi-cpha or spi-cpol (but not both).
- - vref-supply: 	Phandle to the external reference voltage supply.
-
-For other required and optional properties of SPI slave nodes please refer to
-../../spi/spi-bus.txt.
-
-Example:
-	vref_2v5_reg: regulator-vref {
-		compatible = "regulator-fixed";
-		regulator-name = "2v5";
-		regulator-min-microvolt = <2500000>;
-		regulator-max-microvolt = <2500000>;
-		regulator-always-on;
-	};
-
-	dac@0 {
-		compatible = "ti,dac082s085";
-		reg = <0>;
-		spi-max-frequency = <40000000>;
-		spi-cpol;
-		vref-supply = <&vref_2v5_reg>;
-	};
-- 
2.28.0

