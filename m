Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C3C25E951
	for <lists+linux-iio@lfdr.de>; Sat,  5 Sep 2020 19:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgIERci (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Sep 2020 13:32:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbgIERc3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Sep 2020 13:32:29 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD406208DB;
        Sat,  5 Sep 2020 17:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599327148;
        bh=InoOPER+dfdK3R3/ShfHnrpVuku/J1rJIDnlIxp0e60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kj1MdPJQcZxTjbbi8FQUUid/I/SpkKZg1jt/ucLSNsE8WLXoBF+Ux8vmaF2vts9a3
         FLfxLwd/l01tqMdIFOuI2bnjMErMfv6KqJhJPPNWji+hcdo1rICd09/S98YfwB11Ne
         ICCvmYStydYWOTrDS0byhATbH4Knuu34Va2uQGYs=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 02/20] dt-bindings:iio:adc:ti,twl4030-madc yaml conversion
Date:   Sat,  5 Sep 2020 18:29:46 +0100
Message-Id: <20200905173004.216081-3-jic23@kernel.org>
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

Conversion from txt to yaml as part of a general move of IIO bindings
to the new format.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Sebastian Reichel <sre@kernel.org>
---
 .../bindings/iio/adc/ti,twl4030-madc.yaml     | 48 +++++++++++++++++++
 .../bindings/iio/adc/twl4030-madc.txt         | 24 ----------
 2 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,twl4030-madc.yaml b/Documentation/devicetree/bindings/iio/adc/ti,twl4030-madc.yaml
new file mode 100644
index 000000000000..6781ad2f0f51
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,twl4030-madc.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,twl4030-madc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MADC subsystem in the TWL4030 power module
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+description:
+  The MADC subsystem in the TWL4030 consists of a 10-bit ADC
+  combined with a 16-input analog multiplexer.
+
+properties:
+  compatible:
+    const: ti,twl4030-madc
+
+  interrupts:
+    maxItems: 1
+
+  ti,system-uses-second-madc-irq:
+    type: boolean
+    description:
+      Set if the second madc irq register should be used, which is intended
+      to be used  by Co-Processors (e.g. a modem).
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - interrupts
+  - "#io-channel-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    twl {
+        madc {
+            compatible = "ti,twl4030-madc";
+            interrupts = <3>;
+            #io-channel-cells = <1>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/adc/twl4030-madc.txt b/Documentation/devicetree/bindings/iio/adc/twl4030-madc.txt
deleted file mode 100644
index 6bdd21404b57..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/twl4030-madc.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-* TWL4030 Monitoring Analog to Digital Converter (MADC)
-
-The MADC subsystem in the TWL4030 consists of a 10-bit ADC
-combined with a 16-input analog multiplexer.
-
-Required properties:
-  - compatible: Should contain "ti,twl4030-madc".
-  - interrupts: IRQ line for the MADC submodule.
-  - #io-channel-cells: Should be set to <1>.
-
-Optional properties:
-  - ti,system-uses-second-madc-irq: boolean, set if the second madc irq register
-				    should be used, which is intended to be used
-				    by Co-Processors (e.g. a modem).
-
-Example:
-
-&twl {
-	madc {
-		compatible = "ti,twl4030-madc";
-		interrupts = <3>;
-		#io-channel-cells = <1>;
-	};
-};
-- 
2.28.0

