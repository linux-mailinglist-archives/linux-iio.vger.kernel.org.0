Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6CD2A1982
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgJaS0g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:26:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbgJaS0g (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:26:36 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF5D3206E5;
        Sat, 31 Oct 2020 18:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604168795;
        bh=U1dh3AOQV2DXiOJH4cpAjoDC8XqoWAgV4iaJYvGXQtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TryrTrDxC0xSVC3Omn3nqpQKjoikf2Zd2F4cH4+DJRhMlfSl3I1IE115ySymNamTY
         JcO4sG1eVrL/UjFa25Ca0gtNVu8eRHE6FV29iQzIb8eM1AUsEgsGLhHgmIPIucpow4
         RTjZTELc7iq6OQviUAM3mfAQSoiPRi+Jif/8YWhs=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/3] dt-bindings:iio:adc: convert adc.txt to yaml
Date:   Sat, 31 Oct 2020 18:24:21 +0000
Message-Id: <20201031182423.742798-2-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031182423.742798-1-jic23@kernel.org>
References: <20201031182423.742798-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Each driver that uses this will need to use a $ref
We can't always enable it like most of the generic bindings due to
channel@X matching far more widely than IIO.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../devicetree/bindings/iio/adc/adc.txt       | 23 -----------
 .../devicetree/bindings/iio/adc/adc.yaml      | 38 +++++++++++++++++++
 2 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.txt b/Documentation/devicetree/bindings/iio/adc/adc.txt
deleted file mode 100644
index 5bbaa330a250..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/adc.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Common ADCs properties
-
-Optional properties for child nodes:
-- bipolar : Boolean, if set the channel is used in bipolar mode.
-- diff-channels : Differential channels muxed for this ADC. The first value
-		specifies the positive input pin, the second value the negative
-		input pin.
-
-Example:
-	adc@0 {
-		compatible = "some,adc";
-		...
-		channel@0 {
-			bipolar;
-			diff-channels = <0 1>;
-			...
-		};
-
-		channel@1 {
-			diff-channels = <2 3>;
-			...
-		};
-	};
diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
new file mode 100644
index 000000000000..328a4318feee
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic IIO bindings for ADC channels
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+description:
+  A few properties are defined in a common way ADC channels.
+
+properties:
+  $nodename:
+    pattern: "^channel(@[0-9a-f]+)?$"
+    description:
+      A channel index should match reg.
+
+  reg:
+    maxItems: 1
+
+  bipolar:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: If provided, the channel is to be used in bipolar mode.
+
+  diff-channels:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 2
+    minItems: 2
+    description:
+      Many ADCs have dual Muxes to allow different input pins to be routed
+      to both the positive and negative inputs of a differential ADC.
+      The first value specifies the positive input pin, the second
+      specifies the negative input pin.
+
+additionalProperties: true
-- 
2.28.0

