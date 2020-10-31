Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B102D2A19EF
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgJaSwD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:52:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbgJaSwD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:52:03 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1DE920720;
        Sat, 31 Oct 2020 18:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170322;
        bh=wnXWTxJo+4XkKc+gpzNSmMjl4Sp4fe6181L7kywo6ZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sfwk2KOdtHjK4IBBbw911ciLf0qCBJLM4zybtFM6pVrSXxsrjjMr/9JTSUGkMLYBh
         48iuJY6u9EgdXgtkptIWOL3CfI2HF+PQ+kQVeKEpPXKhFUV6QrxqxhHqBwn07xO3mQ
         65SXxmP+1Q2U47Y0nrH5DsELub+msKLOEF68bhAY=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 24/46] dt-bindings:iio:magnetometer:asahi-kasei,ak8974: txt to yaml format conversion
Date:   Sat, 31 Oct 2020 18:48:32 +0000
Message-Id: <20201031184854.745828-25-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple conversion.  I have pruned descriptions that did not add much useful
detail.  Note that the mount-matrix description will form part of a generic
IIO binding.  No need to repeat that in every driver that uses it.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/iio/magnetometer/ak8974.txt      | 31 ----------
 .../iio/magnetometer/asahi-kasei,ak8974.yaml  | 57 +++++++++++++++++++
 2 files changed, 57 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt b/Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt
deleted file mode 100644
index 7f06eff3b504..000000000000
--- a/Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-* Asahi Kasei AK8974 magnetometer sensor
-
-Required properties:
-
-- compatible:
-    * "asahi-kasei,ak8974"
-    * "alps,hscdtd008a"
-- reg : the I2C address of the magnetometer
-
-Optional properties:
-
-- avdd-supply: regulator supply for the analog voltage
-  (see regulator/regulator.txt)
-- dvdd-supply: regulator supply for the digital voltage
-  (see regulator/regulator.txt)
-- interrupts: data ready (DRDY) and interrupt (INT1) lines
-  from the chip, the DRDY interrupt must be placed first.
-  The interrupts can be triggered on rising or falling
-  edges alike.
-- mount-matrix: an optional 3x3 mounting rotation matrix
-
-Example:
-
-ak8974@f {
-	compatible = "asahi-kasei,ak8974";
-	reg = <0x0f>;
-	avdd-supply = <&foo_reg>;
-	dvdd-supply = <&bar_reg>;
-	interrupts = <0 IRQ_TYPE_EDGE_RISING>,
-		     <1 IRQ_TYPE_EDGE_RISING>;
-};
diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8974.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8974.yaml
new file mode 100644
index 000000000000..cefb70def188
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8974.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/asahi-kasei,ak8974.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Asahi Kasei AK8974 magnetometer sensor
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+properties:
+  compatible:
+    enum:
+      - alps,hscdtd008a
+      - asahi-kasei,ak8974
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+    description: |
+      Data ready (DRDY) and interrupt (INT1) lines from the chip. The DRDY
+      interrupt must be placed first. The interrupts can be triggered on
+      rising or falling edges.
+
+  avdd-supply: true
+
+  dvdd-supply: true
+
+  mount-matrix: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@f {
+            compatible = "asahi-kasei,ak8974";
+            reg = <0x0f>;
+            avdd-supply = <&foo_reg>;
+            dvdd-supply = <&bar_reg>;
+            interrupts = <0 IRQ_TYPE_EDGE_RISING>,
+                         <1 IRQ_TYPE_EDGE_RISING>;
+        };
+    };
+...
-- 
2.28.0

