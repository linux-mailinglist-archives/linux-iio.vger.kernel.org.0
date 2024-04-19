Return-Path: <linux-iio+bounces-4355-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3528AAA14
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 10:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFDE91C210CF
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 08:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEBB5FB99;
	Fri, 19 Apr 2024 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8lfng7f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F3754907;
	Fri, 19 Apr 2024 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515137; cv=none; b=fyEogKyscM1hOFB+mby/sVpAB+HOk10j97Ry09kQMCljj6WlwutlyjrWPrz6sYoTzKHaXL2TbzIPSggc2cmIdvzuZLMXsyRYMUhRG54WWdXh9TM7qQThyXicalGUDpJOHzrp+DTT4MX1V08WX06L4l8Zu71obtYyGaVmx7VsZcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515137; c=relaxed/simple;
	bh=JU9xMtgHF7csYGyrdna2VMJrSw3PZxwUCZMaLSIEDGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AvG8tISHlCZ5ND+oTfl7w26AmqM0QBy/Nru7wb6kCqBKe4KZTFFl+JIzXwo4i6YaBX0Wq2L8zYj17dDfcchn/XrmORYexh37EutAPykMgnVIIIJfMAxz4Q3Mkq94Pna8Ug8M2x1SekRudRcCnybFT0bimqR+RhGosL+Q0gkrNr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8lfng7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 704A0C4AF17;
	Fri, 19 Apr 2024 08:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713515137;
	bh=JU9xMtgHF7csYGyrdna2VMJrSw3PZxwUCZMaLSIEDGw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=D8lfng7flhrZ6QiZKvz6842wleic809WXEQ6u1A4ZuTwmHmaYjw7KMFbjIDAH/tCc
	 qKbh7IHuykSWiDPPCtQ0lpegbaVgnHMyeCmTzIbnidPFfeT+g8SekUDKnevVwbfV5p
	 qExKHveBzgCvz0m6rGXKSgwiuT6o/YZGiMWnA9Xx/Gr4DK8Vp4dYdWBDIYCr3tUNz9
	 EtPF9SynQZseXIBFs3mW84GOX2u6iSgDjDNoswLX/RsfICtgH78ipBCasct7ACWgo3
	 kWgTOAKgr7nN2yPE2ZXjHJzG03mOI0H+D0YELnJEvtwyOPHSiBZ7rTnSu2Y+i2Xkm1
	 Qrec/uybXERYg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD41C05052;
	Fri, 19 Apr 2024 08:25:37 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 19 Apr 2024 10:25:40 +0200
Subject: [PATCH v4 07/10] dt-bindings: iio: dac: add docs for AD9739A
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-iio-backend-axi-dac-v4-7-5ca45b4de294@analog.com>
References: <20240419-iio-backend-axi-dac-v4-0-5ca45b4de294@analog.com>
In-Reply-To: <20240419-iio-backend-axi-dac-v4-0-5ca45b4de294@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Dragos Bogdan <dragos.bogdan@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713515134; l=3382;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=GMLvgZ43GiJT/S7gjQSxbTyRzXSCKsuzuMjmfYxCvfc=;
 b=ytKS9K7LRQ3wYpL9nGcQDQKyBz6bdcNx86HWWI7CoymQNt1mBh/exB/SQEV33HsQBD1F5l8ef
 vJ5L0xGCDp5DOh7AXhd20N7J/puRH6wArDE1Iz7Tn5aErA4KwTlzF08
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

This adds the bindings documentation for the 14 bit
RF Digital-to-Analog converter.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad9739a.yaml   | 95 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 ++
 2 files changed, 103 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
new file mode 100644
index 000000000000..c0b36476113a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad9739a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD9739A RF DAC
+
+maintainers:
+  - Dragos Bogdan <dragos.bogdan@analog.com>
+  - Nuno Sa <nuno.sa@analog.com>
+
+description: |
+  The AD9739A is a 14-bit, 2.5 GSPS high performance RF DACs that are capable
+  of synthesizing wideband signals from dc up to 3 GHz.
+
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad9737a_9739a.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad9739a
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-3p3-supply:
+    description: 3.3V Digital input supply.
+
+  vdd-supply:
+    description: 1.8V Digital input supply.
+
+  vdda-supply:
+    description: 3.3V Analog input supply.
+
+  vddc-supply:
+    description: 1.8V Clock input supply.
+
+  vref-supply:
+    description: Input/Output reference supply.
+
+  io-backends:
+    maxItems: 1
+
+  adi,full-scale-microamp:
+    description: This property represents the DAC full scale current.
+    minimum: 8580
+    maximum: 31700
+    default: 20000
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - io-backends
+  - vdd-3p3-supply
+  - vdd-supply
+  - vdda-supply
+  - vddc-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
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
+            compatible = "adi,ad9739a";
+            reg = <0>;
+
+            clocks = <&dac_clk>;
+
+            io-backends = <&iio_backend>;
+
+            vdd-3p3-supply = <&vdd_3_3>;
+            vdd-supply = <&vdd>;
+            vdda-supply = <&vdd_3_3>;
+            vddc-supply = <&vdd>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 2137eb452376..76e872e320d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1234,6 +1234,14 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
 F:	drivers/iio/adc/ad7780.c
 
+ANALOG DEVICES INC AD9739a DRIVER
+M:	Nuno Sa <nuno.sa@analog.com>
+M:	Dragos Bogdan <dragos.bogdan@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
+
 ANALOG DEVICES INC ADA4250 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-iio@vger.kernel.org

-- 
2.44.0



