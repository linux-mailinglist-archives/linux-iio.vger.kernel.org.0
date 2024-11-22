Return-Path: <linux-iio+bounces-12495-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A4C9D6136
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 16:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEBDC1F21163
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 15:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510EE1DE3C9;
	Fri, 22 Nov 2024 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSWWQ1ZJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17D382485;
	Fri, 22 Nov 2024 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288554; cv=none; b=UkOqJE+m45dh/QQIFsN567xhP95omx7YuyMTbyP8+Og4mFS0uCbIbwyU/tpU5ca6VwAg9NzXGPx2uJSai1nLqDVEJo/GWSqeIM+dI3vpDdig/jz6qlvcMRYLFFHac5rW/gBEIQbGDTfJP5/SDxmBXxhmaclLbApeUhyfqNCMyLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288554; c=relaxed/simple;
	bh=UveoLu+MVgy0L/e51kd2g+qswuZGscDbU+A9shb5ABE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fYATPtWM1JS7gZNNlm4tdQvXtOFytD2oqx66d/n8dcikW77F1NHELIBm8/HLX0mXSsMOi6y51Lb6kzvh3xWTb81ypmNF8NRSqsIi/36ov66Ttjoh6g2wU13Qb/b5JagLSguNGi3AQWDx9a38zUWElUSzw8s9nd/ZssC901tEmZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSWWQ1ZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A32C9C4CECF;
	Fri, 22 Nov 2024 15:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732288553;
	bh=UveoLu+MVgy0L/e51kd2g+qswuZGscDbU+A9shb5ABE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oSWWQ1ZJgXWpYzlp1ThUN0D1Db+wsnixLe3EHRU7HrLt2F1Tw3bYZ0BdCJL4coMqB
	 j02Kjh9t3ft5g7jzOYaD6lIho8cpvnwLIyBgypx+gBL8M2zgIMqfwQCxetClwTPKNH
	 caEMkbxK3NQjPGEj8CaR0WiEcyqS0eyNjaq7DyWpDGj6lZ/tgZxAtw/bTnYDrEAJX4
	 n9/gJbCJNli38Co9tRyx5WFVE4TwoRfjm3K9yJpM7m2gQKggsygu8D7AH/G4+250sT
	 HtkpRtRw+MydhTDkJShIzAIHdaCeHE5y36Zum713t+0VvTUgFIJsOft/Ut6hnsPJWA
	 hDVR4SCfUye2A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B905E6916D;
	Fri, 22 Nov 2024 15:15:53 +0000 (UTC)
From: Tobias Sperling via B4 Relay <devnull+tobias.sperling.softing.com@kernel.org>
Date: Fri, 22 Nov 2024 16:15:36 +0100
Subject: [PATCH 1/2] dt-bindings: iio: adc: Introduce ADS7138
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-adc_ml-v1-1-0769f2e1bbc1@softing.com>
References: <20241122-adc_ml-v1-0-0769f2e1bbc1@softing.com>
In-Reply-To: <20241122-adc_ml-v1-0-0769f2e1bbc1@softing.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tobias Sperling <tobias.sperling@softing.com>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732288552; l=2433;
 i=tobias.sperling@softing.com; s=20241122; h=from:subject:message-id;
 bh=9d8aVlgWhVD1SxeGx4yTwCiMmWFogLkRVK10LWzeXP4=;
 b=sejze5g6OSqq5crKP8kbpCldeVk215mFI8F8WS5mjEKu7bkbsLrUofjzKbb1xQSC2a6BDqGjs
 wkUUQKOLB2KDzPrbiy6TF+xMQ6DIGVRKOOP8i/7swfIqcj6sgDW9cMX
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

Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
---
 .../devicetree/bindings/iio/adc/ti,ads7138.yaml    | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..367d3b27cec3bc5800aac42c8a07497da7de4c1b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml
@@ -0,0 +1,64 @@
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
+  root-mean-square (RMS) and a zero-crossing-detect (ZCD) module, which are
+  not yet supported by the driver.
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



