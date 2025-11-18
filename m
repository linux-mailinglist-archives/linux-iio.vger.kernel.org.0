Return-Path: <linux-iio+bounces-26308-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CF2C6BA62
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 21:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 778034EFAD6
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 20:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D722F12CF;
	Tue, 18 Nov 2025 20:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vl5n5lPO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBF129E0E5
	for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763497994; cv=none; b=NXV/LuLDHBlI9FebxgAbOCzbTE5ezW+CeHA10iW4MaWgOsFhzzMfypKNqo2mfPctO7lIGL8GTGUh2Nvo14i0wMcif1I9YppZgBcxLqcd7cUeUe5xMgbfvg00ESxTGFTWfehsrQzLRsAEa2Rw3JaJ3lvQ74rPdkme4x24Bmn5WrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763497994; c=relaxed/simple;
	bh=OhAPqaXLXCmsNIfo7/tILARHNy+GrLJldAAVbkxmaW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZMxjjVWLZcMuXpQ/PgaQBd/dt2oqh+EK6tBVzkDrn5vRFsEe6TjBEYfQ0afBtGCOOJOj04fedAP6rZM3T7co0vLBXaEkAwQeu756vApzNxz0Xx5fp/wh5GF436eQJVzuGmFeZd+Yr6m6jufa0Guv8NnRc6FmjaNPFdn0vwfLZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vl5n5lPO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4775638d819so34577625e9.1
        for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 12:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763497991; x=1764102791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZahglen05z3CRdzByKKHS/uCh35Ibd/55Vn0qmvXT0=;
        b=Vl5n5lPOVosaxqKP4otOhx/YL25k0UiQeuj0e1MlWN5yjFctOcr7Bi2qP0rYafFzkw
         nzaW6XSkhx1v8yEYSwCCJkfyF8i260tzsNytVFwZtG2qWkOiheIvTpYHV1fVbNM8DveH
         Vbz936IakwLa0UGQt8dzhgNO0PfHsjZXv9uxw7V5W4fgd5HU72XcHp33ls9ljY/E6oRq
         qTOgxWXQKSNctw5nMUNEVDsYMpXmcu7OR0R7IccNkC9cPhhd5S15L0u7u8GMbpoM0DfS
         e6r+cjVJaWPlkilW6cm0yD2nFYLW7PO5duNALEaKa+XJT4RVyer0r8o/zboMU38+Z//Q
         bBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763497991; x=1764102791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tZahglen05z3CRdzByKKHS/uCh35Ibd/55Vn0qmvXT0=;
        b=jpLg/m+/lOjhsg88ux3F4C0iljwIuCLgvzS1GPg4ip7+BlyWAUsaEwRcrGrjhG+4gc
         NdkYx1CX9KyFL9BkuQc6YWiMvX4+572UbXHc49J1HQYhGUx5E/BK+RY37ps2an42WDc+
         pY7QuGQbg55w4UJCrL6ErXgLYV4EvO71uR+fOgSkVji1uXQdlj+VFPJOtd1Aa/dpZZkC
         vhcnJnwxvhBTUPv2kWDxbKOiTG0GtARMUTjgkH/PX5av39PcQlW3VgrbIOD5Zxv3wlTq
         PadNTy4QE+VgvFOx5T0bqI2med1ueXh0U4Uhl/nqTnNC8sOJt+OPrUqX2AefdjDW7JW3
         ulRg==
X-Gm-Message-State: AOJu0YxshJSLCsNphp1nrZ3YsbQeNei7PgLW4secc4W1rNVOhP1xmC2j
	vyuTcvSj5Gc+/vmy28WL9uskcsNYccNhK/w+cm/7QhwNlo3QbGyLsOVP0avnbR0ijdE=
X-Gm-Gg: ASbGnctdaBCqOpE8d/aUrOkx9TL9qXVEjMpvEbdL1i3+jDYWzMj05VPdU30EDWmlhau
	BbcIxpcYCAiAeyqwI8XgN80ljwwnbMY0ALCl098fcMCXHFv7n758LStDcgA8YS3M2peFmW055pG
	jl9HkG7gi0NdCnmLUG5grzNPKJnphRrojx0dG1CHhPyStVjpeaSzfPWtICQbRzLEtMtlJTwjofS
	VrLy+iC0eE22EfFLBZ7Z2lDROhjKWGQLuhs00dCd+YfBrBn92acYPHvk/zaDvGCTNQUfjvWDEyM
	/311A9xi8wGl4k7Y1lC/kmyEXjYkdBlrdchhdeyJrIYembJcjBvmPliAZK60QQreVVKpO62rc0j
	+oDBXjreFrnLH54hWgiDnFcBuGauxdSCQD8FGW7SySI44HsZPFuzyfVWnDFQq4pkr/qrkrA56qF
	P6929uFVEqYH4A5fTjwMDPo6V4hqiZBxo=
X-Google-Smtp-Source: AGHT+IHIey4BBbY9jcVXbAjDqlDOZoGbbETWIUdluuvO1V6jyEzRI/OGv2wkWa4tMzjwTmnE+tKsCA==
X-Received: by 2002:a05:600c:138b:b0:471:700:f281 with SMTP id 5b1f17b1804b1-4778fea7f90mr158109115e9.25.1763497990763;
        Tue, 18 Nov 2025 12:33:10 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:3006:e9fd:4de4:66f6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b10260adsm8397875e9.7.2025.11.18.12.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 12:33:10 -0800 (PST)
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
Subject: [PATCH v6 1/2] dt-bindings: iio: adc: Add the NXP SAR ADC for s32g2/3 platforms
Date: Tue, 18 Nov 2025 21:33:04 +0100
Message-ID: <20251118203305.3834987-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118203305.3834987-1-daniel.lezcano@linaro.org>
References: <20251118203305.3834987-1-daniel.lezcano@linaro.org>
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


