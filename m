Return-Path: <linux-iio+bounces-25095-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87389BDF0B6
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 16:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0AA480593
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 14:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6BA27FD54;
	Wed, 15 Oct 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I6smQ6fi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCF727F754
	for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760538608; cv=none; b=EU1Fw37uPYiYelbDbFastyxFXS+tPfvRp6Ucl94r6dmuzUZcdNA/7uxVoImfvhKFAtEw/+NVxZ7NtddV7dcUFWLfjxgH/lzlGl652f/PhvNiTIaORmZPOfI2NC/ODwk6/122luy4eqPWNUGVsr5MqfyAAo8mThti/UyK0VG+m6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760538608; c=relaxed/simple;
	bh=JF5d0RuqHdzuzAyczJrD8nFHVpQJnUZyIUIRam1+8Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmSmNnKpDo62sxPuw0hi4k8kyYfWxo0hF7nb8cyafzVwevrGFbh6GPwTmLrt/QbE4RKuBh3gIYNe4pyH1dnPoM6zV7hJ3vaZE3EOPWnG9Gb8Lt0FlO5bbcturQ/h0D0hmIu9utmuLpmvEks/DhBteyar4eVE8JmkZaHz5gWulwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I6smQ6fi; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8EB241A13D6;
	Wed, 15 Oct 2025 14:30:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5CD91606F9;
	Wed, 15 Oct 2025 14:30:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C55F9102F229E;
	Wed, 15 Oct 2025 16:29:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760538601; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=22T1dg1cbNfiO27ErLkrwh8WK9WMTDQ6TnjoQ7G7mW8=;
	b=I6smQ6fiRvw3h6Haj7ezxlNJWUUXuj20KrGzzFyZarvQRLsiF/+VGb0MIkOIPANjYK6k+3
	F6KAgHv4zAnLkVxEjdSfYweAsEdz5K5C553E38Dq7ysr4dM7oywkL4rKuEmBi73VWm6xcU
	7jfgzzZ/l+KyT5eQ71huXR6tom+M4Q7d0EnvW7qi4h90a7NcviSwKCpus6VTNbFFmIRsdI
	Usxw8duWPDXjlsEd9uYcHJQ+XTggzXQXv+908YAvhQYRMEp7FNS/2Q0+9ctUEh7HY2/yd8
	+SIVXWVHLM8MGQEzub7w4TFxCy7Vu9T3orUDJDS3nOv3A6fQa0Tfwr5GDg5FZQ==
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
Subject: [PATCH 1/4] dt-bindings: iio: adc: Add the Renesas RZ/N1 ADC
Date: Wed, 15 Oct 2025 16:28:13 +0200
Message-ID: <20251015142816.1274605-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015142816.1274605-1-herve.codina@bootlin.com>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
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
 .../bindings/iio/adc/renesas,rzn1-adc.yaml    | 120 ++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzn1-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzn1-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzn1-adc.yaml
new file mode 100644
index 000000000000..73a08eef28d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzn1-adc.yaml
@@ -0,0 +1,120 @@
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
+  can use up to two internal ACD cores (ADC1 and ADC2) those internal cores are
+  handled through ADC controller virtual channels.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a06g032-adc   # RZ/N1D
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
+      - const: adc-clk
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
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - power-domains
+  - '#io-channel-cells'
+
+dependencies:
+  # None or both adc1-avdd-supply / adc1-vref-supply should be present
+  adc1-avdd-supply: [ adc1-vref-supply ]
+  adc1-vref-supply: [ adc1-avdd-supply ]
+  # None or both adc2-avdd-supply / adc2-vref-supply should be present
+  adc2-avdd-supply: [ adc2-vref-supply ]
+  adc2-vref-supply: [ adc2-avdd-supply ]
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
+examples:
+  - |
+    #include <dt-bindings/clock/r9a06g032-sysctrl.h>
+
+    adc: adc@40065000 {
+      compatible = "renesas,r9a06g032-adc", "renesas,rzn1-adc";
+      reg = <0x40065000 0x200>;
+      clocks = <&sysctrl R9A06G032_HCLK_ADC>, <&sysctrl R9A06G032_CLK_ADC>;
+      clock-names = "pclk", "adc-clk";
+      power-domains = <&sysctrl>;
+      adc1-avdd-supply = <&adc1_avdd>;
+      adc1-vref-supply = <&adc1_vref>;
+      #io-channel-cells = <1>;
+    };
+...
-- 
2.51.0


