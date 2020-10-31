Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C752A17EB
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 14:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgJaNoY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 09:44:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbgJaNoX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 09:44:23 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8D5B2071A;
        Sat, 31 Oct 2020 13:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604151862;
        bh=qW4vYQl7MuWt6vW94tGoBpICirXSoCPZ+2WN9wqYkJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sSm6HQun2vDjM2E4YhQYRtMdcjQOloR1HzVljAOayYTnkWIDxpopRILKw25tHXii3
         A2ZWBeVl0iMLllI9X8RCkiOCxHTVTxIUD+qspcYXWpvjcnfPV2dAwPLY6t7lyo99A6
         gFdHkLVpWQsZmK5B13lCsKz+8Me3WGjsTDsEaUjI=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 27/29] dt-bindings:iio:temperature:maxim,max31856 yaml conversion.
Date:   Sat, 31 Oct 2020 13:41:08 +0000
Message-Id: <20201031134110.724233-28-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031134110.724233-1-jic23@kernel.org>
References: <20201031134110.724233-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple txt to yaml conversion of this binding.
Paresh Chaudhary's email is bouncing so for now I've listed
myself as maintainer.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/temperature/max31856.txt     | 24 ---------
 .../iio/temperature/maxim,max31856.yaml       | 54 +++++++++++++++++++
 2 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/max31856.txt b/Documentation/devicetree/bindings/iio/temperature/max31856.txt
deleted file mode 100644
index 06ab43bb4de8..000000000000
--- a/Documentation/devicetree/bindings/iio/temperature/max31856.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Maxim MAX31856 thermocouple support
-
-https://datasheets.maximintegrated.com/en/ds/MAX31856.pdf
-
-Optional property:
-	- thermocouple-type: Type of thermocouple (THERMOCOUPLE_TYPE_K if
-		omitted). Supported types are B, E, J, K, N, R, S, T.
-
-Required properties:
-	- compatible: must be "maxim,max31856"
-	- reg: SPI chip select number for the device
-	- spi-max-frequency: As per datasheet max. supported freq is 5000000
-	- spi-cpha: must be defined for max31856 to enable SPI mode 1
-
-	Refer to spi/spi-bus.txt for generic SPI slave bindings.
-
- Example:
-	temp-sensor@0 {
-		compatible = "maxim,max31856";
-		reg = <0>;
-		spi-max-frequency = <5000000>;
-		spi-cpha;
-		thermocouple-type = <THERMOCOUPLE_TYPE_K>;
-	};
diff --git a/Documentation/devicetree/bindings/iio/temperature/maxim,max31856.yaml b/Documentation/devicetree/bindings/iio/temperature/maxim,max31856.yaml
new file mode 100644
index 000000000000..873b34766676
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/maxim,max31856.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/maxim,max31856.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX31856 thermocouple support
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+description: |
+  https://datasheets.maximintegrated.com/en/ds/MAX31856.pdf
+
+properties:
+  compatible:
+    const: maxim,max31856
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+  spi-cpha: true
+
+  thermocouple-type:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Type of thermocouple (THERMOCOUPLE_TYPE_K if omitted).
+      Use defines in dt-bindings/iio/temperature/thermocouple.h.
+      Supported types are B, E, J, K, N, R, S, T.
+
+required:
+  - compatible
+  - reg
+  - spi-cpha
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/iio/temperature/thermocouple.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        temp-sensor@0 {
+            compatible = "maxim,max31856";
+            reg = <0>;
+            spi-max-frequency = <5000000>;
+            spi-cpha;
+            thermocouple-type = <THERMOCOUPLE_TYPE_K>;
+        };
+    };
+...
-- 
2.28.0

