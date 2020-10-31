Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43352A19F6
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgJaSwH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:52:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbgJaSwH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:52:07 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEB812072C;
        Sat, 31 Oct 2020 18:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170326;
        bh=7/W6pWkdZfo3RBWAX/m2CGUiB8efM1eukGKrO2FOxTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cgi159GZ4sSnk9QHNFPnqo4D4ZODh1Nm3KwnqXHKr+pRIFfvqIuAqFIXV7zlznL81
         gUZ2JaCnN/XSZEfDCHxeKhdQShgIejcSJOOS+jJXnLTrlR1SaXmBxfu0Wnjvqn+5vk
         g3Y2NzeJXEUAnypTNgR5ZC6yEtp+XHgOJaIovE0A=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH 27/46] dt-bindings:iio:magnetometer:pni,rm3100: txt to yaml conversion.
Date:   Sat, 31 Oct 2020 18:48:35 +0000
Message-Id: <20201031184854.745828-28-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple binding format conversion.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Song Qiang <songqiang1304521@gmail.com>
---
 .../bindings/iio/magnetometer/pni,rm3100.txt  | 20 ---------
 .../bindings/iio/magnetometer/pni,rm3100.yaml | 42 +++++++++++++++++++
 2 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
deleted file mode 100644
index 497c932e9e39..000000000000
--- a/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-* PNI RM3100 3-axis magnetometer sensor
-
-Required properties:
-
-- compatible : should be "pni,rm3100"
-- reg : the I2C address or SPI chip select number of the sensor.
-
-Optional properties:
-
-- interrupts: data ready (DRDY) from the chip.
-  The interrupts can be triggered on level high.
-
-Example:
-
-rm3100: rm3100@20 {
-	compatible = "pni,rm3100";
-	reg = <0x20>;
-	interrupt-parent = <&gpio0>;
-	interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
-};
diff --git a/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.yaml b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.yaml
new file mode 100644
index 000000000000..a845cdd23e7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/pni,rm3100.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PNI RM3100 3-axis magnetometer sensor
+
+maintainers:
+  - Song Qiang <songqiang1304521@gmail.com>
+
+properties:
+  compatible:
+    const: pni,rm3100
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
+        magnetometer@20 {
+            compatible = "pni,rm3100";
+            reg = <0x20>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+...
-- 
2.28.0

