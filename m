Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF643B5451
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jun 2021 18:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhF0Qd1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Jun 2021 12:33:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231294AbhF0QdZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Jun 2021 12:33:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5971761A2B;
        Sun, 27 Jun 2021 16:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624811461;
        bh=FRR0xYI09jli8iFHy0b+7kNgcpOOy9LtqHVGcsG5u5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eQQENEWrbUm2VyPVFwbiV+8UE26vlOGqotR4ZcfnxHRLW7+72fLkA0sWwPuTLXzTY
         OJJH7x86FsmLd303xue4f5LlP0cfS+lNlnUZPUbn9dcj2hnTwNu92wjWjh6Fcx9Syq
         cEsft/h4AdKbzaeNHIM5mVThG80j73zQVNx56FL1nHnjRiciMY6Dj7mZPqmN/wmN2V
         KRVQqN1VD0BxmHIakrdZj8eXE5DoM/xbSGrczhwVgipfxqYxSp2mPWfs/FjhHppLtr
         Ehm0a37jnSB7Q0cKRxtfVOxiy6YI7R2Cg8/CsdiAoDjHA3t6pSlHBHYnqSaxeJkDUz
         3ALxBuXvrifSw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ricardo Ribalda <ribalda@kernel.org>
Subject: [PATCH 11/15] dt-bindings: iio: dac: ad5761: Add missing binding doc.
Date:   Sun, 27 Jun 2021 17:32:40 +0100
Message-Id: <20210627163244.1090296-12-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210627163244.1090296-1-jic23@kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Straight forward binding with vref optional for those part with internal
regulators, but required for those without.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ricardo Ribalda <ribalda@kernel.org>
---
 .../bindings/iio/dac/adi,ad5761.yaml          | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5761.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5761.yaml
new file mode 100644
index 000000000000..7f95a9ed55fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5761.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5761.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5761 and similar DACs
+
+maintainers:
+  - Ricardo Ribalda <ribalda@kernel.org>
+  - Jonathan Cameron <jic23@kernel.org>
+
+properties:
+
+  compatible:
+    enum:
+      - adi,ad5721
+      - adi,ad5721r
+      - adi,ad5761
+      - adi,ad5761r
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  vref-supply:
+    description: If not supplied, internal reference will be used.
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
+              - adi,ad5721
+              - adi,ad5761
+    then:
+      required:
+        - vref-supply
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "adi,ad5721";
+            reg = <0>;
+            vref-supply = <&dac_vref>;
+        };
+    };
+...
-- 
2.32.0

