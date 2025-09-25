Return-Path: <linux-iio+bounces-24430-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 869EEB9F492
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 14:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425F43B1192
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 12:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355B51A9FA1;
	Thu, 25 Sep 2025 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cOJTMFFC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99D5146593
	for <linux-iio@vger.kernel.org>; Thu, 25 Sep 2025 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803878; cv=none; b=XBYLecB1WX2G7vj4VIR9T2vHURz94YN/CM8rF6JtBHNk3WwO4Xb15Y94F8xBJoGnu2lTWkPNdsvE6IZKmctLk0wcFUIFVw7uKT7mDVeUvqzO1oRSd0LvcFrTySKv/7uwUz84sCXU+g6HU9TniyQztS8sDwimHhyyWPhYXsAQg0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803878; c=relaxed/simple;
	bh=ARaI6sAn1ScO5elgBBI9/4QuQ8iaswhaC7shsZDwj/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hqrzj85OL5MMxSlzrR3v3wguZAN924e64y0uyaEFmjeg1nFlaauzBwHlziYpjV6j8as6UpZ41PYIY7FbJY1VlFnsuyh2X2EQ0lsY5nVQzYNIctGMvHQwvQcusnsCe1z6P7G4foi7kSnsu6vWpJZI4yfp69ZIHSLAXVTL4fOv1iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cOJTMFFC; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 379414E40DD6;
	Thu, 25 Sep 2025 12:37:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0DE2D6062C;
	Thu, 25 Sep 2025 12:37:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 077E8102F189D;
	Thu, 25 Sep 2025 14:37:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758803873; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ezJpNoVstQDrmQSBUVTTKViwRkcKwZkbTFCSfYyOfLo=;
	b=cOJTMFFCKWKEFQmNFlW3MfN9N5SRo2gPqNd2lCAGbQeabZgTxz1w+7IUHFksTHnoVn7Ryy
	77bpakGtGVZS3mzxBlZnamf8eFsxVDDBUm+5dpnqeiGwk4UJMOTYDXLBGhxQot3npcPDrh
	ZdmWMBfxk8FaKHdKcwzjn8G/uJQt8Jm8pPMeqFxfcSvo6YlQgS087Tv2gD05MsNoOXt4LP
	7QQRcWKd5w9uRuKonJxmCpL+lzXGSIWvkSEhk/SaNLPh8oMC+c+ISnCppsDE0uvLMksYja
	61wpxgyQzci6SSjg2bCwlQbU1CXHGfFYCn9gJgGxAMNViCMPW872T9EAh8JM8g==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Thu, 25 Sep 2025 14:37:33 +0200
Subject: [PATCH v2 1/5] regulator: dt-bindings: Add Linear Technology
 LTM8054 regulator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-ltm8054-driver-v2-1-bb61a401a0dc@bootlin.com>
References: <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
In-Reply-To: <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

The Linear Technology LTM8054 is a Buck-Boost voltage regulator with an
input range of 5V to 36V and an output range of 1.2V to 36V.

The LTM8054's output voltage level is typically set using a voltage divider
between the Vout and FB pins, the FB pin being constantly regulated to
1.2V.

The output current limit of the LTM8054 may be statically set by placing a
sense resistor on a dedicated pin. This limit can then be lowered by
controlling the voltage level on the CTL pin.

Describe the LTM8054 voltage regulator.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 .../devicetree/bindings/regulator/adi,ltm8054.yaml | 73 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 78 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/adi,ltm8054.yaml b/Documentation/devicetree/bindings/regulator/adi,ltm8054.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..8ca8fc4e80b5722f58b4cbe9de22c16d4fd91670
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/adi,ltm8054.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/adi,ltm8054.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices LTM8054 buck-boost regulator
+
+maintainers:
+  - Romain Gantois <romain.gantois@bootlin.com>
+
+description:
+  This regulator operates over an input voltage range of 5V to 36V, and can
+  output from 1.2V to 36V. The output voltage level is typically set with a
+  voltage divider between the Vout pin and the FB pin which is internally
+  regulated to 1.2V.
+
+  The output current of the LTM8054 can be limited by tying the Iout pin to a
+  current sense resistor. This limit can be further lowered by applying a
+  voltage below 1.2V to the CTL pin.
+
+allOf:
+  - $ref: /schemas/regulator/regulator.yaml#
+
+properties:
+  compatible:
+    const: adi,ltm8054
+
+  enable-gpios:
+    description: GPIO connected to the RUN pin.
+    maxItems: 1
+
+  lltc,fb-voltage-divider:
+    description:
+      An array of two integers containing the resistor values
+      R1 and R2 of the feedback voltage divider in Ohms.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 2
+
+  adi,iout-rsense-micro-ohms:
+    description:
+      Value of the output current sense resistor, in micro Ohms.
+
+  io-channels:
+    items:
+      - description: DAC controlling the voltage level of the CTL pin.
+
+  io-channel-names:
+    items:
+      - const: ctl
+
+required:
+  - compatible
+  - lltc,fb-voltage-divider
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    regulator {
+        compatible = "adi,ltm8054";
+
+        enable-gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
+
+        lltc,fb-voltage-divider = <1000000 68000>;
+
+        adi,iout-rsense-micro-ohms = <20000>;
+
+        io-channels = <&dac 1>;
+        io-channel-names = "ctl";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 3763f9fc9e4ed62bc8b273756a25f9c921570bee..69bcba82808bb815af436232fab50f70713fd533 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14534,6 +14534,11 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
 F:	drivers/i2c/muxes/i2c-mux-ltc4306.c
 
+LTM8054 REGULATOR DRIVER
+M:	Romain Gantois <romain.gantois@bootlin.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/regulator/adi,ltm8054.yaml
+
 LTP (Linux Test Project)
 M:	Andrea Cervesato <andrea.cervesato@suse.com>
 M:	Cyril Hrubis <chrubis@suse.cz>

-- 
2.51.0


