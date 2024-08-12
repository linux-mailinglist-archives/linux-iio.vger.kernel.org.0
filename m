Return-Path: <linux-iio+bounces-8421-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AD694F117
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 17:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52371F2298D
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 15:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3684317F4FE;
	Mon, 12 Aug 2024 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vyq++eeH"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50636136338;
	Mon, 12 Aug 2024 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474872; cv=none; b=cf6SKw0CRx6gTUQ0jYb51xC+Bkg3UK4q82WeZfsVHaGJC/yorOX76V+cEgoSFpapSWrBtClt5Md81HcjpmyRFJHj+Khqmw4Z+lJI1PqAQ+IS0thm4ovR77U2akIO8kNtwcOS6GweAggMW1boQAZTxhCCV0Z4t6KPHAa1pN5736c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474872; c=relaxed/simple;
	bh=ccHNdpaiwHDcsnmiP7d1ByZKherUHj2US15sDIeERIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VbIAybDncMSNAzpnC36lUSMYH0/X1vaVmHiDTFxug+MgBLw/L/SnXN/05VjeJHVxogc0NZ6mcf7xmKFMPeHRsnROWoeP+vfHrxrN9kF3TsP4VCKqVPTLFKCdS7w7BVzmHyMcQs8ypsjBeoJ2gG2Qhb0prGiu09QGRRv+vo7zlgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vyq++eeH; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DA2AAFF805;
	Mon, 12 Aug 2024 15:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723474867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ABArNOKCL6dmgKSQJ2r1D6tE7nlhSkwhi7zy54L8RZI=;
	b=Vyq++eeHe730h/JM9G8nzdge0nnhbrCqHl4CrV+1FM3mCsUVmDP1w9nPM8ruKnzoN2wha9
	YbWuWLAKtAjfAntXX4MPtnN+zKksCClIF5AC3bD4HIutks+PmXyTfyw4VtEys4pu9ntIg9
	kuctfrCgq6Wy7peQMg3d18ZdrobDxNoesdrlIoZveA8D7Du+CG9WrOzNVMrXNCFF5mFwMX
	tdoXoPJMuFia0UWtJOr1EHyefAFQ+sTK5obn9tTqn7KWtgTcqkAUukPhc9DImakPrEQWbL
	CtefTNJ20izh2w5p0RL1RDZHUzcNUsG04M3KJrQWvTQNTwJsz+gXct5ICIoCng==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Mon, 12 Aug 2024 17:00:55 +0200
Subject: [PATCH v4 1/3] dt-bindings: iio: adc: sophgo,cv18xx-saradc.yaml:
 Add Sophgo CV18XX SARADC binding
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240812-sg2002-adc-v4-1-599bdb67592f@bootlin.com>
References: <20240812-sg2002-adc-v4-0-599bdb67592f@bootlin.com>
In-Reply-To: <20240812-sg2002-adc-v4-0-599bdb67592f@bootlin.com>
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
 .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     | 85 ++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
new file mode 100644
index 000000000000..846590808e5f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
@@ -0,0 +1,85 @@
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
+    const: sophgo,cv1800b-saradc
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
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^channel@[0-3]+$":
+    $ref: adc.yaml
+
+    description: |
+      Represents the channels of the ADC.
+
+    properties:
+      reg:
+        description: |
+          The channel number. It can have up to 3 channels numbered from 0 to 2.
+        items:
+          - minimum: 0
+            maximum: 2
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sophgo,cv1800.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    adc@30f0000 {
+        compatible = "sophgo,cv1800b-saradc";
+        reg = <0x030f0000 0x1000>;
+        clocks = <&clk CLK_SARADC>;
+        interrupts = <100 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        channel@0 {
+            reg = <0>;
+        };
+        channel@1 {
+            reg = <1>;
+        };
+        channel@2 {
+            reg = <2>;
+        };
+    };

-- 
2.46.0


