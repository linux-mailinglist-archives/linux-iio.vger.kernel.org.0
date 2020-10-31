Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A889E2A19EA
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbgJaSv6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:51:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbgJaSv6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:51:58 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A41220720;
        Sat, 31 Oct 2020 18:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170318;
        bh=8szzC/jL0BENPAx1vuAE9Kiv9H7uUJBWVNZ6zb2rL1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P7j4qujyuVml6scetbqEBb4QF2xgNJX3SxBpXtQ28v5NdGvql6GBY+Qwdpujz/leM
         tdeGMv7Dj3TCZ44P8pzF2Wc7qZ1/SU8jHWgg7xAHQKnAtFovIoxSe/a3llbnDmVF7D
         Ta0uiwTg+xgcKjQIKMJaMVlYs86QeCNvWKs/VtTU=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH 21/46] dt-bindings:iio:light:vishay,vcnl4035: txt to yaml conversion
Date:   Sat, 31 Oct 2020 18:48:29 +0000
Message-Id: <20201031184854.745828-22-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Only significant change in here was dropping the statement that the
i2c address should be 60.  The datasheet suggests there are variants
available with several different addresses.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Parthiban Nallathambi <pn@denx.de>
---
 .../bindings/iio/light/vcnl4035.txt           | 18 --------
 .../bindings/iio/light/vishay,vcnl4035.yaml   | 45 +++++++++++++++++++
 2 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4035.txt b/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
deleted file mode 100644
index c07c7f052556..000000000000
--- a/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-VISHAY VCNL4035 -  Ambient Light and proximity sensor
-
-Link to datasheet: https://www.vishay.com/docs/84251/vcnl4035x01.pdf
-
-Required properties:
-
-	-compatible: should be "vishay,vcnl4035"
-	-reg: I2C address of the sensor, should be 0x60
-	-interrupts: interrupt mapping for GPIO IRQ (level active low)
-
-Example:
-
-light-sensor@60 {
-	compatible = "vishay,vcnl4035";
-	reg = <0x60>;
-	interrupt-parent = <&gpio4>;
-	interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
-};
diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4035.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4035.yaml
new file mode 100644
index 000000000000..e41c25817dd8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4035.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/vishay,vcnl4035.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VISHAY VCNL4035 ambient Light and proximity sensor
+
+maintainers:
+  - Parthiban Nallathambi <pn@denx.de>
+
+description: |
+  Datasheet at https://www.vishay.com/docs/84251/vcnl4035x01.pdf
+
+properties:
+  compatible:
+    const: vishay,vcnl4035
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
+        light-sensor@60 {
+            compatible = "vishay,vcnl4035";
+            reg = <0x60>;
+            interrupt-parent = <&gpio4>;
+            interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
+...
-- 
2.28.0

