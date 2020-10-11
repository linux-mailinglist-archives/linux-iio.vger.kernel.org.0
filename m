Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E0028A842
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 18:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388191AbgJKQdM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 12:33:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388091AbgJKQdM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 12:33:12 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E779221FF;
        Sun, 11 Oct 2020 16:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602433991;
        bh=8k26N85go+1RefiHDXvAcyTtVA5cPAcUtJ+6mS7XSvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JngxnZ8zAH6j6lZxFR8R2okZGPeees8eztoHP3LbB9uLtkNbR1PIeMxq0dkAb6u4J
         tf6YkQe7118HICl68cGza574VbGC6ymjXGj8+9HhVl9A6TIKa9/GfSVq/r1dEHsqHW
         9QYzzHB+wRH2Nn8m3cAqEGNaEBLKjHZXjZ6xmj5k=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH 2/2] dt-bindings:iio:dac:dpot-dac: yaml conversion.
Date:   Sun, 11 Oct 2020 17:30:31 +0100
Message-Id: <20201011163031.240708-3-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201011163031.240708-1-jic23@kernel.org>
References: <20201011163031.240708-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Txt to yaml format conversion.  I dropped the example section
describind the measurement ADC, as that isn't strictly part
of this binding. Uses a reference to the new iio-consumers.yaml
binding.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/iio/dac/dpot-dac.txt  | 41 ------------
 .../devicetree/bindings/iio/dac/dpot-dac.yaml | 67 +++++++++++++++++++
 2 files changed, 67 insertions(+), 41 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/dpot-dac.txt b/Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
deleted file mode 100644
index fdf47a01bfef..000000000000
--- a/Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-Bindings for DAC emulation using a digital potentiometer
-
-It is assumed that the dpot is used as a voltage divider between the
-current dpot wiper setting and the maximum resistance of the dpot. The
-divided voltage is provided by a vref regulator.
-
-                  .------.
-   .-----------.  |      |
-   | vref      |--'    .---.
-   | regulator |--.    |   |
-   '-----------'  |    | d |
-                  |    | p |
-                  |    | o |  wiper
-                  |    | t |<---------+
-                  |    |   |
-                  |    '---'       dac output voltage
-                  |      |
-                  '------+------------+
-
-Required properties:
-- compatible: Should be "dpot-dac"
-- vref-supply: The regulator supplying the voltage divider.
-- io-channels: Channel node of the dpot to be used for the voltage division.
-- io-channel-names: Should be "dpot".
-
-Example:
-
-	&i2c {
-		dpot: mcp4651-503@28 {
-			compatible = "microchip,mcp4651-503";
-			reg = <0x28>;
-			#io-channel-cells = <1>;
-		};
-	};
-
-	dac {
-		compatible = "dpot-dac";
-		vref-supply = <&reg_3v3>;
-		io-channels = <&dpot 0>;
-		io-channel-names = "dpot";
-	};
diff --git a/Documentation/devicetree/bindings/iio/dac/dpot-dac.yaml b/Documentation/devicetree/bindings/iio/dac/dpot-dac.yaml
new file mode 100644
index 000000000000..b4a8073a3a3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/dpot-dac.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/dpot-dac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DAC emulation using a digital potentiometer
+
+maintainers:
+  - Peter Rosin <peda@axentia.se>
+
+description: |
+  It is assumed that the dpot is used as a voltage divider between the
+  current dpot wiper setting and the maximum resistance of the dpot. The
+  divided voltage is provided by a vref regulator.
+
+                  .------.
+   .-----------.  |      |
+   | vref      |--'    .---.
+   | regulator |--.    |   |
+   '-----------'  |    | d |
+                  |    | p |
+                  |    | o |  wiper
+                  |    | t |<---------+
+                  |    |   |
+                  |    '---'       dac output voltage
+                  |      |
+                  '------+------------+
+
+allOf:
+  - $ref: "../iio-consumer.yaml#"
+
+properties:
+  compatible:
+    const: dpot-dac
+
+  reg:
+    maxItems: 1
+
+  vref-supply:
+    description: Regulator supplying the voltage divider.
+
+  io-channels:
+    maxItems: 1
+    description: |
+      Channel node of the dpot to be used for the voltage division.
+
+  io-channel-names:
+    const: dpot
+
+required:
+  - compatible
+  - vref-supply
+  - io-channels
+  - io-channel-names
+
+additionalProperties: false
+
+examples:
+  - |
+    dac {
+        compatible = "dpot-dac";
+        vref-supply = <&reg_3v3>;
+        io-channels = <&dpot 0>;
+        io-channel-names = "dpot";
+    };
+...
-- 
2.28.0

