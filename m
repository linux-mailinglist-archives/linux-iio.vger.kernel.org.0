Return-Path: <linux-iio+bounces-21952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A52FB108CA
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1FBB5A3A1F
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 11:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6DB26CE01;
	Thu, 24 Jul 2025 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUXuB8dU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241AF26D4C2
	for <linux-iio@vger.kernel.org>; Thu, 24 Jul 2025 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355646; cv=none; b=IoDA5QLRuMeq84m2NbquFn3wiV4tSJypr/ZjQ7eTGVPCEezKFjZTlF5G8vK/RSApP7LZyHN4p1nnlo85bO66TGLlZsL4IA1I9OeVDWtZRWCmbIIfp/KklM9YZMY17y5bt7UKkP9yEA9wXqGlwf+hTm8jSerSzDMgU/nEuJ1NSb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355646; c=relaxed/simple;
	bh=QUlUkMxYLf0SjVpBsl0OVkwsTq7YyKk/KjAw6Del9ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQ1a+T2u3FF/g/1VUMwz5KqZvNUmlvk26jWWGrWjovvk+FDpv44rETbu9an4E8jZAg80yj0/klD2PKkVLiSeSw/VldsT7b9KlKZnqxVauTaD+f6iG4tEJDJDVqglfdkWtTohrqyXAFZWr4rEeufHv/8dkPNlgH2N2Dnol5b0PK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OUXuB8dU; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af374d96046so17685866b.3
        for <linux-iio@vger.kernel.org>; Thu, 24 Jul 2025 04:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753355642; x=1753960442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlXiIo1YTe81LzNvByvFXaqoppLPAdO13nkKqXERm8A=;
        b=OUXuB8dU0RZCQdve72E3reseoZ9KffQ+cRCr6FIx1sQYUb8ZiSFECkC1Uhn5wO4BFb
         2Zjqen5Qv7xFb/q+ashmbPH6cEw0BtDrtvkxXvw7EXHtYZZ3tC48Wz4Prsz+2POr3fe0
         TROa9I6SVthk6efxrxsr+XHLkDJV7Y0EU2MHWcHed/L15bis7yTJqK/SdLuhTu/vaTDk
         CcNE6J6U5rKRLZFQv6+nP6hLc5PTpENqz6lowAyIKAEDZq9WL1Wj3VJQn4NVDFiNE4Je
         wAhUrAZGCkEtgwDBp39yqs1wgx8UI8yECLdGMa5JvcwmdxWLk6LjL6H7KmI2anvcdZSq
         bk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753355642; x=1753960442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlXiIo1YTe81LzNvByvFXaqoppLPAdO13nkKqXERm8A=;
        b=bj4vd2byMDd6j8Enupqrm8E/OD2wnyJmovLmBuCMUUxysprYXg5o1scMdbidjFXNjR
         0DvRL71Haed/j/eBuq5K6gGjKbus0sKc1UW7VjY8xYZ/7c6BV0ESayMrtv8XfwpQHMUs
         UNwVby11YAEFDokxgWodty7vcHZvE6c5pP2DDcLX8ZA1FkQp5buM2WOIbbgUx9efhRbY
         f6ekAtIh7asgTxdy32u7Rk3vosVlYs3uYVZq1+Mg3Xq2T5Z1zjSef+Ggl0rGjO4DBE5J
         bV11+Y+abEJb9QYEq8uhBwQav0rD46z53YkUuFSji6NYe2+mFXJl09HuMDmE9x1fkhUd
         pstQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIjR7gLhtAWWJ2rkt9UzGQVWe6mbkKSF7Liu9Wi0rBr+XTwJq5OFy/HgVExRCTLFFuLlE+sNIW2vA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsEQvH89QJlRpTZ1XtbkH1gfpgcgxiG4l5pkd0f2whbfoScxtw
	JEx04ptbwA0FHU0Kb/LwJli/Fp/0hyZmQ6yJ8En9fKbhjmjXdGODZ+KTpRt59IrJHNA=
X-Gm-Gg: ASbGncs+6XlbZsqTB6BdyvbDxj/JnPMUz8cviMtZNROGgf+HUMq6baT9/tRujXRVrAw
	fo3/890aR8rHRCvuY5bTeMLAUDNLji8hx7EAFJKgqxViwKIRv5vMDcQ2fcF6a04VESXII1fIjR9
	+uUJ05T54mVNqcwAh6naiYZ7kw4ORxuKQYbj2BIpKJxUqPRQcFmZDuB9e2MPcx3mALbg5llZS/a
	p1BHs2TmZFeM102q6lLw4Z+3n7EviZnsqujBWk+fk4CzKRtx7mA4N+E5rOaz17H0A8zM3gpv8cy
	UgP30seIJl5VbAaGPL8KBf8W5SQ1gHH3Z/+o6x5k+V+VthhzZ8pZNnFCqD6nFJ56ENAh8+UFxV9
	9mLAY03BTgqj9WoN+pdN4PVaFNyA9nXgD
