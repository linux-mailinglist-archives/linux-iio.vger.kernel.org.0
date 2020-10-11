Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC6F28A85E
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 19:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387612AbgJKRKP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 13:10:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387501AbgJKRKP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:10:15 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63F9F2222F;
        Sun, 11 Oct 2020 17:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602436214;
        bh=DC+D+UR8viORwMy6SrfBehNb1eLhmzfz13Bd9a1TXnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U1rufb+8WezNTgaImBVqhusJ/rc3tAxIlwfsvFAl4zOmCXQzdzWWU4fbff9SaoPq6
         D5JsfPuAGF9qoLYcqZ6AeCNuk3LzL7G/gbNPEYvygw5raXVGSsqkiDIpeRukzBb/+R
         AD0KcTrLGtY4x+wMADg5Nb75CDZClCMyoyqIxYPA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 11/29] dt-bindings:iio:proximity:ams,as3935 yaml conversion
Date:   Sun, 11 Oct 2020 18:07:31 +0100
Message-Id: <20201011170749.243680-12-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201011170749.243680-1-jic23@kernel.org>
References: <20201011170749.243680-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

A straight forward conversion of this binding. I have added
a maximum SPI frequency from the datasheet.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 .../bindings/iio/proximity/ams,as3935.yaml    | 71 +++++++++++++++++++
 .../bindings/iio/proximity/as3935.txt         | 34 ---------
 2 files changed, 71 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/proximity/ams,as3935.yaml b/Documentation/devicetree/bindings/iio/proximity/ams,as3935.yaml
new file mode 100644
index 000000000000..7fcba5d6d508
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/ams,as3935.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/ams,as3935.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Austrian Microsystems AS3935 Franklin lightning sensor
+
+maintainers:
+  - Matt Ranostay <matt.ranostay@konsulko.com>
+
+description:
+  This lightening distance sensor uses an I2C or SPI interface. The
+  binding currently only covers the SPI option.
+
+properties:
+  compatible:
+    const: ams,as3935
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 2000000
+
+  spi-cpha: true
+
+  interrupts:
+    maxItems: 1
+
+  ams,tuning-capacitor-pf:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Calibration tuning capacitor stepping value. This will require using
+      the calibration data from the manufacturer.
+    minimum: 0
+    maximum: 120
+
+  ams,nflwdth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Set the noise and watchdog threshold register on startup. This will
+      need to set according to the noise from the MCU board, and possibly
+      the local environment. Refer to the datasheet for the threshold settings.
+
+required:
+  - compatible
+  - reg
+  - spi-cpha
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+    lightning@0 {
+            compatible = "ams,as3935";
+            reg = <0>;
+            spi-max-frequency = <400000>;
+            spi-cpha;
+            interrupt-parent = <&gpio1>;
+            interrupts = <16 1>;
+            ams,tuning-capacitor-pf = <80>;
+            ams,nflwdth = <0x44>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/proximity/as3935.txt b/Documentation/devicetree/bindings/iio/proximity/as3935.txt
deleted file mode 100644
index 849115585d55..000000000000
--- a/Documentation/devicetree/bindings/iio/proximity/as3935.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-Austrian Microsystems AS3935 Franklin lightning sensor device driver
-
-Required properties:
-	- compatible: must be "ams,as3935"
-	- reg: SPI chip select number for the device
-	- spi-max-frequency: specifies maximum SPI clock frequency
-	- spi-cpha: SPI Mode 1. Refer to spi/spi-bus.txt for generic SPI
-	slave node bindings.
-	- interrupts : the sole interrupt generated by the device
-
-	Refer to interrupt-controller/interrupts.txt for generic
-	interrupt client node bindings.
-
-Optional properties:
-	- ams,tuning-capacitor-pf: Calibration tuning capacitor stepping
-	  value 0 - 120pF. This will require using the calibration data from
-	  the manufacturer.
-	- ams,nflwdth: Set the noise and watchdog threshold register on
-	  startup. This will need to set according to the noise from the
-	  MCU board, and possibly the local environment. Refer to the
-	  datasheet for the threshold settings.
-
-Example:
-
-as3935@0 {
-	compatible = "ams,as3935";
-	reg = <0>;
-	spi-max-frequency = <400000>;
-	spi-cpha;
-	interrupt-parent = <&gpio1>;
-	interrupts = <16 1>;
-	ams,tuning-capacitor-pf = <80>;
-	ams,nflwdth = <0x44>;
-};
-- 
2.28.0

