Return-Path: <linux-iio+bounces-25621-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6B1C1B7B8
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 15:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2125D188C9B1
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 14:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65896325710;
	Wed, 29 Oct 2025 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XXzWV4ja"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BAD348445
	for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749236; cv=none; b=Dbdt7DQ8q1uwB5Wtl4cPE3moVdourdvWPFPayAssGg2/rEvRsFdAiue8YQjqUt+7RPPhLtgSBq1mUMhL3MMqcfD4prAqugifIGuOegG8KDDMIC49V1ngYrHbCBX4y8pnppiJ4jsUcdi94Vj8eU9Vd8wc24ANd3XziPra/VtG8gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749236; c=relaxed/simple;
	bh=b243boCCaTbSMrqckzOBVcc5N40k8Nqv3axAi+ugjIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwzUrFZQcBjuoGWWSpE1FkkRbDiA4qVwdCr8qimsSVd369d10tOlNOf8XCto4rUWHbVWJRBqsRlAigRbYXDGwl7/e7j+JSQeIcwV3Qsy8ZhCay8HTugRSEU2Bp72k3IOI0mH5r/aMWFulhXzCM3BwAPKX0pXqXPS/yNqmPbzvg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XXzWV4ja; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 70B324E413CD;
	Wed, 29 Oct 2025 14:47:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 43FA7606E8;
	Wed, 29 Oct 2025 14:47:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 30B1B117F81D9;
	Wed, 29 Oct 2025 15:47:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761749231; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=fm/+HpeO68MBCP6BcE/IdTzwkeA3DkIILyT2jptsYkQ=;
	b=XXzWV4jarvRgdIdVxhjeaqgO+ujGNnl1bGEAJRnhevh7HP8QBPlOah3EoED79UqvixVmMo
	VCooERib60ZQbimKQj6aVxbX3+NgDousfqRI7lJ9fork9UJ1SIczrv4xDKZ4ZVOPjXLZB+
	Kh9zNbs7Iby7bf5WksKz0MMg4mT07KkSHB5bjuRYyrVH61iZDLv7fhonYyCkiLGUqIZgZH
	KjB+KnafPNs62NJesSLfCN9e6RBDkFHCFtH1NFQLwd2z9n1i+Q6w4ZIFWema98Qx1TLuGT
	1Ree+S74B8Mgm6aYHwOgwJArUMyT0cTDg91Hc4JGNuizNHh7m+cV37kxedbASA==
From: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 1/4] dt-bindings: iio: adc: Add the Renesas RZ/N1 ADC
Date: Wed, 29 Oct 2025 15:46:41 +0100
Message-ID: <20251029144644.667561-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029144644.667561-1-herve.codina@bootlin.com>
References: <20251029144644.667561-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The Renesas RZ/N1 ADC controller is the ADC controller available in the
Renesas RZ/N1 SoCs family.

Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.com>
---
 .../bindings/iio/adc/renesas,rzn1-adc.yaml    | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzn1-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzn1-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzn1-adc.yaml
new file mode 100644
index 000000000000..1a40352165fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzn1-adc.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/renesas,rzn1-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/N1 Analog to Digital Converter (ADC)
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+description:
+  The Renesas RZ/N1 ADC controller available in the Renesas RZ/N1 SoCs family
+  can use up to two internal ADC cores (ADC1 and ADC2) those internal cores are
+  handled through ADC controller virtual channels.
+
+properties:
+  compatible:
+    items:
+      - const: renesas,r9a06g032-adc   # RZ/N1D
+      - const: renesas,rzn1-adc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: APB internal bus clock
+      - description: ADC clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: adc
+
+  power-domains:
+    maxItems: 1
+
+  adc1-avdd-supply:
+    description:
+      ADC1 analog power supply.
+
+  adc1-vref-supply:
+    description:
+      ADC1 reference voltage supply.
+
+  adc2-avdd-supply:
+    description:
+      ADC2 analog power supply.
+
+  adc2-vref-supply:
+    description:
+      ADC2 reference voltage supply.
+
+  '#io-channel-cells':
+    const: 1
+    description: |
+      Channels numbers available:
+        if ADC1 is used (i.e. adc1-{avdd,vref}-supply present):
+          - 0: ADC1 IN0
+          - 1: ADC1 IN1
+          - 2: ADC1 IN2
+          - 3: ADC1 IN3
+          - 4: ADC1 IN4
+          - 5: ADC1 IN6
+          - 6: ADC1 IN7
+          - 7: ADC1 IN8
+        if ADC2 is used (i.e. adc2-{avdd,vref}-supply present):
+          - 8: ADC2 IN0
+          - 9: ADC2 IN1
+          - 10: ADC2 IN2
+          - 11: ADC2 IN3
+          - 12: ADC2 IN4
+          - 13: ADC2 IN6
+          - 14: ADC2 IN7
+          - 15: ADC2 IN8
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - power-domains
+  - '#io-channel-cells'
+
+# At least one of avvd/vref supplies
+anyOf:
+  - required:
+      - adc1-vref-supply
+      - adc1-avdd-supply
+  - required:
+      - adc2-vref-supply
+      - adc2-avdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a06g032-sysctrl.h>
+
+    adc: adc@40065000 {
+      compatible = "renesas,r9a06g032-adc", "renesas,rzn1-adc";
+      reg = <0x40065000 0x200>;
+      clocks = <&sysctrl R9A06G032_HCLK_ADC>, <&sysctrl R9A06G032_CLK_ADC>;
+      clock-names = "pclk", "adc";
+      power-domains = <&sysctrl>;
+      adc1-avdd-supply = <&adc1_avdd>;
+      adc1-vref-supply = <&adc1_vref>;
+      #io-channel-cells = <1>;
+    };
+...
-- 
2.51.0


