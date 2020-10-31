Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273172A17BE
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 14:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbgJaNns (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 09:43:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727591AbgJaNnr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 09:43:47 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B95382071A;
        Sat, 31 Oct 2020 13:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604151826;
        bh=yeq1jZ94chq5UCF3Y6Eab8tO+mAbJGLYov/bxPRYBq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LsRRCw9ibSo5Rb9iez092yVwrcsD6Bef2jPfuB7XOGxOSzBhniK+sM9Hi4BldPCJ8
         Nl/pjYcc9fsYKfs+dArep+4qPOnNYifzS7Tgm20OGdS5RUhAhM4BeqBWeFW/Em2Vrq
         Tcjb77w/7eqrElNVKIr3uq+oUrp7Z6ieFB86LSzM=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, Harald Geyer <harald@ccbib.org>
Subject: [PATCH v2 04/29] dt-bindings:iio:humidity:dht11 yaml conversion
Date:   Sat, 31 Oct 2020 13:40:45 +0000
Message-Id: <20201031134110.724233-5-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031134110.724233-1-jic23@kernel.org>
References: <20201031134110.724233-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The conversion is straight forward, but leaves an open question.
The compatible for this device has never had a vendor.

Harald Geyer has identified as probably being made by aosong,
but we have no current match to any of their more specific part
numbers.  As such, this is noted in the file but the
compatible doesn't include the vendor prefix.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-By: Harald Geyer <harald@ccbib.org>
---

v2: Added note on aosong as probably manufacturer

 .../bindings/iio/humidity/dht11.txt           | 14 -------
 .../bindings/iio/humidity/dht11.yaml          | 41 +++++++++++++++++++
 2 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/humidity/dht11.txt b/Documentation/devicetree/bindings/iio/humidity/dht11.txt
deleted file mode 100644
index ecc24c199fd6..000000000000
--- a/Documentation/devicetree/bindings/iio/humidity/dht11.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-* DHT11 humidity/temperature sensor (and compatibles like DHT22)
-
-Required properties:
-  - compatible: Should be "dht11"
-  - gpios: Should specify the GPIO connected to the sensor's data
-    line, see "gpios property" in
-    Documentation/devicetree/bindings/gpio/gpio.txt.
-
-Example:
-
-humidity_sensor {
-	compatible = "dht11";
-	gpios = <&gpio0 6 0>;
-}
diff --git a/Documentation/devicetree/bindings/iio/humidity/dht11.yaml b/Documentation/devicetree/bindings/iio/humidity/dht11.yaml
new file mode 100644
index 000000000000..2247481d0203
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/humidity/dht11.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/humidity/dht11.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DHT11 humidity + temperature sensor
+
+maintainers:
+  - Harald Geyer <harald@ccbib.org>
+
+description: |
+   A simple and low cost module providing a non standard single GPIO based
+   interface.  It is believed the part is made by aosong but don't have
+   absolute confirmation of this, or what the aosong part number is.
+
+properties:
+  compatible:
+    const: dht11
+
+  reg:
+    maxItems: 1
+
+  gpios:
+    maxItems: 1
+    description:
+      Single, interrupt capable, GPIO used to communicate with the device.
+
+required:
+  - compatible
+  - gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    humidity_sensor {
+        compatible = "dht11";
+        gpios = <&gpio0 6 0>;
+    };
+...
-- 
2.28.0

