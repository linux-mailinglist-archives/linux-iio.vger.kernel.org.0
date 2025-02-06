Return-Path: <linux-iio+bounces-15075-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546A9A2ACDA
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 16:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E977161F8D
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 15:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DB522F391;
	Thu,  6 Feb 2025 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c72r3VMK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46891E5B80;
	Thu,  6 Feb 2025 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738856555; cv=none; b=mKyY3ul0wNUhny9ibkd3cil5fW4B67P6PPn+EUJ0UUGjZZ/Qo/a0i974xVYmkaegmhstIZ1PnRgtWqLEbKLu70RoUd60F60+TgvYXL5v49oUonTdrAoh/qcCGrgKX0ZrbLkUQ7mHcW4We4PsjNfEEe4YW5WNsYSTjh1vqA5+Oak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738856555; c=relaxed/simple;
	bh=hh8ljTGGcNCDtm/Ly7NCy34l8GzC+LqKQozyf6EJ+hU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=INj472j/S8DM5dbsKTTa21PTB5Zh4arnBMnf7n1vP0tYzDZvjG9jgbJa7eqyS7NKzr0Phm0TEeoChCjDmWJw1meP7Yf8TZaPrSz4gAKmEM6fDhsOM0I58v4YW49PM02WiqqGwyX+Flw/932SMeRJ8EmhQ7Zz3ZmPCZFBZbTNIjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c72r3VMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29BB8C4CEDF;
	Thu,  6 Feb 2025 15:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738856555;
	bh=hh8ljTGGcNCDtm/Ly7NCy34l8GzC+LqKQozyf6EJ+hU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=c72r3VMKS0AfgfIRqnV39abeI3FSYCkG/18eDPHiKHsHu/KbzUei/kycRc75qN2yI
	 P9Y8fksVs57blmq8WV9zwtDtaqRCD+SkZslUCEn4wSpwhhJKqxzHeSkcKkRChSLp0T
	 fLTUbyoEnxMUM1AlerNA0E3b0ndyug9OSSBF+a7eRdA23wLd+qqOoJVKbWGR0K6Jqj
	 JfQfN4XouxfIEnnr5JUVUruJy3L7HDo7RYrzNAzJ5Zfi0G8NWl3VDHCRPxCrjSJhoq
	 Ie4qm5N4muvX1KDrTIJXeSVIghd4HdCK98Vmb8ncp2hQHTBk17M4NKHO2MT2mktbKp
	 e5TZFvXW+cUpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15097C02198;
	Thu,  6 Feb 2025 15:42:35 +0000 (UTC)
From: Tobias Sperling via B4 Relay <devnull+tobias.sperling.softing.com@kernel.org>
Date: Thu, 06 Feb 2025 16:41:48 +0100
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: Introduce ADS7138
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-adc_ml-v3-1-1d0bd3483aa2@softing.com>
References: <20250206-adc_ml-v3-0-1d0bd3483aa2@softing.com>
In-Reply-To: <20250206-adc_ml-v3-0-1d0bd3483aa2@softing.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738856545; l=2570;
 i=tobias.sperling@softing.com; s=20241122; h=from:subject:message-id;
 bh=OmyOmU49Tz1XrsAj9x+7MhVBICvzllgrTbFg4A067Vw=;
 b=HtdO/4QK6WW5DkmJDKjLdFYKyNCOOgjadEFB+aTgWm5C9Dge4Z/AYXERkwMyoeGJ0d7cINqxh
 Z5XmFk0g7KZDU7EK/XFsF28L4ZmsZ29cxaiFmjxYd4Tjh6DDJKgIBOB
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



