Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA2E2A17BC
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 14:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgJaNnr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 09:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727589AbgJaNnq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 09:43:46 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B58C20853;
        Sat, 31 Oct 2020 13:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604151825;
        bh=+uTLtslO2QQtK4j3mW/JF0QgRnEKn9Jp/R0CuC672K4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sl2vrPWoaD4RA8lpf5U0cOZINgcCGWkQVfaVCyTOKyHorvMpAK893KCf99a7k5wWQ
         1P6np/50rQJLz9ekfP7UxX62baQyFNi9C+kL3WgnynT5DfU/1wg76AEEQ2DjGaEQz2
         xyRFbyoLlq92vxOnfnzEAA56+9NTIcCoq5wY6zHw=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v2 03/29] dt-bindings:iio:humidity:st,hts221 yaml conversion.
Date:   Sat, 31 Oct 2020 13:40:44 +0000
Message-Id: <20201031134110.724233-4-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031134110.724233-1-jic23@kernel.org>
References: <20201031134110.724233-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Straight forward conversion of this temperature and pressure sensor binding.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/iio/humidity/hts221.txt          | 30 -----------
 .../bindings/iio/humidity/st,hts221.yaml      | 52 +++++++++++++++++++
 2 files changed, 52 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/humidity/hts221.txt b/Documentation/devicetree/bindings/iio/humidity/hts221.txt
deleted file mode 100644
index 84d029372260..000000000000
--- a/Documentation/devicetree/bindings/iio/humidity/hts221.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* HTS221 STM humidity + temperature sensor
-
-Required properties:
-- compatible: should be "st,hts221"
-- reg: i2c address of the sensor / spi cs line
-
-Optional properties:
-- drive-open-drain: the interrupt/data ready line will be configured
-  as open drain, which is useful if several sensors share the same
-  interrupt line. This is a boolean property.
-  If the requested interrupt is configured as IRQ_TYPE_LEVEL_HIGH or
-  IRQ_TYPE_EDGE_RISING a pull-down resistor is needed to drive the line
-  when it is not active, whereas a pull-up one is needed when interrupt
-  line is configured as IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_EDGE_FALLING.
-  Refer to pinctrl/pinctrl-bindings.txt for the property description.
-- interrupts: interrupt mapping for IRQ. It should be configured with
-  flags IRQ_TYPE_LEVEL_HIGH, IRQ_TYPE_EDGE_RISING, IRQ_TYPE_LEVEL_LOW or
-  IRQ_TYPE_EDGE_FALLING.
-
-  Refer to interrupt-controller/interrupts.txt for generic interrupt
-  client node bindings.
-
-Example:
-
-hts221@5f {
-	compatible = "st,hts221";
-	reg = <0x5f>;
-	interrupt-parent = <&gpio0>;
-	interrupts = <0 IRQ_TYPE_EDGE_RISING>;
-};
diff --git a/Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml b/Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml
new file mode 100644
index 000000000000..396451c26728
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/humidity/st,hts221.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HTS221 STM humidity + temperature sensor
+
+maintainers:
+  - Lorenzo Bianconi <lorenzo@kernel.org>
+
+description: |
+   Humidity and temperature sensor with I2C interface and data ready
+   interrupt.
+
+properties:
+  compatible:
+    const: st,hts221
+
+  reg:
+    maxItems: 1
+
+  drive-open-drain:
+    type: boolean
+    description:
+      The interrupt/data ready line will be configured as open drain, which
+      is useful if several sensors share the same interrupt line.
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        hts221@5f {
+            compatible = "st,hts221";
+            reg = <0x5f>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_EDGE_RISING>;
+        };
+    };
+...
-- 
2.28.0

