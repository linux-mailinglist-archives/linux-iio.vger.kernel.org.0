Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D394AB183
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 19:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344194AbiBFS6B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 13:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347039AbiBFS6B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 13:58:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4CDC043184
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 10:58:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 493B5B80D88
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 18:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881BBC340F1;
        Sun,  6 Feb 2022 18:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644173877;
        bh=NE0+/5HujTe9xuJH29fRglAyQTczTemVBOTdFl0Kh7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b64WueTqBqqhvAXY6+2YI1Nn8wfYW7LKdIdFJPYEWms1i4Pn2vQ3EImhAPifrG/dc
         sop2lxGENOyDlocAg6WdSfJIXD7YwL2wp0p37bkgrIbNQhLQzrPRddvKuSePHchsUu
         d/4UpYwygMZvKDt/qKLybqlKd+35FCV4m4pLrDIEPvkvJ/x3UnHrpbck53822vCCvD
         /wSqpgs5fN//rCjc7LKuC66EOimOZapN7UDymq3RiKSC324XBpXrG1Dn9ZgqajXlIz
         7Eobmw+sHA7xpwiv/h/vezCrHPtOvTAJtiswAcZVEY0E/rZsF17uYWv+wuO2CtDgHA
         47Be4JcHAb1dw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Hennerich@vger.kernel.org, Michael <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 16/20] dt-bindings:iio:adc:ad7280a: Add binding
Date:   Sun,  6 Feb 2022 19:03:24 +0000
Message-Id: <20220206190328.333093-17-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220206190328.333093-1-jic23@kernel.org>
References: <20220206190328.333093-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add a binding for this Lithium Ion Battery monitoring chip/chain of chips
as it is now clean and ready to move out of staging.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 .../bindings/iio/adc/adi,ad7280a.yaml         | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
new file mode 100644
index 000000000000..a694d5794d4a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7280a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7280a Lithium Ion Battery Monitoring System
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+  - Jonathan Cameron <jic23@kernel.org>
+
+description: |
+  Bindings for the Analog Devices AD7280a Battery Monitoring System.
+  Used in devices such as hybrid electric cars, battery backup and power tools.
+  Multiple chips can be daisy chained and accessed via a single SPI interface.
+  Data sheet found here:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7280A.pdf
+
+properties:
+  compatible:
+    const: adi,ad7280a
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: IRQ line for the ADC
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  adi,voltage-alert-last-chan:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Allows limiting of scope of which channels are considered for voltage
+      alerts, typically because not all are wired to anything. Only applies to
+      last device in the daisy chain.
+    default: 5
+    enum: [3, 4, 5]
+
+  adi,acquisition-time-ns:
+    description:
+      Additional time may be needed to charge the sampling capacitors depending
+      on external writing.
+    default: 400
+    enum: [400, 800, 1200, 1600]
+
+  adi,thermistor-termination:
+    type: boolean
+    description:
+      Enable the thermistor termination function.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      adc@0 {
+        compatible = "adi,ad7280a";
+        reg = <0>;
+        spi-max-frequency = <700000>;
+        interrupt-parent = <&gpio>;
+        interrupts = <25 2>;
+        adi,thermistor-termination;
+        adi,acquisition-time-ns = <800>;
+        adi,voltage-alert-last-chan = <5>;
+      };
+    };
+...
-- 
2.35.1

