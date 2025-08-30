Return-Path: <linux-iio+bounces-23471-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC78B3CD6F
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 18:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74A81B27026
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 16:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856BA2D46CC;
	Sat, 30 Aug 2025 16:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nASJHhB2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364B22D3743
	for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756572531; cv=none; b=T/BT2dCYRl5BdOvxQPDH17utdWt7fvt14lkHlPN1Hsqn6nzv1NC4Rs3pBpTAPIJWPBSApbdPDvMMcqteQd5d0Ygijpfpqdo2l+T9QnGlJuQuZNUTnUq+fjL5+y/+euixCywkeKbtdkPK6B6rGPLTC5jEWMC3FLMpImrUqR+mrYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756572531; c=relaxed/simple;
	bh=ebjPcUawDuyYiStYmNU5ZL3R3L1PNedniR0atYT+P1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bWYPclEMwInlFLTUnuJiWsB6W0Z7S1ypsR4AV1wmaayiUPxwh8tsCkRwy8tSAcW03yhm16SIoF+p0p0OhvanMgngX0JBQ9wfpD4rn+B42aSyiqYCseH/glcGkjitbypaumNyL5BUadbvdi/bpAxBBoD9EmEniP5uqD5DDj1ZjG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nASJHhB2; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3cd99b4bb72so274871f8f.0
        for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 09:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756572527; x=1757177327; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lR2F57pXZlUmDDCYEA5++08US32un21m5O7B8t3ZqrM=;
        b=nASJHhB27GAWfqIrPfwhzZLmmEJrZPfQFU8WkT1oxfsDcWkZx8Id2GeKaEdn+AA0xJ
         VdF4ELszycKD/WozZlDxoMko6i9gi0LHzdcHeeD8/OdSq+S+SBiL9VbKugpbOU0mPOo1
         KinXYOVEK43cLaGA45KvnpGfV7K9nGOZ0BdYL6cCdVm/kjdsS9Hu2CjSvreBwWiM3MSN
         g3xB7rdO1zdvp68bhcEb5heKMjlWsl+PYHoW38VPXUaqO3jPigjeLoXx+3HuB/x2bUeb
         99t/F6N1rZSMrYY3ch2KVI5VUmooj3qL10NFVtoykQ1rnP0R473DWUPVHWzOdDSCiWAz
         2VbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756572527; x=1757177327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lR2F57pXZlUmDDCYEA5++08US32un21m5O7B8t3ZqrM=;
        b=J4E96cBRaiPkIGwinFmyQMU0EbWSr8dGn064PPv92k5r7l1ex/6fmt4i5FevFkpTXB
         gyHCoiPRb8eFuUEqQJnXRhE5DV7kcpfdsUpDAkuKxBA7Ik/X5WiE2YjOzqn+Gcg48/m4
         OcpPpo8b5z8Y0FXYcJtHUBtqAtPv3uxmrYN0VwdkRZTl3wdMLjZDQFnkQ/IuRtSsVXXh
         +eQawWSmyLU6Ey2JMufkCodtD9xr7zIOkoUqMd2thTrLD0GruF/0Rfdh9xlqnxnnDmKY
         O2lZ4Vxyr4A5h38mBH11EF+f8RJvFWVr1OzJ9CQeMIMJzjjHzejkBTLOWFeOinW6lVIq
         Kkjw==
X-Gm-Message-State: AOJu0Ywdr1lBxomyE6I48BldCYwUSeRbJsU2EqqoTMblqkuM4sE/+EIC
	FJuf5tBxWGwZH97RPEU1qhaek05Vc2V4QVzCkV0rTpPUOa74EXHqXuw1ED32J6Nq6XM=
X-Gm-Gg: ASbGncu47w1yJOYOhx/I4Gii7N3HDalFC3lIUaigJuFxYGQST6rsYGp1f1IHfeyU5Hq
	andgu4KNq3OjVbsZxqvfiJzSCTWAlzqZeRhMBNN4sivHF7BEymgNN0rWphDMNYcbYE1MCzUB2Vz
	I6c4oVDSXbvs1EcAPvLTSzoIlexYMg/dGvQYbvHxbGo9LE5CnttOBfrxRQJhopRdHMjfMWEMwyx
	wnw0CPh0Ms2Oz4cmEKYYNe0FUhiiJ5zb8mlJwReNo/QUV2A4zTnJwiapAviLCM54t/oBKVGC55q
	goOXCTLBzfw7YDxzBo2mWkguA7wSNwdJ3GbOy2Ed29McsrfmwdxK/j0zlenasCIiP5FRbFPgD8W
	fJatglGlXd8uJUaekD9P2H1esmhFOuXNr2VJTQhs=
