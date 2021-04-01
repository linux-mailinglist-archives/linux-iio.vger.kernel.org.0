Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD277351990
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 20:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbhDARyH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 13:54:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236465AbhDARpC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Apr 2021 13:45:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5480261139;
        Thu,  1 Apr 2021 17:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617298993;
        bh=8hYXBEQLia1l5VDqkRWPplK6G18Gnbyqzd6es6m0EoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qAI8jPaTcz8ZbPjAgRFisNU676PrFeo5j0nrv/4Pcv6PB7ZtQSUQMUM21ZYOFIaPe
         3+rlt3DkjHWmvBrtMPXCsOCKKzoHEITTxG4e13GQ+1QBQ/opJH1HJNYgLLO/DG23Et
         JXb0wR8OkrlKDLxiomd81FBuXZ+uoma1+8SWnezpWdVLs7ZTKC1Tiv/f3jAe9nh7e1
         BYgwTZf7vIKsPnanyws9hXNMwPlcnVkEL6TpeMyJY85jwB6K0gFe7n3GLx7GVO+XJc
         20j3qV6wbLueBxcwWi1jwIbM+slBLu2JyL3qdDWU8ozMtn0jSVOo7KjpWNGrrtTxPq
         s8POxzkL5VYDw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Joachim Eastwood <manabian@gmail.com>
Subject: [PATCH 3/6] dt-bindings:iio:accel:fsl,mma7455 binding doc
Date:   Thu,  1 Apr 2021 18:41:09 +0100
Message-Id: <20210401174112.320497-4-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210401174112.320497-1-jic23@kernel.org>
References: <20210401174112.320497-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Binding documentation for this driver was missing.
Note that the binding and some in tree dts files specifiy interrupts
etc but the driver is fairly simple and does not yet make use of them.

Listed both Joachim and myself as maintainers for this binding on basis
it's Joachim's driver but I don't want to volunteer Joachim too
strongly to look after this doc.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Joachim Eastwood <manabian@gmail.com>
---
 .../bindings/iio/accel/fsl,mma7455.yaml       | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/fsl,mma7455.yaml b/Documentation/devicetree/bindings/iio/accel/fsl,mma7455.yaml
new file mode 100644
index 000000000000..7c8f8bdc2333
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/fsl,mma7455.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/fsl,mma7455.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale MMA7455 and MMA7456 three axis accelerometers
+
+maintainers:
+  - Joachim Eastwood <manabian@gmail.com>
+  - Jonathan Cameron <jic23@kernel.org>
+
+description:
+  Devices support both SPI and I2C interfaces.
+
+properties:
+  compatible:
+    enum:
+      - fsl,mma7455
+      - fsl,mma7456
+  reg:
+    maxItems: 1
+
+  avdd-supply: true
+  vddio-supply: true
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    description:
+      Data ready is only available on INT1, but events can use either or
+      both pins.  If not specified, first element assumed to correspond
+      to INT1 and second (where present) to INT2.
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - "INT1"
+        - "INT2"
+
+  spi-max-frequency: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    # include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        accelerometer@18 {
+            compatible = "fsl,mma7455";
+            reg = <0x18>;
+            vddio-supply = <&iovdd>;
+            avdd-supply = <&avdd>;
+            interrupts = <57 IRQ_TYPE_EDGE_FALLING>, <58 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "INT2", "INT1";
+        };
+    };
+  - |
+    # include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        accelerometer@0 {
+            compatible = "fsl,mma7456";
+            reg = <0>;
+            spi-max-frequency = <10000000>;
+            vddio-supply = <&iovdd>;
+            avdd-supply = <&avdd>;
+            interrupts = <57 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "INT1";
+        };
+    };
+...
-- 
2.31.1

