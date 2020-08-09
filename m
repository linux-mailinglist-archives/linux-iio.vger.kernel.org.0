Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7925223FDD5
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 13:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgHILUI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 07:20:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgHILUI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 07:20:08 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D8F92078D;
        Sun,  9 Aug 2020 11:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596972007;
        bh=C27VUfhRi25GeeObvS3kCP/nI3TO5p769C0N1WNJtZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cVPjdETgavHuC98ssCQ4WZMTLwtRabgITT0pBO1zV2ZEuC5m7t4AyMbMYxLb4uFq7
         3BOFHF0fgUjbKKww8pCl/1PtjsGCXFutxkFgJhhD90xQiAES4ZX4/Q7PfiE+oAyTGh
         trgXHtCnxN+tCx4/UDML650r8oNeZZeqlxlJeiNE=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 06/13] dt-bindings: iio: adc: ti,adc0832 yaml conversion.
Date:   Sun,  9 Aug 2020 12:17:46 +0100
Message-Id: <20200809111753.156236-7-jic23@kernel.org>
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

Simple binding conversion of this SPI ADC binding, with reference
voltage.

Added the optional property #io-channel-cells to allow for
consumers of channels if that makes sense for a given board.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
---
 .../bindings/iio/adc/ti,adc0832.yaml          | 56 +++++++++++++++++++
 .../bindings/iio/adc/ti-adc0832.txt           | 19 -------
 2 files changed, 56 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc0832.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc0832.yaml
new file mode 100644
index 000000000000..f5a923cc847f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,adc0832.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,adc0832.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADC0832 and similar ADCs
+
+maintainers:
+  - Akinobu Mita <akinobu.mita@gmail.com>
+
+description: |
+  8 bit ADCs with 1, 2, 4 or 8 inputs for single ended or differential
+  conversion.
+
+properties:
+  compatible:
+    enum:
+      - ti,adc0831
+      - ti,adc0832
+      - ti,adc0834
+      - ti,adc0838
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  vref-supply:
+    description: External reference, needed to establish input scaling
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
+            compatible = "ti,adc0832";
+            reg = <0>;
+            vref-supply = <&vdd_supply>;
+            spi-max-frequency = <200000>;
+            #io-channel-cells = <1>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc0832.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc0832.txt
deleted file mode 100644
index d91130587d01..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/ti-adc0832.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-* Texas Instruments' ADC0831/ADC0832/ADC0832/ADC0838
-
-Required properties:
- - compatible: Should be one of
-	* "ti,adc0831"
-	* "ti,adc0832"
-	* "ti,adc0834"
-	* "ti,adc0838"
- - reg: spi chip select number for the device
- - vref-supply: The regulator supply for ADC reference voltage
- - spi-max-frequency: Max SPI frequency to use (< 400000)
-
-Example:
-adc@0 {
-	compatible = "ti,adc0832";
-	reg = <0>;
-	vref-supply = <&vdd_supply>;
-	spi-max-frequency = <200000>;
-};
-- 
2.28.0

