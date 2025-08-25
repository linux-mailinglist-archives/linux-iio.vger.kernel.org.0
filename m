Return-Path: <linux-iio+bounces-23268-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E601FB34F3E
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 00:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B3B3B8510
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 22:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387222C0F7E;
	Mon, 25 Aug 2025 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="raYk3nZ2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34492BE04F
	for <linux-iio@vger.kernel.org>; Mon, 25 Aug 2025 22:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756162544; cv=none; b=rQqFtDj2+OPw5pqI46Kl3FKwqmWQunvu7niRfnOv9wskQ4DmtZUpKUUhCFMuzl5pGi8Z5gLEcb4KBOWMBrZ6FtGtzDNtsMNe7B+FKclGAnetBiwf6rNw++YKWydIVIQIAoxknX4x81/zYXNRBgT08xTekiiVgmtxBJzLc3MuLMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756162544; c=relaxed/simple;
	bh=ejiW++p+A0I9xjvm23IuPsPQ6EO4iCmJb+R47NFoGFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h3iKzCx7pPh12hHiYbtx3Ya429C6kNlXOYna0wRpAs+T7LuMPCUX9SsbAD5mwK7qyIq7rwJtJrbSGuRJUs7H0EbIDYSAa56AZnkYx+rb2L+Ne5juvjuqUmiEL1dE6yUNUMjEMePMiygZaOnp+HTs3N5pNjCJH6RHtNnvQgbPbJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=raYk3nZ2; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-30ccec928f6so1484683fac.3
        for <linux-iio@vger.kernel.org>; Mon, 25 Aug 2025 15:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756162540; x=1756767340; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCS1blGVKzhibBa+GC93mJ6dY0HkTwPO0389IUyBXCQ=;
        b=raYk3nZ2h0JirOq0RbGPWGuD3i/BfBEOaDV3EFRISMwqJVjv1cNXk5GdWfFg27GaXW
         AimnX2M4TBmeZKETT7ujlxZ1pKc0Zvz5KIRkkw3nJaGsVUgunBxfLnEB7B6bTXusaJ16
         RJu+9NtC0E5SmLXDAVvEsYl0U9y/Xc9V86U+DFECvGSEuUzHN/a0m8iVCr/HvAtMrema
         ou6sGk5uC1lCHngoqADlNv3vyu6wu70l06ZVdMGBHJQl5uuQorPXvjHdW4aTM8Ncclmd
         rPDafvoHbcUdbHV0pmnAvqcPRxIQWydLU+iwCymjcSu+wV2eJVGKU7a04D7PNtpwNDVN
         nHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756162540; x=1756767340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCS1blGVKzhibBa+GC93mJ6dY0HkTwPO0389IUyBXCQ=;
        b=viuPmoYs/hhoZbRRmrAniaqHZ3KgnomRi7sRFlBlPrucQYNBD5gKdwO5uvNc4pkGCu
         BnVzc5aKjdThTWjXcNmmYv1mGrATrq3ZbJweocv56B7pqsxNivujFNNG3AiuBU/0at5v
         Y4715/CpGAjU3GD/aWnFvT+OqB9x/Zh+kzmy1k3boJelVtsMNjlgv8/Q6lcUf22WJdBU
         YzXqhangvtz8kwR1ES/QLMBFEc1psnzp8JX4eOpXsQ9/RcEyOgM1yUAmm8ASZ+a1YY4Q
         nS+reCe2jpvSSGIKaP3rHDdFzYaXMp2JrBa9ZimfSN8WdZFMpgg2ruitkSDZFeo3jGbV
         vusQ==
X-Gm-Message-State: AOJu0YxYVkEj/EXLCnmAWUdNLtcLtoN3AiEYpN+pIOeLgVROR/Y2sPA9
	nfiqIDDJhqBSkuPv7QSrRnVFWwdoqfYdXj66LtQ3cW1Fn2pBtsOE10ZQ+g51yEeEYDV4QCOcT8c
	qq6Sh
X-Gm-Gg: ASbGncsGLdXIObjHdi8uaD45vQmSdHTWIy5RnfLKkvexxS1r0dTw3PQJGroNGgW8FKG
	f/veqWysHRCwnDD+TDW2XETgcZTaDT0CtJV38TlCUacpqU2LL2cAVUcVbNBxe8BVUFduwAwxdzu
	yLySXedFs4mYi479x6JZwGl55ABe9G3fi1a95mWaRStVtwGEZz1o0T4a6JBsHvBZ+xZP4r/DOuq
	BgR11yt1DYtuqyHjku+Zt/vNz9HEZYEsNWWJISMUQAi5aZRR6QCnEAYqeNu66nnnJeujACv4WPv
	v/B2Rsz7K5AZwimqkNch1/VMst3QXkiafRo9QhMQkkEqpt9BHVcaPZjsVqXG4X44ZSt8hJiQLJ8
	9g7fJOTdPRMewKgUtWCnmdlJA2b1yM92ldkb4vfI=
