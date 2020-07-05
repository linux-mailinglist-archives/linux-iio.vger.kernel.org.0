Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D309214CAB
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jul 2020 15:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGENT2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Jul 2020 09:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbgGENT2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Jul 2020 09:19:28 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7238520739;
        Sun,  5 Jul 2020 13:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593955167;
        bh=pjV+d6aGAcPX1U1rVdQXSGwbjbpp5jWnjFiG26nvg5s=;
        h=From:To:Cc:Subject:Date:From;
        b=ChbADlghRaBJcaONIqPEK4KpqxC0JZWqx+8LiGjByN0ch31x/p8TOI3eMa8rfCJT3
         dWdxN8etOwDSzKqPsWSmcnKxbtqcNJREybJDIKPm/aelw/p/DNl+bmXMjWgVzerwao
         aoiLeuoUzNkHhamfLkFJ08O4HOc125jP95+TcE2o=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH] dt-bindings: iio: ti,ads8688 yaml conversion
Date:   Sun,  5 Jul 2020 14:17:20 +0100
Message-Id: <20200705131720.240574-1-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Fairly simple binding.  Most of the changes were filling in information
not previously found in the binding.  I dropped the previous explicit
mention of spi-max-frequency as that is covered by the generic SPI
binding.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Sean Nyekjaer <sean@geanix.com>
---

Sean, are you fine with being explicitly listed at the maintainer
of this binding?  Previously we didn't have that formally laid
out in the old txt bindings but it's now a required field.

I'm going to slowly work my way through some of the simpler yaml conversions
over the next few months.   Of course I welcome anyone else taking
some of these on but for purposes of review, please keep it to only
a few at a time.

 .../bindings/iio/adc/ti,ads8688.yaml          | 45 +++++++++++++++++++
 .../bindings/iio/adc/ti-ads8688.txt           | 20 ---------
 2 files changed, 45 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads8688.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads8688.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads8688.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads8688.yaml
new file mode 100644
index 000000000000..97fe6cbb2efa
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads8688.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads8688.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments' ADS8684 and ADS8688 ADC chip
+
+maintainers:
+  - Sean Nyekjaer <sean@geanix.com>
+
+description: |
+   SPI 16bit ADCs with 4/8 channels.
+
+properties:
+  compatible:
+    enum:
+      - ti,ads8684
+      - ti,ads8688
+
+  reg:
+    maxItems: 1
+
+  vref-supply:
+    description: Optional external reference.  If not supplied, assume
+      REFSEL input tied low to enable the internal reference.
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,ads8688";
+            reg = <0>;
+            vref-supply = <&vdd_supply>;
+            spi-max-frequency = <1000000>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/adc/ti-ads8688.txt b/Documentation/devicetree/bindings/iio/adc/ti-ads8688.txt
deleted file mode 100644
index a02337d7efa4..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/ti-ads8688.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-* Texas Instruments' ADS8684 and ADS8688 ADC chip
-
-Required properties:
- - compatible: Should be "ti,ads8684" or "ti,ads8688"
- - reg: spi chip select number for the device
-
-Recommended properties:
- - spi-max-frequency: Definition as per
-		Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Optional properties:
- - vref-supply: The regulator supply for ADC reference voltage
-
-Example:
-adc@0 {
-	compatible = "ti,ads8688";
-	reg = <0>;
-	vref-supply = <&vdd_supply>;
-	spi-max-frequency = <1000000>;
-};
-- 
2.27.0

