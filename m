Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E9F67892C
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jan 2023 22:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjAWVFN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Jan 2023 16:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbjAWVFC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Jan 2023 16:05:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEE738661;
        Mon, 23 Jan 2023 13:04:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8B67B80EA4;
        Mon, 23 Jan 2023 21:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E06C433EF;
        Mon, 23 Jan 2023 21:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674507886;
        bh=JfdSnP/IqcEU/RUpwi8uEy+ZYVr2XcnzyLksuNk/4MU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YNRo016XnjSx+2eUjgQivHPW6qu9wGLJEfSclufrG+a7FCGG7CLXpMnTOeMRusC5g
         2qGeqOcz9IFBj3uIJhkn6he4GU2IiZSb2eLlW/geh3Ahmvcw47x5hbTILYI08UN0SJ
         QoJRUQ0g3PsYFMRTMmJ0tRsff+VJ63rICoKEuxEZry5IgyUpOKrBnUPSZ/mrPUpa/G
         yV0lTP99JC1s/Q8fWtqc94/a/Diok3RT26pMgM4of7m3nDVQIqdNZ77z1f1L3m9WVZ
         vKZm37Wuig7NywbFgDX+BjreTJmC7u73FX+Mw+IWUezQzjqGSIzDGVb0Q4rH8SQXbo
         rV8q90XoX8DsQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Barry Song <baohua@kernel.org>
Subject: [PATCH 12/12] dt-bindings: iio: accel: Add ADIS16203 Inclinometer
Date:   Mon, 23 Jan 2023 21:17:58 +0000
Message-Id: <20230123211758.563383-13-jic23@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123211758.563383-1-jic23@kernel.org>
References: <20230123211758.563383-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
---
 .../bindings/iio/accel/adi,adis16203.yaml     | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
new file mode 100644
index 000000000000..05c095247e10
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
@@ -0,0 +1,59 @@
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
+    maxItems: 2
+
+  interrupt-names:
+    description:
+      Device has two configurable outputs, both of which may be used
+      as interrupt sources.
+    enum:
+      - dio0
+      - dio1
+
+  reset-gpios: true
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