X-Google-Smtp-Source: AGHT+IG4VbfJVkJxZqA+j3n+8jvXqEZbWK6Ftb5Y0wcjCOXmZgkbdUMlYCsFzEePddd25RPW+aio1w==
X-Received: by 2002:a05:6870:1698:b0:314:b6a6:68aa with SMTP id 586e51a60fabf-314dce1b218mr6156559fac.50.1756162540620;
        Mon, 25 Aug 2025 15:55:40 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:5075:40f3:ff25:c24c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7450e49d36esm1991747a34.40.2025.08.25.15.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 15:55:40 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 25 Aug 2025 17:55:00 -0500
Subject: [PATCH v2 1/4] dt-bindings: iio: adc: adi,ad7124: fix clocks
 properties
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-iio-adc-ad7124-proper-clock-support-v2-1-4dcff9db6b35@baylibre.com>
References: <20250825-iio-adc-ad7124-proper-clock-support-v2-0-4dcff9db6b35@baylibre.com>
In-Reply-To: <20250825-iio-adc-ad7124-proper-clock-support-v2-0-4dcff9db6b35@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3149; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=ejiW++p+A0I9xjvm23IuPsPQ6EO4iCmJb+R47NFoGFU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBorOnQTpaL89+dgO4/3roWZJ3pfkCnrM9sgbTYp
 69gDTUeMLeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaKzp0AAKCRDCzCAB/wGP
 wKXZB/94Npdyo0oG2GLwGHIRiUblJ/LO92HfZFEtoR9yHzK2EzuzUTptn0My93mXkFjWFrR0rqE
 pGf47hKzPM/uQdvDDvWIQxElDCdZLvDDnsskpkYFmSt4NZ+8NwR6LJwJTrQL+ETXRuqFJUUHXeC
 hChKs17tcnrW/YnI3A4Cep96UcZL3od5n5Rm09eIe2MZcwHikmSg+TYu9DDAQIjzfKXBYmdm9kL
 WzeHXQmSanbjEkgGTeTeN7abWznb9kzbmZtu+twd4Qoja+wp8uPWwxhDOQAKzyiIJ+cqUdrwyxu
 1csZ9aC5Ho6zvTGZ2+Tx+toMDO13ZdYirBeDi6ysFmXLMpjF
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use correct clocks properties for the AD7124 family of ADCs.

These ADCs have an internal clock along with an optional external clock
that can be connected to the CLK pin. This pin can be wired up 3 ways:
1. Not connected - the internal clock is used.
2. Connected to an external clock (input) - the external clock is used.
3. Connected to the CLK pin on another ADC (output) - the internal clock
   is used on one and the other is configured for an external clock.

The new bindings describe these 3 cases by picking one of the following:
1. Omit both clocks and #clock-cells properties.
2. Include only the clocks property with a phandle to the external clock.
3. Include only the #clock-cells property on the ADC providing the output.

The clock-names property is now deprecated and should not be used. The
MCLK signal that it refers to is an internal counter in the ADC and
therefore does not make sense as a devicetree property as it can't be
connected to anything external to the ADC. Since there is only one
possible external clock, the clock-names property is not needed anyway.
Based on the implementation of the Linux driver, it looks like the
"mclk" clock was basically being used as a control to select the power
mode of the ADC, which is not something that should be done in the
devicetree.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7124.yaml     | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
index 4dd5395730c10925c86782116dfd70a75d033bfb..2e3f84db6193b3d8765e2bdbd2d3175cf1892ba4 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
@@ -28,12 +28,21 @@ properties:
 
   clocks:
     maxItems: 1
-    description: phandle to the master clock (mclk)
+    description: Optional external clock connected to the CLK pin.
 
   clock-names:
+    deprecated: true
+    description:
+      MCLK is an internal counter in the ADC. Do not use this property.
     items:
       - const: mclk
 
+  '#clock-cells':
+    description:
+      The CLK pin can be used as an output. When that is the case, include
+      this property.
+    const: 0
+
   interrupts:
     description: IRQ line for the ADC
     maxItems: 1
@@ -67,10 +76,14 @@ properties:
 required:
   - compatible
   - reg
-  - clocks
-  - clock-names
   - interrupts
 
+# Can't have both clock input and output at the same time.
+not:
+  required:
+    - '#clock-cells'
+    - clocks
+
 patternProperties:
   "^channel@([0-9]|1[0-5])$":
     $ref: adc.yaml
@@ -136,8 +149,6 @@ examples:
         interrupt-parent = <&gpio>;
         rdy-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
         refin1-supply = <&adc_vref>;
-        clocks = <&ad7124_mclk>;
-        clock-names = "mclk";
 
         #address-cells = <1>;
         #size-cells = <0>;

-- 
2.43.0


