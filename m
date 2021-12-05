Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25FF468D39
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 21:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238538AbhLEU0P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 15:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238544AbhLEU0M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 15:26:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6F4C061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 12:22:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A124B80EE1
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 20:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DA5C341C5;
        Sun,  5 Dec 2021 20:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638735762;
        bh=Tl3K0skETdc+ojf4Mk0ec5IrJatDzKM8FNFQQ/f0dN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SU2l2RrIS36N4W0QFxrgyux10iih186Vz8Daqq4+9CxNz6vZR06WsA8Ip/ATaZ9AL
         OEiU3DcwVLa+7PjHoMI9ofvn365pksgp/+AXpr9tYGb0U9emmlhogm8hH+8XG9K3OD
         j3hMrGiMStBRU2fWGyAhVDUHB5FdpRQZbKUuaLHNnP2mRYiZWMgt8ZyOFnQodXUUG6
         rFY8hpd04C9u0B+iC7SsZZZ9NGnYZjbtqmiCZThQSjcTbwL4UGpyQ5B+KrMDVyFRnR
         M3W1TALToR6HLnckGOpT21H4vhemP13g1W2rwXIkwdSNP8AcgHckHJGmW8OEAJQ0ia
         8Y18O6EbpMnrg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 15/17] dt-bindings:iio:adc:ad7280a: Add binding
Date:   Sun,  5 Dec 2021 20:27:08 +0000
Message-Id: <20211205202710.2847005-16-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205202710.2847005-1-jic23@kernel.org>
References: <20211205202710.2847005-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add a binding for this Lithium Ion Battery monitoring chip/chain of chips
as it is now clean and ready to move out of staging.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/adc/adi,ad7280a.yaml         | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
new file mode 100644
index 000000000000..77b8f67fe446
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
@@ -0,0 +1,87 @@
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
+  adi,temp-alert-last-chan:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Allows limiting of scope of which channels are considered for temperature
+      alerts, typically because not all are wired to anything. Only applies to
+      last device in the daisy chain.
+    default: 5
+    enum: [3, 4, 5]
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
+        adi,temp-alert-last-chan = <5>;
+      };
+    };
+...
-- 
2.34.1

