Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46E4263567
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 20:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgIISE7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 14:04:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727055AbgIISCf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Sep 2020 14:02:35 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB14D21D91;
        Wed,  9 Sep 2020 18:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599674555;
        bh=E38bXaztWbprGXLGB3ZptLRYv4BC3A7eIgpDTMmcQ14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mgqPjG+D69xI2ciYzYhieqhVli2zRwhIqutPsrb8+JT9dn5UNOeLdxs1gv+ROAmC8
         JvMxT4kD5jiInho7lL+WtUC/ofn/C3L7ynMTCmyUuzjywfh1CchfBaZ+OYY6A4xoS7
         dsYNZ53mhrTZn7M6OncnK7NxT7IrzA0JcmHIHCxA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gregory Clement <gregory.clement@bootlin.com>
Subject: [PATCH v2 10/20] dt-bindings:iio:adc:lpc3220-adc yaml conversion
Date:   Wed,  9 Sep 2020 18:59:36 +0100
Message-Id: <20200909175946.395313-11-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200909175946.395313-1-jic23@kernel.org>
References: <20200909175946.395313-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Renamed to remove the wild cards.  These go wrong far too often so
in general preferred to use the name of a specific part.  As this
binding only provides one compatible, I went with that.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>
---
 .../bindings/iio/adc/lpc32xx-adc.txt          | 21 --------
 .../bindings/iio/adc/nxp,lpc3220-adc.yaml     | 50 +++++++++++++++++++
 2 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt b/Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt
deleted file mode 100644
index 3a1bc669bd51..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-* NXP LPC32xx SoC ADC controller
-
-Required properties:
-- compatible: must be "nxp,lpc3220-adc"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- interrupts: The ADC interrupt
-
-Optional:
- - vref-supply: The regulator supply ADC reference voltage, optional
-   for legacy reason, but highly encouraging to us in new device tree
-
-Example:
-
-	adc@40048000 {
-		compatible = "nxp,lpc3220-adc";
-		reg = <0x40048000 0x1000>;
-		interrupt-parent = <&mic>;
-		interrupts = <39 0>;
-		vref-supply = <&vcc>;
-	};
diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,lpc3220-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,lpc3220-adc.yaml
new file mode 100644
index 000000000000..2c5032be83bd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nxp,lpc3220-adc.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/nxp,lpc3220-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC3220 SoC ADC controller
+
+maintainers:
+  - Gregory Clement <gregory.clement@bootlin.com>
+
+description:
+  This hardware block has been used on several LPC32XX SoCs.
+
+properties:
+  compatible:
+    const: nxp,lpc3220-adc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vref-supply: true
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        adc@40048000 {
+            compatible = "nxp,lpc3220-adc";
+            reg = <0x40048000 0x1000>;
+            interrupt-parent = <&mic>;
+            interrupts = <39 0>;
+            vref-supply = <&vcc>;
+        };
+    };
+...
-- 
2.28.0

