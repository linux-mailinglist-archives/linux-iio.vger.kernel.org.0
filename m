Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0798D351998
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 20:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbhDARyL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 13:54:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237000AbhDARuA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Apr 2021 13:50:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D47D46128C;
        Thu,  1 Apr 2021 14:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617286316;
        bh=BB9hAFKo+2v0Bi2crV5qOykg9CQQiAJV0ZePZMybHXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PZp0eDC+B6J5Y/KoopU3KX0fE2iNUUtyF0cNc2wOdUHbZMMxFsOQH9SvtNqpQj/eH
         EiPr/Yg/pg1IDouLScxCEOdVFVh2ivVSM764Bng6PUPZkfTBABJ7qJsw+gHj0lYeqz
         7cVCSZOBiiXZvFguW2B9oBql2TEd4Skcb9tUYUlw5OSdF0sAnZZmpHbZsTGHVXmkQL
         8KcMv1BPCu0za/nZas/m2wLljWjtvMcLu/PDX62f+fc3VaotF0GBthwwYDa7oOfWDh
         VCJMdecayASnpTD2MUPHGTYXiI2vj2NYUJ5mMfm32lWCmv0c5HOxRc1Uf+qIM51nFp
         nbcnJ7oHZQkTw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 2/2] dt-bindings:iio:dac:ti,dac082s085 yaml conversion
Date:   Thu,  1 Apr 2021 15:09:56 +0100
Message-Id: <20210401140956.224084-3-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210401140956.224084-1-jic23@kernel.org>
References: <20210401140956.224084-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Fairly simple conversion with the exception of the XOR between
spi-cpha and spi-cpol.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lukas Wunner <lukas@wunner.de>
Link: https://lore.kernel.org/r/20201031134110.724233-17-jic23@kernel.org
---
 .../bindings/iio/dac/ti,dac082s085.yaml       | 72 +++++++++++++++++++
 .../bindings/iio/dac/ti-dac082s085.txt        | 34 ---------
 2 files changed, 72 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml
new file mode 100644
index 000000000000..b0157050f1ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml
@@ -0,0 +1,72 @@
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
+      Must be either spi-cpha, or spi-cpol but not both.
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
+oneOf:
+  - required:
+      - spi-cpha
+  - required:
+      - spi-cpol
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
2.31.1

