Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524CD25E95B
	for <lists+linux-iio@lfdr.de>; Sat,  5 Sep 2020 19:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgIERcp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Sep 2020 13:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbgIERcn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Sep 2020 13:32:43 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 513512098B;
        Sat,  5 Sep 2020 17:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599327162;
        bh=XpngdjpF08FQex0xcA2ugQ5BaeqEMiH6ImmMdQcJOM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O+z0XvlWfcptQ4ypMjyQ13xcsk+UvRXXZvMFoPgZiBtecrtRH9ql8NvcX0M593mvS
         YzPPAGR3K3j/0G5KSMtbrzvuoWGNPASEXPY+zyKH90Xp4vRWDMy3MXIWmirAd12wzL
         U7MrFh2xlHQ4226rGfeoLz/xag8ag0UEmUMy2xDM=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/20] dt-bindings:iio:adc:motorola,cpcap-adc yaml conversion
Date:   Sat,  5 Sep 2020 18:29:55 +0100
Message-Id: <20200905173004.216081-12-jic23@kernel.org>
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

Conversion from txt to yaml.
Slightly expanded example to give a bit more context.
Description lifted from the original driver commit.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 .../devicetree/bindings/iio/adc/cpcap-adc.txt | 17 -------
 .../bindings/iio/adc/motorola,cpcap-adc.yaml  | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt b/Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt
deleted file mode 100644
index ec04008e8f4f..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Motorola CPCAP PMIC ADC binding
-
-Required properties:
-- compatible: Should be "motorola,cpcap-adc" or "motorola,mapphone-cpcap-adc"
-- interrupts: The interrupt number for the ADC device
-- interrupt-names: Should be "adcdone"
-- #io-channel-cells: Number of cells in an IIO specifier
-
-Example:
-
-cpcap_adc: adc {
-	compatible = "motorola,mapphone-cpcap-adc";
-	interrupt-parent = <&cpcap>;
-	interrupts = <8 IRQ_TYPE_NONE>;
-	interrupt-names = "adcdone";
-	#io-channel-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml b/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
new file mode 100644
index 000000000000..7811c0abd5d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/motorola,cpcap-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Motorola CPCAP PMIC ADC binding
+
+maintainers:
+  - Tony Lindgren <tony@atomide.com>
+
+description:
+  On Motorola phones like droid 4 there is a custom CPCAP PMIC. This PMIC
+  has ADCs that are used for battery charging and USB PHY VBUS and ID pin
+  detection.
+
+properties:
+  compatible:
+    enum:
+      - motorola,cpcap-adc
+      - motorola,mapphone-cpcap-adc
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: adcdone
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - interrupts
+  - "#io-channel-cells"
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        adc {
+            compatible = "motorola,mapphone-cpcap-adc";
+            interrupt-parent = <&cpcap>;
+            interrupts = <8 IRQ_TYPE_NONE>;
+            interrupt-names = "adcdone";
+            #io-channel-cells = <1>;
+        };
+    };
+...
-- 
2.28.0

