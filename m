Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A613D2A17ED
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 14:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgJaNoZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 09:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbgJaNoZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 09:44:25 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D5A920791;
        Sat, 31 Oct 2020 13:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604151864;
        bh=Ruqz8ueB74+ggqtNBpFiwiBv8rLdQK7FbuIhhh3IIek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZyumrEFEoO68bR7PeT+8V9tEbVMICLXLh0s39nS1TO1F07O3+nh8fwRsEk2aU+WUM
         TVa/7n9KuNyMJDjGiQ1k6vAj/g0zMiSdJQ7NtVGmI75/QfgdjOZ7QEiBHHot3I96uQ
         KmC2ZvU4IK5pYvTQpxDGDnf6kPRB7TQiOCNdYI5E=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2 28/29] dt-bindings:iio:temperature:maxim_thermocouple.txt to maxim,max31855k.yaml
Date:   Sat, 31 Oct 2020 13:41:09 +0000
Message-Id: <20201031134110.724233-29-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031134110.724233-1-jic23@kernel.org>
References: <20201031134110.724233-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Given we already have another maxim thermocouple driver that isn't
covered by this binding it seems a better idea to chose to name it
after a specific part.

I added an additional example for the maxim,max6755 to illustrate
the need for spi-cpha for that part.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 .../iio/temperature/maxim,max31855k.yaml      | 76 +++++++++++++++++++
 .../iio/temperature/maxim_thermocouple.txt    | 24 ------
 2 files changed, 76 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/maxim,max31855k.yaml b/Documentation/devicetree/bindings/iio/temperature/maxim,max31855k.yaml
new file mode 100644
index 000000000000..9969bac66aa1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/maxim,max31855k.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/maxim,max31855k.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX31855 and similar thermocouples
+
+maintainers:
+  - Matt Ranostay <matt.ranostay@konsulko.com>
+
+description: |
+  https://datasheets.maximintegrated.com/en/ds/MAX6675.pdf
+  https://datasheets.maximintegrated.com/en/ds/MAX31855.pdf
+
+properties:
+  compatible:
+    description:
+      The generic maxim,max31855 compatible is deprecated in favour of
+      the thermocouple type specific variants.
+    enum:
+      - maxim,max6675
+      - maxim,max31855
+      - maxim,max31855k
+      - maxim,max31855j
+      - maxim,max31855n
+      - maxim,max31855s
+      - maxim,max31855t
+      - maxim,max31855e
+      - maxim,max31855r
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+  spi-cpha: true
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - maxim,max6675
+    then:
+      required:
+        - spi-cpha
+    else:
+      properties:
+        spi-cpha: false
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        temp-sensor@0 {
+            compatible = "maxim,max31855k";
+            reg = <0>;
+            spi-max-frequency = <4300000>;
+        };
+        temp-sensor@1 {
+            compatible = "maxim,max6675";
+            reg = <1>;
+            spi-max-frequency = <4300000>;
+            spi-cpha;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt b/Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt
deleted file mode 100644
index bb85cd0e039c..000000000000
--- a/Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Maxim thermocouple support
-
-* https://datasheets.maximintegrated.com/en/ds/MAX6675.pdf
-* https://datasheets.maximintegrated.com/en/ds/MAX31855.pdf
-
-Required properties:
-
-	- compatible: must be "maxim,max6675" or one of the following:
-	   "maxim,max31855k", "maxim,max31855j", "maxim,max31855n",
-	   "maxim,max31855s", "maxim,max31855t", "maxim,max31855e",
-	   "maxim,max31855r"; the generic "max,max31855" is deprecated.
-	- reg: SPI chip select number for the device
-	- spi-max-frequency: must be 4300000
-	- spi-cpha: must be defined for max6675 to enable SPI mode 1
-
-	Refer to spi/spi-bus.txt for generic SPI slave bindings.
-
-Example:
-
-	max31855@0 {
-		compatible = "maxim,max31855k";
-		reg = <0>;
-		spi-max-frequency = <4300000>;
-	};
-- 
2.28.0

