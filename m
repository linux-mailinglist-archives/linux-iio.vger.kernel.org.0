Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5721A3B544B
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jun 2021 18:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhF0QdU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Jun 2021 12:33:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231288AbhF0QdU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Jun 2021 12:33:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68E3E619F1;
        Sun, 27 Jun 2021 16:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624811456;
        bh=b5DcIJGaJZtvQooeD30lASG5zHHRlCd4zNzKyFkCOvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dVU8rfx8Pg9990qLiCR9o0isxszadpOKPLrppjE+9Lr6fDL7SH2tLC+URNAytYxfN
         vDSOfGGb5Ygf+sRjO7EZ7QDrlhu5RQnE47HrHJifJElvaH/lrDdNWCcq4bdvOcH5iw
         RNTAii/rjBdBck/7drG7lNvznhEZtXI4IDkz3ODu0js+h7JEGGmKXT08DS4T07j/js
         1EAjxZIcDcfPP++A9jOxIY5hxgN69OfNO698+5F4DRbMdkN+E3UU7DeiwiQt8rSSwN
         Ex9uLLGtdJcEVuS1YEj9WQ9ZHqLFvyolep46wXakrsjmLBZHJ+hUq1NnpVP+S6Y5QQ
         JXFx0taBRl/bQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 09/15] dt-bindings: iio: dac: ad5624r: Add missing binding document
Date:   Sun, 27 Jun 2021 17:32:38 +0100
Message-Id: <20210627163244.1090296-10-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210627163244.1090296-1-jic23@kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple binding, with optional vref.
Note that the Linux driver does support vcc-supply for historical
reasons, but lets not let that get into any bindings that are checked
going forwards.  Hence I have deliberately not documented it.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../bindings/iio/dac/adi,ad5624r.yaml         | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5624r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5624r.yaml
new file mode 100644
index 000000000000..330383b85eeb
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5624r.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5624r.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5624r and similar DACs
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - adi,ad5624r3
+      - adi,ad5644r3
+      - adi,ad5664r3
+      - adi,ad5624r5
+      - adi,ad5644r5
+      - adi,ad5664r5
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  vref-supply:
+    description: If not present, internal reference will be used.
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
+            compatible = "adi,ad5624r3";
+            vref-supply = <&vref>;
+        };
+    };
+...
-- 
2.32.0

