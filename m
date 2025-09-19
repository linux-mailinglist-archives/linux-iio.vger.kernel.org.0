Return-Path: <linux-iio+bounces-24287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DF1B89BEA
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 15:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BFC172814
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 13:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61CE31283B;
	Fri, 19 Sep 2025 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dg+XUrQQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56021B21BD
	for <linux-iio@vger.kernel.org>; Fri, 19 Sep 2025 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758290193; cv=none; b=ut9Ne8JcfTufozwxr2XIk9wSF2oMVH5JWmMzOrgZYRFbNvvJKu43zcj/+NYF1pFg79UPCYYQkzUqTlIdxDZnZfegDgLQNTFSu/5iAK/1McDryx8PmrfHPmyCuP9HHY+6xvimHSFcTmuLro8r0gdnv11ay1UhX44JhZRSza4ySFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758290193; c=relaxed/simple;
	bh=OhAPqaXLXCmsNIfo7/tILARHNy+GrLJldAAVbkxmaW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jKiUnoGiLZsMQXYpdbRbaxwIrUDSQbniI2J0tXNe5UHsBPwZOwIWDPmDTotDAJ2NHLD/FiqbcK2bBO9vl3nHM59y96aeodWr370CIu0xlSi5yKLCeyAxrqsSLTI0asV+i1kOBgioCYn2o+FkajdXrq1/9g7peEEg8SDVRVtAE1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dg+XUrQQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4619eb182c8so20266305e9.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Sep 2025 06:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758290190; x=1758894990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZahglen05z3CRdzByKKHS/uCh35Ibd/55Vn0qmvXT0=;
        b=dg+XUrQQkuTGT32s5zYt8TCMHW1IZ1rBNLPXBV2jiCtTrCfF6X6fn/ILaPVihc4zIp
         m4RIi5LarV3u/KBDCi8B26hrwfVYUp+CwCdR7viPa5mu78Yxes5s2iHgnG7AKhC09O72
         OszmqBT4UcOzNN02JW4x3wGfezh81DiLCahMT5zkTVMqZCVp5AF6MktlOtVxw1RWBlPG
         GzX4KNzgv90CIJDsZlpMCoFMPGtVXGHf5RlQw1MR+n5/Rtf/D7gLwA4rEul2OILuyOqT
         uIc55KPCo29ie3DtR+cXfgGdHnfn9pxpAAKC91kzRrq8UvEPsbsZhx9NwKdTRCOxbLgu
         gzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758290190; x=1758894990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZahglen05z3CRdzByKKHS/uCh35Ibd/55Vn0qmvXT0=;
        b=doM5neYLJSc+SbYu9bbIPD99UHvgRDmd6r3PbCwx6mWgoyhXkYrZoeaCyBu5C6sa4Z
         8/vTsQK0o//mnNO5Sj4MW+WPIYolthZ0GVDR/wvWXdOd5XQHaXfK1Pf1vBD6at/rtgEt
         4m3oebw/jvOgryJz5csYdAASaJiR413bQzYdG3P+PZEVIjmokfNA12zFPqZhSDf65e09
         b500J32QxzFMg3EffbGLjsVUwpV3ISWYdOYNjs5gZJFncPQ/HlmImLapgGm4uhXnwUlK
         /yQd9oxZIIqzMoEFVJjvk3NMv2Iwfh78S/kn7nrVUsvggMS/wGMPY0KVbnJHzaConJNy
         PnwA==
X-Gm-Message-State: AOJu0YzdV2SEjsOM5PU71uqiYIwKnsMGmO2EGjfP3gvGgiKHerIXZuRy
	TDjCNbDwPnF9svvSXIJ11mYkwoYbgUvEtQv8LmsOmwCwOwyjo6XKZ94RfwjOYJK9dh0=
X-Gm-Gg: ASbGnctV3/0DSw4Cu5+W5jC2BlZYVpW3pvBNWTW5zzs9VwE8tcLlKzstjr+Xu7gp/cP
	DbYVU8Eh2TKNPnlVCWxSCtfnYWuL6KBf82GVKGXQoiQykjZaMl6cXB3a/FudKEkw5cUngNLA3hu
	xrfrOsLo34pFzTP1oyloFWfoisYPO4scJEzVMn7cGdIf7+FbendvJ7YJXOXfeBURb+SohcpR0Gc
	cRdqjAMVLVzuEf2qJbS7ZkK904gJgUzToIkvepbFV3dXyD/4a3Q9QJ8/S9mCW3tcV9tPFMuhToC
	OWEjHS8JbEzfxUufDgfphdPuDhdTC7ua1OIUjMjoXGbgA2lttgcDrERkHND8H32yO8KVsZJTnxi
	ReKzuAo2cDO6EGh9OGC2tm+6NCEbjVVl/u7jDFiOnG9g=
X-Google-Smtp-Source: AGHT+IEZnPyiX9zPgtHCPY0Gj5f3YF+XX20JUZSlTSApuNgq3hFjaMsYQnCWDPD1krWsK+v+e2L12A==
X-Received: by 2002:a05:600c:6288:b0:45b:86ee:415f with SMTP id 5b1f17b1804b1-467e63be254mr27573835e9.6.1758290189985;
        Fri, 19 Sep 2025 06:56:29 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:8ffd:205a:6719:49c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613d14d212sm144913025e9.12.2025.09.19.06.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 06:56:29 -0700 (PDT)
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
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v4 1/2] dt-bindings: iio: adc: Add the NXP SAR ADC for s32g2/3 platforms
Date: Fri, 19 Sep 2025 15:56:17 +0200
Message-ID: <20250919135618.3065608-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919135618.3065608-1-daniel.lezcano@linaro.org>
References: <20250919135618.3065608-1-daniel.lezcano@linaro.org>
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


