Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3006D28A866
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 19:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388234AbgJKRK1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 13:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387984AbgJKRK1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:10:27 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 713D32222C;
        Sun, 11 Oct 2020 17:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602436226;
        bh=qxz1nFYffvdJkqktFxYS4QndAo/Hvp2pWUygCya5Z4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LKc9CTZONyPgk9m4pURD40QZ1u6px9oFQNaWEiZIby6jhMylkSeKH7nLuAPq1xIDL
         wBhn2ifaGw2EKO5IsaW+Nr0iV2N+YF1h7DSHxtGD1TFpWD/Mu7CbsIGZ4Lkblz3vhH
         m5BOIZpr/+CLh9GNbocGP5SQeqW6x3clWSeeYEq8=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH 19/29] dt-bindings:iio:dac:fsl,vf610-dac yaml conversion
Date:   Sun, 11 Oct 2020 18:07:39 +0100
Message-Id: <20201011170749.243680-20-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201011170749.243680-1-jic23@kernel.org>
References: <20201011170749.243680-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple binding to convert.  Example expanded a little to include
an example bus.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Sanchayan Maity <maitysanchayan@gmail.com>
---
 .../bindings/iio/dac/fsl,vf610-dac.yaml       | 55 +++++++++++++++++++
 .../devicetree/bindings/iio/dac/vf610-dac.txt | 20 -------
 2 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/fsl,vf610-dac.yaml b/Documentation/devicetree/bindings/iio/dac/fsl,vf610-dac.yaml
new file mode 100644
index 000000000000..999c715c6179
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/fsl,vf610-dac.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/fsl,vf610-dac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale vf610 Digital to Analog Converter
+
+maintainers:
+  - Sanchayan Maity <maitysanchayan@gmail.com>
+
+properties:
+  compatible:
+    const: fsl,vf610-dac
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: dac
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/vf610-clock.h>
+    bus@40000000 {
+        compatible = "fsl,aips-bus", "simple-bus";
+        reg = <0x40000000 0x00070000>;
+        ranges;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        dac@400cc000 {
+            compatible = "fsl,vf610-dac";
+            reg = <0x400cc000 0x1000>;
+            interrupts = <55 IRQ_TYPE_LEVEL_HIGH>;
+            clock-names = "dac";
+            clocks = <&clks VF610_CLK_DAC0>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/dac/vf610-dac.txt b/Documentation/devicetree/bindings/iio/dac/vf610-dac.txt
deleted file mode 100644
index 20c6c7ae9687..000000000000
--- a/Documentation/devicetree/bindings/iio/dac/vf610-dac.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Freescale vf610 Digital to Analog Converter bindings
-
-The devicetree bindings are for the new DAC driver written for
-vf610 SoCs from Freescale.
-
-Required properties:
-- compatible: Should contain "fsl,vf610-dac"
-- reg: Offset and length of the register set for the device
-- interrupts: Should contain the interrupt for the device
-- clocks: The clock is needed by the DAC controller
-- clock-names: Must contain "dac" matching entry in the clocks property.
-
-Example:
-dac0: dac@400cc000 {
-	compatible = "fsl,vf610-dac";
-	reg = <0x400cc000 0x1000>;
-	interrupts = <55 IRQ_TYPE_LEVEL_HIGH>;
-	clock-names = "dac";
-	clocks = <&clks VF610_CLK_DAC0>;
-};
-- 
2.28.0

