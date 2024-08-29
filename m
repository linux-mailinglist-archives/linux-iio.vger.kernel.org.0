Return-Path: <linux-iio+bounces-8865-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB3396447D
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 14:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9A61F26322
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 12:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF821A38F0;
	Thu, 29 Aug 2024 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SrO1Qxtj"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EB81922F6;
	Thu, 29 Aug 2024 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934729; cv=none; b=HdAyxsGdXDpjH+DclQ5+5KibgbbLBetAXU9pnHOlxI2vrDtqsIcfCabmwgGx97g0UkY50Ss/V+DYXxLiYLgCsSVjOzMQrgOokZdOc4PPWRXxWRZLOUHVOUud433/tPLBFlNc3HdGB1L92jOli16Qs1qlUvle9uzbN16VUxQww5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934729; c=relaxed/simple;
	bh=ot7vWnfTHIwWSPkq6vfo7jJGSBoumbQ0PKw6f1XG92c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jIZ1vEZ4GU9r+gkKDor71fsAbVZbdQbkhYOSc6h8e0ENWJ5u6OP+co4eSy4g6yJsbACIQoUEXZkBYLO50h4nmiVWFyi2juTBmEmH8JrJDrWGXmsE9yG2HHiRSvOaqlsdze3IvPGG5cyRIGnYwByopvb10hio2gzUjRtP48qPlXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SrO1Qxtj; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 067A11C000B;
	Thu, 29 Aug 2024 12:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724934724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZFMETiTqp68bZQf/Uc678bUmyXC3+gumwmJpkb2eIU=;
	b=SrO1QxtjtfBWoeT+ncaKYKkh8QcRaLPYH50TYcLxfrqwBDbn4qX0LE6AM+bDcwR2Nln5sT
	naVx7vsPDjBCLwjIbPgIAAbMuxCGWU7e5xmsYG+H1zgFMNA6SJAnmRexAONAIJ2fG20z0H
	JKsGtk58Vm21cvw9LLxj+17umVVSmWez3ThiRIzhROOIUlLXjGKY4gwbA+SrVSgsNbHSp0
	CY8ZBV12MjpbPETuNrC/6Ya3Yp4v2NrED24DSAyke3N1Uv8X9cpydYy42Xs81dr9P7ZEiQ
	2753iAOk4bjqdLnplRAtzBsDdfABVj8fKv1CDWI9MIDTQqkIsQDUsttFBeoVVQ==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Thu, 29 Aug 2024 14:31:50 +0200
Subject: [PATCH v5 1/3] dt-bindings: iio: adc: sophgo,cv1800b-saradc: Add
 Sophgo CV1800B SARADC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-sg2002-adc-v5-1-aacb381e869b@bootlin.com>
References: <20240829-sg2002-adc-v5-0-aacb381e869b@bootlin.com>
In-Reply-To: <20240829-sg2002-adc-v5-0-aacb381e869b@bootlin.com>
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

The Sophgo CV1800B SARADC is a Successive Approximation ADC that can be
found in the Sophgo CV1800B SoC.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 .../bindings/iio/adc/sophgo,cv1800b-saradc.yaml    | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/sophgo,cv1800b-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/sophgo,cv1800b-saradc.yaml
new file mode 100644
index 000000000000..f652b98615f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/sophgo,cv1800b-saradc.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/sophgo,cv1800b-saradc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:
+  Sophgo CV1800B SoC 3 channels Successive Approximation Analog to
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
+  "^channel@[0-2]$":
+    $ref: adc.yaml
+
+    properties:
+      reg:
+        items:
+          - minimum: 0
+            maximum: 2
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
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
+
+        channel@1 {
+            reg = <1>;
+        };
+
+        channel@2 {
+            reg = <2>;
+        };
+    };

-- 
2.46.0


