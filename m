Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8EF35198F
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 20:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbhDARyG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 13:54:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236468AbhDARpC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Apr 2021 13:45:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00FB9613BE;
        Thu,  1 Apr 2021 17:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617299000;
        bh=DYBylFCzwf/mC1qtfHCHRZAYGu4r3hcX9pYrM/Et+T0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n7DEEBdoZVB6pQDH/QEAOLAVGoQkgGkFICaNFMo7ECIFLilAMUhlJkVJ57U0+29Dm
         QfCfWm8JJhdYjPSeRF3SOWbDZhOSC5ziZTCsWZGJbXZpsvZMRZHr8E0vEBhMOFGNwN
         JdtVHqL4n14SFhhgAAS0Yas32UmDgFrUrTNl1g7C/JOcCc+qpI+01rYUs6gGRIQi32
         Q9uMn9y7g10BJkfX9e6WGb6iHoi33bYGDZV4P+DpB7hLct70jOK5kXMtmutYkYK/Lx
         cMThOAmPM8R4vDhc/EtEDC269WKApNW1LfyWKIADvojaLMg564ghu3NKGIWURi5GCT
         WANmobMB6aEAQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 6/6] dt-bindings:iio:adc:adi,ad7298 document bindings
Date:   Thu,  1 Apr 2021 18:41:12 +0100
Message-Id: <20210401174112.320497-7-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210401174112.320497-1-jic23@kernel.org>
References: <20210401174112.320497-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The device has a tsens-busy pin, but it's both fiddly and currently
ignored by the Linux driver.  Given it's not clear whether the binding
should be an interrupt, or a GPIO I have left that out for now.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>
---
 .../bindings/iio/adc/adi,ad7298.yaml          | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7298.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7298.yaml
new file mode 100644
index 000000000000..ca414bb396c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7298.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7298.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7298 ADC
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+
+description: |
+  Bindings for the Analog Devices AD7298 ADC device. Datasheet can be
+  found here:
+    https://www.analog.com/en/products/ad7298.html
+
+properties:
+  compatible:
+    const: adi,ad7298
+
+  reg:
+    maxItems: 1
+
+  vref-supply: true
+  vdd-supply: true
+  spi-max-frequency: true
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
+        compatible = "adi,ad7298";
+        reg = <0>;
+        spi-max-frequency = <5000000>;
+        vref-supply = <&adc_vref>;
+      };
+    };
+...
-- 
2.31.1

