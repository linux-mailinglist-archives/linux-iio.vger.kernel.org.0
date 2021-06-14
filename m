Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E583A65BF
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 13:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbhFNLmF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 07:42:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236555AbhFNLjP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Jun 2021 07:39:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCCDB613D0;
        Mon, 14 Jun 2021 11:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623670437;
        bh=nUZoBNjU8SfS4RGpa++OgfFzwMNgdWbkuCW0Fi/pt2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O9sDz8DQgq2kBMLLDMhei/S4sOMDsDjFPPx+WrkqIIV6TYQu8tLENfjp9aCASnVlb
         uLSUrE7m1amxOoyt8zbcWTuELv6uqU4GFRYmKt5Smaprlv+weiVEsSe7fSsuFZpnLD
         1Q0HJCKoBefw+oskbTNRAj0vxR4QCUjVfRZceWz5GTMTkwkH8KeTulFyECR3jo0fB6
         ocuByyw5WuXpxbcc+CLs4aTG/ObTPqGyBTzrJ2jdQdatNBemw++4KLLVJ5s20R902V
         7vaydq0IxyEBTZtYfwfo7iWurA+85JTyTDusIGwp4v5DN5WANv3uhygnzSzz3y7Dkg
         YsH4UffG0Vl/Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Michael.Hennerich@analog.com, lars@metafoo.de,
        devicetree@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 15/17] dt-bindings:iio:adc:ad7280a: Add binding
Date:   Mon, 14 Jun 2021 12:35:05 +0100
Message-Id: <20210614113507.897732-16-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614113507.897732-1-jic23@kernel.org>
References: <20210614113507.897732-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add a binding for this Lithium Ion Battery monitoring chip/chain of chips
as it is now clean and ready to move out of staging.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
2.32.0

