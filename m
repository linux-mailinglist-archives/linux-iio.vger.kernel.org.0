Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0E12A1A1A
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgJaSwa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728500AbgJaSw3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:52:29 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E4CA205ED;
        Sat, 31 Oct 2020 18:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170349;
        bh=tF5TMG9YDsXu44meERg+4haDV0Vs3wDEY5Fb2FlRqDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mnOmJgBXNUfrIh7d46bWySZWEFFW/ikSLr7d5xS0L+UyjYQjzh5x+rjw5NfSEMIsk
         psu73h00PqawrGh/bM5U1QPSJF/7fvrOPdnx8v4TaK3EOkbYMKYJO+RHnakORXUdGV
         3wvyXf65mXgT2zFkN7m20yqztcElgVfBXi0P0z3Q=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: [PATCH 42/46] dt-bindings:iio:accel:fsl,mma8452: txt to yaml conversion.
Date:   Sat, 31 Oct 2020 18:48:50 +0000
Message-Id: <20201031184854.745828-43-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple binding so mostly straight forward to convert.
Original binding was unclear on how many interrupts there are.
The device has two such lines, whilst I believe the driver currently
only uses one at a time.  The binding should allow both to be specified.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
---
 .../bindings/iio/accel/fsl,mma8452.yaml       | 62 +++++++++++++++++++
 .../devicetree/bindings/iio/accel/mma8452.txt | 35 -----------
 2 files changed, 62 insertions(+), 35 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml b/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml
new file mode 100644
index 000000000000..3b8e5ebdf90c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/fsl,mma8452.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:
+  Freescale MMA8451Q, MMA8452Q, MMA8453Q, MMA8652FC, MMA8653FC or FXLS8471Q
+  triaxial accelerometer
+
+maintainers:
+  - Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
+
+properties:
+  compatible:
+    enum:
+      - fsl,mma8451
+      - fsl,mma8452
+      - fsl,mma8453
+      - fsl,mma8652
+      - fsl,mma8653
+      - fsl,fxls8471
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      2 highly configurable interrupt lines exist.
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    description: Specify which interrupt line is in use.
+    enum:
+      - INT1
+      - INT2
+
+  vdd-supply: true
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        accel@1d {
+            compatible = "fsl,mma8453";
+            reg = <0x1d>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <5 0>;
+            interrupt-names = "INT2";
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/accel/mma8452.txt b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
deleted file mode 100644
index e132394375a1..000000000000
--- a/Documentation/devicetree/bindings/iio/accel/mma8452.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-Freescale MMA8451Q, MMA8452Q, MMA8453Q, MMA8652FC, MMA8653FC or FXLS8471Q
-triaxial accelerometer
-
-Required properties:
-
-  - compatible: should contain one of
-    * "fsl,mma8451"
-    * "fsl,mma8452"
-    * "fsl,mma8453"
-    * "fsl,mma8652"
-    * "fsl,mma8653"
-    * "fsl,fxls8471"
-
-  - reg: the I2C address of the chip
-
-Optional properties:
-
-  - interrupts: interrupt mapping for GPIO IRQ
-
-  - interrupt-names: should contain "INT1" and/or "INT2", the accelerometer's
-		     interrupt line in use.
-
-  - vdd-supply: phandle to the regulator that provides vdd power to the accelerometer.
-
-  - vddio-supply: phandle to the regulator that provides vddio power to the accelerometer.
-
-Example:
-
-	mma8453fc@1d {
-		compatible = "fsl,mma8453";
-		reg = <0x1d>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <5 0>;
-		interrupt-names = "INT2";
-	};
-- 
2.28.0

