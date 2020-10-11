Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841C728A841
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 18:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388182AbgJKQdL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 12:33:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388091AbgJKQdK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 12:33:10 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FD9D2222F;
        Sun, 11 Oct 2020 16:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602433990;
        bh=APaEzrXD8m2ycuL796wBGjbb9vQKOwbTzbusbKhLeG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kAAZ8/5Yz+TlHYxuKFE0aBT/u3r2hC2o6PeTmJdWvyBbKILXxsJe4RJVjkR9Lg0Nn
         jdBOsReWiW8uRYSTX7vYOZsqKy0pmciRh2h8WLodXSay/0SUeEn3MbaSDoVrSswDNT
         Tn8UQ2Emvb7SAcBSuk1RMRiSVpqlMnxG676DLE6Q=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/2] dt-bindings:iio:iio-consumer add yaml binding for IIO consumers
Date:   Sun, 11 Oct 2020 17:30:30 +0100
Message-Id: <20201011163031.240708-2-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201011163031.240708-1-jic23@kernel.org>
References: <20201011163031.240708-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This can be used via $ref by bindings that are consumers of the
channels provided by IIO devices.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../devicetree/bindings/iio/iio-bindings.txt  | 53 -----------------
 .../devicetree/bindings/iio/iio-consumer.yaml | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 53 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
index aa63cac7323e..cfaed2b54fa9 100644
--- a/Documentation/devicetree/bindings/iio/iio-bindings.txt
+++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
@@ -47,56 +47,3 @@ Example for a configuration with trigger:
 		};
 	};
 
-==IIO consumers==
-
-Required properties:
-io-channels:	List of phandle and IIO specifier pairs, one pair
-		for each IIO input to the device. Note: if the
-		IIO provider specifies '0' for #io-channel-cells,
-		then only the phandle portion of the pair will appear.
-
-Optional properties:
-io-channel-names:
-		List of IIO input name strings sorted in the same
-		order as the io-channels property. Consumers drivers
-		will use io-channel-names to match IIO input names
-		with IIO specifiers.
-io-channel-ranges:
-		Empty property indicating that child nodes can inherit named
-		IIO channels from this node. Useful for bus nodes to provide
-		and IIO channel to their children.
-
-For example:
-
-	device {
-		io-channels = <&adc 1>, <&ref 0>;
-		io-channel-names = "vcc", "vdd";
-	};
-
-This represents a device with two IIO inputs, named "vcc" and "vdd".
-The vcc channel is connected to output 1 of the &adc device, and the
-vdd channel is connected to output 0 of the &ref device.
-
-==Example==
-
-	adc: max1139@35 {
-		compatible = "maxim,max1139";
-		reg = <0x35>;
-		#io-channel-cells = <1>;
-	};
-
-	...
-
-	iio-hwmon {
-		compatible = "iio-hwmon";
-		io-channels = <&adc 0>, <&adc 1>, <&adc 2>,
-			<&adc 3>, <&adc 4>, <&adc 5>,
-			<&adc 6>, <&adc 7>, <&adc 8>,
-			<&adc 9>;
-	};
-
-	some_consumer {
-		compatible = "some-consumer";
-		io-channels = <&adc 10>, <&adc 11>;
-		io-channel-names = "adc1", "adc2";
-	};
diff --git a/Documentation/devicetree/bindings/iio/iio-consumer.yaml b/Documentation/devicetree/bindings/iio/iio-consumer.yaml
new file mode 100644
index 000000000000..5f28cc29edce
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/iio-consumer.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/iio-consumer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic IIO consumer-bindings
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+description:
+  This binding describes generic properties a consumer of the channels
+  provided by an IIO device may use.
+
+  As well, direct readings of channels on an IIO Device, an IIO device
+  can provide services to consumer devices. Thes are in the form of
+  channel readings and properties.  For example, an ADC might provide
+  3 channels to an analog accelerometer so that an accelerometer
+  driver can use them to read the voltages that correspond to the
+  accelerations on the 3 axis and apply appropriate calibration to
+  provide useful outputs.
+
+properties:
+  io-channels:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: >
+      List of phandle and IIO specifier pairs, one pair
+      for each IIO input to the device. Note: if the
+      IIO provider specifies '0' for #io-channel-cells,
+      then only the phandle portion of the pair will appear.
+
+  io-channel-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: >
+      List of names associated with a given IIO channel by the consumer
+      device.  An example for an analog accelerometer would be "accel_x".
+      Consumers drivers will use io-channel-names to locate the correct
+      phandle based reference in io-channels.
+
+  io-channel-ranges:
+    type: boolean
+    description: >
+      Empty property indicating that child nodes can inherit named
+      IIO channels from this node. Useful for bus nodes to provide
+      and IIO channel to their children.
+
+additionalProperties: true
+
+examples:
+ - |
+   iio-hwmon {
+       compatible = "iio-hwmon";
+       io-channels = <&adc 0>, <&adc 1>, <&adc 2>,
+                     <&adc 3>, <&adc 4>, <&adc 5>,
+                     <&adc 6>, <&adc 7>, <&adc 8>,
+                     <&adc 9>;
+   };
+...
\ No newline at end of file
-- 
2.28.0

