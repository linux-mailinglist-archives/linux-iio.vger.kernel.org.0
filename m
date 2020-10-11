Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCF628A861
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 19:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388163AbgJKRKT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 13:10:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387984AbgJKRKT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:10:19 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D13542222C;
        Sun, 11 Oct 2020 17:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602436218;
        bh=YBu/KHG023jDo7dYvIZA9imsnQRnzD01yzKpg4FMg9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G79cAuuVXspt6mwtPil73Lx0lth/dv2Z+9QrDdsZ0r+MfLPqPunLUjTS9Yk9bj9sE
         mrXElOI3sKvvoJdW/JccBldwnnmHXqnCxJOXIu3DUmwpsHeoSXluSWS4A62Td862IH
         ui3AxSXAlMOCPaQrG0x24J/3wDVeXk2hgmHLo3JU=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 14/29] dt-bindings:iio:dac:ti,dac7512 yaml conversion
Date:   Sun, 11 Oct 2020 18:07:34 +0100
Message-Id: <20201011170749.243680-15-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201011170749.243680-1-jic23@kernel.org>
References: <20201011170749.243680-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This one is a bit interesting because the binding was moved from
misc a while back, but the linux support for this device is
provided via the ad5446 DAC driver which doesn't currently
have a binding.

For now, lets just convert this file over, but we may want to
think about consolidating this with proper documentation of
the bindings for the other parts supported by the ad5446 driver.

As Daniel Mack does not seem to have been active since 2015,
I've put myself as maintainer of this binding for now.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../bindings/iio/dac/ti,dac7512.txt           | 20 ---------
 .../bindings/iio/dac/ti,dac7512.yaml          | 42 +++++++++++++++++++
 2 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7512.txt b/Documentation/devicetree/bindings/iio/dac/ti,dac7512.txt
deleted file mode 100644
index 1db45939dac9..000000000000
--- a/Documentation/devicetree/bindings/iio/dac/ti,dac7512.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-TI DAC7512 DEVICETREE BINDINGS
-
-Required properties:
-
-	- "compatible"		Must be set to "ti,dac7512"
-
-Property rules described in Documentation/devicetree/bindings/spi/spi-bus.txt
-apply. In particular, "reg" and "spi-max-frequency" properties must be given.
-
-
-Example:
-
-	spi_master {
-		dac7512: dac7512@0 {
-			compatible = "ti,dac7512";
-			reg = <0>; /* CS0 */
-			spi-max-frequency = <1000000>;
-		};
-	};
-
diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7512.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac7512.yaml
new file mode 100644
index 000000000000..4277cf8a4a2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7512.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/ti,dac7512.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments DAC7512 DAC
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+properties:
+  compatible:
+    const: ti,dac7512
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    description:
+      Maximum frequency is reduced for supply voltage of less than 3.6V
+    maximum: 30000000
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "ti,dac7512";
+            reg = <0>; /* CS0 */
+            spi-max-frequency = <1000000>;
+        };
+    };
+...
-- 
2.28.0

