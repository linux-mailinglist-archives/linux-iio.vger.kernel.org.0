Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60E4A1490C2
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jan 2020 23:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgAXWOB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jan 2020 17:14:01 -0500
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:33218 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728900AbgAXWOA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 24 Jan 2020 17:14:00 -0500
Received: from localhost.localdomain (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id C5332251E8;
        Fri, 24 Jan 2020 23:04:16 +0100 (CET)
From:   David Heidelberg <david@ixit.cz>
To:     linux-iio@vger.kernel.org
Cc:     David Heidelberg <david@ixit.cz>
Subject: [PATCH 3/7] dt-bindings: iio: light: add support for Dyna-Image AL3320A
Date:   Fri, 24 Jan 2020 23:03:42 +0100
Message-Id: <20200124220346.2655336-3-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124220346.2655336-1-david@ixit.cz>
References: <20200124220346.2655336-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This commit add dt-bindings support to al3320a driver and vendor-prefix
dynaimage.
Partly based on unmerged commit:
"iio: Add Dyna-Image AP3223 ambient light and proximity driver"

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../bindings/iio/light/al3320a.yaml           | 40 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/al3320a.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/al3320a.yaml b/Documentation/devicetree/bindings/iio/light/al3320a.yaml
new file mode 100644
index 000000000000..5b6b0061dee7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/al3320a.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/al3320a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dyna-Image AL3320A sensor
+
+maintainers:
+  - Daniel Baluta <daniel.baluta@intel.com>
+
+properties:
+  compatible:
+    const: dynaimage,al3320a
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor
+
+required:
+  - compatible
+  - reg
+  - interrupt
+  - vdd-supply
+
+examples:
+  - |
+    i2c {
+        al3320a@1c {
+            compatible = "dynaimage,al3320a";
+            reg = <0x1c>;
+            vdd-supply = <&vdd_reg>;
+            interrupts = <0 99 4>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 3dab8150dae7..b36588769cbd 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -265,6 +265,8 @@ patternProperties:
     description: Dragino Technology Co., Limited
   "^dserve,.*":
     description: dServe Technology B.V.
+  "^dynaimage,.*":
+    description: Dyna-Image
   "^ea,.*":
     description: Embedded Artists AB
   "^ebs-systart,.*":
-- 
2.25.0

