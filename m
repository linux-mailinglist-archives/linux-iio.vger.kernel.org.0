Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245512A1A00
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgJaSwP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728457AbgJaSwN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:52:13 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23DCD20702;
        Sat, 31 Oct 2020 18:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170333;
        bh=8pPbzMTtYqPwgfVAYgw1UGJat1LPuOQLCSUFbh6djDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zLQid0J6QenuIM15HPvEazlRN6VYWlQlWns5YXe18lcEx19+fbFxHxYxv3i0ZPSqx
         bucHGkZXkmb7kbHal65h+yhc9wLofbilCPfKhzDuI9zTyoe6J5WoSC6uh1vA7T/bvA
         xqIxZiBerAdByFF9v4nEqdstmLL1g++P5Qb5uf00=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH 31/46] dt-bindings:iio:adc:x-powers,axp209-adc: txt to yaml conversion
Date:   Sat, 31 Oct 2020 18:48:39 +0000
Message-Id: <20201031184854.745828-32-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This is a very small binding.  It might make sense at some stage
to just roll it into the parent mfd.  For now, converted as is.
The main advantage of this document is the identification of the
channel index values when this is used as a provider of ADC channels
to consumers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Quentin Schulz <quentin.schulz@bootlin.com>
---
 .../bindings/iio/adc/axp20x_adc.txt           | 48 -------------
 .../bindings/iio/adc/x-powers,axp209-adc.yaml | 67 +++++++++++++++++++
 2 files changed, 67 insertions(+), 48 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
deleted file mode 100644
index 7a6313913923..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-* X-Powers AXP ADC bindings
-
-Required properties:
-  - compatible: should be one of:
-    - "x-powers,axp209-adc",
-    - "x-powers,axp221-adc",
-    - "x-powers,axp813-adc",
-  - #io-channel-cells: should be 1,
-
-Example:
-
-&axp22x {
-	adc {
-		compatible = "x-powers,axp221-adc";
-		#io-channel-cells = <1>;
-	};
-};
-
-ADC channels and their indexes per variant:
-
-AXP209
-------
- 0 | acin_v
- 1 | acin_i
- 2 | vbus_v
- 3 | vbus_i
- 4 | pmic_temp
- 5 | gpio0_v
- 6 | gpio1_v
- 7 | ipsout_v
- 8 | batt_v
- 9 | batt_chrg_i
-10 | batt_dischrg_i
-
-AXP22x
-------
- 0 | pmic_temp
- 1 | batt_v
- 2 | batt_chrg_i
- 3 | batt_dischrg_i
-
-AXP813
-------
- 0 | pmic_temp
- 1 | gpio0_v
- 2 | batt_v
- 3 | batt_chrg_i
- 4 | batt_dischrg_i
diff --git a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
new file mode 100644
index 000000000000..288a5ac31a16
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/x-powers,axp209-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: X-Powers AXP ADC bindings
+
+maintainers:
+  - Quentin Schulz <quentin.schulz@bootlin.com>
+
+description: |
+  ADC is frequently used as a provider to consumers of the ADC channels.
+  Device is a child of an axp209 multifunction device
+  ADC channels and their indexes per variant:
+
+  AXP209
+  ------
+   0 | acin_v
+   1 | acin_i
+   2 | vbus_v
+   3 | vbus_i
+   4 | pmic_temp
+   5 | gpio0_v
+   6 | gpio1_v
+   7 | ipsout_v
+   8 | batt_v
+   9 | batt_chrg_i
+  10 | batt_dischrg_i
+
+  AXP22x
+  ------
+   0 | pmic_temp
+   1 | batt_v
+   2 | batt_chrg_i
+   3 | batt_dischrg_i
+
+  AXP813
+  ------
+   0 | pmic_temp
+   1 | gpio0_v
+   2 | batt_v
+   3 | batt_chrg_i
+   4 | batt_dischrg_i
+
+
+properties:
+  compatible:
+    enum:
+      - x-powers,axp209-adc
+      - x-powers,axp221-adc
+      - x-powers,axp813-adc
+
+  "#io-channel-cells":
+    const: 1
+
+additionalProperties: false
+
+examples:
+  - |
+    axp221 {
+        adc {
+            compatible = "x-powers,axp221-adc";
+            #io-channel-cells = <1>;
+        };
+    };
+...
-- 
2.28.0

