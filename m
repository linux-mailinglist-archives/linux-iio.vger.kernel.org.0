Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15A02A1A06
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgJaSwT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728475AbgJaSwS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:52:18 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EBD7205ED;
        Sat, 31 Oct 2020 18:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170337;
        bh=VQJKRRT65H62Y++NqT8W0EZxvj3p7YWlonqQD0nA/9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zkbopPTB0lLMwVaFvL5s1bpA+FLiALky6tjGbRaap2pDe1WXxg+zCzRS+tc7OFnMa
         qp4bxVKuLsY2fgIq+eWUs0X2eTVjrb15KAkt0b6daD9eBN6XtRXT8lCI+mfNqayIgU
         psRR4ZfOw6TzK5udnxNbH/qHQM68rnyosNPS8Was=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 34/46] dt-bindings:iio:adc:ti,palmas-gpadc: txt to yaml format conversion.
Date:   Sat, 31 Oct 2020 18:48:42 +0000
Message-Id: <20201031184854.745828-35-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple conversion of the binding doc for this subnode of the palmas
PMIC.
Given age of driver and lack interaction with original authors,
I've guessed at Tony for a maintainer on this one.  Tony, if you
are happy with that great, otherwise I can default back to myself.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 .../bindings/iio/adc/palmas-gpadc.txt         | 48 ----------
 .../bindings/iio/adc/ti,palmas-gpadc.yaml     | 87 +++++++++++++++++++
 2 files changed, 87 insertions(+), 48 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt b/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
deleted file mode 100644
index 4bb9a86065d1..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-* Palmas general purpose ADC IP block devicetree bindings
-
-Channels list:
-	0 battery type
-	1 battery temp NTC (optional current source)
-	2 GP
-	3 temp (with ext. diode, optional current source)
-	4 GP
-	5 GP
-	6 VBAT_SENSE
-	7 VCC_SENSE
-	8 Backup Battery voltage
-	9 external charger (VCHG)
-	10 VBUS
-	11 DC-DC current probe (how does this work?)
-	12 internal die temp
-	13 internal die temp
-	14 USB ID pin voltage
-	15 test network
-
-Required properties:
-- compatible : Must be "ti,palmas-gpadc".
-- #io-channel-cells: Should be set to <1>.
-
-Optional sub-nodes:
-ti,channel0-current-microamp: Channel 0 current in uA.
-	Values are rounded to derive 0uA, 5uA, 15uA, 20uA.
-ti,channel3-current-microamp: Channel 3 current in uA.
-	Values are rounded to derive 0uA, 10uA, 400uA, 800uA.
-ti,enable-extended-delay: Enable extended delay.
-
-Example:
-
-pmic {
-	compatible = "ti,twl6035-pmic", "ti,palmas-pmic";
-	...
-	gpadc {
-		compatible = "ti,palmas-gpadc";
-		interrupts = <18 0
-			      16 0
-			      17 0>;
-		#io-channel-cells = <1>;
-		ti,channel0-current-microamp = <5>;
-		ti,channel3-current-microamp = <10>;
-		};
-	};
-	...
-};
diff --git a/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml
new file mode 100644
index 000000000000..692dacd0fee5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,palmas-gpadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Palmas general purpose ADC IP block devicetree bindings
+
+maintainers:
+  - Tony Lindgren <tony@atomide.com>
+
+description: |
+  This ADC is often used to provide channels via the io-channels
+  consumer framework.
+  Channels list:
+    0 battery type
+    1 battery temp NTC (optional current source)
+    2 GP
+    3 temp (with ext. diode, optional current source)
+    4 GP
+    5 GP
+    6 VBAT_SENSE
+    7 VCC_SENSE
+    8 Backup Battery voltage
+    9 external charger (VCHG)
+    10 VBUS
+    11 DC-DC current probe (how does this work?)
+    12 internal die temp
+    13 internal die temp
+    14 USB ID pin voltage
+    15 test network
+
+properties:
+  compatible:
+    const: ti,palmas-gpadc
+
+  interrupts:
+    minItems: 1
+    maxItems: 3
+
+  "#io-channel-cells":
+    const: 1
+
+  ti,channel0-current-microamp:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Channel 0 current in uA.
+    enum:
+      - 0
+      - 5
+      - 15
+      - 20
+
+  ti,channel3-current-microamp:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Channel 3 current in uA.
+    enum:
+      - 0
+      - 10
+      - 400
+      - 800
+
+  ti,enable-extended-delay:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Enable extended delay.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - "#io-channel-cells"
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8183-clk.h>
+    pmic {
+        compatible = "ti,twl6035-pmic", "ti,palmas-pmic";
+        adc {
+            compatible = "ti,palmas-gpadc";
+            interrupts = <18 0
+                          16 0
+                          17 0>;
+            #io-channel-cells = <1>;
+            ti,channel0-current-microamp = <5>;
+            ti,channel3-current-microamp = <10>;
+        };
+    };
+...
-- 
2.28.0

