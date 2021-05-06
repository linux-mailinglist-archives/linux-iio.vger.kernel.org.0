Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A5A374FC6
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 09:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbhEFHKt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 May 2021 03:10:49 -0400
Received: from first.geanix.com ([116.203.34.67]:43776 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231929AbhEFHKt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 May 2021 03:10:49 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id B4C5E467B91;
        Thu,  6 May 2021 07:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1620284988; bh=63pLvFMM0fWPTWS+syaz4IkTW6fwQBurzDkBQp/9rdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=No8F7fESBagDiBzzBImd0haxW3P5+LChpfn0bCOOvUITlo58YX9WW/1TT7lm/LbQK
         /L4wtAeoBpdpaKg4jC24Eqqj0u9YPPduV+DVsPA0/alh5cdvP9v5mGE9NvL/uRvD/P
         ww7JdSmab1DKdUqt6i2HKuVo/xMB0jWgC4V7BV1F92L7+0DwVVKzV4Le1JiV2VW1L+
         e3RMv542Dlp3geTyJrmaL+mhr0pFd5jklfIBSsup6/MVLqFITg7Q8rDJZfWf+4OhL0
         OBtHXwle2nxKC/91q2Wzl9SHRW89/TV3LyeYpmXmisjQXt10Q+OWOEZpJ/HRIxATLp
         kuhFZcWcaS6wg==
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de, Nuno.Sa@analog.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        tomas.melin@vaisala.com
Cc:     Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v5 2/6] dt-bindings: iio: accel: fxls8962af: add bindings
Date:   Thu,  6 May 2021 09:09:36 +0200
Message-Id: <20210506070940.312959-2-sean@geanix.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210506070940.312959-1-sean@geanix.com>
References: <20210506070940.312959-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree binding for the NXP FXLS8962AF/FXLS8964AF
accelerometer sensor.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes for v2:
 - removed requirement for interrupt

Changes for v3:
 - None

Changes for v4:
 - Included the dt patch from the RFC

Changes for v5:
 - fixed interrupt enum

 .../bindings/iio/accel/nxp,fxls8962af.yaml    | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
new file mode 100644
index 000000000000..ad529ab2c6e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/nxp,fxls8962af.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP FXLS8962AF/FXLS8964AF Accelerometer driver
+
+maintainers:
+  - Sean Nyekjaer <sean@geanix.com>
+
+description: |
+  NXP FXLS8962AF/FXLS8964AF Accelerometer driver that supports
+  SPI and I2C interface.
+    https://www.nxp.com/docs/en/data-sheet/FXLS8962AF.pdf
+    https://www.nxp.com/docs/en/data-sheet/FXLS8964AF.pdf
+
+properties:
+  compatible:
+    enum:
+      - nxp,fxls8962af
+      - nxp,fxls8964af
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: phandle to the regulator that provides power to the accelerometer
+
+  spi-max-frequency: true
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    enum:
+      - INT1
+      - INT2
+
+  drive-open-drain:
+    type: boolean
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* Example for a I2C device node */
+        accelerometer@62 {
+            compatible = "nxp,fxls8962af";
+            reg = <0x62>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "INT1";
+        };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* Example for a SPI device node */
+        accelerometer@0 {
+            compatible = "nxp,fxls8962af";
+            reg = <0>;
+            spi-max-frequency = <4000000>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "INT1";
+        };
+    };
-- 
2.31.0

