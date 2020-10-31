Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8013D2A19C8
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgJaSve (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:51:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728395AbgJaSvd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:51:33 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B0BA20723;
        Sat, 31 Oct 2020 18:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170293;
        bh=WKV36q4UiFqh94PWNWGqvJw5ltboEidH/EpBsVhJWR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GHmJqDlBy5PGrG+f9fSic28HL/SouLq/Yuyc+WpqVF1lMKU9wzFVG2gaWMnbkC4Db
         3zcJKcULon8iorftd8Z7VIIu1kqKbrcYc26r2idfRBHhWaah+JtYPqHVwngFmbf8XC
         fTqgvOBXoSsNZHweqqR7uKGebCQa3XI7yGY1P43g=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Chris Coffey <cmc@babblebit.net>
Subject: [PATCH 04/46] dt-bindings:iio:potentiometer:microchip,mcp41010 txt to yaml conversion
Date:   Sat, 31 Oct 2020 18:48:12 +0000
Message-Id: <20201031184854.745828-5-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

A simple binding that I almost just move to trivial devices.
The small amount of additional documentation and relatively large number
of compatible entries convinced me to suggest we keep this one separately
documented.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Chris Coffey <cmc@babblebit.net>
---
 .../bindings/iio/potentiometer/mcp41010.txt   | 28 -----------
 .../iio/potentiometer/microchip,mcp41010.yaml | 48 +++++++++++++++++++
 2 files changed, 48 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt b/Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt
deleted file mode 100644
index 4f245e8469fd..000000000000
--- a/Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-* Microchip MCP41010/41050/41100/42010/42050/42100 Digital Potentiometer
-
-Datasheet publicly available at:
-https://ww1.microchip.com/downloads/en/devicedoc/11195c.pdf
-
-The node for this driver must be a child node of a SPI controller, hence
-all mandatory properties described in
-
-        Documentation/devicetree/bindings/spi/spi-bus.txt
-
-must be specified.
-
-Required properties:
-	- compatible:  	Must be one of the following, depending on the
-			model:
-			"microchip,mcp41010"
-			"microchip,mcp41050"
-			"microchip,mcp41100"
-			"microchip,mcp42010"
-			"microchip,mcp42050"
-			"microchip,mcp42100"
-
-Example:
-potentiometer@0 {
-	compatible = "microchip,mcp41010";
-	reg = <0>;
-	spi-max-frequency = <500000>;
-};
diff --git a/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp41010.yaml b/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp41010.yaml
new file mode 100644
index 000000000000..567697d996ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp41010.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/potentiometer/microchip,mcp41010.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP41010/41050/41100/42010/42050/42100 Digital Potentiometer
+
+maintainers:
+  - Chris Coffey <cmc@babblebit.net>
+
+description: |
+  Datasheet: https://ww1.microchip.com/downloads/en/devicedoc/11195c.pdf
+
+properties:
+  compatible:
+    enum:
+      - microchip,mcp41010
+      - microchip,mcp41050
+      - microchip,mcp41100
+      - microchip,mcp42010
+      - microchip,mcp42050
+      - microchip,mcp42100
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        potentiometer@0 {
+            compatible = "microchip,mcp41010";
+            reg = <0>;
+            spi-max-frequency = <500000>;
+        };
+    };
+...
-- 
2.28.0

