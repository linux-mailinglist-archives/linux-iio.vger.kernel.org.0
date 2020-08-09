Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BD223FDDC
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 13:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgHILUM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 07:20:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgHILUM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 07:20:12 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBBB52076C;
        Sun,  9 Aug 2020 11:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596972011;
        bh=qomiOKxTUeSfn56banZXI2i5A5k2DuDKDauQW496Q2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0CUMNyqOnUDYMkuAZ4WYvIO/iea7VTrcoIOimCRhulp1UdOR2rBx6yWUld+rCwji6
         YeYo1ScbyI8/Ict68IKTeokOSsZ4ROPw/C/xO/YEbl9ZEgYpemUF7SJJPFhnJ1NuvI
         p/rZ15RIp5qn7ViDvwtSvpRw5UHSlD7stlP8SdN4=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH 09/13] dt-bindings: iio: adc: ti,adc128s052 yaml conversion.
Date:   Sun,  9 Aug 2020 12:17:49 +0100
Message-Id: <20200809111753.156236-10-jic23@kernel.org>
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

Simple binding.  Only addition to txt version is
as a provider of channels to other devices using the consumer
binding.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
 .../bindings/iio/adc/ti,adc128s052.yaml       | 59 +++++++++++++++++++
 .../bindings/iio/adc/ti-adc128s052.txt        | 25 --------
 2 files changed, 59 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml
new file mode 100644
index 000000000000..d54a0183f024
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,adc128s052.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADC128S052 and similar ADCs
+
+maintainers:
+  - Angelo Compagnucci <angelo.compagnucci@gmail.com>
+
+description: |
+  Family of 12 bit SPI ADCs with 2 to 8 channels with a range of different
+  target sample rates.
+
+properties:
+  compatible:
+    enum:
+      - ti,adc122s021
+      - ti,adc122s051
+      - ti,adc122s101
+      - ti,adc124s021
+      - ti,adc124s051
+      - ti,adc124s101
+      - ti,adc128s052
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,adc128s052";
+            reg = <0>;
+            vref-supply = <&vdd_supply>;
+            spi-max-frequency = <1000000>;
+            #io-channel-cells = <1>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
deleted file mode 100644
index c07ce1a3f5c4..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-* Texas Instruments' ADC128S052, ADC122S021 and ADC124S021 ADC chip
-
-Required properties:
- - compatible: Should be one of:
-   - "ti,adc128s052"
-   - "ti,adc122s021"
-   - "ti,adc122s051"
-   - "ti,adc122s101"
-   - "ti,adc124s021"
-   - "ti,adc124s051"
-   - "ti,adc124s101"
- - reg: spi chip select number for the device
- - vref-supply: The regulator supply for ADC reference voltage
-
-Recommended properties:
- - spi-max-frequency: Definition as per
-		Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Example:
-adc@0 {
-	compatible = "ti,adc128s052";
-	reg = <0>;
-	vref-supply = <&vdd_supply>;
-	spi-max-frequency = <1000000>;
-};
-- 
2.28.0

