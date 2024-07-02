Return-Path: <linux-iio+bounces-7125-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 613EE923CE4
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 13:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23774285DF6
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 11:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A58015B98E;
	Tue,  2 Jul 2024 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h7w8X7Ym"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8903412FB02;
	Tue,  2 Jul 2024 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921199; cv=none; b=K3TghGLl3yuxaLsEci/O6lOo0tQNOuEr/ZIrJaIDwsWOLzWJ3xTQkH0jfUDuIWwwu3oIr09jOr6jk8LQNSyEj2c+QJNLlabnXzg9ViIwHWzZr6mim8zYakmj9erF6nTHditoeKlJ5hLwG/iQqhfTKCGxiAyfza4lINjsWrrFuXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921199; c=relaxed/simple;
	bh=xFU1ZTWWDXMnh1IPgPeerJ9PIRESjK9ivSjm0yRjZ6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IMNCsSphTs33x8jyp+RKn7DvguueZUit4mad0obUOQyHiU4uiJeY2I1pduBupISdpEcMdznyZZ45NcgPp7wZVhJTn2k0T77pH9BRrg4T861x2vvJvwowRzR1+6aWD57vcJ0FDu+3g2UBVTU8su+pP2tf3ca3C+3HtX6ostIe34c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h7w8X7Ym; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 084991BF213;
	Tue,  2 Jul 2024 11:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719921194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gqC7auAvQgW9A/VK3641+r1UdxlnIIFJMqdNw3IN0E8=;
	b=h7w8X7Ymc/zvg+nQGNtcHw99Z+LNVB4kkkykGYu1pNVAwfUAOJGqYPwIX4EO1l/UW7qfV6
	MsR/SRV06v6diweqPiAPi5hIw80hC40El59u52AB5lOR/YEg1mEaxK4ffe/JmICNilGJnG
	/C9D9LyAlJxmkw876Ltaz01I3TTz6bwwXwD17cHpDemzFCQzyHyFwWFMNo8D5e/1jV/tn8
	eO2cFGHP8fvaLTXOkzcI+RyJ/VezVBx0NCdmuKNZAY6BSy7vCsbHW2lf0t/hiFdMDTvq8o
	/WEaSmPHk7X0y1WCly5PwlRLR/MGfutj2Yn80KmC5Sr+a1ONVdmFV3vY3GR/RQ==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Tue, 02 Jul 2024 13:52:21 +0200
Subject: [PATCH 1/3] dt-bindings: iio: adc: sophgo,cv18xx-saradc.yaml: Add
 Sophgo SARADC binding documentation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-sg2002-adc-v1-1-ac66e076a756@bootlin.com>
References: <20240702-sg2002-adc-v1-0-ac66e076a756@bootlin.com>
In-Reply-To: <20240702-sg2002-adc-v1-0-ac66e076a756@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
 Inochi Amaoto <inochiama@outlook.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: thomas.bonnefille@bootlin.com

The Sophgo SARADC is a Successive Approximation ADC that can be found in
the Sophgo SoC.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     | 51 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 +++
 2 files changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
new file mode 100644
index 000000000000..21fd5dc8e24e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/sophgo,cv18xx-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo 3 channels Successive Approximation Analog to Digital Converters
+
+maintainers:
+  - Thomas Bonnefille <thomas.bonnefille@bootlin.com>
+
+description:
+  Datasheet at https://github.com/sophgo/sophgo-doc/releases
+
+properties:
+  compatible:
+    const: sophgo,cv18xx-saradc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description:
+      SARADC will use the presence of this clock to determine if the controller
+      needs to be explicitly clocked by it (Active domain) or if it is part of
+      the No-Die Domain, along with the RTC, which does not require explicit
+      clocking.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    # ADC in the Active domain
+    adc@30f0000 {
+      compatible = "sophgo,cv18xx-saradc";
+      clocks = <&clk CLK_SARADC>;
+      interrupts = <100 IRQ_TYPE_LEVEL_HIGH>;
+      reg = <0x030F0000 0x1000>;
+    };
+  - |
+    # ADC in the No-Die domain
+    adc@502c000 {
+      compatible = "sophgo,cv18xx-saradc";
+      reg = <0x0502C000 0x1000>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index aacccb376c28..dc87898c518c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20901,6 +20901,11 @@ S:	Maintained
 N:	sophgo
 K:	sophgo
 
+SOPHGO SARADC DEVICE DRIVER
+M:	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
+
 SOUND
 M:	Jaroslav Kysela <perex@perex.cz>
 M:	Takashi Iwai <tiwai@suse.com>

-- 
2.45.2


