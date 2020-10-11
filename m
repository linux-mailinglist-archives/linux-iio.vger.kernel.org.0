Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B6628A857
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 19:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbgJKRKE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 13:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729634AbgJKRKE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:10:04 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC8C322247;
        Sun, 11 Oct 2020 17:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602436203;
        bh=oaRRkSSGkLvjYvC7py+YBMLCWtUP45LKWRnWSsfQlPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUM0TYpZCM8RHXIuHU2/jY4v5hhUsISNqTQI1N2MKl9zmSGy1TrXT1UPghvgOWxr3
         W/+wRFjSFlpwL/QHYYt/rvSyJ8ke3KCabYrzFienXakCgRx1PRhjaRKhneA9elYxYs
         nqZYeSlXFXJAyt80y+RBI5EYOYlAkzkv6Ak5cnDA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Harald Geyer <harald@ccbib.org>
Subject: [PATCH 04/29] dt-bindings:iio:humidity:dht11 yaml conversion
Date:   Sun, 11 Oct 2020 18:07:24 +0100
Message-Id: <20201011170749.243680-5-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201011170749.243680-1-jic23@kernel.org>
References: <20201011170749.243680-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The conversion is straight forward, but leaves an open question.
The compatible for this device has never had a vendor. I suspect
this because it is non-obvious who actually makes the module. It is
resold by numerous vendors and it may be that there is no single vendor
of the parts they are using.  If anyone has any more info on the
vendor, please let me know and we can add a more informative
compatible.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Harald Geyer <harald@ccbib.org>
---
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
index 000000000000..38ec4c302760
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
+   interface.  Whilst commonly available it is not easy to establish if there
+   is a single manufacturer for this part.
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

