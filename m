Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED6A1906F8
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 09:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgCXIDU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 04:03:20 -0400
Received: from jax4mhob21.registeredsite.com ([64.69.218.109]:41092 "EHLO
        jax4mhob21.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726047AbgCXIDU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2020 04:03:20 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.204])
        by jax4mhob21.registeredsite.com (8.14.4/8.14.4) with ESMTP id 02O83D9G050538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2020 04:03:15 -0400
Received: (qmail 1779 invoked by uid 0); 24 Mar 2020 08:03:13 -0000
X-TCPREMOTEIP: 83.128.90.119
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO phenom.domain?not?set.invalid) (mike@milosoftware.com@83.128.90.119)
  by 0 with ESMTPA; 24 Mar 2020 08:03:13 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH v5 1/2] dt-bindings: iio: accel: Add bmi088 accelerometer bindings
Date:   Tue, 24 Mar 2020 09:03:07 +0100
Message-Id: <20200324080309.12171-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds the device-tree bindings for the Bosch Sensortec BMI088 IMU,
the accelerometer part.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
v2: convert to yaml format
v3..v4: -
v5: submit together with driver code as patch series
 .../bindings/iio/accel/bosch,bmi088.yaml      | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
new file mode 100644
index 000000000000..715f79c3b2a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/bosch,bma400.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch BMI088 IMU accelerometer part
+
+maintainers:
+  - Mike Looijmans <mike.looijmans@topic.nl>
+
+description: |
+  Acceleration part of the IMU sensor with an SPI interface
+
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
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+  spi {
+    bmi088_accel@1 {
+      compatible = "bosch,bmi088_accel";
+      reg = <1>;
+      spi-max-frequency = <10000000>;
+    };
+  };
-- 
2.17.1

