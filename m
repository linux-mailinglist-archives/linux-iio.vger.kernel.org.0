Return-Path: <linux-iio+bounces-26922-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A81CABD40
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 03:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1735E303789F
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 02:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045FE275B06;
	Mon,  8 Dec 2025 02:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xspga4Pe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42500246770
	for <linux-iio@vger.kernel.org>; Mon,  8 Dec 2025 02:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765159714; cv=none; b=JhOghTROI3S4JheIS7HvFxYZyj06Yeh6IQt0XHWOe9KmcdfoUtuvbA0P1ZzPfZ6T1UFREwt1njoadlcqkeGvvO0/rjgnEHi+AK7W23HGnixSWOCSQUW9MFhGY2oUi38rFfCNSWzpEft+gqzPI/0Y40tegomLX7IFnJ7O/QPwIn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765159714; c=relaxed/simple;
	bh=OhAPqaXLXCmsNIfo7/tILARHNy+GrLJldAAVbkxmaW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uH1xFkY5WZG1QwK/8khrTtuaxwhIjZgJA2sKIlEO26y0Xu2EMUXeHDFXbIDvaClnpQTpGcM4hqUT0dc2v8DQVSCsL6S3i6kBTGDhYdI/sf3TaXrGdwXzOAQLSgBKpHRUd1uNbF38/fKaG5mWTUJFXIlC0O8djYkqXn7uKMXSHeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xspga4Pe; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so1811575f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 07 Dec 2025 18:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765159709; x=1765764509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZahglen05z3CRdzByKKHS/uCh35Ibd/55Vn0qmvXT0=;
        b=xspga4PePRRlNcGliaIQgV4qZQi+SXnYwW6RyRPzwlHsM2trM9ftNI5n9pjNu8APub
         j9UWmbPK1xv3WKTqSShNEMzUBXRXkpEtNwFI7iGrRf9LndnKavUWHI+ZuGfOczZz+4LF
         2g85h/7+tHOGCOvv/pPPRs/8YNTiOnsACzXSV9kfGZbG6ak+ttlEJzfeBYZoUUJA1aI9
         w4Epf2ZFc7dVTjUwmJXy5cQ2vZ0qM7SuDpAVaIRaJMj/h9e7sg9bdj7WMw53Zxv8PIZI
         qngJ3UnESyRrv9Fkgc3rP+C5H7PWO3y0E2wKPM7zPVLDGr4X/N28IOQ1KhMjnu7Q7GsW
         CpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765159709; x=1765764509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tZahglen05z3CRdzByKKHS/uCh35Ibd/55Vn0qmvXT0=;
        b=xMigYwWHgikaV5/a8fUpWwDm53/Jkiy7M44DcbFVPdTXJcm8RobT5AbioMaFIzEOsq
         kjkC8EHYxa6Frns77cws4Rg8ZMJKksnd4CvCN8Wh0ZmkuwmCBdhFhF920RGgx9VuYaoo
         omozwKVX3MLa4CSo88haUKOjOqXj0oqsCp2lbxxLeRjrZWogi+6Ymot04/qbhJaEzpf4
         W5QqXCx7iii+pjczZZwL5RFyQLG5gObM4m7zvxZ7yvb2Aa4HmDOvYz90OlHRsnggN54L
         xFRnpfgl21N3yfhMCn7i/nUrCy+44hQ10StkFSIl3rmzWJaSkU/kF1ZX5T24fWbYrGQG
         yoXg==
X-Gm-Message-State: AOJu0YwlOLbQhY88bANgQEAgJk8sbh1NqvBNBK50DtjchkdRracXfda4
	fLbIPDpPX3EexaN+WAjYQaHH3+wq81ZANvjJzO0FGPpRfR7z9JvcgWNERWg2fz7+hOA=
X-Gm-Gg: ASbGnctvKm7XocsaPG50oo/9myqZwmMA6WJklbfVCQVl0JgYFA9yCm6joQ1+fPc5f6H
	T0UA2ybVJ2uNNco4yykhYPRyuD4eM+LcF9ppsjRLW1sOlR/br0V5GB2dF6wQR3BZOnYna0PHFx4
	uYFQot2YZy5v29qg8HBeu4a6uxRe+oNsLD1TahnU5x1pY8KhiUbFHhBnCWG4MZMftzXIJLA2Tfz
	2U/vqVCn8kfQRx3jwtbR3gYx1KfN1TL4S9rFKuLV0bMNhaigMWLuBa8Oiv+ihkbvfXPMYwbFqvl
	IruiZ3FnaYtOqyhtO2QYDY48DHmnI3755gvxVGFFQyQAqiboT0YYFCH+2PquehNo+d7vAER07rn
	IoQ3yPcEo96wZkIXk3nz+i6olK70+lvfI6RrVMd9oS9E6wZLe73hBnBKMnXELm1CqMWP7ne6gnv
	2AOeK6C1kFYuFoWHB3mc4Smujvb2W311su5o7pWvyx5A==
X-Google-Smtp-Source: AGHT+IE66FrPJ19gojUZQwYUQUVG6TO/sxetLa9tgwD9g8BE3ycPA+5flnZf45m2zANsdCZ+AwIJTw==
X-Received: by 2002:a05:6000:40de:b0:42e:d669:9e84 with SMTP id ffacd0b85a97d-42f89ef1a08mr7706246f8f.29.1765159709453;
        Sun, 07 Dec 2025 18:08:29 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbff352sm22647813f8f.17.2025.12.07.18.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 18:08:29 -0800 (PST)
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
Subject: [PATCH v9 1/2] dt-bindings: iio: adc: Add the NXP SAR ADC for s32g2/3 platforms
Date: Mon,  8 Dec 2025 03:08:18 +0100
Message-ID: <20251208020819.3063506-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208020819.3063506-1-daniel.lezcano@linaro.org>
References: <20251208020819.3063506-1-daniel.lezcano@linaro.org>
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


