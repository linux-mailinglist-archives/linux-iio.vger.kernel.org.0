Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4712A194C
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgJaSOy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:14:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728263AbgJaSOy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:14:54 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD764206F9;
        Sat, 31 Oct 2020 18:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604168093;
        bh=NMc1PNAZQxUSeAZbY3Gczu/MXpIt6te8IgTivcFzDlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fkz5vcgT87Abb7uu9li5CAvBaM6/gaRoIhxKika5fpxmeKgt1Mm9Zine6ygjqNa/Y
         sQTKUuMv1zh0XjDEluSTGcNCYKS5jrYzUUXk4Zwn9c+/wsiO7risJsJBLqvfP/hnL9
         7voKoy/FK1ZeOV1ySNIUdSaf4C6cguibIVj38MxM=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 01/10] dt-bindings:iio:iio-binding.txt Drop file as content now in dt-schema
Date:   Sat, 31 Oct 2020 18:12:33 +0000
Message-Id: <20201031181242.742301-2-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031181242.742301-1-jic23@kernel.org>
References: <20201031181242.742301-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

File contained generic IIO wide bindings.
Now part of the external dt-schema repository.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../devicetree/bindings/iio/iio-bindings.txt  | 102 ------------------
 1 file changed, 102 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
deleted file mode 100644
index aa63cac7323e..000000000000
--- a/Documentation/devicetree/bindings/iio/iio-bindings.txt
+++ /dev/null
@@ -1,102 +0,0 @@
-This binding is derived from clock bindings, and based on suggestions
-from Lars-Peter Clausen [1].
-
-Sources of IIO channels can be represented by any node in the device
-tree. Those nodes are designated as IIO providers. IIO consumer
-nodes use a phandle and IIO specifier pair to connect IIO provider
-outputs to IIO inputs. Similar to the gpio specifiers, an IIO
-specifier is an array of one or more cells identifying the IIO
-output on a device. The length of an IIO specifier is defined by the
-value of a #io-channel-cells property in the IIO provider node.
-
-[1] https://marc.info/?l=linux-iio&m=135902119507483&w=2
-
-==IIO providers==
-
-Required properties:
-#io-channel-cells: Number of cells in an IIO specifier; Typically 0 for nodes
-		   with a single IIO output and 1 for nodes with multiple
-		   IIO outputs.
-
-Optional properties:
-label:		   A symbolic name for the device.
-
-
-Example for a simple configuration with no trigger:
-
-	adc: voltage-sensor@35 {
-		compatible = "maxim,max1139";
-		reg = <0x35>;
-		#io-channel-cells = <1>;
-		label = "voltage_feedback_group1";
-	};
-
-Example for a configuration with trigger:
-
-	adc@35 {
-		compatible = "some-vendor,some-adc";
-		reg = <0x35>;
-
-		adc1: iio-device@0 {
-			#io-channel-cells = <1>;
-			/* other properties */
-		};
-		adc2: iio-device@1 {
-			#io-channel-cells = <1>;
-			/* other properties */
-		};
-	};
-
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
-- 
2.28.0

