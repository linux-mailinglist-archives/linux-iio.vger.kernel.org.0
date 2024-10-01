Return-Path: <linux-iio+bounces-9950-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457BB98B604
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 09:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0808F282B6E
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 07:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B601BD513;
	Tue,  1 Oct 2024 07:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j+NHsodS"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D93E1BDAA8;
	Tue,  1 Oct 2024 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768790; cv=none; b=QGUdXHSE99EiuvlPYazC5ygk1JJgUixf/zHyFGYYZ9gCwVWXTq822Y5AHVb3SnIV50PjU0i8EqzavxLxpite5Y3gjnSn+YmF/BM3x8qXLB12peBuiJwZZjrQpFX4Yb1lykUbbTde09OPJjlpHPYrAqiqawETPrLqRmG9mfioSus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768790; c=relaxed/simple;
	bh=h5tPQi8XVwl6qbXiLI/d18hB5vGeurzdyIrzw6QGfzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0bUvWSXL6GukBJrH1bYpctCZ92qFJ8N0+WLH6hppwzSpdrloAKJwYXcgt2pFZRgLqx/B2nd6bB8SdU76ko1UAGiN/u9u+nE9FiIUczz3esb9w6qyZQixx+RS5dtoCC/V2SA55oDg/Jbp851gChfIpNvladsZOVp5u1Vao4UD44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j+NHsodS; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 066F560003;
	Tue,  1 Oct 2024 07:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727768786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlsJIhRsYGVxhsX2g9Hz3WTP9j580Ur99InpWpDuuTo=;
	b=j+NHsodSKZ/a72WBrRug9Qlt0rVETgAMBcHY3367MAp80zl3WsEsMEI+bLQhU8aKg8FTvK
	2SfhqWsTXLhG7D02zhmFZvmYCuFNX5CR2wiaH1eKVqidcss/R7AyH3UiC+fpoHlKB/4XlK
	DKCvV9XLvvCHy2RCYuyjhsmbr31qPCw499B9XPoluBOuQM8sra4ZLBHBHi7PlrYtznNwT3
	fuqa0O9l7wKNx9Esc0lAX3Hjz4D9COgssDyrouIQiN0mHhKMr8g77QVApbWFriSwn/W28Q
	QV5K4qcyaBnQF1QJttI5jdni4xlS3BELi5hNgEwjZbSCWWOfZIxHqjLb+ioXFg==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Ian Ray <ian.ray@gehealthcare.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 2/4] dt-bindings: iio: adc: Add the GE HealthCare PMC ADC
Date: Tue,  1 Oct 2024 09:46:16 +0200
Message-ID: <20241001074618.350785-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241001074618.350785-1-herve.codina@bootlin.com>
References: <20241001074618.350785-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The GE HealthCare PMC Analog to Digital Converter (ADC) is a 16-Channel
(voltage and current), 16-Bit ADC with an I2C Interface.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/iio/adc/gehc,pmc-adc.yaml        | 82 +++++++++++++++++++
 include/dt-bindings/iio/adc/gehc,pmc-adc.h    | 10 +++
 2 files changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/gehc,pmc-adc.yaml
 create mode 100644 include/dt-bindings/iio/adc/gehc,pmc-adc.h

diff --git a/Documentation/devicetree/bindings/iio/adc/gehc,pmc-adc.yaml b/Documentation/devicetree/bindings/iio/adc/gehc,pmc-adc.yaml
new file mode 100644
index 000000000000..6b2bb1309767
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/gehc,pmc-adc.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/gehc,pmc-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GE HealthCare PMC Analog to Digital Converter (ADC)
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+description:
+  The GE HealthCare PMC ADC is a 16-Channel (voltage and current), 16-Bit ADC
+  with an I2C Interface.
+
+properties:
+  compatible:
+    const: gehc,pmc-adc
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description:
+      Regulator for the VDD power supply.
+
+  vdda-supply:
+    description:
+      Regulator for the VDD analog (VDDA) power supply.
+
+  vddio-supply:
+    description:
+      Regulator for the VDD IO (VDDIO) power supply.
+
+  vref-supply:
+    description:
+      Regulator for the voltage reference power supply.
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: osc
+
+  "#io-channel-cells":
+    const: 2
+    description: |
+      The first cell is the channel type (dt-bindings/iio/adc/gehc,pmc-adc.h
+      defines these values):
+       - 0: voltage
+       - 1: current
+      The second cell is the channel number from 0 to 15.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vdda-supply
+  - vddio-supply
+  - vref-supply
+  - '#io-channel-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@14 {
+            compatible = "gehc,pmc-adc";
+            reg = <0x14>;
+            vdd-supply = <&reg_vdd>;
+            vdda-supply = <&reg_vdda>;
+            vddio-supply = <&reg_vddio>;
+            vref-supply = <&reg_vref>;
+            #io-channel-cells = <2>;
+        };
+    };
+...
diff --git a/include/dt-bindings/iio/adc/gehc,pmc-adc.h b/include/dt-bindings/iio/adc/gehc,pmc-adc.h
new file mode 100644
index 000000000000..2f291e3c76ae
--- /dev/null
+++ b/include/dt-bindings/iio/adc/gehc,pmc-adc.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+
+#ifndef _DT_BINDINGS_IIO_ADC_GEHC_PMC_ADC_H
+#define _DT_BINDINGS_IIO_ADC_GEHC_PMC_ADC_H
+
+/* ADC channel type */
+#define GEHC_PMC_ADC_VOLTAGE	0
+#define GEHC_PMC_ADC_CURRENT	1
+
+#endif
-- 
2.46.1


