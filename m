Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4118728A86C
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 19:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388244AbgJKRKh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 13:10:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387984AbgJKRKh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:10:37 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 432CD2224A;
        Sun, 11 Oct 2020 17:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602436236;
        bh=FMoo14yg6th2YgTEyix5yZQ4fLqtRXNPYwhFQSv7dIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EP62Sk+u4O0eg5CrlDVSJC2Av3xHDtzQmzDRpe6COK1huein1N3VJtmPCqLPQWH92
         e6CGl/S0Nfu213L5i6KcUPmodTPBmEKOTuxuAi4DFb/MyOggUknHPbBswcNAl/CbdC
         IN4pQo73Q3vMLOskRt76O5Xc+SxiiVENlx630iG0=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH 25/29] dt-bindings:iio:temperature:melexis,mlx90632 conversion to yaml
Date:   Sun, 11 Oct 2020 18:07:45 +0100
Message-Id: <20201011170749.243680-26-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201011170749.243680-1-jic23@kernel.org>
References: <20201011170749.243680-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Technically this could have gone in trivial-devices.yaml, but I have
kept it as a separate binding due to the detailed additional description
from the text file.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Crt Mori <cmo@melexis.com>
---
 .../iio/temperature/melexis,mlx90632.yaml     | 55 +++++++++++++++++++
 .../bindings/iio/temperature/mlx90632.txt     | 28 ----------
 2 files changed, 55 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml
new file mode 100644
index 000000000000..b547ddcd544a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/melexis,mlx90632.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Melexis MLX90632 contactless Infra Red temperature sensor
+
+maintainers:
+  - Crt Mori <cmo@melexis.com>
+
+description: |
+  https://www.melexis.com/en/documents/documentation/datasheets/datasheet-mlx90632
+
+  There are various applications for the Infra Red contactless temperature
+  sensor and MLX90632 is most suitable for consumer applications where
+  measured object temperature is in range between -20 to 200 degrees
+  Celsius with relative error of measurement below 1 degree Celsius in
+  object temperature range for industrial applications. Since it can
+  operate and measure ambient temperature in range of -20 to 85 degrees
+  Celsius it is suitable also for outdoor use.
+
+  Be aware that electronics surrounding the sensor can increase ambient
+  temperature. MLX90632 can be calibrated to reduce the housing effect via
+  already existing EEPROM parameters.
+
+  Since measured object emissivity effects Infra Red energy emitted,
+  emissivity should be set before requesting the object temperature.
+
+properties:
+  compatible:
+    const: melexis,mlx90632
+
+  reg:
+    maxItems: 1
+    description: Default is 0x3a, but can be reprogrammed.
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
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        temp-sensor@3a {
+            compatible = "melexis,mlx90632";
+            reg = <0x3a>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/temperature/mlx90632.txt b/Documentation/devicetree/bindings/iio/temperature/mlx90632.txt
deleted file mode 100644
index 0b05812001f8..000000000000
--- a/Documentation/devicetree/bindings/iio/temperature/mlx90632.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-* Melexis MLX90632 contactless Infra Red temperature sensor
-
-Link to datasheet: https://www.melexis.com/en/documents/documentation/datasheets/datasheet-mlx90632
-
-There are various applications for the Infra Red contactless temperature sensor
-and MLX90632 is most suitable for consumer applications where measured object
-temperature is in range between -20 to 200 degrees Celsius with relative error
-of measurement below 1 degree Celsius in object temperature range for
-industrial applications. Since it can operate and measure ambient temperature
-in range of -20 to 85 degrees Celsius it is suitable also for outdoor use.
-
-Be aware that electronics surrounding the sensor can increase ambient
-temperature. MLX90632 can be calibrated to reduce the housing effect via
-already existing EEPROM parameters.
-
-Since measured object emissivity effects Infra Red energy emitted, emissivity
-should be set before requesting the object temperature.
-
-Required properties:
-  - compatible: should be "melexis,mlx90632"
-  - reg: the I2C address of the sensor (default 0x3a)
-
-Example:
-
-mlx90632@3a {
-	compatible = "melexis,mlx90632";
-	reg = <0x3a>;
-};
-- 
2.28.0

