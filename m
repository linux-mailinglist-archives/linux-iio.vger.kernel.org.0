Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420002A19E6
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgJaSv4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:51:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbgJaSv4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:51:56 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49B1820706;
        Sat, 31 Oct 2020 18:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170315;
        bh=6Mz4UZ4WYPbinv3v7/uGVxfb3CPipsu5OPcEBeAiI2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q5k9XMBfC9hcfjffqWywQ4J5Y0t1Q7H+1EnPJiQQLZzenf0B0SntpEgcjbjqxaElB
         Spd4TGQnDy40xFjx9g79uG4sVkMSQ86RXQ3cMl052ANEWfKoq9qHfNWBTzHw2cZvxE
         mqgMeOyj29uvFGg16NuOJvbLhVLxZFdPH3vj0uW0=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 19/46] dt-bindings:iio:light:upisemi,us51882: txt to yaml conversion.
Date:   Sat, 31 Oct 2020 18:48:27 +0000
Message-Id: <20201031184854.745828-20-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I don't have an up to date address for Adriana Reus so I've put myself
as the binding maintainer for this one.  I'm happy to hand over to Adriana
or anyone else who wants take it on!

This has a lot of optional tuning parameters. The docs are modified to try
and put the default values in the description of each one rather than a
forwards reference to the example.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../bindings/iio/light/upisemi,us5182.yaml    | 75 +++++++++++++++++++
 .../devicetree/bindings/iio/light/us5182d.txt | 45 -----------
 2 files changed, 75 insertions(+), 45 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/upisemi,us5182.yaml b/Documentation/devicetree/bindings/iio/light/upisemi,us5182.yaml
new file mode 100644
index 000000000000..b9dc8ae25bf0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/upisemi,us5182.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/upisemi,us5182.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: UPISEMI us5182d I2C ALS and Proximity sensor
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+properties:
+  compatible:
+    const: upisemi,asd5182
+
+  reg:
+    maxItems: 1
+
+  upsemi,glass-coef:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      glass attenuation factor - compensation factor of resolution 1000
+      for material transmittance.  Default: 1000
+
+  upisemi,dark-ths:
+    $ref: /schemas/types.yaml#/definitions/uint16-array
+    minItems: 8
+    maxItems: 8
+    description:
+      16-bit thresholds (adc counts) corresponding to every scale.
+
+  upisemi,upper-dark-gain:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description: |
+      8-bit dark gain compensation factor(4 int and 4 fractional bits - Q4.4)
+      applied when light > threshold. Default: 0.
+
+  upisemi,lower-dark-gain:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description: |
+      8-bit dark gain compensation factor(4 int and 4 fractional bits - Q4.4)
+      applied when light < threshold. Default: 0x16
+
+  upisemi,continuous:
+    $ref: /schemas/types.yaml#definitions/flag
+    description: |
+      This chip has two power modes: one-shot (chip takes one measurement and
+      then shuts itself down) and continuous (chip takes continuous
+      measurements). The one-shot mode is more power-friendly but the
+      continuous mode may be more reliable. If this property is specified
+      the continuous mode will be used instead of the default one-shot one for
+      raw reads.
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
+            compatible = "upisemi,usd5182";
+            reg = <0x39>;
+            upisemi,glass-coef = < 1000 >;
+            upisemi,dark-ths = /bits/ 16 <170 200 512 512 800 2000 4000 8000>;
+            upisemi,upper-dark-gain = /bits/ 8 <0x00>;
+            upisemi,lower-dark-gain = /bits/ 8 <0x16>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/light/us5182d.txt b/Documentation/devicetree/bindings/iio/light/us5182d.txt
deleted file mode 100644
index a61979997f37..000000000000
--- a/Documentation/devicetree/bindings/iio/light/us5182d.txt
+++ /dev/null
@@ -1,45 +0,0 @@
-* UPISEMI us5182d I2C ALS and Proximity sensor
-
-Required properties:
-- compatible: must be "upisemi,usd5182"
-- reg: the I2C address of the device
-
-Optional properties:
-- upisemi,glass-coef: glass attenuation factor - compensation factor of
-                      resolution 1000 for material transmittance.
-
-- upisemi,dark-ths: array of 8 elements containing 16-bit thresholds (adc
-                    counts) corresponding to every scale.
-
-- upisemi,upper-dark-gain: 8-bit dark gain compensation factor(4 int and 4
-                           fractional bits - Q4.4) applied when light > threshold
-
-- upisemi,lower-dark-gain: 8-bit dark gain compensation factor(4 int and 4
-                           fractional bits - Q4.4) applied when light < threshold
-
-- upisemi,continuous: This chip has two power modes: one-shot (chip takes one
-                      measurement and then shuts itself down) and continuous (
-                      chip takes continuous measurements). The one-shot mode is
-                      more power-friendly but the continuous mode may be more
-                      reliable. If this property is specified the continuous
-                      mode will be used instead of the default one-shot one for
-                      raw reads.
-
-If the optional properties are not specified these factors will default to the
-values in the below example.
-The glass-coef defaults to no compensation for the covering material.
-The threshold array defaults to experimental values that work with US5182D
-sensor on evaluation board - roughly between 12-32 lux.
-There will be no dark-gain compensation by default when ALS > thresh
-(0 * dark-gain), and a 1.35 compensation factor when ALS < thresh.
-
-Example:
-
-    usd5182@39 {
-                compatible = "upisemi,usd5182";
-                reg = <0x39>;
-                upisemi,glass-coef = < 1000 >;
-                upisemi,dark-ths = /bits/ 16 <170 200 512 512 800 2000 4000 8000>;
-                upisemi,upper-dark-gain = /bits/ 8 <0x00>;
-                upisemi,lower-dark-gain = /bits/ 8 <0x16>;
-    };
-- 
2.28.0

