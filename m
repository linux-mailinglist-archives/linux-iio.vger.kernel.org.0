Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB2A263575
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 20:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgIISFd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 14:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbgIISEa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Sep 2020 14:04:30 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E730C221EB;
        Wed,  9 Sep 2020 18:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599674561;
        bh=pIGED+JyPxgowS0lFF9cJwDhp/9iv4X0tN+lMhcd7Mw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R43MGhl91+eUaPZyD7+9F+Az4Z/tMZG1bA68KGhFD78EqUYeu9nksdvdUlxHsnk24
         Ul3vM1VuAKaJIpxnwAd0Y5DwXYGKm/ozhtoX5/pwkqBakiHjRPhbSc4ddSornCFXib
         oO0N64/ZbR5UeEclZcX7gt0enpQtDdiZ1lIcKdNM=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Subject: [PATCH v2 14/20] dt-bindings:iio:adc:adi,ad7949 yaml conversion
Date:   Wed,  9 Sep 2020 18:59:40 +0100
Message-Id: <20200909175946.395313-15-jic23@kernel.org>
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

Simple SPI driver. I've added the #io-channel-cells
as an optional parameter to allow use of this device as a provider
of ADC capabilities to other devices.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
---
 .../devicetree/bindings/iio/adc/ad7949.txt    | 16 ------
 .../bindings/iio/adc/adi,ad7949.yaml          | 57 +++++++++++++++++++
 2 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ad7949.txt b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
deleted file mode 100644
index c7f5057356b1..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/ad7949.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-* Analog Devices AD7949/AD7682/AD7689
-
-Required properties:
- - compatible: Should be one of
-	* "adi,ad7949"
-	* "adi,ad7682"
-	* "adi,ad7689"
- - reg: spi chip select number for the device
- - vref-supply: The regulator supply for ADC reference voltage
-
-Example:
-adc@0 {
-	compatible = "adi,ad7949";
-	reg = <0>;
-	vref-supply = <&vdd_supply>;
-};
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
new file mode 100644
index 000000000000..9b56bd4d5510
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7949.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7949/AD7682/AD7689 analog to digital converters
+
+maintainers:
+  - Charles-Antoine Couret <charles-antoine.couret@essensium.com>
+
+description: |
+  Specifications on the converters can be found at:
+    AD7949:
+      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7949.pdf
+    AD7682/AD7698:
+      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7682_7689.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7682
+      - adi,ad7689
+      - adi,ad7949
+
+  reg:
+    maxItems: 1
+
+  vref-supply:
+    description:
+      ADC reference voltage supply
+
+  spi-max-frequency: true
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
+            compatible = "adi,ad7949";
+            reg = <0>;
+            vref-supply = <&vdd_supply>;
+        };
+    };
+...
-- 
2.28.0

