Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E44229E35
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 19:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbgGVROk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 13:14:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732119AbgGVROe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Jul 2020 13:14:34 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAB1A207E8;
        Wed, 22 Jul 2020 17:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595438073;
        bh=GjUjbdMOXzZ7zvnhgBI+PToZohDSdnP4YTbKBRVL5jM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B2+LcZtTM7P4Ebp9YHQDDBobTMNE4Ez9FgqBH3xoPwAJI8s5dTTQRhCuYmptflQ3k
         XhGuCwx4YhhW7lTRgSJ3qHCLis14h9uxj0YcJXC4GUjKgwqd6sZKdjqK8vIu/tPk9T
         Wq4OwtahMXvsx0WDvsVMCyYZPCfJjdnvWNKuwtOE=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3/3] dt-bindings: iio: adc: maxim,max9611 yaml conversions
Date:   Wed, 22 Jul 2020 18:12:24 +0100
Message-Id: <20200722171224.989138-4-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722171224.989138-1-jic23@kernel.org>
References: <20200722171224.989138-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Straight forward conversion of this binding for this
current sense amplifier and ADC.

Cc: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../devicetree/bindings/iio/adc/max9611.txt   | 27 ----------
 .../bindings/iio/adc/maxim,max9611.yaml       | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/max9611.txt b/Documentation/devicetree/bindings/iio/adc/max9611.txt
deleted file mode 100644
index ab4f43145ae5..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/max9611.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-* Maxim max9611/max9612 current sense amplifier with 12-bits ADC interface
-
-Maxim max9611/max9612 is an high-side current sense amplifier with integrated
-12-bits ADC communicating over I2c bus.
-The device node for this driver shall be a child of a I2c controller.
-
-Required properties
-  - compatible: Should be "maxim,max9611" or "maxim,max9612"
-  - reg: The 7-bits long I2c address of the device
-  - shunt-resistor-micro-ohms: Value, in micro Ohms, of the current sense shunt
-			        resistor
-
-Example:
-
-&i2c4 {
-	csa: adc@7c {
-		compatible = "maxim,max9611";
-		reg = <0x7c>;
-
-		shunt-resistor-micro-ohms = <5000>;
-	};
-};
-
-This device node describes a current sense amplifier sitting on I2c4 bus
-with address 0x7c (read address is 0xf9, write address is 0xf8).
-A sense resistor of 0,005 Ohm is installed between RS+ and RS- current-sensing
-inputs.
diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max9611.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max9611.yaml
new file mode 100644
index 000000000000..a9fc05e6b62c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max9611.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/maxim,max9611.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX9611 and similar current sense amplifiers with integrated ADCs
+
+maintainers:
+  - Jacopo Mondi <jacopo@jmondi.org>
+
+description: |
+   These devices combine a high-side current sense amplifier with a 12 bit ADC.
+   They have an i2c interface.
+
+properties:
+  compatible:
+    enum:
+      - maxim,max9611
+      - maxim,max9612
+
+  reg:
+    maxItems: 1
+
+  shunt-resistor-micro-ohms:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Value in micro Ohms of the shunt resistor connected between the RS+ and
+      RS- inputs, across which the current is measured.  Value needed to compute
+      the scaling of the measured current.
+
+required:
+  - compatible
+  - reg
+  - shunt-resistor-micro-ohms
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@7c {
+            compatible = "maxim,max9611";
+            reg = <0x7c>;
+            shunt-resistor-micro-ohms = <5000>;
+        };
+    };
+...
-- 
2.27.0

