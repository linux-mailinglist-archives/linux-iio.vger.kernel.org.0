Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A772A19CA
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgJaSvg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:51:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728395AbgJaSvf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:51:35 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82D3420720;
        Sat, 31 Oct 2020 18:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170294;
        bh=GL5NLMdYAIJDAG2pgmplmCsOw7mxQvaz0GX+UG2FpR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oj1g4dvoursWtKCmfQ6m0XnBGkbFRD0K8Vx5+6fAX1yvQTqW3hKa0pU2rq/Osm5so
         aEB/BHSCKPfVjBlVD2x1VvATqQPXwz6poq4t5o/uWNKJrOXvCf+Nl24YGayg9HRROM
         V8teHVEhVTosFqzKgWpRLs1l8SOaqAmbUiR7oKfo=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Gabriel Capella <gabriel@capella.pro>,
        Alexandru Ardelean <Alexandru.Ardelean@analog.com>
Subject: [PATCH 05/46] dt-bindings:iio:impedance-analyzer:adi,ad5933 yaml conversion.
Date:   Sat, 31 Oct 2020 18:48:13 +0000
Message-Id: <20201031184854.745828-6-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The example in this one had a completely wrong compatible so I've
fixed that. Otherwise, a fairly simple conversion.

Note the driver itself is still in staging.  Looking back at the
last discussion around this, I think we were just waiting for some
test results on some refactors.  As such the binding should be stable
even if the driver might need a little more love and attention.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Gabriel Capella <gabriel@capella.pro>
Cc: Alexandru Ardelean <Alexandru.Ardelean@analog.com>
---
 .../iio/impedance-analyzer/ad5933.txt         | 26 --------
 .../iio/impedance-analyzer/adi,ad5933.yaml    | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt b/Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt
deleted file mode 100644
index 5ff38728ff91..000000000000
--- a/Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Analog Devices AD5933/AD5934 Impedance Converter, Network Analyzer
-
-https://www.analog.com/media/en/technical-documentation/data-sheets/AD5933.pdf
-https://www.analog.com/media/en/technical-documentation/data-sheets/AD5934.pdf
-
-Required properties:
- - compatible : should be one of
-		"adi,ad5933"
-		"adi,ad5934"
- - reg : the I2C address.
- - vdd-supply : The regulator supply for DVDD, AVDD1 and AVDD2 when they
-   are connected together.
-
-Optional properties:
-- clocks : external clock reference.
-- clock-names : must be "mclk" if clocks is set.
-
-Example for a I2C device node:
-
-	impedance-analyzer@0d {
-		compatible = "adi,adxl345";
-		reg = <0x0d>;
-		vdd-supply = <&vdd_supply>;
-		clocks = <&ref_clk>;
-		clock-names = "mclk";
-	};
diff --git a/Documentation/devicetree/bindings/iio/impedance-analyzer/adi,ad5933.yaml b/Documentation/devicetree/bindings/iio/impedance-analyzer/adi,ad5933.yaml
new file mode 100644
index 000000000000..2ad043554b9c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/impedance-analyzer/adi,ad5933.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/impedance-analyzer/adi,ad5933.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5933/AD5934 Impedance Converter, Network Analyzer
+
+maintainers:
+  - Marcelo Schmitt <marcelo.schmitt1@gmail.com>
+  - Gabriel Capella <gabriel@capella.pro>
+
+description: |
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD5933.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD5934.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad5933
+      - adi,ad5934
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: |
+      The regulator supply for DVDD, AVDD1 and AVDD2 when they
+      are connected together.  Used to calculate voltage scaling of measurement
+      channels.
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: mclk
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        impedance-analyzer@d {
+            compatible = "adi,ad5933";
+            reg = <0x0d>;
+            vdd-supply = <&vdd_supply>;
+            clocks = <&ref_clk>;
+            clock-names = "mclk";
+        };
+    };
+...
-- 
2.28.0

