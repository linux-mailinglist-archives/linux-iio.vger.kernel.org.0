Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1049040017A
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 16:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349488AbhICOtB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 10:49:01 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46645 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349248AbhICOtB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 10:49:01 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 3A4DF60003;
        Fri,  3 Sep 2021 14:47:59 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>, linux-iio@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: iio: chemical: Document senseair,sunrise CO2 sensor
Date:   Fri,  3 Sep 2021 16:48:26 +0200
Message-Id: <20210903144828.497166-2-jacopo@jmondi.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210903144828.497166-1-jacopo@jmondi.org>
References: <20210903144828.497166-1-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add documentation for the Senseair Sunrise 006-0-0007 CO2 NDIR sensor.

Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../iio/chemical/senseair,sunrise.yaml        | 55 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml b/Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
new file mode 100644
index 000000000000..337fe09e4bb8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/chemical/senseair,sunrise.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Senseair Sunrise 006-0-0007 CO2 Sensor
+
+maintainers:
+  - Jacopo Mondi <jacopo@jmondi.org>
+
+description: |
+  Senseair Sunrise 006-0-0007 is a NDIR CO2 sensor. It supports I2C or UART buses
+  for communications and control.
+
+  Datasheets:
+    https://rmtplusstoragesenseair.blob.core.windows.net/docs/Dev/publicerat/PSP11704.pdf
+    https://rmtplusstoragesenseair.blob.core.windows.net/docs/Dev/publicerat/PSH11649.pdf
+    https://rmtplusstoragesenseair.blob.core.windows.net/docs/Dev/publicerat/TDE5531.pdf
+    https://rmtplusstoragesenseair.blob.core.windows.net/docs/Market/publicerat/TDE7318.pdf
+
+properties:
+  compatible:
+    const: senseair,sunrise-006-0-0007
+
+  reg:
+    maxItems: 1
+
+  ndry-gpios:
+    maxItems: 1
+    description:
+      Phandle to the GPIO line connected to the nDRY pin. Typically active low.
+
+  en-gpios:
+    maxItems: 1
+    description:
+      Phandle to the GPIO line connected to the EN pin. Typically active high.
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
+      co2-sensor@68 {
+        compatible = "senseair,sunrise-006-0-0007";
+        reg = <0x68>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 07fb0d25fc15..8415e6067ce1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1008,6 +1008,8 @@ patternProperties:
     description: Shenzhen SEI Robotics Co., Ltd
   "^semtech,.*":
     description: Semtech Corporation
+  "^senseair,.*":
+    description: Senseair AB
   "^sensirion,.*":
     description: Sensirion AG
   "^sensortek,.*":
-- 
2.32.0

