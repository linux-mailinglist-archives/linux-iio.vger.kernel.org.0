Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F00263560
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 20:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgIISEf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 14:04:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730128AbgIISC0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Sep 2020 14:02:26 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B1C221D95;
        Wed,  9 Sep 2020 18:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599674545;
        bh=KoEd7JhadoV/WuAlOl/OSAE8z4BEPt6pY8SVVSs0NxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PZHtSw8k85IJskvyMcjKJL0liMzjLbmDPShxLYoLVLT24NjgAmEVPvdd1yufvgJW8
         cNuXE6WqgzSZMhDUqSBV/B32lG9vr9B70ZAMU6GX9sREW7JJvayAeJZIdSD1EI693S
         c5PTykDlr0TpeG2vZBbski1lA68Nehd2mt2D0aE8=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rick Altherr <raltherr@google.com>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH v2 04/20] dt-bindings:iio:adc: aspeed,ast2400 yaml conversion
Date:   Wed,  9 Sep 2020 18:59:30 +0100
Message-Id: <20200909175946.395313-5-jic23@kernel.org>
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

Simple txt to yaml conversion. Part of a general move to convert
all the IIO bindings over to yaml.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Rick Altherr <raltherr@google.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>
---
 .../bindings/iio/adc/aspeed,ast2400-adc.yaml  | 54 +++++++++++++++++++
 .../bindings/iio/adc/aspeed_adc.txt           | 22 --------
 2 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml
new file mode 100644
index 000000000000..09018487d690
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/aspeed,ast2400-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADC that forms part of an ASPEED server management processor.
+
+maintainers:
+  - Rick Altherr <raltherr@google.com>
+
+description:
+  This device is a 10-bit converter for 16 voltage channels.  All inputs are
+  single ended.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2400-adc
+      - aspeed,ast2500-adc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description:
+      Input clock used to derive the sample clock. Expected to be the
+      SoC's APB clock.
+
+  resets: true
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - "#io-channel-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/aspeed-clock.h>
+    adc@1e6e9000 {
+        compatible = "aspeed,ast2400-adc";
+        reg = <0x1e6e9000 0xb0>;
+        clocks = <&syscon ASPEED_CLK_APB>;
+        resets = <&syscon ASPEED_RESET_ADC>;
+        #io-channel-cells = <1>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt b/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
deleted file mode 100644
index 034fc2ba100e..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Aspeed ADC
-
-This device is a 10-bit converter for 16 voltage channels.  All inputs are
-single ended.
-
-Required properties:
-- compatible: Should be "aspeed,ast2400-adc" or "aspeed,ast2500-adc"
-- reg: memory window mapping address and length
-- clocks: Input clock used to derive the sample clock. Expected to be the
-          SoC's APB clock.
-- resets: Reset controller phandle
-- #io-channel-cells: Must be set to <1> to indicate channels are selected
-                     by index.
-
-Example:
-	adc@1e6e9000 {
-		compatible = "aspeed,ast2400-adc";
-		reg = <0x1e6e9000 0xb0>;
-		clocks = <&syscon ASPEED_CLK_APB>;
-		resets = <&syscon ASPEED_RESET_ADC>;
-		#io-channel-cells = <1>;
-	};
-- 
2.28.0

