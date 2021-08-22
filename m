Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BB43F40FE
	for <lists+linux-iio@lfdr.de>; Sun, 22 Aug 2021 20:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhHVSta (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Aug 2021 14:49:30 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:42465 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhHVSta (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Aug 2021 14:49:30 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 4468F40002;
        Sun, 22 Aug 2021 18:48:46 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jacopo Mondi <jacopo@jmondi.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: iio: chemical: Document senseair,sunrise CO2 sensor
Date:   Sun, 22 Aug 2021 20:49:25 +0200
Message-Id: <20210822184927.94673-2-jacopo@jmondi.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210822184927.94673-1-jacopo@jmondi.org>
References: <20210822184927.94673-1-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add documentation for the Senseair Sunrise 006-0-0007 CO2 NDIR sensor.

Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---
v2->v3:
- Fix syntax error reported by dt_binding_check
  The device node label in the example cannot contain '-'
- Add 'Typically' to the gpios polarities description

v1->v2:
- Add maxItems to -gpios properties as suggested by Rob
- Add a label to the device node in the example as suggested by Rob
---
 .../iio/chemical/senseair,sunrise.yaml        | 55 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml b/Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
new file mode 100644
index 000000000000..d05d06b5840e
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
+      sunrise: co2-sensor@68 {
+        compatible = "senseair,sunrise-006-0-0007";
+        reg = <0x68>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 944a14926e02..c60502eb3d36 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1000,6 +1000,8 @@ patternProperties:
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

