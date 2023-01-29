Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8D6680004
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jan 2023 16:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjA2Pmj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Jan 2023 10:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbjA2Pmi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2023 10:42:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1281E1E5FF;
        Sun, 29 Jan 2023 07:42:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95A67B80D1D;
        Sun, 29 Jan 2023 15:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8677C4339B;
        Sun, 29 Jan 2023 15:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675006953;
        bh=qmVa9jZ4Srbg16/5mWKHGWabaBJ05sNxieFRffrNPHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z74NC/g+OS7foeXBmDewrt9cJyC+TKDOQ+L9Vzo0+tPwSZF3d51ThEkUb2zKtfbzZ
         MucyHHusf93HIPZsQ8KpqABHemTy3aHh1q8K8TT6vGO5DzMA9R4WJW9ndRiJIVULbx
         tGM8j29g+Gs7LtYx5d04DrTXyXrgiYFtaNI/DeISRlojhBcQG2fnkIw7xa0sLpoiwP
         Cjvh+XEW+iYiiHpT7cVhUSfYs5Ett1j4SCya6dcL0LyZyB4kWmky/+PRAvCLsNoG/e
         L7bU0fOYYGUvSd7QwQGlIsQiYU3LyQZjacacsFU32g8+aKR3M+GJxdlgTIZRpS04it
         jAxJJpDN/+m8Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 12/12] dt-bindings: iio: accel: Add ADIS16203 Inclinometer
Date:   Sun, 29 Jan 2023 15:56:02 +0000
Message-Id: <20230129155602.740743-13-jic23@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230129155602.740743-1-jic23@kernel.org>
References: <20230129155602.740743-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

There has been a driver in staging for quite a while.
Given we are now moving it to the main tree, time to make sure it
has binding documentation.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

--
V2:
- maxItems/minItems added where needed.
- fix interrupt-names to allow multiple entries.
---
 .../bindings/iio/accel/adi,adis16203.yaml     | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
new file mode 100644
index 000000000000..2248fb4eb2c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/adi,adis16203.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADIS16203 Programmable 360 degree inclinometer
+
+maintainers:
+  - Jonathan Cameron <Jonathan.Cameron@huawei.com>
+
+properties:
+  compatible:
+    const: adi,adis16203
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    description:
+      Device has two configurable outputs, both of which may be used
+      as interrupt sources.
+    items:
+      enum:
+        - dio0
+        - dio1
+
+  reset-gpios:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        accelerometer@0 {
+            compatible = "adi,adis16201";
+            reg = <0>;
+            spi-max-frequency = <2500000>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "dio0";
+        };
+    };
+...
+
-- 
2.39.1

