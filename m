Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED17C2A19E4
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgJaSvz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:51:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbgJaSvy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:51:54 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF5462072C;
        Sat, 31 Oct 2020 18:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170313;
        bh=q8M0ngosIXnnFuLGJvLw9/VYkcC7swEZP+Mvf/JvSCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ic7dJTmFhM3GkZTCRxiZMjK1JbJMosywq4c2/wsG4QR7fWBE2RoJ7fwfg2Al8aNJR
         SqsP9HD3tytG4IYdWyze8IeKF6OPQ7y45WOvc8NqtZK9CfM4w5j/BytTPrQnq6ihnn
         7dlTkE4V8jrS6AsqcJNFRFIR8ylTaY7XNUjWkU64=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH 18/46] dt-bindings:iio:light:ti,opt3001: txt to yaml conversion
Date:   Sat, 31 Oct 2020 18:48:26 +0000
Message-Id: <20201031184854.745828-19-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Straight forward format conversion of this simple binding.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andreas Dannenberg <dannenberg@ti.com>
---
 .../devicetree/bindings/iio/light/opt3001.txt | 25 ----------
 .../bindings/iio/light/ti,opt3001.yaml        | 47 +++++++++++++++++++
 2 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/opt3001.txt b/Documentation/devicetree/bindings/iio/light/opt3001.txt
deleted file mode 100644
index 9e6f2998e751..000000000000
--- a/Documentation/devicetree/bindings/iio/light/opt3001.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-* Texas Instruments OPT3001 Ambient Light Sensor
-
-The driver supports interrupt-driven and interrupt-less operation, depending
-on whether an interrupt property has been populated into the DT. Note that
-the optional generation of IIO events on rising/falling light threshold changes
-requires the use of interrupts. Without interrupts, only the simple reading
-of the current light value is supported through the IIO API.
-
-https://www.ti.com/product/opt3001
-
-Required properties:
-  - compatible: should be "ti,opt3001"
-  - reg: the I2C address of the sensor
-
-Optional properties:
-  - interrupts: interrupt mapping for GPIO IRQ (configure for falling edge)
-
-Example:
-
-opt3001@44 {
-	compatible = "ti,opt3001";
-	reg = <0x44>;
-	interrupt-parent = <&gpio1>;
-	interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
-};
diff --git a/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml b/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml
new file mode 100644
index 000000000000..441e9343fc97
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/ti,opt3001.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments OPT3001 Ambient Light Sensor
+
+maintainers:
+  - Andreas Dannenberg <dannenberg@ti.com>
+
+description: |
+  The device supports interrupt-driven and interrupt-less operation, depending
+  on whether an interrupt property has been populated into the DT.
+
+properties:
+  compatible:
+    const: ti,opt3001
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: Should be configured with type IRQ_TYPE_EDGE_FALLING
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
+        light-sensor@44 {
+            compatible = "ti,opt3001";
+            reg = <0x44>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
+...
-- 
2.28.0

