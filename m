Return-Path: <linux-iio+bounces-27334-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B161CD9DEE
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 16:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AECA13024E35
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 15:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B287B29AB11;
	Tue, 23 Dec 2025 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yGQI0UkA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B395E275B06;
	Tue, 23 Dec 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766505353; cv=none; b=QeMtuQbTYJpWzy5OJM+8MXF6KeXUYt0bJJkdmspZXZNkCmBisL4FkYsLhYxvhpeowQtnTP+iL5X1B4hiSBU14U5nSh1ozpKQUNzTKu7d38zYru0/ClUFF2Ux06lU3rRYkS+vCF9b0KKHE6PcqjmsAf8cOwVpMnFXkUzC8jnuOi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766505353; c=relaxed/simple;
	bh=Q3ctYQU1rVgXAMam9Ncnna7UIHqfS/2j8YnOh/bGPCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EaZGaL2rprvidE1EOtmNrtykmOg0SDV72ZrLlX2CnmbMnUBIGerGwSumXZ1Sw0qxt1dw43JDe4WmVB7N+AKLlmNOR4etsa7eR/HLqZ36Pk7aOzjTJYIkp5LXlcz2wO2hu4z52NDIPqwfWL4U0Cs2IvImXPyUmxPAqoW+0HC6VHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yGQI0UkA; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 07D4FC1AE26;
	Tue, 23 Dec 2025 15:55:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1BAAD60716;
	Tue, 23 Dec 2025 15:55:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C98F810AB0BB0;
	Tue, 23 Dec 2025 16:55:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766505349; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=0AGvUoXA3WqR7xPRGLiv4z6PT4pGE6W54hFH1dJ1ESU=;
	b=yGQI0UkAmOqIxZCocLparNaW7Ptk96r0LKQQXarkb/k5tkw5BQ2kxcrJ5KX0dCsaWGYyCQ
	EeuglPeN3AZ+XvgeW3BmOFojaPgHhN8znm0JVDBVxdPbgLRSPGbYanYT3E0ymANt5Z1MHw
	p/OQHdpEEIzNoNoEalMX/ZyOvYLU6fWZlUzNicSrjfQBVYmFk2wGYxFPGTRsMuYyWVXulj
	dflDBZC0yGewkDdO2yAwpIhIXPRu+w6R2sYw5DhB7xUj1ECaD3eJFURYV3LFYsTqtNAZqA
	Jp1hSYejAgQ/LE+VbXZ+Zzo7OX7DflEXDuEpu0xJgh9zNo2ZI6t3LSDqlmz4gQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	nuno.sa@analog.com,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Eason Yang <j2anfernee@gmail.com>,
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	duje@dujemihanovic.xyz,
	herve.codina@bootlin.com,
	Rodolfo Giometti <giometti@enneenne.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com
Subject: [PATCH 1/2] dt-bindings: iio: adc: add Texas Instruments TLA 2528
Date: Tue, 23 Dec 2025 16:55:32 +0100
Message-ID: <20251223155534.220504-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251223155534.220504-1-maxime.chevallier@bootlin.com>
References: <20251223155534.220504-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The TI TLA 2528 is a simple 8 channel, 12-bit ADC? Add a binding
documentation for it.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../bindings/iio/adc/ti,tla2528.yaml          | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml b/Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml
new file mode 100644
index 000000000000..0ee326d77014
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,tla2528.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TLA2528 8-channel 12bit I2C ADC
+
+maintainers:
+  - Maxime Chevallier <maxime.chevallier@bootlin.com>
+
+description: |
+  12bit 8-channel I2C ADC.
+
+properties:
+  compatible:
+    const: ti,tla2528
+
+  reg:
+    maxItems: 1
+
+  vref-supply:
+    description: Supply for 2.35V to 5.5V reference voltage
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - vref-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@17 {
+            compatible = "ti,tla2528";
+            reg = <0x17>;
+            vref-supply = <&reg_adc_supply>;
+            #io-channel-cells = <1>;
+        };
+    };
+...
-- 
2.49.0


