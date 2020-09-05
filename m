Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C6125E950
	for <lists+linux-iio@lfdr.de>; Sat,  5 Sep 2020 19:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgIERci (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Sep 2020 13:32:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbgIERcc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Sep 2020 13:32:32 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A05C220C09;
        Sat,  5 Sep 2020 17:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599327152;
        bh=KoEd7JhadoV/WuAlOl/OSAE8z4BEPt6pY8SVVSs0NxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XM6m8PtzYabdvgh2YrS0AApxsvkrh6BzaFoGU1cWWKBJWqf0wFL+DJ+aZcRbzUed7
         uEiPooVPhnN5oSPmlT3UaosyjzchnQb4pUNvei8ekwC9VSy+3l+NgHU9tFd4CY9Fmh
         Dt6QLTmKL0HmOnnCSlgYWfCdgXvl0MkEzPcPlk00=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rick Altherr <raltherr@google.com>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH 04/20] dt-bindings:iio:adc: aspeed,ast2400 yaml conversion
Date:   Sat,  5 Sep 2020 18:29:48 +0100
Message-Id: <20200905173004.216081-5-jic23@kernel.org>
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

