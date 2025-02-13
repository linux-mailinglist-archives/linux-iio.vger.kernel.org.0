Return-Path: <linux-iio+bounces-15492-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E21A348B6
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 16:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318F71886AB0
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 15:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028461D61AA;
	Thu, 13 Feb 2025 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpXRVU/7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9BA18784A;
	Thu, 13 Feb 2025 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462354; cv=none; b=qV1vNwsO8Mpy6X6CBLKwVtc71++qyoMW+SstGIndrLCLnR4QDGJin+qHaDVs9lEai+J7yWksGpLpkE6W9wLyAJxOsR9Bqo3bKbweFerfO9sLPjoDcc5xEDM5Zy8NStXJV35XEoIGwPiHOGDvQ4wYr96ptRz7XPdyniFY/2YHSA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462354; c=relaxed/simple;
	bh=zlBG9qYGUjR/lSZUlalEBvZ9XCoFpAXqvSmJkhuISIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hjt22irvqvRSLP1mfTRQN15yWFDJtTZW0FBU/Z4mZjKzMQXdcWcYmZ5nKLtBObf3PCvPlwIoNFFcoTaidLTT7KAmhivxwZRPuec5mu7RbtYalKw/6kVxJQdWZiEJT4MhDk3MUPzoS0LsL4UHBWrexIbjluyFytsZg09EsZwZEQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpXRVU/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D475C4CEE5;
	Thu, 13 Feb 2025 15:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739462354;
	bh=zlBG9qYGUjR/lSZUlalEBvZ9XCoFpAXqvSmJkhuISIU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lpXRVU/7l9NBtnzrZdjBTkJBOIPKHQ+iLLqQMI8PQZJvasEJUyZL8hDN/R8sLP6C8
	 V7hxZAlU4POG63Hh0FLtAx0k3AK1nMFOd01PHCnc+G5i1CWwU2hRzBPru2jJJf+yNz
	 glepQvj5PTWCm2NaXvs0h2Xf1BCgt/O+18ujfEV7waZ24xRwUM4P6t095J8nNGnA8d
	 WO9OzQRtPjwq3Nh6241C14NU7QFKfOePEAqsUVhtYlkSDUmKDAc7olTdkKy680Yt7Y
	 0GrlwJjKrhhtuI35KQZSigKk6xIDYQK8T2Nh/x+11i2i5LkCethCQOqPdVsAKjgN1z
	 jxO4EE3nHIpKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB2BC021A6;
	Thu, 13 Feb 2025 15:59:14 +0000 (UTC)
From: Tobias Sperling via B4 Relay <devnull+tobias.sperling.softing.com@kernel.org>
Date: Thu, 13 Feb 2025 16:58:57 +0100
Subject: [PATCH v4 1/2] dt-bindings: iio: adc: Introduce ADS7138
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-adc_ml-v4-1-66b68f8fdb8c@softing.com>
References: <20250213-adc_ml-v4-0-66b68f8fdb8c@softing.com>
In-Reply-To: <20250213-adc_ml-v4-0-66b68f8fdb8c@softing.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Tobias Sperling <tobias.sperling@softing.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739462353; l=2588;
 i=tobias.sperling@softing.com; s=20241122; h=from:subject:message-id;
 bh=g1zfSLm9Map0BpGfvjWMEymgbGpQOBRGtMWcObulW84=;
 b=vyNYPdaJbiGBAQlZe7ygvRLI3eogMUOgxpf1tA7WFMcMbTbkRCi6pTNyQ2RmeSY+naMtqR36l
 CxvEvJFhWMECRFm5KR6mydLdPk2WDuq8psnuFpmYPQ29hAsZsa8XnGC
X-Developer-Key: i=tobias.sperling@softing.com; a=ed25519;
 pk=v7hgaMHsrA9ul4UXkBVUuwusS9PF3uHW/CC+gABI65E=
X-Endpoint-Received: by B4 Relay for tobias.sperling@softing.com/20241122
 with auth_id=281
X-Original-From: Tobias Sperling <tobias.sperling@softing.com>
Reply-To: tobias.sperling@softing.com

From: Tobias Sperling <tobias.sperling@softing.com>

Add documentation for the driver of ADS7128 and ADS7138 12-bit, 8-channel
analog-to-digital converters. These ADCs have a wide operating range and
a wide feature set. Communication is based on the I2C interface.
ADS7128 differs in the addition of further hardware features, like a
root-mean-square (RMS) and a zero-crossing-detect (ZCD) module.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
---
 .../devicetree/bindings/iio/adc/ti,ads7138.yaml    | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..a51893e207d4047fe915e87c4be9caa732c45465
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads7138.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADS7128/ADS7138 analog-to-digital converter (ADC)
+
+maintainers:
+  - Tobias Sperling <tobias.sperling@softing.com>
+
+description: |
+  The ADS7128 and ADS7138 chips are 12-bit, 8 channel analog-to-digital
+  converters (ADC) with build-in digital window comparator (DWC), using the
+  I2C interface.
+  ADS7128 differs in the addition of further hardware features, like a
+  root-mean-square (RMS) and a zero-crossing-detect (ZCD) module.
+
+  Datasheets:
+    https://www.ti.com/product/ADS7128
+    https://www.ti.com/product/ADS7138
+
+properties:
+  compatible:
+    enum:
+      - ti,ads7128
+      - ti,ads7138
+
+  reg:
+    maxItems: 1
+
+  avdd-supply:
+    description:
+      The regulator used as analog supply voltage as well as reference voltage.
+
+  interrupts:
+    description:
+      Interrupt on ALERT pin, triggers on low level.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@10 {
+            compatible = "ti,ads7138";
+            reg = <0x10>;
+            avdd-supply = <&reg_stb_3v3>;
+            interrupt-parent = <&gpio2>;
+            interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
+...

-- 
2.34.1



