Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361FA41C2F4
	for <lists+linux-iio@lfdr.de>; Wed, 29 Sep 2021 12:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244901AbhI2KsC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Sep 2021 06:48:02 -0400
Received: from mail.kernelconcepts.de ([188.40.83.200]:33546 "EHLO
        mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244886AbhI2KsB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Sep 2021 06:48:01 -0400
Received: from [217.146.132.69] (helo=yoda.kc.loc)
        by mail.kernelconcepts.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <florian.boor@kernelconcepts.de>)
        id 1mVX6M-0002Ot-V5; Wed, 29 Sep 2021 12:46:15 +0200
From:   Florian Boor <florian.boor@kernelconcepts.de>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, Jonathan.Cameron@huawei.com,
        Michael.Hennerich@analog.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Florian Boor <florian.boor@kernelconcepts.de>
Subject: [PATCH v5 2/2] dt-bindings: iio: ad779x: Add binding document
Date:   Wed, 29 Sep 2021 12:46:07 +0200
Message-Id: <20210929104607.2699117-2-florian.boor@kernelconcepts.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929104607.2699117-1-florian.boor@kernelconcepts.de>
References: <20210929104607.2699117-1-florian.boor@kernelconcepts.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

New binding documentation for AD799x series of I²C ADC ICs.

Signed-off-by: Florian Boor <florian.boor@kernelconcepts.de>
---
Changes in v5:
- Correct errors in documentation found by
  'make DT_CHECKER_FLAGS=-m dt_binding_check'
  + Reduce title length
  + Move information to description
  + Add I²C bits to example

 .../bindings/iio/adc/adi,ad799x.yaml          | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml
new file mode 100644
index 000000000000..cdba1ea91f42
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad799x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD799x analog to digital converters
+
+maintainers:
+  - Michael Hennerich, Analog Devices Inc. <Michael.Hennerich@analog.com>
+
+description: |
+    Support for Analog Devices AD7991, AD7992, AD7993, AD7994, AD7995, AD7997, AD7998,
+    AD7999 and similar analog to digital converters.
+    Specifications on the converters can be found at:
+    AD7991, AD7995, AD7999:
+      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7991_7995_7999.pdf
+    AD7992:
+      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7992.pdf
+    AD7993, AD7994:
+      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7993_7994.pdf
+    AD7997, AD7998:
+      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7997_7998.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7991
+      - adi,ad7992
+      - adi,ad7993
+      - adi,ad7994
+      - adi,ad7995
+      - adi,ad7997
+      - adi,ad7998
+      - adi,ad7999
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vcc-supply:
+    description:
+      ADC power supply
+
+  vref-supply:
+    description:
+      ADC reference voltage supply, optional for AD7991, AD7995 and AD7999
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
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+       adc1: ad7991@28 {
+               reg = <0x28>;
+               compatible = "adi,ad7991";
+               interrupts = <13 2>;
+               interrupt-parent = <&gpio6>;
+
+               vcc-supply = <&vcc_3v3>;
+               vref-supply = <&adc_vref>;
+        };
+    };
+...
-- 
2.30.2

