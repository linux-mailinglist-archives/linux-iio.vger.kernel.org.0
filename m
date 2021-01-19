Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F792FB904
	for <lists+linux-iio@lfdr.de>; Tue, 19 Jan 2021 15:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395346AbhASOPd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jan 2021 09:15:33 -0500
Received: from atl4mhfb03.myregisteredsite.com ([209.17.115.119]:34944 "EHLO
        atl4mhfb03.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393609AbhASNAt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jan 2021 08:00:49 -0500
Received: from jax4mhob08.registeredsite.com (jax4mhob08.myregisteredsite.com [64.69.218.88])
        by atl4mhfb03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id 10JClZTc027158
        for <linux-iio@vger.kernel.org>; Tue, 19 Jan 2021 07:47:36 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.205])
        by jax4mhob08.registeredsite.com (8.14.4/8.14.4) with ESMTP id 10JCkRAl024339
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-iio@vger.kernel.org>; Tue, 19 Jan 2021 07:46:28 -0500
Received: (qmail 17343 invoked by uid 0); 19 Jan 2021 12:46:27 -0000
X-TCPREMOTEIP: 83.128.90.119
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO phenom.domain?not?set.invalid) (mike@milosoftware.com@83.128.90.119)
  by 0 with ESMTPA; 19 Jan 2021 12:46:27 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-iio@vger.kernel.org
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: iio: accel: Add bmi088 accelerometer bindings
Date:   Tue, 19 Jan 2021 13:46:21 +0100
Message-Id: <20210119124622.9490-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds the device-tree bindings for the Bosch Sensortec BMI088 IMU,
the accelerometer part.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

Changes in v6:
I't been almost a year since the last commit, sorry...
Fixed the yaml errors
Add interrupt, vdd and vddio properties

Changes in v5:
submit together with driver code as patch series

Changes in v2:
convert to yaml format

 .../bindings/iio/accel/bosch,bmi088.yaml      | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
new file mode 100644
index 000000000000..459b9969fd12
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
@@ -0,0 +1,55 @@
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
+      - bosch,bmi088_accel
+
+  reg:
+    maxItems: 1
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
+      The first interrupt listed must be the one connected to the INT1 pin, the
+      second must be the one connected to the INT2 pin.
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      bmi088_accel@1 {
+        compatible = "bosch,bmi088_accel";
+        reg = <1>;
+        spi-max-frequency = <10000000>;
+        interrupt-parent = <&gpio6>;
+        interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
+      };
+    };
+...
-- 
2.17.1

