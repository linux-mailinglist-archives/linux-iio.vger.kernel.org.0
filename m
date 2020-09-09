Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCB5263573
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 20:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgIISFb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 14:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729251AbgIISEa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Sep 2020 14:04:30 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02AC022206;
        Wed,  9 Sep 2020 18:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599674564;
        bh=a8NvT8GrB3MC2P5uCmXgeNzeGo+67sqznTDHWFubi94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HHHkKG4d6onNz4L+yBN8fDaH2QBpQ2H7wCEBFx2DQnaV6QzCmxHOgn1KR3571xf3J
         F+y/QD8yrxccCUGUmk43mp8qFUWW512Xdr0OJjgWu0ax5pPV/RpAOym4Y5xf78v6CR
         aGnJkMmBdlc399xF28iVK3nEBdTNXrlpgFEdZEU0=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dirk Eibach <eibach@gdsys.de>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 16/20] dt-bindings:iio:adc:ti,ads1015 yaml conversion
Date:   Wed,  9 Sep 2020 18:59:42 +0100
Message-Id: <20200909175946.395313-17-jic23@kernel.org>
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

This binding was moved over from hwmon some time ago so is a bit
unusual in terms of IIO bindings.  However, conversion was fairly
straight forwards.

I've listed both Dirk (who think wrote original binding) and Daniel
who added the IIO driver for this device.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dirk Eibach <eibach@gdsys.de>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
---
 .../devicetree/bindings/iio/adc/ads1015.txt   |  73 -----------
 .../bindings/iio/adc/ti,ads1015.yaml          | 113 ++++++++++++++++++
 2 files changed, 113 insertions(+), 73 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ads1015.txt b/Documentation/devicetree/bindings/iio/adc/ads1015.txt
deleted file mode 100644
index 918a507d1159..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/ads1015.txt
+++ /dev/null
@@ -1,73 +0,0 @@
-ADS1015 (I2C)
-
-This device is a 12-bit A-D converter with 4 inputs.
-
-The inputs can be used single ended or in certain differential combinations.
-
-For configuration all possible combinations are mapped to 8 channels:
-  0: Voltage over AIN0 and AIN1.
-  1: Voltage over AIN0 and AIN3.
-  2: Voltage over AIN1 and AIN3.
-  3: Voltage over AIN2 and AIN3.
-  4: Voltage over AIN0 and GND.
-  5: Voltage over AIN1 and GND.
-  6: Voltage over AIN2 and GND.
-  7: Voltage over AIN3 and GND.
-
-Each channel can be configured individually:
- - pga is the programmable gain amplifier (values are full scale)
-    0: +/- 6.144 V
-    1: +/- 4.096 V
-    2: +/- 2.048 V (default)
-    3: +/- 1.024 V
-    4: +/- 0.512 V
-    5: +/- 0.256 V
- - data_rate in samples per second
-    0: 128
-    1: 250
-    2: 490
-    3: 920
-    4: 1600 (default)
-    5: 2400
-    6: 3300
-
-1) The /ads1015 node
-
-  Required properties:
-
-   - compatible : must be "ti,ads1015"
-   - reg : I2C bus address of the device
-   - #address-cells : must be <1>
-   - #size-cells : must be <0>
-
-  The node contains child nodes for each channel that the platform uses.
-
-  Example ADS1015 node:
-
-    ads1015@49 {
-	    compatible = "ti,ads1015";
-	    reg = <0x49>;
-	    #address-cells = <1>;
-	    #size-cells = <0>;
-
-	    [ child node definitions... ]
-    }
-
-2) channel nodes
-
-  Required properties:
-
-   - reg : the channel number
-
-  Optional properties:
-
-   - ti,gain : the programmable gain amplifier setting
-   - ti,datarate : the converter data rate
-
-  Example ADS1015 channel node:
-
-    channel@4 {
-	    reg = <4>;
-	    ti,gain = <3>;
-	    ti,datarate = <5>;
-    };
diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
new file mode 100644
index 000000000000..c7c850b7ecc6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads1015.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI ADS1015 4 channel I2C analog to digital converter
+
+maintainers:
+  - Dirk Eibach <eibach@gdsys.de>
+  - Daniel Baluta <daniel.baluta@nxp.com>
+
+description: |
+  Datasheet at: https://www.ti.com/lit/gpn/ads1015
+  Supports both single ended and differential channels.
+
+properties:
+  compatible:
+    const: ti,ads1015
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+patternProperties:
+  "^channel@[0-7]+$":
+    type: object
+    description:
+      Child nodes needed for each channel that the platform uses.
+
+    properties:
+      reg:
+        description: |
+          0: Voltage over AIN0 and AIN1.
+          1: Voltage over AIN0 and AIN3.
+          2: Voltage over AIN1 and AIN3.
+          3: Voltage over AIN2 and AIN3.
+          4: Voltage over AIN0 and GND.
+          5: Voltage over AIN1 and GND.
+          6: Voltage over AIN2 and GND.
+          7: Voltage over AIN3 and GND.
+        items:
+          - minimum: 0
+            maximum: 7
+
+      ti,gain:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 5
+        description: |
+          pga is the programmable gain amplifier (values are full scale)
+          0: +/- 6.144 V
+          1: +/- 4.096 V
+          2: +/- 2.048 V (default)
+          3: +/- 1.024 V
+          4: +/- 0.512 V
+          5: +/- 0.256 V
+
+      ti,datarate:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 6
+        description: |
+          Data acquisition rate in samples per second
+          0: 128
+          1: 250
+          2: 490
+          3: 920
+          4: 1600 (default)
+          5: 2400
+          6: 3300
+
+    required:
+      - reg
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@49 {
+            compatible = "ti,ads1015";
+            reg = <0x49>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            channel@0 {
+              reg = <0>;
+            };
+            channel@4 {
+              reg = <4>;
+              ti,gain = <3>;
+              ti,datarate = <5>;
+            };
+        };
+    };
+...
-- 
2.28.0

