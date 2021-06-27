Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734BE3B544F
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jun 2021 18:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhF0QdZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Jun 2021 12:33:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231335AbhF0QdW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Jun 2021 12:33:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C48A4619AD;
        Sun, 27 Jun 2021 16:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624811458;
        bh=UEasIvT43WJvGGnmc3s7yO7hCaHy5uC+Ko8xz+oHGhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gt31NFzkm9LTrcXXfac8+XxgNka8wTHLLaS0iVi4Jqcse1OBcWzhPCbkwTqRc4Xeq
         JSqT008KDG9MBrnYVHAflsCl1es11KLbZzQ5Ku3FyeAx6ENzqzAZT+bWvl2hbh4zEC
         w+GwPxa45z48ucIq+ItLNG/YXT4VLUZrFtMrk3o2anwaM9NvHJblGXZI/MUJCEp/5i
         W5XZR/cIRBYpuvKKZBAgczcxWjTI+R/vVh0PSiFXot2nQY7OEmYaoBwIKZplwXxpzn
         n0O5gS+3ZRXKHmwerbQrasqtNmLHb1c7KrKOHdsl6Ulj0wKUqEk6IQT7fkOsBV0nfu
         c1mF4GJSGVeZw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 10/15] dt-bindings: iio: dac: ad5686 and ad5696: Add missing binding document.
Date:   Sun, 27 Jun 2021 17:32:39 +0100
Message-Id: <20210627163244.1090296-11-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210627163244.1090296-1-jic23@kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The use of vcc-supply for the reference voltage is unsual and should
probably be deprecated as there is an explicit VREF pin on at least
some of these parts.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../bindings/iio/dac/adi,ad5686.yaml          | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
new file mode 100644
index 000000000000..5c26441eae9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5686.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5360 and similar DACs
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+  - Jonathan Cameron <jic23@kernel.org>
+
+properties:
+  compatible:
+    oneOf:
+      - description: SPI devices
+        enum:
+          - adi,ad5310r
+          - adi,ad5672r
+          - adi,ad5674r
+          - adi,ad5676
+          - adi,ad5676r
+          - adi,ad5679r
+          - adi,ad5681r
+          - adi,ad5682r
+          - adi,ad5683
+          - adi,ad5683r
+          - adi,ad5684
+          - adi,ad5684r
+          - adi,ad5685r
+          - adi,ad5686
+          - adi,ad5686r
+      - description: I2C devices
+        enum:
+          - adi,ad5311r
+          - adi,ad5338r
+          - adi,ad5671r
+          - adi,ad5675r
+          - adi,ad5691r
+          - adi,ad5692r
+          - adi,ad5693
+          - adi,ad5693r
+          - adi,ad5694
+          - adi,ad5694r
+          - adi,ad5695r
+          - adi,ad5696
+          - adi,ad5696r
+
+
+  reg:
+    maxItems: 1
+
+  vcc-supply:
+    description: If not supplied the internal reference is used.
+
+  spi-max-frequency: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        dac@0 {
+            reg = <0>;
+            compatible = "adi,ad5310r";
+            vcc-supply = <&dac_vref0>;
+        };
+    };
+...
-- 
2.32.0

