Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BFE3B5445
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jun 2021 18:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhF0QdN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Jun 2021 12:33:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhF0QdM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Jun 2021 12:33:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC246619EE;
        Sun, 27 Jun 2021 16:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624811448;
        bh=MeXy1XMu9z/PWDSHfoCk/MelsWxU00zLJ3GfFEqxGVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qFWuVKSUbR01xUlr4duKzG7mKAGlSJUfmBEFcXD3B2lEgXps7o7qOZb6DwPcfZo8U
         bT7ndfJ/WiYXkrJwEibsmNjazzR/0c97gB0D2qCrUHz0fUOXs4hwa+A0mP8Wr51hmr
         Xi/pgUU+iTkFzm3WHZJ3tsRBxMVLsGFNdSe8UBmOYQX1gVV7LSvCF2vAbKPdTtbiK4
         dSpAg71vn/+ANEHWwb0trvKy1k1Eu/fpVPlfw/UHnDgh50UKDsBWe1vZ4t6oVu1sV/
         RLCqO3DUYZdNwX5sURKxnkhfkIP6fHROnR9xIFjxavWZQBG9kzPkndwbfjcZvasu+0
         ZTVnalWkzTW8g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/15] dt-bindings: iio: dac: ad5449: Add missing binding document.
Date:   Sun, 27 Jun 2021 17:32:35 +0100
Message-Id: <20210627163244.1090296-7-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210627163244.1090296-1-jic23@kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Documenting existing binding, so little flexibility available.
2 channel devices that require separate reference voltages.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 .../bindings/iio/dac/adi,ad5449.yaml          | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5449.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5449.yaml
new file mode 100644
index 000000000000..044332c97743
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5449.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5449.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5449 and similar DACs
+
+maintainers:
+  - Lars-Peter Clausen <lars@metafoo.de>
+  - Jonathan Cameron <jic23@kernel.org>
+
+description:
+  Family of multiplying DACs from Analog Devices
+
+properties:
+  compatible:
+    enum:
+      - adi,ad5415
+      - adi,ad5426
+      - adi,ad5429
+      - adi,ad5432
+      - adi,ad5439
+      - adi,ad5443
+      - adi,ad5449
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  VREF-supply: true
+  VREFA-supply: true
+  VREFB-supply: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad5415
+              - adi,ad5426
+              - adi,ad5432
+    then:
+      properties:
+        VREF-supply: true
+        VREFA-supply: false
+        VREFB-supply: false
+      required:
+        - VREF-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad5429
+              - adi,ad5439
+              - adi,ad5449
+    then:
+      properties:
+        VREF-supply: false
+        VREFA-supply: true
+        VREFB-supply: true
+      required:
+        - VREFA-supply
+        - VREFB-supply
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        dac@0 {
+            reg = <0>;
+            compatible = "adi,ad5415";
+            VREF-supply = <&dac_ref>;
+        };
+    };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        dac@0 {
+            reg = <0>;
+            compatible = "adi,ad5429";
+            VREFA-supply = <&dac_refA>;
+            VREFB-supply = <&dac_refB>;
+        };
+    };
+...
-- 
2.32.0

