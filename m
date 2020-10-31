Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878542A19E9
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgJaSv5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:51:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbgJaSv5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:51:57 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9331520739;
        Sat, 31 Oct 2020 18:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170316;
        bh=PIlhQlJ6RI+wDnZrSZOBiPJJxTqENBthr5Qdxd7tOa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0vRQzQ3uO2raeKX3Bfggs+qAEn4cKf+8BWR3J7XPDqPTenRDhVna7QpACyOKlf3+y
         j3EJOCpFQNH9FTjBfz2p3sfDqyobA26+Rd2xD7KIggRHPDnbNx5H34EGv7T4z9smzt
         jGJ7TMlF1r1OzM/eXv8V+BBXrkZGbbZmvtqszV14=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: [PATCH 20/46] dt-bindings:iio:light:st,uvis25: txt to yaml conversion for this UV sensor
Date:   Sat, 31 Oct 2020 18:48:28 +0000
Message-Id: <20201031184854.745828-21-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

For the example, node name is uv-sensor because the standard option
of light-sensor seemed a little too generic for this.

This one could have just been moved to trivial-devices.yaml but for now
I have kept it as a separate doc.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
---
 .../bindings/iio/light/st,uvis25.yaml         | 42 +++++++++++++++++++
 .../devicetree/bindings/iio/light/uvis25.txt  | 22 ----------
 2 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/st,uvis25.yaml b/Documentation/devicetree/bindings/iio/light/st,uvis25.yaml
new file mode 100644
index 000000000000..c86e5e1d135e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/st,uvis25.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/st,uvis25.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST UVIS25 uv sensor
+
+maintainers:
+  - Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
+
+properties:
+  compatible:
+    const: st,uvis25
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
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
+        uv-sensor@47 {
+            compatible = "st,uvis25";
+            reg = <0x47>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_EDGE_RISING>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/light/uvis25.txt b/Documentation/devicetree/bindings/iio/light/uvis25.txt
deleted file mode 100644
index 043c139d91e6..000000000000
--- a/Documentation/devicetree/bindings/iio/light/uvis25.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-* ST UVIS25 uv sensor
-
-Required properties:
-- compatible: should be "st,uvis25"
-- reg: i2c address of the sensor / spi cs line
-
-Optional properties:
-- interrupts: interrupt mapping for IRQ. It should be configured with
-  flags IRQ_TYPE_LEVEL_HIGH, IRQ_TYPE_EDGE_RISING, IRQ_TYPE_LEVEL_LOW or
-  IRQ_TYPE_EDGE_FALLING.
-
-  Refer to interrupt-controller/interrupts.txt for generic interrupt
-  client node bindings.
-
-Example:
-
-uvis25@47 {
-	compatible = "st,uvis25";
-	reg = <0x47>;
-	interrupt-parent = <&gpio0>;
-	interrupts = <0 IRQ_TYPE_EDGE_RISING>;
-};
-- 
2.28.0