X-Google-Smtp-Source: AGHT+IEFsO1jeCJCKKhxjlisy/SsUZZ3OuDpWFhFwhM5aFP4wr0fQrdhbCZsUAkk2m0dTOMZzux8qg==
X-Received: by 2002:a17:906:7956:b0:aec:5d6d:2180 with SMTP id a640c23a62f3a-af2f8c55a72mr223332966b.13.1753355642274;
        Thu, 24 Jul 2025 04:14:02 -0700 (PDT)
Received: from kuoka.. ([178.197.203.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47cc6b416sm98680266b.40.2025.07.24.04.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 04:14:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Dan Robertson <dan@dlrobertson.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	Stefan Popa <stefan.popa@analog.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Alexandru Lazar <alazar@startmail.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	David Heidelberg <david@ixit.cz>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Andreas Klinger <ak@it-klinger.de>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] dt-bindings: iio: adc: samsung,exynos-adc: Use correct IRQ level in example
Date: Thu, 24 Jul 2025 13:13:48 +0200
Message-ID: <20250724111345.47889-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250724111345.47889-5-krzysztof.kozlowski@linaro.org>
References: <20250724111345.47889-5-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1492; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=QUlUkMxYLf0SjVpBsl0OVkwsTq7YyKk/KjAw6Del9ZE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoghVuzHS4uXkyTU6sLVWBewujbkHFikNttM/IZ
 isOEeWsOKCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaIIVbgAKCRDBN2bmhouD
 10l9D/9DQ2PDHDgUtLpbh1bG9p4sGi3ncJTi0AN2Is3G8KmpxmpfhMyu1KOOykbxxWYASd5nQQn
 XLCKNWaU40/sTcE05eH6IeyPkaVbBAmrqOIKiWYnkGPWLk2hFeyeDjU1i/299W2erhYLqqImuFZ
 BdUteV1wXC9ce8uWNX0o14sewzu6cz7tRYfaCcM+TSmP/Ngj1xDy+4HOIgw/dZb5jaDN0Dkx+oF
 BX7F0Toypv9+/XDHBm/ToCHcF68AHBVsUH4Sun7kLo6gnUu8uqDZ3wyDq6inD9w+iUkkwb1kquX
 kunMrEATyImHxNK9PBKolSZe1BnFjP6qM/G796nPqDzotG3blFp7admLxwk20kfNBGgeBF9LGPV
 BSAbdxqQcxiN33p/icJcU6hLpEy7wsLgPguvVkL+3qwBWfKo9mlnlmf0GpyVGh1qAm5o9v3p/Mg
 T/Ut7KQp4l00G0fmEBvTELyk8iXW4KRMZTFoeNFChPU+iXoJCKRfY5ULOtpSzXYn8wJnoRLwVkf
 DSpoXxNqM1g8gim36z+BCRQgS5jFE9Miduv2EhAZQVedb+0Tu0Tep62i7ZLXUpl6KKGTCsmj3bE
 vAdNuW2Cslh5TlRotpuzZ+fv3XaVrA+z6fLaIfLrL18NXt0ptrlGhgOjMlhPNV8wLYZZ/RG649H oPxf6PSkRACc8nQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The interrupt line to GIC is IRQ_TYPE_LEVEL_HIGH, so use that instead of
"none".  Also replace the hard-coded GIC_SPI flag.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml    | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
index 4e40f6bed5db..8069e99ddac8 100644
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
@@ -128,10 +128,12 @@ allOf:
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
     adc: adc@12d10000 {
         compatible = "samsung,exynos-adc-v1";
         reg = <0x12d10000 0x100>;
-        interrupts = <0 106 0>;
+        interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
         #io-channel-cells = <1>;
 
         clocks = <&clock 303>;
@@ -152,11 +154,12 @@ examples:
 
   - |
     #include <dt-bindings/clock/exynos3250.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     adc@126c0000 {
         compatible = "samsung,exynos3250-adc";
         reg = <0x126c0000 0x100>;
-        interrupts = <0 137 0>;
+        interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
         #io-channel-cells = <1>;
 
         clocks = <&cmu CLK_TSADC>,
-- 
2.48.1


