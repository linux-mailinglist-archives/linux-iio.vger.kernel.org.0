Return-Path: <linux-iio+bounces-26325-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0962AC714B0
	for <lists+linux-iio@lfdr.de>; Wed, 19 Nov 2025 23:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id F0F1724146
	for <lists+linux-iio@lfdr.de>; Wed, 19 Nov 2025 22:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207CE314D2F;
	Wed, 19 Nov 2025 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pH4KXZfK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A3E2E6CB2
	for <linux-iio@vger.kernel.org>; Wed, 19 Nov 2025 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763591955; cv=none; b=qZb7Vm1AXOuQk/vNKI7yGFqpYdxt6CSYKBOdh5y5Txe0Q6NC/ZMw0leLEtEkRb0LOPvg9RoEWRGVeJYn4urwG5+xJv3bXVBcJVNbc0OrOv4ltf/PQZMVfYXdnJsoW5Hi5feD6x8smoes7rpERkapEu6Yqd90X+q9hrqd2bvV6CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763591955; c=relaxed/simple;
	bh=OhAPqaXLXCmsNIfo7/tILARHNy+GrLJldAAVbkxmaW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qozxDgPtTeRc9d4fNuMNTVfeAehlbl3rZ2ySuBEunSF2ulpYLGmanpXvDWw0NAyk+NNptlQVv5CdEW6KYaeHx3LcjGjFJFZ9BPwIVgZGAMqwM90L8FFNc5NcYB8mBH0Gfv+N32oVBETJopMU6V790HtFsyTXXAu9Nyu9xWmWUlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pH4KXZfK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b3c965ca9so136070f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 19 Nov 2025 14:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763591952; x=1764196752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZahglen05z3CRdzByKKHS/uCh35Ibd/55Vn0qmvXT0=;
        b=pH4KXZfKXMC2JNr1lsv0HuQma0jTOhV0wg/BLSetFPktKgLFF8UrctM1VWrD0/5D19
         VA3jQo8rPVXSF+che641JEawQYJeKoKNz+zaD8fqNDA4+cslBd3Fqqmu3RG2XOPfgEtD
         o6LRcJnmB9HYe5afHyRg6oJJfeVjAmMYxoKgmoCXkhwbvNBB5hFeZSBAYKSEeITszcdf
         bS3Zy3l+yPCUtIKYnGORs07Kp/TsBFlwbF+XsnYXzNMj6ZmddplJKLq0zQKr9nbJtBn/
         IjLxRXYJo3j4nfXa6podJneOcFQNXhbvkSL6JXZ04dGcaIHDJpiVVkwXdaxoY+v6CK7r
         MFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763591952; x=1764196752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tZahglen05z3CRdzByKKHS/uCh35Ibd/55Vn0qmvXT0=;
        b=aKJ4vN9UQFHDY4U42U56+APZPr0Yuu+qNGOnxK6mjYCASWJsseill2A8Rao4l7Jj/I
         xSdGAlnRzBz3nDv1ITVQdi3C+g4hAzjRXenEaFTQG3aYhXS7SW8iWubt5VNFXyJGH7ep
         1Hab61yV3SE4n4Ok0hNb5H5EA0tYdOYGwQ/WDXjh2PfzcNWDKyMdyAcpmpWwUzLF0qP+
         LmjW9MxTXfdtRS8PtbrPk9UPaCbe0a4xKZZOaYS9WLFctjwpziIL4sKJrAEyn/EHhj9/
         8UydgiBznl/Ga4cg3Gq59Ko8W3nFv5SmYlic3cN7axbiwZ2s3kWJfrU6sEgQDjTqanJd
         X7LQ==
X-Gm-Message-State: AOJu0Yyh+oarZLeO8kJ93He0FzPPtm9+PxcII41e8YoqbkY41QRlx8aK
	WhAq6HPNHAmldRNeK9mqkVEvwRfdUcNZJYw/huUyvuToTT04cgyoEvHqIJqoCDXMM0k=
X-Gm-Gg: ASbGncuuCRjDO4J1vWnJHWo5G4VE6DHTwksmlGnSMhkkxHdkEirNDrrjDp0AXEE9PVQ
	2YLluIzNfVnUwnPHniknLEQQ/FYumbPAn+8XOYzeOjQ5XPYrX70yuJn/gSP5Jh+eMNdLK5qBXWi
	l3fav2wFdHEwEmG880rLsQJJRUDj1AhJO0GsjCXZCHybkcvtvO/BSvpbF1bSfh/XBwOFG7yCjFt
	lO+ju/Gn6GG8qaBa66CogS3FSFjZv9APWLwC+8t1UhQCvXfua/1pAIFxyJ5viUEIBMn+7FU4iIC
	Ktg3Zl73d2NiI6h0H6CG47s0WjYH3CNErECyV4coDhmG5aDO+7mfbJ0vTtMuMB7y5olrY9Mhj5Q
	j0RHNqZ4RTfFDdyeh5867S9mjdvLUNBV8JslOoLTOdaKg6x8mWP4RQ2WhChPUBLLm8sY14NBRtH
	6REbe0Dp8xWTGZcTXXWA/eu+fSNRmMMkPDeUH+aHcpFg==
X-Google-Smtp-Source: AGHT+IE2ZC+1zr8PNHtsNfVk/F8yFtUCAXnGn41I/+/f7HNLT+5aBJEsNqoIQ1+Qu51qF+3OQC1wNQ==
X-Received: by 2002:a05:6000:26ca:b0:429:c4bb:fbd6 with SMTP id ffacd0b85a97d-42cb9c02a71mr230573f8f.31.1763591952259;
        Wed, 19 Nov 2025 14:39:12 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa41d2sm1569760f8f.22.2025.11.19.14.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 14:39:11 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	s32@nxp.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com,
	vkoul@kernel.org
Subject: [PATCH v8 1/2] dt-bindings: iio: adc: Add the NXP SAR ADC for s32g2/3 platforms
Date: Wed, 19 Nov 2025 23:39:04 +0100
Message-ID: <20251119223905.107065-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119223905.107065-1-daniel.lezcano@linaro.org>
References: <20251119223905.107065-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The s32g2 and s32g3 NXP platforms have two instances of a Successive
Approximation Register ADC. It supports the raw, trigger and scan
modes which involves the DMA. Add their descriptions.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/iio/adc/nxp,s32g2-sar-adc.yaml   | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml
new file mode 100644
index 000000000000..ec258f224df8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/nxp,s32g2-sar-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP Successive Approximation ADC
+
+description:
+  The NXP SAR ADC provides fast and accurate analog-to-digital
+  conversion using the Successive Approximation Register (SAR) method.
+  It has 12-bit resolution with 8 input channels. Conversions can be
+  launched in software or using hardware triggers. It supports
+  continuous and one-shot modes with separate registers.
+
+maintainers:
+  - Daniel Lezcano <daniel.lezcano@kernel.org>
+
+properties:
+  compatible:
+    oneOf:
+      - const: nxp,s32g2-sar-adc
+      - items:
+          - const: nxp,s32g3-sar-adc
+          - const: nxp,s32g2-sar-adc
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
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: rx
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - dmas
+  - dma-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    adc@401f8000 {
+        compatible = "nxp,s32g2-sar-adc";
+        reg = <0x401f8000 0x1000>;
+        interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks 0x41>;
+        dmas = <&edma0 0 32>;
+        dma-names = "rx";
+    };
-- 
2.43.0


