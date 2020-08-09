Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3A423FDE0
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 13:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgHILUP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 07:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgHILUP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 07:20:15 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 902162065D;
        Sun,  9 Aug 2020 11:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596972014;
        bh=U4FgdftWxD8YI33Nce7CbbUhkmxE3fQ82dNpmo1uPX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rxsSWMqzQmj4ZZ/g8HUV2hlFpM3oH1237R5b3hMMD3p+EGQwxdo/L7dYdCIsMVpGF
         Qgk6ILEBO1ZJzJJFqAkd2oGShr+VA99qjCqoZddTE2H0wKfjXDDMxZSskcs4SUM3/P
         aTcTNUxwFotmKYv2J4tRwzUhyh0sp4kMbcWzH79Q=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 11/13] dt-bindings: iio: adc: ti,ads8344 yaml conversion
Date:   Sun,  9 Aug 2020 12:17:51 +0100
Message-Id: <20200809111753.156236-12-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809111753.156236-1-jic23@kernel.org>
References: <20200809111753.156236-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple binding so easy to convert.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../bindings/iio/adc/ti,ads8344.yaml          | 51 +++++++++++++++++++
 .../bindings/iio/adc/ti-ads8344.txt           | 19 -------
 2 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads8344.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads8344.yaml
new file mode 100644
index 000000000000..b8c398187d5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads8344.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads8344.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADS8344 ADC
+
+maintainers:
+  - Gregory Clement <gregory.clement@bootlin.com>
+
+description: |
+  16bit 8-channel ADC with single ended inputs.
+
+properties:
+  compatible:
+    const: ti,ads8344
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  vref-supply:
+    description: Supply the 2.5V or 5V reference voltage
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - vref-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,ads8344";
+            reg = <0>;
+            vref-supply = <&refin_supply>;
+            spi-max-frequency = <10000000>;
+            #io-channel-cells = <1>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/adc/ti-ads8344.txt b/Documentation/devicetree/bindings/iio/adc/ti-ads8344.txt
deleted file mode 100644
index e47c3759a82b..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/ti-ads8344.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-* Texas Instruments ADS8344 A/DC chip
-
-Required properties:
- - compatible: Must be "ti,ads8344"
- - reg: SPI chip select number for the device
- - vref-supply: phandle to a regulator node that supplies the
-   reference voltage
-
-Recommended properties:
- - spi-max-frequency: Definition as per
-		Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Example:
-adc@0 {
-	compatible = "ti,ads8344";
-	reg = <0>;
-	vref-supply = <&refin_supply>;
-	spi-max-frequency = <10000000>;
-};
-- 
2.28.0

