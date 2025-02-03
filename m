Return-Path: <linux-iio+bounces-14935-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6A3A25FEF
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 17:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789C23AADB8
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 16:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC14F20AF8F;
	Mon,  3 Feb 2025 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bic8CwZd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BD420ADF1;
	Mon,  3 Feb 2025 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738600070; cv=none; b=QCfwO6pzGif+fvbRPvX1+jWnX1LtOcal1f6IMK0cGjUKFjll9T+UOie+w4KKZpvRD14dSOX+GC9nGzpcMjyLIGeMfdqgKOyibCHQS5gPTyOrqSrLiZQylF0T90zMCBwLPesb+S+/+n9LyWzcz+Sr5amK9Mesw35a00ccGqZlJC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738600070; c=relaxed/simple;
	bh=hh8ljTGGcNCDtm/Ly7NCy34l8GzC+LqKQozyf6EJ+hU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=skz/8dBy1NUlWKpmMb/ARl48aOLwcKBr2nyWa3kEsJgGJksDre/FS8u+hHNMAyrvdiFwy/k9ZOhcTSU/2lX52aVdMli/H1GPl9Ai3iFWpyBkwIOKdU1lCEoLVNnrwcEjyAweCBSunrN1rNBDe6TLEs709OjGLvLUxX0RPUFx158=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bic8CwZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 800D5C4CEE3;
	Mon,  3 Feb 2025 16:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738600070;
	bh=hh8ljTGGcNCDtm/Ly7NCy34l8GzC+LqKQozyf6EJ+hU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bic8CwZd94/kHTG6cAwczuV/FlnC05Gh3VJFC2dkO6FkgkkWQjwRcqZ7YnelQ7IAp
	 Zvis6cbYKOrAgqurSoHfxlDeLP6//erdoNmD5juC3o8Ox17t5QVY9nEqTMogAq1LkV
	 VPuFGPKTmaDLQ87JW0Lv5pdBNbTOIYJikCm6X5vsbLo8WxN5W5onxbM5HRnBe4uAgS
	 veClBZ606au+RCBkEtgJqn5oEAzqpvA3EjfPNmc3U3yRt85YYa/KY52LTgfZgl1/4S
	 x6iEduTEBlpfzoBlrmZvg0WWQvDbuwMKeURdkssbSGss4tLmHxL704G/bokRRkO5Fi
	 GLbG/lAm2NSdQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72792C02196;
	Mon,  3 Feb 2025 16:27:50 +0000 (UTC)
From: Tobias Sperling via B4 Relay <devnull+tobias.sperling.softing.com@kernel.org>
Date: Mon, 03 Feb 2025 17:27:34 +0100
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: Introduce ADS7138
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-adc_ml-v2-1-8a597660c395@softing.com>
References: <20250203-adc_ml-v2-0-8a597660c395@softing.com>
In-Reply-To: <20250203-adc_ml-v2-0-8a597660c395@softing.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738600069; l=2570;
 i=tobias.sperling@softing.com; s=20241122; h=from:subject:message-id;
 bh=OmyOmU49Tz1XrsAj9x+7MhVBICvzllgrTbFg4A067Vw=;
 b=MDHxEkxPXoj9vT/XalU8a15PJKhH0+FjFtE6rkAtkTEV7IDoTBPKqLPSG4fUq/MlhTHRTiGVc
 0/YafsLXPxhCWmXMmLMU+Z31nOPnScK5EAA9qoOXoaB4Jer0gJEQ1qg
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
 .../devicetree/bindings/iio/adc/ti,ads7138.yaml    | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..c73057df6d8a56230a69978a7f673045f17a276b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml
@@ -0,0 +1,62 @@
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



