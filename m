Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCEE3B543F
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jun 2021 18:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhF0QdF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Jun 2021 12:33:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhF0QdE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Jun 2021 12:33:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EE1E619F1;
        Sun, 27 Jun 2021 16:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624811440;
        bh=xRdqalZ8E+dwdFxyZIJWwbxFhbSG/NZbYezfc0DgEyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XGuhtJgsfqZpnG0+HVCziy7hYYy0KP/BcX6f2dU7l/Ws5JkNiqewo3WF5+zGXnfmd
         6krv3zOQenfBM/Lnjwsl8X/RCeZ7GDeAZAWP3vRu8ikQyB65DKS2iC1SmsKzu/8/zh
         r1dkN488m5bGqm0fCyPmtOmS3mJCAyFiGiWbMjucRGlQEGKzQY+mXMDXfhUgGQcvWB
         XHfMpqKU4qr5mQYv/EHfJXAw1I+ABu4GN1YcwLLMcu4MJcW1bbopiCardDcn5k6QTX
         EwkaPMR7vXMKFITo0pI64XcCNXQ1y7grC9CU49WOY2cfQsDd83vmb2Fef+qHUcnsra
         PNp2YCTbSgi/Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/15] dt-bindings: iio: dac: adi,ad5360: Add missing binding document
Date:   Sun, 27 Jun 2021 17:32:32 +0100
Message-Id: <20210627163244.1090296-4-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210627163244.1090296-1-jic23@kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Bindings for the family of many channel DACs.  Fairly straight forward
with just a differing number of voltage references (an extra one
for the 40 channel ad4371)

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 .../bindings/iio/dac/adi,ad5360.yaml          | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5360.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5360.yaml
new file mode 100644
index 000000000000..0d8fb56f4b09
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5360.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5360.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5360 and similar DACs
+
+maintainers:
+  - Lars-Peter Clausen <lars@metafoo.de>
+  - Jonathan Cameron <jic23@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - adi,ad5360
+      - adi,ad5361
+      - adi,ad5363
+      - adi,ad5370
+      - adi,ad5371
+      - adi,ad5372
+      - adi,ad5373
+
+  reg:
+    maxItems: 1
+
+  vref0-supply: true
+  vref1-supply: true
+  vref2-supply: true
+
+  spi-max-frequency: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - vref0-supply
+  - vref1-supply
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad5360
+              - adi,ad5361
+              - adi,ad5363
+              - adi,ad5370
+              - adi,ad5372
+              - adi,ad5373
+    then:
+      properties:
+        vref2-supply: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad5371
+      then:
+        required:
+          - vref2-supply
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        dac@0 {
+            reg = <0>;
+            compatible = "adi,ad5371";
+            vref0-supply = <&dac_vref0>;
+            vref1-supply = <&dac_vref1>;
+            vref2-supply = <&dac_vref2>;
+        };
+    };
+...
-- 
2.32.0

