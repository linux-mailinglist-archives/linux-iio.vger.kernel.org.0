Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B89A26354A
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 20:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgIISC2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 14:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730085AbgIISCX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Sep 2020 14:02:23 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E02F21D81;
        Wed,  9 Sep 2020 18:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599674542;
        bh=ZN6NGpvZGo3yujVKM7KhX/BMrihZUNzLTI7BVhYHBnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZdhAi+G7apVMEHq/aHkQhY6WTNO38epa3PIh8dB2HtRYRDN85CBHKfn3bkjNJqxL7
         DisqU4yVAx3qT34ymXfM5XpsDTlgiiFKLIEsT2R3rcdu02Ku/IHwXHQ4yjgXm6n/nh
         VsDo9iysONmY9WKhXBscHYURZ6F62lQKqRSXN+Us=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v2 02/20] dt-bindings:iio:adc:ti,twl4030-madc yaml conversion
Date:   Wed,  9 Sep 2020 18:59:28 +0100
Message-Id: <20200909175946.395313-3-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200909175946.395313-1-jic23@kernel.org>
References: <20200909175946.395313-1-jic23@kernel.org>
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
Acked-by: Sebastian Reichel <sre@kernel.org>
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

