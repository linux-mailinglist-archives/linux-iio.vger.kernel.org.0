Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AB525E96E
	for <lists+linux-iio@lfdr.de>; Sat,  5 Sep 2020 19:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgIERdF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Sep 2020 13:33:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728459AbgIERcp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Sep 2020 13:32:45 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FE7D20760;
        Sat,  5 Sep 2020 17:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599327165;
        bh=3VEbxW/JWesur5P76EKWlc6CVFWvzP9iSLLTM79UxgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HTAsQBv1w6Nl93W/C6lzeHKZ3ADXBRUu7MGBMKVc3kmv7tEwAW3YJMESvuNq9f3rH
         0bk9nG5TnF9ChVfKC39N59jW44vKOufZ0eT9v2P7tpOtJU0R25fk2ErewuN/j3P5yP
         9ItiHkHxYfP6452gFH1HARAi1GkAEPCNl5O352b8=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Phani Movva <Phani.Movva@imgtec.com>
Subject: [PATCH 13/20] dt-bindings:iio:adc:cosmic,10001-adc yaml conversion
Date:   Sat,  5 Sep 2020 18:29:57 +0100
Message-Id: <20200905173004.216081-14-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905173004.216081-1-jic23@kernel.org>
References: <20200905173004.216081-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I don't really know much about this one, hence the binding is
a simple conversion of what was in the txt file.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Phani Movva <Phani.Movva@imgtec.com>
---
 .../bindings/iio/adc/cc10001_adc.txt          | 22 -------
 .../bindings/iio/adc/cosmic,10001-adc.yaml    | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/cc10001_adc.txt b/Documentation/devicetree/bindings/iio/adc/cc10001_adc.txt
deleted file mode 100644
index 904f76de9055..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/cc10001_adc.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-* Cosmic Circuits - Analog to Digital Converter (CC-10001-ADC)
-
-Required properties:
-  - compatible: Should be "cosmic,10001-adc"
-  - reg: Should contain adc registers location and length.
-  - clock-names: Should contain "adc".
-  - clocks: Should contain a clock specifier for each entry in clock-names
-  - vref-supply: The regulator supply ADC reference voltage.
-
-Optional properties:
-  - adc-reserved-channels: Bitmask of reserved channels,
-    i.e. channels that cannot be used by the OS.
-
-Example:
-adc: adc@18101600 {
-	compatible = "cosmic,10001-adc";
-	reg = <0x18101600 0x24>;
-	adc-reserved-channels = <0x2>;
-	clocks = <&adc_clk>;
-	clock-names = "adc";
-	vref-supply = <&reg_1v8>;
-};
diff --git a/Documentation/devicetree/bindings/iio/adc/cosmic,10001-adc.yaml b/Documentation/devicetree/bindings/iio/adc/cosmic,10001-adc.yaml
new file mode 100644
index 000000000000..313a3b9642f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/cosmic,10001-adc.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/cosmic,10001-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cosmic Circuits CC-10001 ADC
+
+maintainers:
+  - Phani Movva <Phani.Movva@imgtec.com>
+
+description:
+  Cosmic Circuits 10001 10-bit ADC device.
+
+properties:
+  compatible:
+    const: cosmic,10001-adc
+
+  reg:
+    maxItems: 1
+
+  adc-reserved-channels:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+       Bitmask of reserved channels, i.e. channels that cannot be
+       used by the OS.
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: adc
+      
+  vref-supply: true
+
+  "#io-channel-cells":
+    const: 1
+
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - vref-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    adc@18101600 {
+        compatible = "cosmic,10001-adc";
+        reg = <0x18101600 0x24>;
+        adc-reserved-channels = <0x2>;
+        clocks = <&adc_clk>;
+        clock-names = "adc";
+        vref-supply = <&reg_1v8>;
+    };
+...
-- 
2.28.0

