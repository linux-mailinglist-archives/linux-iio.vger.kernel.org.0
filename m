Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCF828A870
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 19:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388249AbgJKRKn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 13:10:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387984AbgJKRKn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:10:43 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5F142222F;
        Sun, 11 Oct 2020 17:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602436242;
        bh=SAqrR3+DNlpOMb5JijKMJonUOoAsWlE2fxST9BsXLrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CkmatXR6iKF0HwFp4PEPkyhABeBmjW6DFBruj5FYHN7DzVavRd7LfcsQk12SZzq9m
         h1Iya+1mLrbX8DxarjNyMdsMFriVUaaJmsZJMZGMfNjpWyaxiVeMcoXpWY638UjfDS
         r9jy5+zsrPFQLCp6fMbQSTQYKjvhDOXW4YHgCJbQ=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Manivannan Sadhasivam <manivannanece23@gmail.com>
Subject: [PATCH 29/29] dt-bindings:iio:temperature:ti,tmp07 yaml conversion
Date:   Sun, 11 Oct 2020 18:07:49 +0100
Message-Id: <20201011170749.243680-30-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201011170749.243680-1-jic23@kernel.org>
References: <20201011170749.243680-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple conversion from txt to yaml.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Manivannan Sadhasivam <manivannanece23@gmail.com>
---
 .../bindings/iio/temperature/ti,tmp007.yaml   | 57 +++++++++++++++++++
 .../bindings/iio/temperature/tmp007.txt       | 33 -----------
 2 files changed, 57 insertions(+), 33 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp007.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp007.yaml
new file mode 100644
index 000000000000..3c2b7189fa2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp007.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/ti,tmp007.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IR thermopile sensor with integrated math engine
+
+maintainers:
+  - Manivannan Sadhasivam <manivannanece23@gmail.com>
+
+description: |
+  http://www.ti.com/lit/ds/symlink/tmp007.pdf
+
+properties:
+  compatible:
+    const: ti,tmp007
+
+  reg:
+    description: |
+      The I2C address of the sensor (changeable via ADR pins)
+      ------------------------------
+      |ADR1 | ADR0 | Device Address|
+      ------------------------------
+         0      0        0x40
+         0      1        0x41
+         0     SDA       0x42
+         0     SCL       0x43
+         1      0        0x44
+         1      1        0x45
+         1     SDA       0x46
+         1     SCL       0x47
+    maxItems: 1
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        temp-sensor@40 {
+            compatible = "ti,tmp007";
+            reg = <0x40>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <5 0x08>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/temperature/tmp007.txt b/Documentation/devicetree/bindings/iio/temperature/tmp007.txt
deleted file mode 100644
index da0af234a357..000000000000
--- a/Documentation/devicetree/bindings/iio/temperature/tmp007.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-* TI TMP007 - IR thermopile sensor with integrated math engine
-
-Link to datasheet: http://www.ti.com/lit/ds/symlink/tmp007.pdf
-
-Required properties:
-
-  - compatible: should be "ti,tmp007"
-  - reg: the I2C address of the sensor (changeable via ADR pins)
-		------------------------------
-		|ADR1 | ADR0 | Device Address|
-		------------------------------
-		   0      0        0x40
-		   0	  1	   0x41
-		   0	 SDA       0x42
-		   0     SCL       0x43
-		   1      0        0x44
-		   1      1        0x45
-		   1	 SDA	   0x46
-		   1     SCL       0x47
-
-Optional properties:
-
-  - interrupts: interrupt mapping for GPIO IRQ (level active low)
-
-Example:
-
-tmp007@40 {
-        compatible = "ti,tmp007";
-        reg = <0x40>;
-	interrupt-parent = <&gpio0>;
-	interrupts = <5 0x08>;
-};
-
-- 
2.28.0

