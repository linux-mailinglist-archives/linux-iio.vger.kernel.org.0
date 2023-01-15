Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18AB66B32E
	for <lists+linux-iio@lfdr.de>; Sun, 15 Jan 2023 18:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjAOR0d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Jan 2023 12:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjAOR02 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Jan 2023 12:26:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2775565BD;
        Sun, 15 Jan 2023 09:26:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEADAB80B8E;
        Sun, 15 Jan 2023 17:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B49C433EF;
        Sun, 15 Jan 2023 17:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803583;
        bh=DSpVFRa2HLy8rOXPFLzlM+mV4wBVdBIHObvDcFyf1wE=;
        h=From:To:Cc:Subject:Date:From;
        b=quVuOysr24tZytXvBI1G2t2g0KGz+FNM2JXpaKtEqtRiQKSYgkIQ8baXT1YHO5+Tr
         kSqJrfsDDu3OpniFlikAA8vcfqLt3OEiLYGTwmaOPMk6KqHpwTyzKhFSaB+xjpAFMy
         rRC7oTuDR/dkjmYppm7Q3w/Exq65iR5BX9giGzgCv59lXvWXsgDwQaUvq+8f4lpv3k
         csWSlprt5Pyoy6DjzA/WOPMMGTEosbFp1R7YHp/pjd5RQRaG2bEWWWmizuLU/9H/3e
         CcM/npI8gUuOD/QwiFgO7lRX9WdWwe0/3SnAYADVuWlIAoDNVz376UE9zAFCp7c7z8
         qn7VBlWsS5S6Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] dt-bindings: iio: dac: Maxim max5522 DAC
Date:   Sun, 15 Jan 2023 17:39:58 +0000
Message-Id: <20230115173958.134201-1-jic23@kernel.org>
X-Mailer: git-send-email 2.39.0
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

Add binding Doc for this SPI DAC.

The driver was perviously posted but was missing the DT binding document.
https://lore.kernel.org/all/20221106165928.223318-1-angelo.dureghello@timesys.com/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Angelo Dureghello <angelo.dureghello@timesys.com>

---

As it has been a few months and I don't want to end up not taking the driver
simply because it lacked this simple binding doc, I've written one.

 .../bindings/iio/dac/maxim,max5522.yaml       | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/maxim,max5522.yaml b/Documentation/devicetree/bindings/iio/dac/maxim,max5522.yaml
new file mode 100644
index 000000000000..24830f56c501
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/maxim,max5522.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/maxim,max5522.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX5522 Dual 10-bit Voltage-Output SPI DACs
+
+maintainers:
+  - Angelo Dureghello <angelo.dureghello@timesys.com>
+  - Jonathan Cameron <jic23@kernel.org>
+
+description: |
+  Datasheet available at:
+  https://www.analog.com/en/products/max5522.html
+
+properties:
+  compatible:
+    const: maxim,max5522
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+  vrefin-supply: true
+
+required:
+  - compatible
+  - reg
+  - vrefin-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "maxim,max5522";
+            reg = <0>;
+            vrefin-supply = <&vref>;
+        };
+    };
+...
-- 
2.39.0

