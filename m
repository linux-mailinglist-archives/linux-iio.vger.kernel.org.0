Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5762A19D1
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgJaSvk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbgJaSvk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:51:40 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19A2820702;
        Sat, 31 Oct 2020 18:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170299;
        bh=e/MkVrjRakw7cLnmR3YugQ6Pwb34z3r6wXW5JBj6mss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LtpWeygI1e5Ap4EvY8OlSPnBCVaiO9OZBLB9MLK6Lo4+SWW9Yz0u2n8vd4LJPJsbW
         Mld4g7ZijLcREllJuPlBh4uzEFP1jmWYAkCaZBiY7i+C0BpzyX6prCwOSNJR2Y/0B4
         iCchAtiXb8XISYmc3Wtt2sk4l16EMgMVIHoxr1Bk=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 08/46] dt-bindings:iio:health:ti,afe4404: txt to yaml conversion
Date:   Sat, 31 Oct 2020 18:48:16 +0000
Message-Id: <20201031184854.745828-9-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This basically has same questions as for the afe4403.  We could combine
the two bindings, but as the drivers are separate and it would be a little
fiddly due to different buses let's keep the separating.
To repeat questions from the ti,afe4403 binding.

A few questions came up whilst converting this one.
1) What is actually required?
   - Checking Linux driver, interrupt is not, and the tx-supply could
     be supplied by a stub regulator as long as it's always on.
     As such I have reduced the required list to just compatible and reg.
2) What is the regulator called?
   - It's tx-supply in the binding doc, but the driver request tx_sup
     I've left this alone for now.  Andrew could you confirm what is
     intended for this?

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andrew F. Davis <afd@ti.com>
---
 .../bindings/iio/health/afe4404.txt           | 29 -----------
 .../bindings/iio/health/ti,afe4404.yaml       | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/health/afe4404.txt b/Documentation/devicetree/bindings/iio/health/afe4404.txt
deleted file mode 100644
index 0b52830a0d9c..000000000000
--- a/Documentation/devicetree/bindings/iio/health/afe4404.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Texas Instruments AFE4404 Heart rate and Pulse Oximeter
-
-Required properties:
- - compatible		: Should be "ti,afe4404".
- - reg			: I2C address of the device.
- - tx-supply		: Regulator supply to transmitting LEDs.
- - interrupts		: The interrupt line the device ADC_RDY pin is
-			  connected to. For details refer to,
-			  ../interrupt-controller/interrupts.txt.
-
-Optional properties:
- - reset-gpios		: GPIO used to reset the device.
-			  For details refer to, ../gpio/gpio.txt.
-
-Example:
-
-&i2c2 {
-	heart_mon@58 {
-		compatible = "ti,afe4404";
-		reg = <0x58>;
-
-		tx-supply = <&vbat>;
-
-		interrupt-parent = <&gpio1>;
-		interrupts = <28 IRQ_TYPE_EDGE_RISING>;
-
-		reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml b/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml
new file mode 100644
index 000000000000..187b99b22312
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/health/ti,afe4404.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments AFE4404 Heart rate and Pulse Oximeter
+
+maintainers:
+  - Andrew F. Davis <afd@ti.com>
+
+properties:
+  compatible:
+    const: ti,afe4403
+
+  reg:
+    maxItems: 1
+
+  tx-supply:
+    description: Supply to transmitting LEDs.
+
+  interrupts:
+    maxItems: 1
+    description: Connected to ADC_RDY pin.
+
+  reset-gpios: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        heart_mon@58 {
+            compatible = "ti,afe4404";
+            reg = <0x58>;
+            tx-supply = <&vbat>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <28 IRQ_TYPE_EDGE_RISING>;
+            reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
+        };
+    };
+...
-- 
2.28.0

