Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4882A19DB
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgJaSvr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbgJaSvq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:51:46 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B3472072C;
        Sat, 31 Oct 2020 18:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170306;
        bh=78147WRxiyxt7sN1gLHlmXA7ziYE9l/25sqw0GzfE2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NsNwXQxby4zp5/ZDPxXM5tEnmn0XIQyLvqrVBu/S4XnFgRPso4l/N23F6Taf9vcTH
         ZrY/nq5RSzgD/HGJ817S5wS4NoO1GVB6LApGKQG9Jk9c57YAqrtW0RfmHGHx6XZyu+
         WnRHKLjVI/BH7UP8mBRa9c7RPrB1j/i39WJ5V+sk=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: [PATCH 13/46] dt-bindings:iio:light:avago,apds9300: txt to yaml conversion.
Date:   Sat, 31 Oct 2020 18:48:21 +0000
Message-Id: <20201031184854.745828-14-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This could have gone in trivial-devices.yaml, but there was a datasheet
link so I've given it a minimal file of it's own.
Very simple binding and so a very simple conversion.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
---
 .../bindings/iio/light/apds9300.txt           | 21 ---------
 .../bindings/iio/light/avago,apds9300.yaml    | 44 +++++++++++++++++++
 2 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/apds9300.txt b/Documentation/devicetree/bindings/iio/light/apds9300.txt
deleted file mode 100644
index 3aa6db3ee99d..000000000000
--- a/Documentation/devicetree/bindings/iio/light/apds9300.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-* Avago APDS9300 ambient light sensor
-
-https://www.avagotech.com/docs/AV02-1077EN
-
-Required properties:
-
-  - compatible : should be "avago,apds9300"
-  - reg : the I2C address of the sensor
-
-Optional properties:
-
-  - interrupts : interrupt mapping for GPIO IRQ
-
-Example:
-
-apds9300@39 {
-	compatible = "avago,apds9300";
-	reg = <0x39>;
-	interrupt-parent = <&gpio2>;
-	interrupts = <29 8>;
-};
diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
new file mode 100644
index 000000000000..1cc026b9a62b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/avago,apds9300.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Avago APDS9300 ambient light sensor
+
+maintainers:
+  - Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
+
+description: |
+  Datasheet at https://www.avagotech.com/docs/AV02-1077EN
+
+properties:
+  compatible:
+    const: avago,apds9300
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@39 {
+            compatible = "avago,apds9300";
+            reg = <0x39>;
+            interrupt-parent = <&gpio2>;
+            interrupts = <29 8>;
+        };
+    };
+...
-- 
2.28.0

