Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2BE3B543D
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jun 2021 18:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhF0QdC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Jun 2021 12:33:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhF0QdB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Jun 2021 12:33:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E091619D1;
        Sun, 27 Jun 2021 16:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624811437;
        bh=6qrzyIL+AHe8VrjfusUVVvYznEz+S6YYi1btIDS1pdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RTT4eztm8ZG7w8y3lr1QWBkPgNKQ7ZuisJH/2krg95wh+PaBYIcNKhDKB6lcUQZ8Q
         00Yecrx8qk2aHermyF8sxpIKR+yu7L+HJKINt2nuhISrEk0kpzHuhysiRJgiPRcTeG
         BXYhQ/TheTx6B+I3sJshIRepRnoUJlZIQv9YHqOwLGZzbpzZ8hgYt28Bwd68kDQD8b
         Z5DfkmCsXtpWhn0HZ6Af4Vktp9VaFgfBKDxd1qHJiwnQIoMzgsHRxyWrWgQsAndYG0
         xvb35YnzEpXgQ1/0o48u1zQRcIuDns++dNCBx2YoGbRWYBLRRQjUW0H8yNQKN18g6L
         5KM9vquSsefMg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/15] dt-bindings: iio: dac: adi,ad5064: Document bindings for many different DACs
Date:   Sun, 27 Jun 2021 17:32:31 +0100
Message-Id: <20210627163244.1090296-3-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210627163244.1090296-1-jic23@kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Note this is documenting bindings that have effectively existing ever
since this driver was merged. The naming conventions for the ADI
parts are inconsistent on the data sheets which has lead to a mixture
of -X and -reference voltage part naming.  We could attempt to clean this
up, but as we are stuck supporting the existing binding it is probably
not worthwhile.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 .../bindings/iio/dac/adi,ad5064.yaml          | 268 ++++++++++++++++++
 1 file changed, 268 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5064.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5064.yaml
