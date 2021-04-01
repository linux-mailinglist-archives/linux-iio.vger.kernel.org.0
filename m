Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0235035198D
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 20:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbhDARyF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 13:54:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236464AbhDARpC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Apr 2021 13:45:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8F0C60FDC;
        Thu,  1 Apr 2021 17:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617298990;
        bh=Fm0cejd2vCxIhfGEwUI4LawYQxbjdzYkPvBX6SYU5/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TwRzHuU4gFy+/Dwo/SEiEVwLncIb8bom0zF0vMxvLXxM0/ez5VwC46Ue0bWLgLLAE
         Qz/ezPBa9CXUnKopxtlXb5QD8kJW0aILKrXWobAWZdjCIigQlxSmz/uQfbZ1S/Bx9i
         kT+czKiR2MN6k+don4JuZvWEnw3qV17ydxoh6rdQz9PSbpv2UnURCihCiG3fUV2WSn
         Y62OS7VK6/J9HkcbwP8XHJlOiXvBm3jBLwCPzj1R1SD/8P0b+XPubWORfZtl9+C/jW
         y5QCGnhAbRgl45CInZrBQbUyVKh7vQvBfAA3CFLCWzamY2nS8BoAnOv1uc79QEaaG2
         EfEyuStuMAfvQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/6] dt-bindings:iio:accel:bosch,bma220 device tree binding documentation
Date:   Thu,  1 Apr 2021 18:41:08 +0100
Message-Id: <20210401174112.320497-3-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210401174112.320497-1-jic23@kernel.org>
References: <20210401174112.320497-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Linux driver currently relies on the driver.name to match to the
compatible, but that doesn't mean it isn't a good idea to document it.

Only real complexity is the 3 separate power supplies.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../bindings/iio/accel/bosch,bma220.yaml      | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
new file mode 100644
index 000000000000..942b23ad0712
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/bosch,bma220.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch BMA220 Trixial Acceleration Sensor
+
+maintainers:
+  - Jonathan Cameron <Jonathan.Cameron@huawei.com>
+
+properties:
+  compatible:
+    enum:
+      - bosch,bma220
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  vdda-supply: true
+  vddd-supply: true
+  vddio-supply: true
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
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        accelerometer@0 {
+            compatible = "bosch,bma220";
+            reg = <0>;
+            spi-max-frequency = <2500000>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+...
-- 
2.31.1

