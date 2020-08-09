Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA6023FDD2
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 13:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgHILUF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 07:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgHILUF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 07:20:05 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A103C20748;
        Sun,  9 Aug 2020 11:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596972004;
        bh=fFjRg4u2O6rIsnmb5QeqklxTxGScNwRug1+xq9CT+p0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c9XRpL4iWTFkrLxl5H//i2fokGeZPU0w1XWxyYUoCgx22XO6pN/NOjoNrxOkbtz7w
         ty7xAdr5PiWp/Y4WhjqT/LCtXez2KpIY01JVz2hrfMOjyA3HcCwYRJ1BV6Nl5b4pIe
         0wDi20TRDL/BttaDA9xEPSFBG6N9AIkuJMF14dD4=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 04/13] dt-bindings: iio: adc: lltc,ltc2497 yaml conversion.
Date:   Sun,  9 Aug 2020 12:17:44 +0100
Message-Id: <20200809111753.156236-5-jic23@kernel.org>
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

Very simple binding for this i2c device with a reference supply.

Added the #io-channel-cells property to allow for consumers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>
---
 .../bindings/iio/adc/lltc,ltc2497.yaml        | 44 +++++++++++++++++++
 .../devicetree/bindings/iio/adc/ltc2497.txt   | 13 ------
 2 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
new file mode 100644
index 000000000000..6a176f551d75
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/lltc,ltc2497.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Linear Technology / Analog Devices LTC2497 ADC
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+
+description: |
+  16bit ADC supporting up to 16 single ended or 8 differential inputs.
+  I2C interface.
+
+properties:
+  compatible:
+    const:
+      lltc,ltc2497
+
+  reg: true
+  vref-supply: true
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - vref-supply
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@76 {
+            compatible = "lltc,ltc2497";
+            reg = <0x76>;
+            vref-supply = <&ltc2497_reg>;
+            #io-channel-cells = <1>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/adc/ltc2497.txt b/Documentation/devicetree/bindings/iio/adc/ltc2497.txt
deleted file mode 100644
index a237ed99c0d8..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/ltc2497.txt
+++ /dev/null
@@ -1,13 +0,0 @@
-* Linear Technology / Analog Devices LTC2497 ADC
-
-Required properties:
- - compatible: Must be "lltc,ltc2497"
- - reg: Must contain the ADC I2C address
- - vref-supply: The regulator supply for ADC reference voltage
-
-Example:
-	ltc2497: adc@76 {
-		compatible = "lltc,ltc2497";
-		reg = <0x76>;
-		vref-supply = <&ltc2497_reg>;
-	};
-- 
2.28.0

