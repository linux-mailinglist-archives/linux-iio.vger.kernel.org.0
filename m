Return-Path: <linux-iio+bounces-10028-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDF698EE6A
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 13:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C681F24176
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 11:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD4C175D35;
	Thu,  3 Oct 2024 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i/gO/LMc"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBF0156F2B;
	Thu,  3 Oct 2024 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956012; cv=none; b=WJQNfPeKpkODl4+WFlwCTUXtDnzXEDHkYnONzXFhQFmxFVmIGSIdqJwPd+PJuJPiNnjeEOOGdKC1jvwG0C8oy9Am9fgY+Eab24xbSIhFIMDP3SEle9zzeC38AdCZkuVughGgJWvXDS3M1Texd48Bz0KNyW8F/++p+VPHsiXNQOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956012; c=relaxed/simple;
	bh=h3LS5n4pvalkUgi1BZ4Ks4B4Rb5GjW863XbmDr2s9V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiP1AXxWGxuZKQnrgjtWlaa1rGpvzrif/D++C6MxnddhtAS/469szdimmAPeb+h7CgO6B0zAJfWuGCYKNBzb7DxtoJiRp5+TlSgENXZQVCaIuo2cc+/pC9sD6vz+NIvNC2AGBO7Fk2ZATVRs0Xj6ccNu//AkmikSth4pkF1RruE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i/gO/LMc; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 88D4FC0003;
	Thu,  3 Oct 2024 11:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727956008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lkiSM+vn4ME69DaeEjqEky/BkDXAljK/2OzQ+ielh14=;
	b=i/gO/LMcwQzsPoVF/XnjYIOEIIJpoe7HMfZ7fVy0+MyGdWsuSPFG3lRvbb6smIyquig823
	uZIzx756GdFKMcHWfGlpeMYl/bJHDAwhtg6jUvnMMWz/NrVJTDwCCBVkAdTk3YNmg04fb5
	YWkpiMVytU5emAiWHM+eZ3atjYXuP0OOWDc6ggjdMslvbXvW8uNcYwcR8m6fIr+rfILtNA
	AZiRhYmV736nDPQgHoEfglzLzjVdVrdLSEwmKmHB9YnR0PwehrnzHa7w60TOtDb+m5gFH8
	KicKAcutK9X+XE4rLNvcq4wgNNqPjJj0hN8NbdD7gXP/lFAQkE/VSqz1aSeZUw==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	David Lechner <dlechner@baylibre.com>,
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
Subject: [PATCH v2 2/4] dt-bindings: iio: adc: Add the GE HealthCare PMC ADC
Date: Thu,  3 Oct 2024 13:46:39 +0200
Message-ID: <20241003114641.672086-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241003114641.672086-1-herve.codina@bootlin.com>
References: <20241003114641.672086-1-herve.codina@bootlin.com>
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
 .../bindings/iio/adc/gehc,pmc-adc.yaml        | 86 +++++++++++++++++++
 include/dt-bindings/iio/adc/gehc,pmc-adc.h    | 10 +++
 2 files changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/gehc,pmc-adc.yaml
 create mode 100644 include/dt-bindings/iio/adc/gehc,pmc-adc.h

diff --git a/Documentation/devicetree/bindings/iio/adc/gehc,pmc-adc.yaml b/Documentation/devicetree/bindings/iio/adc/gehc,pmc-adc.yaml
new file mode 100644
index 000000000000..2cea7c104a26
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/gehc,pmc-adc.yaml
@@ -0,0 +1,86 @@
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
+    description:
+      The component uses an external oscillator (osc) if an external oscillator
+      is connected to its clock pins. Otherwise, it uses an internal reference
+      clock.
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


