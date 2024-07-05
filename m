Return-Path: <linux-iio+bounces-7361-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A669289FC
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 15:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2661C24206
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 13:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E77155392;
	Fri,  5 Jul 2024 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cYemTJtw"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22556154458;
	Fri,  5 Jul 2024 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186956; cv=none; b=SY85Y8kej/KPvqLDrUZWHUIHII2yn5V608EwKHVW95yj2SaGp3B1rHrYNHBZr+ckYxOW4v1GBMt2TJgSYWOgJcysq3V7ie6S6/G51+P/4t2Dq04V9hrEgvmcJ2f+lHOg6nCCVgLmZnRUed690nB0EsogEK8W13Sre58rnBUnYAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186956; c=relaxed/simple;
	bh=eV1nr9EcWp01rio9fuJXhva/jBt+bqRu5Lz/dqYDjNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SJhMDHPmiFEotSGlC8MxYzigWYhgXjDxRI/sK5zBw4tUewy2F7ZsT5QuCj44asGznsaI6sSJZztiF8IxKe3fnfEiC+4F18YFZ37B+Yvx+d8DojTV7sqpBwiq+catq6P5TcT1q+mGa3k7MMtBcardnkfXP1GZVPWfHl3V4TcWDBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cYemTJtw; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A367B240006;
	Fri,  5 Jul 2024 13:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720186952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ODottIJUZD5cbwACBdwt28E6WF2p4dCijXNFos9RZ6s=;
	b=cYemTJtwaBgKyuYuDe1/QjDtG1Xo55/jjihYG4oMnzU7p8Mwhxtne1hv/DjMfm5ZLSBTje
	88rEkrCGXP8BSL+LUW+LNWD8QQOW2nRDVeTBgjUcLAAL5W3Uf9qYg+YjVVjSH0lq4MEiUp
	dGOTKE6RXafz+nffLqgaEBcn/K6COSCANd8QYfO2G4oJQZLmbNHt+Z+j4I/aW1LVH12nCo
	A/imJDvpA+FHYRL6tg0AEtHFnbjByAm08Lzc9nJv8uUd31AALMAjT+2A1lRm5IeKlzgGzs
	HHUKMzlWnfTzYBenKKloR3a0gFYH4M4/BSOMMz0AeOpICaUwn8/p39HyNOOGwA==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Fri, 05 Jul 2024 15:42:23 +0200
Subject: [PATCH v2 1/3] dt-bindings: iio: adc: sophgo,cv18xx-saradc.yaml:
 Add Sophgo SARADC binding documentation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-sg2002-adc-v2-1-83428c20a9b2@bootlin.com>
References: <20240705-sg2002-adc-v2-0-83428c20a9b2@bootlin.com>
In-Reply-To: <20240705-sg2002-adc-v2-0-83428c20a9b2@bootlin.com>
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
 .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
new file mode 100644
index 000000000000..31bd8ac6dfa5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
@@ -0,0 +1,63 @@
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
+          - enum:
+              - sophgo,cv1800b-saradc
+          - const: sophgo,cv18xx-saradc
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
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sophgo,cv1800.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    /* ADC in the Active domain */
+    adc@30f0000 {
+        compatible = "sophgo,cv1800b-saradc", "sophgo,cv18xx-saradc";
+        clocks = <&clk CLK_SARADC>;
+        interrupts = <100 IRQ_TYPE_LEVEL_HIGH>;
+        reg = <0x030F0000 0x1000>;
+    };
+  - |
+    #include <dt-bindings/clock/sophgo,cv1800.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    /* ADC in the No-Die domain */
+    adc@502c000 {
+        compatible = "sophgo,cv1800b-saradc", "sophgo,cv18xx-saradc";
+        reg = <0x0502C000 0x1000>;
+    };

-- 
2.45.2