new file mode 100644
index 000000000000..05ed4e0ec364
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5064.yaml
@@ -0,0 +1,268 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5064.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5064 and similar DACs
+
+maintainers:
+  - Lars-Peter Clausen <lars@metafoo.de>
+  - Jonathan Cameron <jic23@kernel.org>
+
+description: |
+   A range of similar DAC devices with between 1 and 12 channels. Some parts
+   have internal references, others require a single shared external reference
+   and the remainder have a separate reference pin for each DAC.
+
+properties:
+  compatible:
+    oneOf:
+      - description: I2C devics
+        enum:
+          - adi,ad5024
+          - adi,ad5025
+          - adi,ad5044
+          - adi,ad5045
+          - adi,ad5064
+          - adi,ad5064-1
+          - adi,ad5065
+          - adi,ad5628-1
+          - adi,ad5628-2
+          - adi,ad5648-1
+          - adi,ad5648-2
+          - adi,ad5666-1
+          - adi,ad5666-2
+          - adi,ad5668-1
+          - adi,ad5668-2
+          - adi,ad5668-3
+      - description: SPI devices
+        enum:
+          - adi,ad5625
+          - adi,ad5625r-1v25
+          - adi,ad5625r-2v5
+          - adi,ad5627
+          - adi,ad5627r-1v25
+          - adi,ad5627r-2v5
+          - adi,ad5629-1
+          - adi,ad5629-2
+          - adi,ad5629-3
+          - adi,ad5645r-1v25
+          - adi,ad5645r-2v5
+          - adi,ad5665
+          - adi,ad5665r-1v25
+          - adi,ad5665r-2v5
+          - adi,ad5667
+          - adi,ad5667r-1v25
+          - adi,ad5667r-2v5
+          - adi,ad5669-1
+          - adi,ad5669-2
+          - adi,ad5669-3
+          - lltc,ltc2606
+          - lltc,ltc2607
+          - lltc,ltc2609
+          - lltc,ltc2616
+          - lltc,ltc2617
+          - lltc,ltc2619
+          - lltc,ltc2626
+          - lltc,ltc2627
+          - lltc,ltc2629
+          - lltc,ltc2631-l12
+          - lltc,ltc2631-h12
+          - lltc,ltc2631-l10
+          - lltc,ltc2631-h10
+          - lltc,ltc2631-l8
+          - lltc,ltc2631-h8
+          - lltc,ltc2633-l12
+          - lltc,ltc2633-h12
+          - lltc,ltc2633-l10
+          - lltc,ltc2633-h10
+          - lltc,ltc2633-l8
+          - lltc,ltc2633-h8
+          - lltc,ltc2635-l12
+          - lltc,ltc2635-h12
+          - lltc,ltc2635-l10
+          - lltc,ltc2635-h10
+          - lltc,ltc2635-l8
+          - lltc,ltc2635-h8
+
+  reg:
+    maxItems: 1
+
+  vrefA-supply: true
+  vrefB-supply: true
+  vrefC-supply: true
+  vrefD-supply: true
+  vref-supply: true
+
+  spi-max-frequency: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - # Shared external vref, no internal reference
+    if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad5064-1
+              - adi,ad5625
+              - adi,ad5627
+              - adi,ad5665
+              - adi,ad5667
+              - lltc,ltc2606
+              - lltc,ltc2607
+              - lltc,ltc2616
+              - lltc,ltc2617
+              - lltc,ltc2626
+              - lltc,ltc2627
+    then:
+      properties:
+        vref-supply: true
+        vrefA-supply: false
+        vrefB-supply: false
+        vrefC-supply: false
+        vrefD-supply: false
+      required:
+        - vref-supply
+  - # Shared external vref, internal reference available
+    if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad5625r-1v25
+              - adi,ad5625r-2v5
+              - adi,ad5627r-1v25
+              - adi,ad5627r-2v5
+              - adi,ad5628-1
+              - adi,ad5628-2
+              - adi,ad5629-1
+              - adi,ad5629-2
+              - adi,ad5629-3
+              - adi,ad5645r-1v25
+              - adi,ad5645r-2v5
+              - adi,ad5647r-1v25
+              - adi,ad5647r-2v5
+              - adi,ad5648-1
+              - adi,ad5648-2
+              - adi,ad5665r-1v25
+              - adi,ad5665r-2v5
+              - adi,ad5666-1
+              - adi,ad5666-2
+              - adi,ad5667r-1v25
+              - adi,ad5667r-2v5
+              - adi,ad5668-1
+              - adi,ad5668-2
+              - adi,ad5668-3
+              - adi,ad5669-1
+              - adi,ad5669-2
+              - adi,ad5669-3
+              - lltc,ltc2631-l12
+              - lltc,ltc2631-h12
+              - lltc,ltc2631-l10
+              - lltc,ltc2631-h10
+              - lltc,ltc2631-l8
+              - lltc,ltc2631-h8
+              - lltc,ltc2633-l12
+              - lltc,ltc2633-h12
+              - lltc,ltc2633-l10
+              - lltc,ltc2633-h10
+              - lltc,ltc2633-l8
+              - lltc,ltc2633-h8
+              - lltc,ltc2635-l12
+              - lltc,ltc2635-h12
+              - lltc,ltc2635-l10
+              - lltc,ltc2635-h10
+              - lltc,ltc2635-l8
+              - lltc,ltc2635-h8
+    then:
+      properties:
+        vref-supply: true
+        vrefA-supply: false
+        vrefB-supply: false
+        vrefC-supply: false
+        vrefD-supply: false
+  - # 4 input devices, separate vrefs, no internal reference
+    if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad5024
+              - adi,ad5044
+              - adi,ad5064
+              - lltc,ltc2609
+              - lltc,ltc2619
+              - lltc,ltc2629
+    then:
+      properties:
+        vrefA-supply: true
+        vrefB-supply: true
+        vrefC-supply: true
+        vrefD-supply: true
+        vref-supply: false
+      required:
+        - vrefA-supply
+        - vrefB-supply
+        - vrefC-supply
+        - vrefD-supply
+  - # 2 input devices, separate vrefs, no internal reference
+    if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad5025
+              - adi,ad5045
+              - adi,ad5065
+    then:
+      properties:
+        vrefA-supply: true
+        vrefB-supply: true
+        vrefC-supply: false
+        vrefD-supply: false
+        vref-supply: false
+      required:
+        - vrefA-supply
+        - vrefB-supply
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        dac@0 {
+            reg = <0>;
+            compatible = "adi,ad5625";
+            vref-supply = <&dac_vref>;
+        };
+    };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        dac@0 {
+            reg = <0>;
+            compatible = "adi,ad5625r-1v25";
+        };
+    };
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        dac@42 {
+            reg = <0x42>;
+            compatible = "adi,ad5024";
+            vrefA-supply = <&dac_vref>;
+            vrefB-supply = <&dac_vref>;
+            vrefC-supply = <&dac_vref2>;
+            vrefD-supply = <&dac_vref2>;
+        };
+    };
+...
-- 
2.32.0

