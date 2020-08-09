Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1FC23FDE3
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 13:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgHILUS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 07:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgHILUS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 07:20:18 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63DF5206D8;
        Sun,  9 Aug 2020 11:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596972017;
        bh=Cbyhs/Xet1hHvl6FhTjFIxhhezZP6HgWsZoUKNXnESw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o3SGvmQ8Bk2IGmKQFKQgD9GJBqSzw64tcmZUmSJF2n++bMGZttlFPyIiwKnERK5l0
         NNCKlnW0t5Nw4yDDV5sYIj8F8a0wOaNSwZswCGpowhyIBvCKuA6zhrnraGo7ptiWNG
         ENWEW24JWurXJ9gDYprYSOnG3CGPbMmxFJsXxlxU=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Phil Reid <preid@electromag.com.au>
Subject: [PATCH 13/13] dt-bindings: iio: adc: ti,tlc4541 binding conversion
Date:   Sun,  9 Aug 2020 12:17:53 +0100
Message-Id: <20200809111753.156236-14-jic23@kernel.org>
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
Dropped the stated value of maximum spi bus frequency as it does
not seem to correspond to the datasheet.  The value of 200kHz
is the max sampling frequency of the ADC, not the clock frequency of
the SPI bus.

Added #io-channel-cells to allow use as a provider of channels to
other devices via the consumer binding.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Phil Reid <preid@electromag.com.au>
---
 .../bindings/iio/adc/ti,tlc4541.yaml          | 52 +++++++++++++++++++
 .../bindings/iio/adc/ti-tlc4541.txt           | 17 ------
 2 files changed, 52 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,tlc4541.yaml b/Documentation/devicetree/bindings/iio/adc/ti,tlc4541.yaml
new file mode 100644
index 000000000000..6c2539b3d707
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,tlc4541.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,tlc4541.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TLC4541 and similar ADCs
+
+maintainers:
+  - Phil Reid <preid@electromag.com.au>
+
+description: |
+  14/16bit single channel ADC with SPI interface.
+
+properties:
+  compatible:
+    enum:
+      - ti,tlc3541
+      - ti,tlc4541
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  vref-supply: true
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
+            compatible = "ti,tlc4541";
+            reg = <0>;
+            vref-supply = <&vdd_supply>;
+            spi-max-frequency = <200000>;
+            #io-channel-cells = <1>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/adc/ti-tlc4541.txt b/Documentation/devicetree/bindings/iio/adc/ti-tlc4541.txt
deleted file mode 100644
index 6b2692723a04..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/ti-tlc4541.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-* Texas Instruments' TLC4541
-
-Required properties:
- - compatible: Should be one of
-	* "ti,tlc4541"
-	* "ti,tlc3541"
-	- reg: SPI chip select number for the device
- - vref-supply: The regulator supply for ADC reference voltage
- - spi-max-frequency: Max SPI frequency to use (<= 200000)
-
-Example:
-adc@0 {
-	compatible = "ti,tlc4541";
-	reg = <0>;
-	vref-supply = <&vdd_supply>;
-	spi-max-frequency = <200000>;
-};
-- 
2.28.0

