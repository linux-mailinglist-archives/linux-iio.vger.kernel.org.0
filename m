Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FED533A779
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 19:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbhCNSSV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 14:18:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234060AbhCNSSI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 14:18:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8417164EE2;
        Sun, 14 Mar 2021 18:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615745888;
        bh=ivoStxHayDObgJdCDz7yp1aoi+PiXjUWhK3ZgLGEj70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ovP46vG6dvjKP3OAJEDhFzu5gSeyKUXa74zwQ0z3wrLK6x/ab+aeZ6HdRsP7JTbnS
         +XHvs6ip0oJL7OxzjBAdi0B4Jk78Nsy4cuQBQxmiff7QRc/iE6YOfjVPCboxpWuYi7
         WrsgE3cV246Ve5SM1tQqeYWr/V7IQ/NzS9vgpIUTy8qZm8HPZHS7hPQkFrPzr9HSCm
         iJrR60t0KyMPiTfyGsD7GicVrzs/HgFmBXq12cOlMuIyuMy+r3K8vZeY7Z7J8PzILG
         +ygobOURNnvUnEt1Rd+wcSh9lZhRSwbqLgYpLvxd0aNPd1A9f3sEhLxZU4GJa9+LPI
         x397UEpP2/eVA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>, Robh+dt@kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 23/24] dt-bindings:iio:cdc:adi,ad7150 binding doc
Date:   Sun, 14 Mar 2021 18:15:10 +0000
Message-Id: <20210314181511.531414-24-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314181511.531414-1-jic23@kernel.org>
References: <20210314181511.531414-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Binding covering the ad7150, ad7151 and ad7156 capacitance to digital
convertors.  The only difference between these is how many channels they
have (1 or 2)

Whilst it is clearly necessary to provide power to the part, we don't
need to know the voltage or anything so if it is always on, there should
be no need to have it specified in the binding.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Robh+dt@kernel.org
Cc: devicetree@vger.kernel.org
Link: https://lore.kernel.org/r/20210207154623.433442-22-jic23@kernel.org
---
 .../bindings/iio/cdc/adi,ad7150.yaml          | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/cdc/adi,ad7150.yaml b/Documentation/devicetree/bindings/iio/cdc/adi,ad7150.yaml
new file mode 100644
index 000000000000..2155d3f5666c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/cdc/adi,ad7150.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/cdc/adi,ad7150.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog device AD7150 and similar capacitance to digital convertors.
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7150
+      - adi,ad7151
+      - adi,ad7156
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  interrupts: true
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7150
+              - adi,ad7156
+    then:
+      properties:
+        interrupts:
+          minItems: 2
+          maxItems: 2
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ad7151
+    then:
+      properties:
+        interrupts:
+          minItems: 1
+          maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        cdc@48 {
+            compatible = "adi,ad7150";
+            reg = <0x48>;
+            interrupts = <25 2>, <26 2>;
+            interrupt-parent = <&gpio>;
+        };
+    };
+...
-- 
2.30.2

