Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5FD2A19C4
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgJaSva (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:51:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbgJaSva (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:51:30 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42C5B20706;
        Sat, 31 Oct 2020 18:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170290;
        bh=dmNcGpk/in1UROXkjsC592GjkjKjgweuFnqYOK/Zceg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qQz/THYtOXglvYM9rBFLDt9xt2dodRRbjaGM3aPSw/MmNAuIkZ4VQuRs77HO3ot/l
         YoqNE2xz834mCKf8IhgR2LG4TUK5c8X5QPNQNQaj/s5/PU3TrYUApp/tiRIyVxtTET
         XcMI357qpM18nA8v2MipdR7TiVqIAWx/EiO8ep8o=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Phil Reid <preid@electromag.com.au>
Subject: [PATCH 02/46] dt-bindings:iio:potentiometer:adi,ad5272 yaml conversion
Date:   Sat, 31 Oct 2020 18:48:10 +0000
Message-Id: <20201031184854.745828-3-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple direct conversion from txt to yaml as part of a general aim of
converting all IIO bindings to this machine readable format.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Phil Reid <preid@electromag.com.au>
---
 .../bindings/iio/potentiometer/ad5272.txt     | 27 ----------
 .../iio/potentiometer/adi,ad5272.yaml         | 50 +++++++++++++++++++
 2 files changed, 50 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt b/Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt
deleted file mode 100644
index f9b2eef946aa..000000000000
--- a/Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-* Analog Devices AD5272 digital potentiometer
-
-The node for this device must be a child node of a I2C controller, hence
-all mandatory properties for your controller must be specified. See directory:
-
-        Documentation/devicetree/bindings/i2c
-
-for more details.
-
-Required properties:
-	- compatible:  	Must be one of the following, depending on the model:
-			adi,ad5272-020
-			adi,ad5272-050
-			adi,ad5272-100
-			adi,ad5274-020
-			adi,ad5274-100
-
-Optional properties:
- - reset-gpios: GPIO specification for the RESET input. This is an
-		active low signal to the AD5272.
-
-Example:
-ad5272: potentiometer@2f {
-	reg = <0x2F>;
-	compatible = "adi,ad5272-020";
-	reset-gpios = <&gpio3 6 GPIO_ACTIVE_HIGH>;
-};
diff --git a/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5272.yaml b/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5272.yaml
new file mode 100644
index 000000000000..b9b7d383bff1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5272.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/potentiometer/adi,ad5272.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5272 digital potentiometer
+
+maintainers:
+  - Phil Reid <preid@electromag.com.au>
+
+description: |
+  Datasheet: https://www.analog.com/en/products/ad5272.html
+
+properties:
+  compatible:
+    enum:
+      - adi,ad5272-020
+      - adi,ad5272-050
+      - adi,ad5272-100
+      - adi,ad5274-020
+      - adi,ad5274-100
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      Active low signal to the AD5272 RESET input.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        potentiometer@2f {
+            compatible = "adi,ad5272-020";
+            reg = <0x2F>;
+            reset-gpios = <&gpio3 6 GPIO_ACTIVE_HIGH>;
+        };
+    };
+...
-- 
2.28.0

