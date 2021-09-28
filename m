Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D4841B02F
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 15:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241064AbhI1Ndl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 09:33:41 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52979 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241051AbhI1Ndl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Sep 2021 09:33:41 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id DEB576000D;
        Tue, 28 Sep 2021 13:31:55 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>, <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 04/48] dt-bindings: iio: adc: ti,am3359-adc: New yaml description
Date:   Tue, 28 Sep 2021 15:30:59 +0200
Message-Id: <20210928133143.157329-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210928133143.157329-1-miquel.raynal@bootlin.com>
References: <20210928133143.157329-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This ADC was already described in a text file also containing an MFD
description an a touchscreen description:
Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
Let's add a proper description for this hardware.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/adc/ti,am3359-adc.yaml       | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml b/Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml
new file mode 100644
index 000000000000..f262402ca037
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,am3359-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI AM3359 ADC
+
+maintainers:
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+
+properties:
+  compatible:
+    const: ti,am3359-adc
+
+  '#io-channel-cells':
+    const: 1
+
+  ti,adc-channels:
+    description: List of analog inputs available for ADC. AIN0 = 0, AIN1 = 1 and
+      so on until AIN7 = 7.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 8
+
+  ti,chan-step-opendelay:
+    description: List of open delays for each channel of ADC in the order of
+      ti,adc-channels. The value corresponds to the number of ADC clock cycles
+      to wait after applying the step configuration registers and before sending
+      the start of ADC conversion. Maximum value is 0x3FFFF.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 8
+
+  ti,chan-step-sampledelay:
+    description: List of sample delays for each channel of ADC in the order of
+      ti,adc-channels. The value corresponds to the number of ADC clock cycles
+      to sample (to hold start of conversion high). Maximum value is 0xFF.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 8
+
+  ti,chan-step-avg:
+    description: Number of averages to be performed for each channel of ADC. If
+      average is 16 (this is also the maximum) then input is sampled 16 times
+      and averaged to get more accurate value. This increases the time taken by
+      ADC to generate a sample. Maximum value is 16.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 8
+
+required:
+  - compatible
+  - '#io-channel-cells'
+  - ti,adc-channels
+
+additionalProperties: false
+
+examples:
+  - |
+    adc {
+        compatible = "ti,am3359-adc";
+        #io-channel-cells = <1>;
+        ti,adc-channels = <4 5 6 7>;
+        ti,chan-step-opendelay = <0x098 0x3ffff 0x098 0x0>;
+        ti,chan-step-sampledelay = <0xff 0x0 0xf 0x0>;
+        ti,chan-step-avg = <16 2 4 8>;
+    };
-- 
2.27.0

