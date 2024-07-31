Return-Path: <linux-iio+bounces-8091-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A99D942E5A
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 14:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE499B24F96
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 12:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07DD1B141B;
	Wed, 31 Jul 2024 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fPzfAHUN"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5800318E03E;
	Wed, 31 Jul 2024 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428665; cv=none; b=GhS/xYAQLBxlfJ3nn1A2oGXS7zBdAb6QPKC28jMdP+UflMMOgliQUMHjQ2WjXigbmnGsUdmAiERmNisvwRFbVuFt1yfYQXQKhYk0UK6wu1UnpRjhQP/RYM5rzFP44RrHYfFmw75DwE1t++kL3xhzuRRxQ5FRW3AyApjVJcydoIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428665; c=relaxed/simple;
	bh=Z+N10bCG7+YiKm7h6EUMdXG5BJ+tQXs4o8Z5DSg8AaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HiHhOmSW3BOGSuiDNJMrkERMp+unKJsvcDLs//ZsMA8zGdaF/28STfxd5+GMS7IkbeMB0BhfQ1RMEsHiRVrJ8PoQeZJwk+HvQ2sGz7D99VPAH/cawK0eO3c9D+UVHV5bjP/9bsuFLWjJ00lPqfrOaImN1pnVOygrwkkf9ywCGYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fPzfAHUN; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B4ABFF805;
	Wed, 31 Jul 2024 12:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722428660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WX/Hj4Pt/yRxr0nGT2LrpjQSv1HGzsNeBfY67q/Rvu4=;
	b=fPzfAHUNbUy5m7YrD5YmT3tsa0XZG7WXll2mNXIdKBTb4Pe7aXyJxUoaO0xJT30g8pjn4N
	FI4pe8Uo8eaEK3DPf47eHRGN8xtv7R9ePhekWPKX874lffXvyRIoc8VUYYLEKdckFPLY51
	o5cg77Ha4B/jb3LEk5bp8g9lMCKQdbu/V/17jlP3BqC+f0FVZYqXgLvxMzcZeJNNy14apW
	J30aG3/JGSxY61dXkE4h8iboNSH4c3wTUYjsaaRplNklDdB5DGIXRufybZh7zUb2OCtC5h
	gjZc90KOthvlqIvg6JhH+LxOAIPbqakAOelbfa6MIHBJLEFctbmYYXExVmmvYA==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Wed, 31 Jul 2024 14:24:14 +0200
Subject: [PATCH v3 1/3] dt-bindings: iio: adc: sophgo,cv18xx-saradc.yaml:
 Add Sophgo SARADC binding documentation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-sg2002-adc-v3-1-5ac40a518c0a@bootlin.com>
References: <20240731-sg2002-adc-v3-0-5ac40a518c0a@bootlin.com>
In-Reply-To: <20240731-sg2002-adc-v3-0-5ac40a518c0a@bootlin.com>
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
X-Mailer: b4 0.14.1
X-GND-Sasl: thomas.bonnefille@bootlin.com

The Sophgo SARADC is a Successive Approximation ADC that can be found in
the Sophgo SoC.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
new file mode 100644
index 000000000000..79d8cb52279f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/sophgo,cv18xx-saradc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:
+  Sophgo CV18XX SoC series 3 channels Successive Approximation Analog to
+  Digital Converters
+
+maintainers:
+  - Thomas Bonnefille <thomas.bonnefille@bootlin.com>
+
+description:
+  Datasheet at https://github.com/sophgo/sophgo-doc/releases
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: sophgo,cv1800b-saradc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - clocks
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sophgo,cv1800.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    adc@30f0000 {
+        compatible = "sophgo,cv1800b-saradc";
+        clocks = <&clk CLK_SARADC>;
+        interrupts = <100 IRQ_TYPE_LEVEL_HIGH>;
+        reg = <0x030F0000 0x1000>;
+    };

-- 
2.45.2