X-Google-Smtp-Source: AGHT+IHt0KuSMQTDPQqKwlDvsHq9uYVnTMb+JaxUV+LdGdK88mtHqEQl+7TJcM0mcCtVtJuqsHFZ5w==
X-Received: by 2002:a05:6000:2dc7:b0:3b7:8890:8e71 with SMTP id ffacd0b85a97d-3d0fdc6311amr1950866f8f.11.1756572527510;
        Sat, 30 Aug 2025 09:48:47 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf274dde69sm7818129f8f.14.2025.08.30.09.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 09:48:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Aug 2025 18:48:33 +0200
Subject: [PATCH v2 4/5] dt-bindings: iio: adc: samsung,exynos: Drop S3C2410
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-s3c-cleanup-adc-v2-4-4f8299343d32@linaro.org>
References: <20250830-s3c-cleanup-adc-v2-0-4f8299343d32@linaro.org>
In-Reply-To: <20250830-s3c-cleanup-adc-v2-0-4f8299343d32@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ebjPcUawDuyYiStYmNU5ZL3R3L1PNedniR0atYT+P1Y=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBosytleZMp+yMmU7xsdbFO7JlxlKksf/lRJNJaZ
 YnqE1JDQ0CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLMrZQAKCRDBN2bmhouD
 10QUD/4gM1mCrSjYdcPTKpWDO6kCTZbB6/rtQiu0sGhp1ajK+tkWUy1YKGoYABMormyPFvjUzls
 4xbQEJN5gc40zxgmpfXhXLCfD7wl7VQsCVTtMAycfoR7jhL8kL2OB+vaNPXyE85AyseRAEnvYAv
 IDDGCmTzXLhDx+HejGYmRE/6Xeh2UWau1h6nkxpE6RPsTkr2P8VsGyYtqwuIvhluJShhDAW7DSG
 oPtUQr5q2g8KUANF6+JswThvWjwy0ImF+dNRp+1dHdeg46dbXLuzviBtqGzGw1syBI4N0uyS24D
 UcpQCZ+F4MZLpV0Z4TfQkf8bAr8gwB2DMAEkBZOML7culmARpQnlbqPA9do2wc+bDQkP66EuRsB
 7QzCly5CwNSmvfX5kOcmkhggEY7fSzm025jZLBwEVTs2iskQ8VZTnuUzTDU3jWkgF1bZY+olaVX
 s37qaxVKymOdFawq/CMkiAmqz3E/Nuwi1Uk0RzqejCeuqArxiwsWKp7QfqEribbB7X3BYbmgAMl
 tqsbPGMttaqCRBMqUi1B1UdZeP9DjS2ZNWfI/Jt3Bdgi0L5CZSJAIL/Td07t4tXZ3joYpp+p5Ou
 nGEmXkZeVdmhA8UPjHErtSQ85D6cRgivmj+rE1dXRgsgmZfpzXxRTx+sOGdE/R8pz2K02gZgJm1
 c0y2ypd7f+7giyA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Samsung S3C24xx family of SoCs was removed the Linux kernel in the
commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support"), in January
2023.  There are no in-kernel users of remaining S3C24xx compatibles.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
index 8069e99ddac860b22c793c3ef9479f720cfd8c65..73d7ba0fda1def433a97d10bce21e762a307e36c 100644
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
@@ -18,10 +18,6 @@ properties:
           - samsung,exynos3250-adc
           - samsung,exynos4212-adc                # Exynos4212 and Exynos4412
           - samsung,exynos7-adc
-          - samsung,s3c2410-adc
-          - samsung,s3c2416-adc
-          - samsung,s3c2440-adc
-          - samsung,s3c2443-adc
           - samsung,s3c6410-adc
           - samsung,s5pv210-adc
       - items:

-- 
2.48.1


