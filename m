Return-Path: <linux-iio+bounces-24148-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D459EB593A8
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 12:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510921BC7E05
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 10:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E89304BA0;
	Tue, 16 Sep 2025 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UncBYGta"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732FE2EA17F
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018260; cv=none; b=RugTUbI6DQAxUH08Cw7Hc5URHNYJlNK28rrqASvwGMXjeRvmQ+JK1Bdfpp1Rbs9j8FKiMVgsuoiLEMsGmA2T3NuKPh53CQX+1RCD4B6x3AliTfgnfxBvrQ2x41xqeG8RPJKK+Nixya5SrcUUCBxfIV+gpB7GzSsix+dprTdDDDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018260; c=relaxed/simple;
	bh=1HH2OEcu+cpc+I8pNMm7X8z4A5Dj+Gawx9fnsMB1wgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g1KDNF0LD4b9Ig6WDdoYR90DtkOPgGVe39WSJ0hYbQDgGoDAvMEYBNcOdE0XBB7hmT3/6SMH7d4iUsOKhGe1qiSFuydya7tF7ActwMg8zwSc04Gh5PLdkbsu9rE5+6H29Mp9fQktEggoKaR/KhwwUAHfto8knLDc0Lv+dAxMeYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UncBYGta; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 693B8C653F4;
	Tue, 16 Sep 2025 10:24:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C86376061E;
	Tue, 16 Sep 2025 10:24:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 65A7A102F16DF;
	Tue, 16 Sep 2025 12:24:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758018255; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QmgIZk8v+yaO4KbxgsVom5F3SapikDvNEzIqr0l6CME=;
	b=UncBYGtaNWoFCZJ9ojRw9CNZFtnDWAray699C2BrLgpRlFfZTYSWOJTl7MF0hpUsbVrzYK
	7mP1E9hb0kxyQGcM02lhgOMz9c3s9wxSEcQwMMkSCJItE7BFsHn0e2vlp6MgdPEJJ0o6pB
	ZacmwpvfieXrR6eCnj/gZ9yIgYEPE9XPwsCdG84U3RjIPyOeTPbSV0Tjomo8IX4hmzEd31
	A/Mih5Di3iAonrRaXQNsizoX/lJJnUyJbcF0yv2TiCMiousFV0lVA/2XVMPxHAlECoAKY1
	KPfS5HwIE/1Empflk+Wk+LjQ+oSwt7A4S0xytUXb53A+tAkXl9X0LmJd01bBxA==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 16 Sep 2025 12:24:06 +0200
Subject: [PATCH 1/4] regulator: dt-bindings: Add Linear Technology LTM8054
 regulator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-ltm8054-driver-v1-1-fd4e781d33b9@bootlin.com>
References: <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
In-Reply-To: <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
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
 .../bindings/regulator/lltc,ltm8054.yaml           | 77 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 82 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/lltc,ltm8054.yaml b/Documentation/devicetree/bindings/regulator/lltc,ltm8054.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..4db11be178b0e662ec51f3d3d73202f8c32625d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/lltc,ltm8054.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/lltc,ltm8054.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Linear Technology LTM8054 buck-boost regulator
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
+    const: lltc,ltm8054
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
+  lltc,iout-rsense-micro-ohms:
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
+
+    / {
+
+        regulator {
+            compatible = "lltc,ltm8054";
+
+            enable-gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
+
+            lltc,fb-voltage-divider = <1000000 68000>;
+
+            lltc,iout-rsense-micro-ohms = <20000>;
+
+            io-channels = <&dac 1>;
+            io-channel-names = "ctl";
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa45799dfe07de2f54de6d6a1ce0615..7160179e6bf9d45a241582c1b6df8c0ebf6c3641 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14517,6 +14517,11 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
 F:	drivers/i2c/muxes/i2c-mux-ltc4306.c
 
+LTM8054 REGULATOR DRIVER
+M:	Romain Gantois <romain.gantois@bootlin.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/regulator/lltc,ltm8054.yaml
+
 LTP (Linux Test Project)
 M:	Andrea Cervesato <andrea.cervesato@suse.com>
 M:	Cyril Hrubis <chrubis@suse.cz>

-- 
2.51.0


