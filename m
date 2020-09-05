Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E90225E968
	for <lists+linux-iio@lfdr.de>; Sat,  5 Sep 2020 19:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgIERc5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Sep 2020 13:32:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728445AbgIERcv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Sep 2020 13:32:51 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF1E7208DB;
        Sat,  5 Sep 2020 17:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599327170;
        bh=D/xeIW7B0P3+axp/oO/rsfBk7WsGfDLCbQBzyamngHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TB/ugh41LEEa4fEErW706dX9CbmCATlgLRdqYkMiSnXS5X+3MBu3xaJOwqhLVfRS0
         hntCDeu1Jjpfchy5KDY8czZdwGF+TRv5EJu4nsDuI5qO+hwJ8037RqSV8PX4UJBMbu
         2JaDte6ShFO6I23ihNU9+aoA+y0BzQ3LaGmCxWcQ=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Subject: [PATCH 17/20] dt-bindings:iio:adc:holt,hi8435 yaml conversion
Date:   Sat,  5 Sep 2020 18:30:01 +0100
Message-Id: <20200905173004.216081-18-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905173004.216081-1-jic23@kernel.org>
References: <20200905173004.216081-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Very simple binding.  I've changed the example to use the node
name threshold-detector@0 as sensor@0 seemed too generic.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
---
 .../devicetree/bindings/iio/adc/hi8435.txt    | 21 --------
 .../bindings/iio/adc/holt,hi8435.yaml         | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/hi8435.txt b/Documentation/devicetree/bindings/iio/adc/hi8435.txt
deleted file mode 100644
index 3b0348c5e516..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/hi8435.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Holt Integrated Circuits HI-8435 threshold detector bindings
-
-Required properties:
- - compatible: should be "holt,hi8435"
- - reg: spi chip select number for the device
-
-Recommended properties:
- - spi-max-frequency: definition as per
-		Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Optional properties:
- - gpios: GPIO used for controlling the reset pin
-
-Example:
-sensor@0 {
-	compatible = "holt,hi8435";
-	reg = <0>;
-	gpios = <&gpio6 1 0>;
-
-	spi-max-frequency = <1000000>;
-};
diff --git a/Documentation/devicetree/bindings/iio/adc/holt,hi8435.yaml b/Documentation/devicetree/bindings/iio/adc/holt,hi8435.yaml
new file mode 100644
index 000000000000..4ff08e9fcc74
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/holt,hi8435.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/holt,hi8435.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Holt Integrated Circuits HI-8435 SPI threshold detector
+
+maintainers:
+  - Vladimir Barinov <vladimir.barinov@cogentembedded.com>
+
+description: |
+  Datasheet: http://www.holtic.com/documents/427-hi-8435_v-rev-lpdf.do
+
+properties:
+  compatible:
+    const: holt,hi8435
+
+  reg:
+    maxItems: 1
+
+  gpios:
+    description:
+       GPIO used for controlling the reset pin
+
+  spi-max-frequency: true
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        threshold-detector@0 {
+            compatible = "holt,hi8435";
+            reg = <0>;
+            gpios = <&gpio6 1 0>;
+            spi-max-frequency = <1000000>;
+        };
+    };
+...
-- 
2.28.0

