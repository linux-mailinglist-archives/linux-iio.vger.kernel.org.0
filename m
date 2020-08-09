Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C4B23FDCF
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 13:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHILUE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 07:20:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgHILUD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 07:20:03 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AA6B20729;
        Sun,  9 Aug 2020 11:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596972003;
        bh=WbQLTXNbjRMQftFIIOZ4GiMYlCKeyiFb4uALYzHXB4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HAs6g7GqIqdYEfCex97mPrbW5xmGnJVKkD1CkghjUUS+uq3KiFfvtLakmdxv/o4D4
         cm/RatgTSVNp0oZNCpPW946MkyqdYYGEeV9lmuKn1BcsM+qnGtc+WB/6e4KzgaVbtR
         PC1/SwQqKYtbyG8AgVZhBsqW5Zd5BDsPIowNxcSk=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 03/13] dt-bindings: iio: adc: ti,adc108s102 yaml conversion
Date:   Sun,  9 Aug 2020 12:17:43 +0100
Message-Id: <20200809111753.156236-4-jic23@kernel.org>
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

Very simple conversion of spi device with reference supply.

Added the #io-channel-cells property to allow for consumers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../bindings/iio/adc/ti,adc108s102.yaml       | 47 +++++++++++++++++++
 .../bindings/iio/adc/ti-adc108s102.txt        | 18 -------
 2 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc108s102.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc108s102.yaml
new file mode 100644
index 000000000000..54955f03df93
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,adc108s102.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,adc108s102.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADC108S102 and ADC128S102
+
+maintainers:
+  - Bogdan Pricop <bogdan.pricop@emutex.com>
+
+description: |
+  Family of 8 channel, 10/12 bit, SPI, single ended ADCs.
+
+properties:
+  compatible:
+    const:
+      ti,adc108s102
+
+  reg: true
+  vref-supply: true
+  spi-max-frequency: true
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
+        #address-cells= <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,adc108s102";
+            reg = <0>;
+            vref-supply = <&vdd_supply>;
+            spi-max-frequency = <1000000>;
+            #io-channel-cells = <1>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc108s102.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc108s102.txt
deleted file mode 100644
index bbbbb4a9f58f..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/ti-adc108s102.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-* Texas Instruments' ADC108S102 and ADC128S102 ADC chip
-
-Required properties:
- - compatible: Should be "ti,adc108s102"
- - reg: spi chip select number for the device
- - vref-supply: The regulator supply for ADC reference voltage
-
-Recommended properties:
- - spi-max-frequency: Definition as per
-		Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Example:
-adc@0 {
-	compatible = "ti,adc108s102";
-	reg = <0>;
-	vref-supply = <&vdd_supply>;
-	spi-max-frequency = <1000000>;
-};
-- 
2.28.0

