Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10062A17D3
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 14:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgJaNoF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 09:44:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbgJaNoE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 09:44:04 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B365820791;
        Sat, 31 Oct 2020 13:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604151843;
        bh=ise7qoDYets/OyDtAWyWcXuIS/5Vl3f6IE759KxT3K8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dk16aIsFZ956DbKzTTYPSlmsjsmG1ReS7xdTT5cTLQluIjNR9te0OuhgAq8VWMO0c
         YJBrV5ZNiNupfNJ9fm8sXuFDn5MHfvq/Tlwi1GfFnkecbC+NIbp9FkLGXWTYncCfi7
         KfaJkfjGMUOPKy5ueaNAvWSr4D7jUkH1Ugjb3JLQ=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Ricardo Ribalda Delgado <ricardo@ribalda.com>
Subject: [PATCH v2 15/29] dt-bindings:iio:dac:ti,dac7612 yaml conversion
Date:   Sat, 31 Oct 2020 13:40:56 +0000
Message-Id: <20201031134110.724233-16-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031134110.724233-1-jic23@kernel.org>
References: <20201031134110.724233-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple conversion from txt to yaml.  No significant adjustments.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
---
 .../bindings/iio/dac/ti,dac7612.txt           | 28 ----------
 .../bindings/iio/dac/ti,dac7612.yaml          | 53 +++++++++++++++++++
 2 files changed, 53 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
deleted file mode 100644
index 17af395b99d9..000000000000
--- a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-* Texas Instruments Dual, 12-Bit Serial Input Digital-to-Analog Converter
-
-The DAC7612 is a dual, 12-bit digital-to-analog converter (DAC) with guaranteed
-12-bit monotonicity performance over the industrial temperature range.
-Is is programmable through an SPI interface.
-
-The internal DACs are loaded when the LOADDACS pin is pulled down.
-
-https://www.ti.com/lit/ds/sbas106/sbas106.pdf
-
-Required Properties:
-- compatible: Should be one of:
-		"ti,dac7612"
-		"ti,dac7612u"
-		"ti,dac7612ub"
-- reg: Definition as per Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Optional Properties:
-- ti,loaddacs-gpios: GPIO descriptor for the LOADDACS pin.
-- spi-*: Definition as per Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Example:
-
-	dac@1 {
-		compatible = "ti,dac7612";
-		reg = <0x1>;
-		ti,loaddacs-gpios = <&msmgpio 25 GPIO_ACTIVE_LOW>;
-	};
diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
new file mode 100644
index 000000000000..d172b142f6ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/ti,dac7612.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments DAC7612 family of DACs
+
+description:
+  The DAC7612 is a dual, 12-bit digital-to-analog converter (DAC) with
+  guaranteed 12-bit monotonicity performance over the industrial temperature
+  range. Is is programmable through an SPI interface.
+
+maintainers:
+  - Ricardo Ribalda Delgado <ricardo@ribalda.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,dac7612
+      - ti,dac7612u
+      - ti,dac7612ub
+
+  reg:
+    maxItems: 1
+
+  ti,loaddacs-gpios:
+    description:
+      DACs are loaded when the pin connected to this GPIO is pulled low.
+    maxItems: 1
+
+  spi-max-frequency: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@1 {
+            compatible = "ti,dac7612";
+            reg = <0x1>;
+            ti,loaddacs-gpios = <&msmgpio 25 GPIO_ACTIVE_LOW>;
+        };
+    };
+...
-- 
2.28.0

