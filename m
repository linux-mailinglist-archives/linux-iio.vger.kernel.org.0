Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623E42A17C3
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 14:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbgJaNnw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 09:43:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727589AbgJaNnw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 09:43:52 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F83D2087E;
        Sat, 31 Oct 2020 13:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604151831;
        bh=WnaIZ8/8M/vrdA7BhuoUczOSHHHuTx+iPZJLssvNnsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GobSoA8M+fGBM0D7fFtlHNJFcXSbQnyUHE4f6UVPpUzTD6r/6ogS3os6hxoYZyV5B
         RbV6ZGh5B2YfDYPAwnR0GoHIFPkzneum35/qC5EhxFWKUT4jUhrTFvXY6niR5MGexY
         6zdjJe6cLqcHZmQ/2MFIYaB14fyT0A5rrtdd8xjY=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH v2 07/29] dt-bindings:iio:pressure:meas,ms5611 yaml conversion.
Date:   Sat, 31 Oct 2020 13:40:48 +0000
Message-Id: <20201031134110.724233-8-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031134110.724233-1-jic23@kernel.org>
References: <20201031134110.724233-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

One addition here was to put in a 20MHz maximum for the SPI bus
as specified in the datasheets of both support parts.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Tomasz Duszynski <tduszyns@gmail.com>
---
 .../bindings/iio/pressure/meas,ms5611.yaml    | 57 +++++++++++++++++++
 .../bindings/iio/pressure/ms5611.txt          | 19 -------
 2 files changed, 57 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/meas,ms5611.yaml b/Documentation/devicetree/bindings/iio/pressure/meas,ms5611.yaml
new file mode 100644
index 000000000000..4f06707450bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/meas,ms5611.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/meas,ms5611.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Measurement Specialities ms5611 and similar pressure sensors
+
+maintainers:
+  - Tomasz Duszynski <tduszyns@gmail.com>
+
+description: |
+  Pressure sensors from MEAS Switzerland with SPI and I2C bus interfaces.
+
+properties:
+  compatible:
+    enum:
+      - meas,ms5607
+      - meas,ms5611
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  spi-max-frequency:
+    maximum: 20000000
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
+        pressure@77 {
+            compatible = "meas,ms5607";
+            reg = <0x77>;
+            vdd-supply = <&ldo_3v3_gnss>;
+        };
+    };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pressure@0 {
+            compatible = "meas,ms5611";
+            reg = <0>;
+            vdd-supply = <&ldo_3v3_gnss>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/pressure/ms5611.txt b/Documentation/devicetree/bindings/iio/pressure/ms5611.txt
deleted file mode 100644
index 17bca866c084..000000000000
--- a/Documentation/devicetree/bindings/iio/pressure/ms5611.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-MEAS ms5611 family pressure sensors
-
-Pressure sensors from MEAS Switzerland with SPI and I2C bus interfaces.
-
-Required properties:
-- compatible: "meas,ms5611" or "meas,ms5607"
-- reg: the I2C address or SPI chip select the device will respond to
-
-Optional properties:
-- vdd-supply: an optional regulator that needs to be on to provide VDD
-  power to the sensor.
-
-Example:
-
-ms5607@77 {
-	compatible = "meas,ms5607";
-	reg = <0x77>;
-	vdd-supply = <&ldo_3v3_gnss>;
-};
-- 
2.28.0

