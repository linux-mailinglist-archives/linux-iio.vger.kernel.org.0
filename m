Return-Path: <linux-iio+bounces-26421-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29557C81222
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 15:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26F844E5C8D
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 14:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147C0290D81;
	Mon, 24 Nov 2025 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iTAdJRrF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DA02857F0
	for <linux-iio@vger.kernel.org>; Mon, 24 Nov 2025 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763995723; cv=none; b=grUwmKllCOcsrkcyFpbAIdYU9SsKWjMcr1PUSU5y8+ztxyKIRlxtvjy7Kgfy8p5nh4iyHa/bNBwmTPXDnpkxWCTPEfBvbrtKsEdyrMXCOsTXSonbaUyUfSETXrwHUTjI08IPZyMIUbiwgae1IEb9d9cfKHDP3Nm8swhuy3q6bXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763995723; c=relaxed/simple;
	bh=OrkO7y9qnE72/Ku9E8D+eF1uBBKEPB6QSQT57rMvsiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O4IMDbDTXI4LhbZRcdgIBLa85FlOcKR9DWZXozEkzcl6g7Vax9oJZTYxdKRx3hJ2APFqZDRKuxSALsZfwYUajphw7QChVj9Fz/s7sLDgQaDUzXLR4RWumH61iThWggK2iOvVHLPn0+N6r13SUG+TI/LXmsB2TlYjtK7QGEErjZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iTAdJRrF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4857B1A1D22;
	Mon, 24 Nov 2025 14:48:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 18FD6606FC;
	Mon, 24 Nov 2025 14:48:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7610610371CD0;
	Mon, 24 Nov 2025 15:48:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763995718; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=F8s8iUypkLbmb7E4q/ez8SIGqplwHRkz5HZEnqvCcrQ=;
	b=iTAdJRrFz6tB5yGxtMdAXwwPA7rHaRL8aNQ9IZoj1ztl1GN3shjCEHg1eNYRP4wy3OqPc6
	Lfft3bmKUOpt9SOdk89sXRNtOgkpefkuMWr+WTZK7YbGZg/LM//PSQ0P0zgSbqpzvkEizM
	CQyRYiGkYAR4nySLeoALu2Q4cVTm7aygel7Y6DXpJpcjYIURNsg8kdH22MT/3nOqwn8yXO
	WtRvvEfheJocg8q900i8GGHh9j88mUoOl3iHmvKjzktGZMMMh3RMMl+oQF/KWsxBSmOQKt
	6Yt/AJOhIBJM/l/SO6U0LUuiEibx55TE/2oWGMARuVZ9vlPqRM5jrL0VU0+Muw==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Mon, 24 Nov 2025 15:48:05 +0100
Subject: [PATCH v4 1/6] regulator: dt-bindings: Add Linear Technology
 LTM8054 regulator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-ltm8054-driver-v4-1-107a8a814abe@bootlin.com>
References: <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
In-Reply-To: <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
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

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 .../devicetree/bindings/regulator/adi,ltm8054.yaml | 71 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 76 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/adi,ltm8054.yaml b/Documentation/devicetree/bindings/regulator/adi,ltm8054.yaml
new file mode 100644
index 000000000000..a982daecb4cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/adi,ltm8054.yaml
@@ -0,0 +1,71 @@
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
+  regulator-fb-voltage-divider-ohms:
+    description: Feedback voltage divider resistor values, in Ohms.
+    items:
+      - description: Top resistor value.
+      - description: Bottom resistor value.
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
+  - regulator-fb-voltage-divider-ohms
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
+        regulator-fb-voltage-divider-ohms = <1000000 68000>;
+
+        adi,iout-rsense-micro-ohms = <20000>;
+
+        io-channels = <&dac 1>;
+        io-channel-names = "ctl";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index b30cdbc270aa..01949aab8240 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14790,6 +14790,11 @@ W:	https://ez.analog.com/linux-software-drivers
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
2.51.2


