Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB972A1957
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgJaSPF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728332AbgJaSPB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:15:01 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8D7220723;
        Sat, 31 Oct 2020 18:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604168100;
        bh=+KKQvxitikpmSsDORSTRtGhhfcyGmEHjn9x1tgY/194=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bCG51qMXl+kJbXF2yXQLnY1sZ4nSgWFeu6mWrMjldSiRv9oseuXUJKwHRN5rCqRtN
         fcoZRPTaNL0q41XbNjLEbGCC10CUXbeOt57LEp4dlCpSZz4i213dBgG1o+ZLCddAE4
         gZu0ZFPA/hdpUMIkt570oBaA4HBP7X2U5lzvRh/A=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH 06/10] dt-bindings:iio:afe:current-sense-shunt: txt to yaml conversion.
Date:   Sat, 31 Oct 2020 18:12:38 +0000
Message-Id: <20201031181242.742301-7-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031181242.742301-1-jic23@kernel.org>
References: <20201031181242.742301-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Very simple binding. As such straight forward conversion.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Rosin <peda@axentia.se>
---
 .../bindings/iio/afe/current-sense-shunt.txt  | 41 ------------
 .../bindings/iio/afe/current-sense-shunt.yaml | 65 +++++++++++++++++++
 2 files changed, 65 insertions(+), 41 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt b/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
deleted file mode 100644
index 0f67108a07b6..000000000000
--- a/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-Current Sense Shunt
-===================
-
-When an io-channel measures the voltage over a current sense shunt,
-the interesting measurement is almost always the current through the
-shunt, not the voltage over it. This binding describes such a current
-sense circuit.
-
-Required properties:
-- compatible : "current-sense-shunt"
-- io-channels : Channel node of a voltage io-channel.
-- shunt-resistor-micro-ohms : The shunt resistance in microohms.
-
-Example:
-The system current is measured by measuring the voltage over a
-3.3 ohms shunt resistor.
-
-sysi {
-	compatible = "current-sense-shunt";
-	io-channels = <&tiadc 0>;
-
-	/* Divide the voltage by 3300000/1000000 (or 3.3) for the current. */
-	shunt-resistor-micro-ohms = <3300000>;
-};
-
-&i2c {
-	tiadc: adc@48 {
-		compatible = "ti,ads1015";
-		reg = <0x48>;
-		#io-channel-cells = <1>;
-
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		channel@0 { /* IN0,IN1 differential */
-			reg = <0>;
-			ti,gain = <1>;
-			ti,datarate = <4>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml b/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
new file mode 100644
index 000000000000..2f18409c64e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/afe/current-sense-shunt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Current Sense Shunt
+
+maintainers:
+  - Peter Rosin <peda@axentia.se>
+
+description: |
+  When an io-channel measures the voltage over a current sense shunt,
+  the interesting measurement is almost always the current through the
+  shunt, not the voltage over it. This binding describes such a current
+  sense circuit.
+
+properties:
+  compatible:
+    const: current-sense-shunt
+
+  io-channels:
+    maxItems: 1
+    description: |
+      Channel node of a voltage io-channel.
+
+  shunt-resistor-micro-ohms:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The shunt resistance.
+
+required:
+  - compatible
+  - io-channels
+  - shunt-resistor-micro-ohms
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        tiadc: adc@48 {
+            compatible = "ti,ads1015";
+            reg = <0x48>;
+            #io-channel-cells = <1>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 { /* IN0,IN1 differential */
+                reg = <0>;
+                ti,gain = <1>;
+                ti,datarate = <4>;
+            };
+        };
+    };
+    sysi {
+        compatible = "current-sense-shunt";
+        io-channels = <&tiadc 0>;
+
+        /* Divide the voltage by 3300000/1000000 (or 3.3) for the current. */
+        shunt-resistor-micro-ohms = <3300000>;
+    };
+...
-- 
2.28.0

