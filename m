Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1836A2A1A02
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgJaSwR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728458AbgJaSwR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:52:17 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB8AC20720;
        Sat, 31 Oct 2020 18:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170336;
        bh=iFGwE/9PSfd7hpDY+R4VCPz8RfOLa8Ub95oGrw/tXgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pD2edyoutsZ01IHWc6s/zNkLbvDIBzOjfQFXsJjUkeXTrfMwd3nts/p9pUyUEc7TK
         +M6CaqLSVHSrINIXsnfiZHWHTGu500peFXSUvYNaeKk5ZB12CywpZiPxIIGiQFc3xm
         NjN6dZ+M4tiefMg/YxgnhTa0yz+oL6AtnH+F3Ub8=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 33/46] dt-bindings:iio:adc:mediatek,mt2701-auxadc: rename and yaml conversion.
Date:   Sat, 31 Oct 2020 18:48:41 +0000
Message-Id: <20201031184854.745828-34-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The current driver and indeed binding are named after a part that they
do not list in the compatible.  Hence renamed the binding to reflect
one that does.

From the driver it looks like there is a lot more backwards compatibility
than the binding currently reflects. We could consider expressing that
more explicitly in the yaml for the compatible property. I have
added one explicit pair that was present in the upstream dtsi files.

I added Matthias alongside Zhiyong Tao because I don't think
Zhiyong Tao has reviewed recent patches.  Please let me know if this
isn't the right thing to do.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
---
 .../iio/adc/mediatek,mt2701-auxadc.yaml       | 77 +++++++++++++++++++
 .../bindings/iio/adc/mt6577_auxadc.txt        | 34 --------
 2 files changed, 77 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
new file mode 100644
index 000000000000..5b21a9fba5dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/mediatek,mt2701-auxadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek AUXADC - ADC on Mediatek mobile SoC (mt65xx/mt81xx/mt27xx)
+
+maintainers:
+  - Zhiyong Tao <zhiyong.tao@mediatek.com>
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+description: |
+  The Auxiliary Analog/Digital Converter (AUXADC) is an ADC found
+  in some Mediatek SoCs which among other things measures the temperatures
+  in the SoC. It can be used directly with register accesses, but it is also
+  used by thermal controller which reads the temperatures from the AUXADC
+  directly via its own bus interface. See mediatek-thermal bindings
+  for the Thermal Controller which holds a phandle to the AUXADC.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - mediatek,mt2701-auxadc
+          - mediatek,mt2712-auxadc
+          - mediatek,mt6765-auxadc
+          - mediatek,mt7622-auxadc
+          - mediatek,mt8173-auxadc
+      - items:
+          - enum:
+              - mediatek,mt7623-auxadc
+          - const: mediatek,mt2701-auxadc
+      - items:
+          - enum:
+              - mediatek,mt8183-auxadc
+              - mediatek,mt8516-auxadc
+          - const: mediatek,mt8173-auxadc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: main
+
+  "#io-channel-cells":
+    const: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - "#io-channel-cells"
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8183-clk.h>
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        adc@11001000 {
+            compatible = "mediatek,mt8183-auxadc",
+                         "mediatek,mt8173-auxadc";
+            reg = <0 0x11001000 0 0x1000>;
+            clocks = <&infracfg CLK_INFRA_AUXADC>;
+            clock-names = "main";
+            #io-channel-cells = <1>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt b/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
deleted file mode 100644
index 1b7ff9e5615a..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-* Mediatek AUXADC - Analog to Digital Converter on Mediatek mobile soc (mt65xx/mt81xx/mt27xx)
-===============
-
-The Auxiliary Analog/Digital Converter (AUXADC) is an ADC found
-in some Mediatek SoCs which among other things measures the temperatures
-in the SoC. It can be used directly with register accesses, but it is also
-used by thermal controller which reads the temperatures from the AUXADC
-directly via its own bus interface. See
-Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
-for the Thermal Controller which holds a phandle to the AUXADC.
-
-Required properties:
-  - compatible: Should be one of:
-    - "mediatek,mt2701-auxadc": For MT2701 family of SoCs
-    - "mediatek,mt2712-auxadc": For MT2712 family of SoCs
-    - "mediatek,mt6765-auxadc": For MT6765 family of SoCs
-    - "mediatek,mt7622-auxadc": For MT7622 family of SoCs
-    - "mediatek,mt8173-auxadc": For MT8173 family of SoCs
-    - "mediatek,mt8183-auxadc", "mediatek,mt8173-auxadc": For MT8183 family of SoCs
-    - "mediatek,mt8516-auxadc", "mediatek,mt8173-auxadc": For MT8516 family of SoCs
-  - reg: Address range of the AUXADC unit.
-  - clocks: Should contain a clock specifier for each entry in clock-names
-  - clock-names: Should contain "main".
-  - #io-channel-cells: Should be 1, see ../iio-bindings.txt
-
-Example:
-
-auxadc: adc@11001000 {
-	compatible = "mediatek,mt2701-auxadc";
-	reg = <0 0x11001000 0 0x1000>;
-	clocks = <&pericfg CLK_PERI_AUXADC>;
-	clock-names = "main";
-	#io-channel-cells = <1>;
-};
-- 
2.28.0

