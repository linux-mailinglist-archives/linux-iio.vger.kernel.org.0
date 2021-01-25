Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BC6304837
	for <lists+linux-iio@lfdr.de>; Tue, 26 Jan 2021 20:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbhAZFsZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Jan 2021 00:48:25 -0500
Received: from atl4mhfb03.myregisteredsite.com ([209.17.115.119]:36162 "EHLO
        atl4mhfb03.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729852AbhAYPfl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jan 2021 10:35:41 -0500
Received: from jax4mhob14.registeredsite.com (jax4mhob14.registeredsite.com [64.69.218.102])
        by atl4mhfb03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id 10PF9PCD030576
        for <linux-iio@vger.kernel.org>; Mon, 25 Jan 2021 10:09:25 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.205])
        by jax4mhob14.registeredsite.com (8.14.4/8.14.4) with ESMTP id 10PF7co7049480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-iio@vger.kernel.org>; Mon, 25 Jan 2021 10:07:38 -0500
Received: (qmail 3240 invoked by uid 0); 25 Jan 2021 15:07:38 -0000
X-TCPREMOTEIP: 83.128.90.119
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO phenom.domain?not?set.invalid) (mike@milosoftware.com@83.128.90.119)
  by 0 with ESMTPA; 25 Jan 2021 15:07:38 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-iio@vger.kernel.org
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/2] dt-bindings: iio: accel: Add bmi088 accelerometer bindings
Date:   Mon, 25 Jan 2021 16:07:31 +0100
Message-Id: <20210125150732.23873-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds the device-tree bindings for the Bosch Sensortec BMI088 IMU,
the accelerometer part.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

Changes in v8:
Add spi-max-frequency: true

Changes in v7:
Add additionalProperties
Change bmi088_accel to bmi088-accel
Add interrupt-names and adjust description

Changes in v6:
I't been almost a year since the last commit, sorry...
Fixed the yaml errors
Add interrupt, vdd and vddio properties

Changes in v5:
submit together with driver code as patch series

Changes in v2:
convert to yaml format

 .../bindings/iio/accel/bosch,bmi088.yaml      | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
new file mode 100644
index 000000000000..911a1ae9c83f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/bosch,bmi088.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch BMI088 IMU accelerometer part
+
+maintainers:
+  - Mike Looijmans <mike.looijmans@topic.nl>
+
+description: |
+  Acceleration part of the IMU sensor with an SPI interface
+  Specifications about the sensor can be found at:
+    https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi088-ds001.pdf
+
+properties:
+  compatible:
+    enum:
+      - bosch,bmi088-accel
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  vdd-supply: true
+
+  vddio-supply: true
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+    description: |
+      Type should be either IRQ_TYPE_LEVEL_HIGH or IRQ_TYPE_LEVEL_LOW.
+      Two configurable interrupt lines exist.
+
+  interrupt-names:
+    description: Specify which interrupt line is in use.
+    items:
+      enum:
+        - INT1
+        - INT2
+    minItems: 1
+    maxItems: 2
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      bmi088-accel@1 {
+        compatible = "bosch,bmi088-accel";
+        reg = <1>;
+        spi-max-frequency = <10000000>;
+        interrupt-parent = <&gpio6>;
+        interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
+        interrupt-names = "INT2";
+      };
+    };
+...
-- 
2.17.1

