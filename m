Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC452A194B
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgJaSO4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:14:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728324AbgJaSOz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:14:55 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A69F206DD;
        Sat, 31 Oct 2020 18:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604168095;
        bh=r/HMSSHlxN7A44SSKNFurR/Pa6IplZTBID1cSbgL6aM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6sjw362l/vZIfp+FC6Ne5HEZHZPwT4MQ8E17CYl6Re4yyQa2jZXHODvVlX1lf41A
         8brfG/NUVllV2DOCpxRWOmdSWAGTNirl6pw4zZaspWdsZa+B7qI71qjKgeXcA7IqLD
         8UZGruB/pLiZq0LT/a9gATTAOWf6U6txGEYcliPk=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH 02/10] dt-bindings:iio:dac:dpot-dac: yaml conversion.
Date:   Sat, 31 Oct 2020 18:12:34 +0000
Message-Id: <20201031181242.742301-3-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031181242.742301-1-jic23@kernel.org>
References: <20201031181242.742301-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Txt to yaml format conversion.  I dropped the example section
describing the measurement ADC, as that isn't strictly part
of this binding.

Uses the new dt-schema/schema/iio/iio-consumer.yaml schema.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/iio/dac/dpot-dac.txt  | 41 ------------
 .../devicetree/bindings/iio/dac/dpot-dac.yaml | 64 +++++++++++++++++++
 2 files changed, 64 insertions(+), 41 deletions(-)

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
index 000000000000..6a7ca8e432d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/dpot-dac.yaml
@@ -0,0 +1,64 @@
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
+properties:
+  compatible:
+    const: dpot-dac
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
+  "#io-channel-cells":
+    const: 1
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

