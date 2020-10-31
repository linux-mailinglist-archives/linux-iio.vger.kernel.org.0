Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0044E2A19CB
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgJaSvh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbgJaSvg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:51:36 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40EE62071A;
        Sat, 31 Oct 2020 18:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170296;
        bh=KjGYay2ITMr/cJxUpcpyVNbSXDT6KAOvgzmxPMfreIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SrsHROi3HW/azXQRN66ayjd2XhvAsjApB0gaBmfWs2U8SF1cwwfI2bvTDktLibuY3
         2z0GXmS6m+Wjla4m7X+UtLa905e4x8iIfYl1mJ5NzWriIr8vLPfRY5Gzts/3l104OQ
         VkBnyhph0b6yBMpESxcIh3yAPOFlSHpWr2iLHMyg=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Karol Wrona <k.wrona@samsung.com>
Subject: [PATCH 06/46] dt-bindings:iio:samsung,sensorhub-rinato: yaml conversion
Date:   Sat, 31 Oct 2020 18:48:14 +0000
Message-Id: <20201031184854.745828-7-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Renamed to be more specific as I would be surprised if this is the only
sensorhub Samsung have ever shipped.
Fixed missing reg property in the example

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Karol Wrona <k.wrona@samsung.com>
---
 .../iio/samsung,sensorhub-rinato.yaml         | 72 +++++++++++++++++++
 .../devicetree/bindings/iio/sensorhub.txt     | 24 -------
 2 files changed, 72 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/samsung,sensorhub-rinato.yaml b/Documentation/devicetree/bindings/iio/samsung,sensorhub-rinato.yaml
new file mode 100644
index 000000000000..62366cbd37e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/samsung,sensorhub-rinato.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/samsung,sensorhub-rinato.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Sensorhub driver
+
+maintainers:
+  - Karol Wrona <k.wrona@samsung.com>
+
+description: |
+  Sensorhub is a MCU which manages several sensors and also plays the role
+  of a virtual sensor device.
+
+properties:
+  compatible:
+    enum:
+      - samsung,sensorhub-rinato
+      - samsung,sensorhub-thermostat
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  ap-mcu-gpios:
+    maxItems: 1
+    description:
+      Application Processor to sensorhub line - used during communication
+
+  mcu-ap-gpios:
+    maxItems: 1
+    description:
+      Sensorhub to Application Processor - used during communication
+
+  mcu-reset-gpios:
+    maxItems: 1
+    description:
+      Reset the sensorhub.
+
+  spi-max-frequency: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - ap-mcu-gpios
+  - mcu-ap-gpios
+  - mcu-reset-gpios
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        sensorhub@0 {
+            compatible = "samsung,sensorhub-rinato";
+            reg = <0>;
+            spi-max-frequency = <5000000>;
+            interrupt-parent = <&gpx0>;
+            interrupts = <2 0>;
+            ap-mcu-gpios = <&gpx0 0 0>;
+            mcu-ap-gpios = <&gpx0 4 0>;
+            mcu-reset-gpios = <&gpx0 5 0>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/sensorhub.txt b/Documentation/devicetree/bindings/iio/sensorhub.txt
deleted file mode 100644
index b6ac0457d4ea..000000000000
--- a/Documentation/devicetree/bindings/iio/sensorhub.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Samsung Sensorhub driver
-
-Sensorhub is a MCU which manages several sensors and also plays the role
-of a virtual sensor device.
-
-Required properties:
-- compatible: "samsung,sensorhub-rinato" or "samsung,sensorhub-thermostat"
-- spi-max-frequency: max SPI clock frequency
-- interrupts: communication interrupt
-- ap-mcu-gpios: [out] ap to sensorhub line - used during communication
-- mcu-ap-gpios: [in] sensorhub to ap - used during communication
-- mcu-reset-gpios: [out] sensorhub reset
-
-Example:
-
-	shub_spi: shub {
-		compatible = "samsung,sensorhub-rinato";
-		spi-max-frequency = <5000000>;
-		interrupt-parent = <&gpx0>;
-		interrupts = <2 0>;
-		ap-mcu-gpios = <&gpx0 0 0>;
-		mcu-ap-gpios = <&gpx0 4 0>;
-		mcu-reset-gpios = <&gpx0 5 0>;
-	};
-- 
2.28.0

