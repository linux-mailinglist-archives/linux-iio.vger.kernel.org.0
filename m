Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8843428A868
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 19:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388240AbgJKRKb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 13:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387984AbgJKRKa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:10:30 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 958B32222F;
        Sun, 11 Oct 2020 17:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602436229;
        bh=VaEldpieY7f67nCt0bzaA9fnu0j9W/NdL0QIIOM5T6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ffJAyxenh2hv7eJoRgkVtifrfi3mN2YVOo35KdJIdNMcISytEdnaI2m7ngeUBfh5D
         SNhKbKfL7ke2XN8Fg1o22Izs8jOgT3H4dUGJkewlX6Y3wVGKYqElIyHdx/T85tCq1w
         lWA1N6IRZshPbUZH4zVxkDtxLVEYsrlw1ocRMZBI=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Philippe Reynes <tremyfr@yahoo.fr>
Subject: [PATCH 21/29] dt-bindings:iio:dac:maxim,max5821 yaml conversion
Date:   Sun, 11 Oct 2020 18:07:41 +0100
Message-Id: <20201011170749.243680-22-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201011170749.243680-1-jic23@kernel.org>
References: <20201011170749.243680-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple txt to yaml conversion for this binding description.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Philippe Reynes <tremyfr@yahoo.fr>
---
 .../devicetree/bindings/iio/dac/max5821.txt   | 14 ------
 .../bindings/iio/dac/maxim,max5821.yaml       | 44 +++++++++++++++++++
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/max5821.txt b/Documentation/devicetree/bindings/iio/dac/max5821.txt
deleted file mode 100644
index 54276ce8c971..000000000000
--- a/Documentation/devicetree/bindings/iio/dac/max5821.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-Maxim max5821 DAC device driver
-
-Required properties:
-	- compatible: Must be "maxim,max5821"
-	- reg: Should contain the DAC I2C address
-	- vref-supply: Phandle to the vref power supply
-
-Example:
-
-	max5821@38 {
-		compatible = "maxim,max5821";
-		reg = <0x38>;
-		vref-supply = <&reg_max5821>;
-	};
diff --git a/Documentation/devicetree/bindings/iio/dac/maxim,max5821.yaml b/Documentation/devicetree/bindings/iio/dac/maxim,max5821.yaml
new file mode 100644
index 000000000000..c43fb5f3f8ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/maxim,max5821.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/maxim,max5821.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim max5821 dual 10-bit DAC
+
+maintainers:
+  - Philippe Reynes <tremyfr@yahoo.fr>
+
+description: |
+  Datasheet publicly available at:
+  https://datasheets.maximintegrated.com/en/ds/MAX5821.pdf
+
+properties:
+  compatible:
+    const: maxim,max5821
+
+  reg:
+    maxItems: 1
+
+  vref-supply: true
+
+required:
+  - compatible
+  - reg
+  - vref-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@38 {
+            compatible = "maxim,max5821";
+            reg = <0x38>;
+            vref-supply = <&reg_max5821>;
+        };
+    };
+...
-- 
2.28.0

