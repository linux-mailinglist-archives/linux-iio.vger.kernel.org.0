Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8037325E973
	for <lists+linux-iio@lfdr.de>; Sat,  5 Sep 2020 19:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgIERdK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Sep 2020 13:33:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728376AbgIERce (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Sep 2020 13:32:34 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5702C208FE;
        Sat,  5 Sep 2020 17:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599327153;
        bh=dj7sY8XR4e2NJSncNf247eOtg7Oz4MBwoP7y68zXUEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YwHFc6O4rgNmkW7IF5Jn+2eZqlt7LO4PpniTqIgKBk78wAv76EsPj7QpmdvJ8ssYp
         M3n1HdWxLLKMCxuJjx0My3m/xXF+1U+HDNC49asauLg53nEo3Tj1mywWdzuIgFj7up
         eMYZTJgGNKZshwo2GhYWd8rBWgWjr1ZKeCxrCZtw=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH 05/20] dt-bindings:iio:adc:marvell,berlin2-adc yaml conversion
Date:   Sat,  5 Sep 2020 18:29:49 +0100
Message-Id: <20200905173004.216081-6-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905173004.216081-1-jic23@kernel.org>
References: <20200905173004.216081-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Part of a general move of IIO bindings over to yaml.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 .../bindings/iio/adc/berlin2_adc.txt          | 19 -------
 .../bindings/iio/adc/marvell,berlin2-adc.yaml | 50 +++++++++++++++++++
 2 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/berlin2_adc.txt b/Documentation/devicetree/bindings/iio/adc/berlin2_adc.txt
deleted file mode 100644
index 908334c6b07f..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/berlin2_adc.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-* Berlin Analog to Digital Converter (ADC)
-
-The Berlin ADC has 8 channels, with one connected to a temperature sensor.
-It is part of the system controller register set. The ADC node should be a
-sub-node of the system controller node.
-
-Required properties:
-- compatible: must be "marvell,berlin2-adc"
-- interrupts: the interrupts for the ADC and the temperature sensor
-- interrupt-names: should be "adc" and "tsen"
-
-Example:
-
-adc: adc {
-	compatible = "marvell,berlin2-adc";
-	interrupt-parent = <&sic>;
-	interrupts = <12>, <14>;
-	interrupt-names = "adc", "tsen";
-};
diff --git a/Documentation/devicetree/bindings/iio/adc/marvell,berlin2-adc.yaml b/Documentation/devicetree/bindings/iio/adc/marvell,berlin2-adc.yaml
new file mode 100644
index 000000000000..496cddbe96ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/marvell,berlin2-adc.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/marvell,belin2-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Berlin 2 Analog to Digital Convertor (ADC)
+
+maintainers:
+  - Antoine Tenart <antoine.tenart@free-electrons.com>
+
+description:
+  The Berlin ADC has 8 channels, with one connected to a temperature sensor.
+  It is part of the system controller register set. The ADC node should be a
+  sub-node of the system controller node.
+
+properties:
+  compatible:
+    const: marvell,berlin2-adc
+
+  interrupts:
+    minItems: 2
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: adc
+      - const: tsen
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - interrupts
+  - interrupt-names
+
+additionalProperties: false
+
+examples:
+  - |
+    sysctrl {
+        adc {
+            compatible = "marvell,berlin2-adc";
+            interrupt-parent = <&sic>;
+            interrupts = <12>, <14>;
+            interrupt-names = "adc", "tsen";
+        };
+    };
+...
-- 
2.28.0

