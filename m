Return-Path: <linux-iio+bounces-11261-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D529AFEED
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 11:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB7AEB23131
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 09:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BF21D9593;
	Fri, 25 Oct 2024 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jG3qPu3w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9991D4159
	for <linux-iio@vger.kernel.org>; Fri, 25 Oct 2024 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849860; cv=none; b=PXVZqRVJEyowoVu2pBXRq2kPQJaiDi763JrGxSF2HdwHPIO1LQzNC+y6EmC8JUEqhaByzvwOMsGStf0mlQ7QUEFlRD3WmZ+1LlZMMmJfMAexz+Rlrvb9iJVvKJwDXpy+BpRixJJrKOb+GXrSdUedCN/w1ld6aDe9aZxBm7bPOjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849860; c=relaxed/simple;
	bh=MA2oG/y7V1+Goz7xziXlVN+hyrEb/+ZFaEcTpQoHM1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LT2CxOFJ6ZwP4Jktx2KFxLt7B197Ain1usErcJWdWG0pAg0Kcj2Suq1xvtZO6eq2Wyjk0JAgk/WodF2x+4vOKB1DD1MWan66fprm8c8j9T7tmfBEQslVjcPQr89VsIWV/r42d5cPrYUs6SXVAukiePG3Y5rij8cE0t6Gr+pxEuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jG3qPu3w; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso24442735e9.0
        for <linux-iio@vger.kernel.org>; Fri, 25 Oct 2024 02:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729849856; x=1730454656; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3Jl9+VGm0G8JZ+DzIDolKuvv4I1MhBsGUOVMggicwA=;
        b=jG3qPu3w6hjd7ymVPk20n8xJK37iBchpm2hF9xM5c4UQTtgIGwW9Nl3D570U21fWyF
         tx9nKQ3jymp2JtGjqxwV5s+6MKJgcN105VtFz2nIOemGH80mJtO31WkrXuWbygjAtLhv
         vQhxha7aaz4Px2ptYtefUWMMrqB5UrlQ9gG8LnkUE1hk9Eo85Faytgfv9h6v3gVRC4Su
         uro6OzS/3/+w8dz2TsUau/U+ZRdCULFNWsjPxlzP7iOBmH6+3O2iv6lvNBoVXepkgdjH
         r2TRN80mGumKWAA4kG8eXRv8qtriItv4BHfcu0D2b2qVQqDpAbgTLOQH3RV9W5IJOKMR
         InEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729849856; x=1730454656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3Jl9+VGm0G8JZ+DzIDolKuvv4I1MhBsGUOVMggicwA=;
        b=Q4vyIMu7iERFZHlolhoO2a/y//LBAjWVsvVuAut1w34/ULE06kMeZ+64EqDM4rGc2s
         zpjM9EwFNKaaXXmiiZFyzpsBV3Cak4E0eNo6LOXW/wJAf/tNg88TqpkwJmDsB0rwOB3f
         u2E9sbWyAD2jhTU6yu8UH8lSGfmsbOzmmnxYE9s6ahPWvXA2KYo6FGA6tIyU3JYY08aU
         Hwp/xTk11f0oC2F9xwfqgazXrqnJ1v7j3BqVawDVLuTw1kEas1di/dlgrDea33OC+zfG
         phEuN5pw96G1FC/swKH/bT7zzd3PtSzVUAYEtkJDkPqFuDqy0vvxrMrkCtsB3a2tnn/7
         6L7A==
X-Gm-Message-State: AOJu0Yyh9UdgI4ZEvCZNuHKcpPBOm5hRBjSRoDpuPZ23F/xoE3Jfca5u
	3tx8BznKKGB8VLTq0aNE0V5l0cPsGXxYsmTYnzhgVOL2d8jw9WR+jT+JQd2Y/GfOfs5YiS7YXf9
	gi5PGHA==
X-Google-Smtp-Source: AGHT+IGp6FOLRzHC4WGgiEzptHXcfUuJz06Ojf2vMBCrTO1PWzKMoH/swRVXT64yBEJHdmEx2htglA==
X-Received: by 2002:a05:600c:3543:b0:42c:b508:750e with SMTP id 5b1f17b1804b1-43184201ddemr84270515e9.11.1729849855699;
        Fri, 25 Oct 2024 02:50:55 -0700 (PDT)
Received: from [127.0.1.1] (host-79-41-194-153.retail.telecomitalia.it. [79.41.194.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935f6df1sm12895085e9.35.2024.10.25.02.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:50:55 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 25 Oct 2024 11:49:34 +0200
Subject: [PATCH v8 1/8] dt-bindings: iio: dac: ad3552r: add iio backend
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-1-74ca7dd60567@baylibre.com>
References: <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-0-74ca7dd60567@baylibre.com>
In-Reply-To: <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-0-74ca7dd60567@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 dlechner@baylibre.com, Angelo Dureghello <adureghello@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

There is a version of AXI DAC IP block (for FPGAs) that provides
a physical QSPI bus for AD3552R and similar chips, so supporting
spi-controller functionalities.

For this case, the binding is modified to include some additional
properties.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
index 41fe00034742..2d2561a52683 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
@@ -60,6 +60,12 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1, 2, 3]
 
+  io-backends:
+    description: The iio backend reference.
+      Device can be optionally connected to the "axi-ad3552r IP" fpga-based
+      QSPI + DDR (Double Data Rate) controller to reach high speed transfers.
+    maxItems: 1
+
   '#address-cells':
     const: 1
 
@@ -128,6 +134,7 @@ patternProperties:
           - custom-output-range-config
 
 allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
   - if:
       properties:
         compatible:

-- 
2.45.0.rc1


