Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2535023FDD7
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 13:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgHILUK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 07:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgHILUJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 07:20:09 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E03D92076B;
        Sun,  9 Aug 2020 11:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596972008;
        bh=LQa3oA0XrV5L39YgAkj15csoBQWKNcLKu0FArIRY1sM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fYBcKbNzCoSIUxXANAWX9jlER0lfH7tIDfkuI90j9KLk0yLIMb+Imk7f3n706bfvE
         bwTy73OQZv/iRK6M9wJg3FSEhxg5e4eHlj/A5sExUMnbwvHqt7Y7kIaWisUg86E7md
         XamfpOIZ21guDtMZPyN39f+i/CTWI2qR8OOm1C2I=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <martenli@axis.com>
Subject: [PATCH 07/13] dt-bindings: iio: adc: ti,adc084s021 yaml conversion
Date:   Sun,  9 Aug 2020 12:17:47 +0100
Message-Id: <20200809111753.156236-8-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809111753.156236-1-jic23@kernel.org>
References: <20200809111753.156236-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple conversion.

Added the #io-channel-cells optional property to allow for consumer
bindings if appropriate on a given board.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mårten Lindahl <martenli@axis.com>
---
 .../bindings/iio/adc/ti,adc084s021.yaml       | 58 +++++++++++++++++++
 .../bindings/iio/adc/ti-adc084s021.txt        | 19 ------
 2 files changed, 58 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc084s021.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc084s021.yaml
new file mode 100644
index 000000000000..1a113b30a414
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,adc084s021.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,adc084s021.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADC084S021 ADC
+
+maintainers:
+  - Mårten Lindahl <martenli@axis.com>
+
+description: |
+  8 bit ADC with 4 channels
+
+properties:
+  compatible:
+    const: ti,adc084s021
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  vref-supply:
+    description: External reference, needed to establish input scaling
+
+  spi-cpol: true
+  spi-cpha: true
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - vref-supply
+  - spi-cpol
+  - spi-cpha
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
+            compatible = "ti,adc084s021";
+            reg = <0>;
+            vref-supply = <&adc_vref>;
+            spi-cpol;
+            spi-cpha;
+            spi-max-frequency = <16000000>;
+            #io-channel-cells = <1>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc084s021.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc084s021.txt
deleted file mode 100644
index 4259e50620bc..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/ti-adc084s021.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-* Texas Instruments' ADC084S021
-
-Required properties:
- - compatible        : Must be "ti,adc084s021"
- - reg               : SPI chip select number for the device
- - vref-supply       : The regulator supply for ADC reference voltage
- - spi-cpol          : Per spi-bus bindings
- - spi-cpha          : Per spi-bus bindings
- - spi-max-frequency : Per spi-bus bindings
-
-Example:
-adc@0 {
-	compatible = "ti,adc084s021";
-	reg = <0>;
-	vref-supply = <&adc_vref>;
-	spi-cpol;
-	spi-cpha;
-	spi-max-frequency = <16000000>;
-};
-- 
2.28.0

