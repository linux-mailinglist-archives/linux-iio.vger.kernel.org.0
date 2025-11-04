Return-Path: <linux-iio+bounces-25870-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0645C31DD0
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 16:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE2E3B8AC2
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 15:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7734D299AA3;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j20I2iYl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDE526158B;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270474; cv=none; b=kl2+fClfEgZNwptkVXsY8liX4Tfaw2eBw8hE/hKLtSRgvnhn5wtE1y28xoqjInGaWJX94ol5+eqg7grSxrefNILVzAEJgcTkySAZNo8iBAOhVs30anh9ueW49IitJBu+H2GbNq2ihvaxX8QQM2qjfJj6X0OG5a4+adobqJ0+RpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270474; c=relaxed/simple;
	bh=pK6vCEZC6DF7MwzAFXKfnnTvYAgdCk2SG8ngn/f4ZaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U2F+9Bxf7RXV+d/sD6zvUiMPTxvtpY/Lgzd0Tn9YwM1tkqt7adKmzNjLx03iJVmzQwpS135P46kHAN0h6+z9LJ10UBwH1mdjsLrqdQG2W/9StN36K2EOwSv6pEhPVK+85xT1F2bdiUhxMf6zX/LjL8885pZTk45ybhCztMDE+Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j20I2iYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED29FC116C6;
	Tue,  4 Nov 2025 15:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762270474;
	bh=pK6vCEZC6DF7MwzAFXKfnnTvYAgdCk2SG8ngn/f4ZaQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=j20I2iYlZXmyJpnlEk6mFvIFoyNZEckjzqKYWnPs7ggG7/Uy6PNoeWeluHdwehYJf
	 Xdo/iLH/+XGI/Zk3x3My+w7b2gm6U7RbeNR3PCBcNkjp1I4A51UbKOairS/pLJ50dD
	 vZfisINYQfbJ7rr7l7vkLBxXcMA2Jfbnb/hJb3tIAIgWQlouIDN9jJo2SG95Zl1m4s
	 /EfsoQkUDV6qmWDXL2NAzHcczZr/GxkBcWEWTj5/TrESqJ44FbQRnxoUtpd1vB7nOn
	 n6N0ssHOoGdiMt7COyv0PRGkYUag2PZpm/c20kgk4NKig8ATnAtL4zE3p1uVJJqcod
	 5C0StEzFB/Lzg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF47BCCF9E3;
	Tue,  4 Nov 2025 15:34:33 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 04 Nov 2025 15:35:06 +0000
Subject: [PATCH v4 01/12] dt-bindings: iio: dac: Document AD5446 and
 similar devices
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251104-dev-add-ad5542-v4-1-6fe35458bf8c@analog.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
In-Reply-To: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762270508; l=5117;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ilsaRzkJ8yfckQSj+fp3nBx94rCUsN0wDViEmHKqLcY=;
 b=CtkjpUo54DYBeYmVkGKe2qpRcDxncB8BzSa/0Io0FWHoXMqbNECbYT9wHxLXJLZ+BDMSAekPE
 lyUpazHhwSzD6EVL85pnNZ6VRFJXu9/LL/YK1J4PvIetI35vCHmlTcm
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Add device tree binding documentation for the Analog Devices AD5446
family of Digital-to-Analog Converters and derivative devices from
Texas Instruments. There's both SPI and I2C interfaces and feature
resolutions ranging from 8-bit to 16-bit.

The binding covers 29 derivatives devices including the AD5446 series,
AD5600 series, AD5620/5640/5660 variants with different voltage ranges,
and TI DAC081s101/DAC101s101/DAC121s101 devices.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5446.yaml    | 138 +++++++++++++++++++++
 MAINTAINERS                                        |   8 ++
 2 files changed, 146 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
new file mode 100644
index 000000000000..2669d2c4948b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5446.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5446 and similar DACs
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+  - Nuno Sá <nuno.sa@analog.com>
+
+description:
+  Digital to Analog Converter devices supporting both SPI and I2C interfaces.
+  These devices feature a range of resolutions from 8-bit to 16-bit.
+
+properties:
+  compatible:
+    oneOf:
+      - description: SPI DACs
+        enum:
+          - adi,ad5300
+          - adi,ad5310
+          - adi,ad5320
+          - adi,ad5444
+          - adi,ad5446
+          - adi,ad5450
+          - adi,ad5451
+          - adi,ad5452
+          - adi,ad5453
+          - adi,ad5512a
+          - adi,ad5541a
+          - adi,ad5542
+          - adi,ad5542a
+          - adi,ad5543
+          - adi,ad5553
+          - adi,ad5600
+          - adi,ad5601
+          - adi,ad5611
+          - adi,ad5621
+          - adi,ad5641
+          - adi,ad5620-2500
+          - adi,ad5620-1250
+          - adi,ad5640-2500
+          - adi,ad5640-1250
+          - adi,ad5660-2500
+          - adi,ad5660-1250
+          - adi,ad5662
+          - ti,dac081s101
+          - ti,dac101s101
+          - ti,dac121s101
+      - description: I2C DACs
+        enum:
+          - adi,ad5301
+          - adi,ad5311
+          - adi,ad5321
+          - adi,ad5602
+          - adi,ad5612
+          - adi,ad5622
+
+  reg:
+    maxItems: 1
+
+  vcc-supply:
+    description:
+      Reference voltage supply. If not supplied, devices with internal
+      voltage reference will use that.
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad5300
+              - adi,ad5310
+              - adi,ad5320
+              - adi,ad5444
+              - adi,ad5446
+              - adi,ad5450
+              - adi,ad5451
+              - adi,ad5452
+              - adi,ad5453
+              - adi,ad5512a
+              - adi,ad5541a
+              - adi,ad5542
+              - adi,ad5542a
+              - adi,ad5543
+              - adi,ad5553
+              - adi,ad5600
+              - adi,ad5601
+              - adi,ad5611
+              - adi,ad5621
+              - adi,ad5641
+              - adi,ad5620-2500
+              - adi,ad5620-1250
+              - adi,ad5640-2500
+              - adi,ad5640-1250
+              - adi,ad5660-2500
+              - adi,ad5660-1250
+              - adi,ad5662
+              - ti,dac081s101
+              - ti,dac101s101
+              - ti,dac121s101
+    then:
+      allOf:
+        - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "adi,ad5446";
+            reg = <0>;
+            vcc-supply = <&dac_vref>;
+        };
+    };
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@42 {
+            compatible = "adi,ad5622";
+            reg = <0x42>;
+            vcc-supply = <&dac_vref>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 8082081ea742..9654f0c25423 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -440,6 +440,14 @@ W:	http://wiki.analog.com/AD5398
 W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/regulator/ad5398.c
 
+AD5446	ANALOG DEVICES INC AD5446 DAC DRIVER
+M:	Michael Hennerich <michael.hennerich@analog.com>
+M:	Nuno Sá <nuno.sa@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
+
 AD714X CAPACITANCE TOUCH SENSOR DRIVER (AD7142/3/7/8/7A)
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported

-- 
2.51.0



