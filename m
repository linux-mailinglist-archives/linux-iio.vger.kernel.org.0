Return-Path: <linux-iio+bounces-23470-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47552B3CD6C
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 18:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DE85E523F
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 16:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7E12D3A9B;
	Sat, 30 Aug 2025 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yfp8KxBH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3C12D2398
	for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756572530; cv=none; b=L0+vdzYia7+YUXL8kuohs54fWpgByYntt5duKdkVJGgyzDZGrAcmZfepaLm0KjycrXL9znwCrxDBC/GZ994a5SADuCEbToG7vVeJ0Uio+0EkehLnIrw7IpW1DXyRwvOMVKOQa9axzR2YBE1eUgOZB2NXIjNPwkAdrlqGqRU0TtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756572530; c=relaxed/simple;
	bh=6AT9ywUCC32xDJqdhfxsK5Br7bqJJTl+mGHOc7ie3tI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hUxT+BuWYj57BDiJypnYyRnLqvojFSfcumell0rA6Bo1J7LktNxLwMvb8AzEU6T3IhFFvswtIkNuaC4Vuw78uV/sexXNubuarra+i6hk7tahMTQm02b1c3ujxmBu3XKk7/NAmYPOdi4sC+B9ZDP/RYXOtX/9Y0nxAXlOIjbE2as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yfp8KxBH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ceed75169cso252507f8f.2
        for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 09:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756572526; x=1757177326; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NHu7s5gw1lYyul9BgLj8lXh4B9A4kmI9Hzn2CmTilU=;
        b=yfp8KxBHPzQt5lj82AMgIyuB07k6OnSjbmPRv1lDG1o4Lu9j1Jn6R2G8TDVphmwfw9
         dCBZPDZY2ahJ4yHDqUt2vf9xYr1IvMm6gtVaNyC2RYEkv1x4GbP5QKCJOHvbFZCX9ZjT
         IXjUAIc6xRK2vY22GqGu5BAhwoa4CmwsMw2MMEihn+LL5lwSeyaqTt0wmIoNgWyXlsgU
         wX0pOXWzuLFphA6IexzrTIcN9PJuNFUoSAT6FB2BFzaD6CmCkv5UqkbwNRTWN9veEcRJ
         fXnj2qk1HJGQ9dhtnxsIPEzSBIySqNaCOFNGImYTrxgFOVE7gfhlGcer3zhc6JqEPZbn
         vmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756572526; x=1757177326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NHu7s5gw1lYyul9BgLj8lXh4B9A4kmI9Hzn2CmTilU=;
        b=hDqDfLI4qgo1dQFIZWyda7nHnCSdWcbDuTkGQKTx3JRq4arpzymaCkOAtH4f+2YCbX
         S2SHrqYW3TT81b+5+123v7xyIv9BeDkksa1yL+4nELnv1ErOiAnp7g1eO0iOThEpRJcu
         e70tGBMcufww0vJLbZdZusK+T1AnrSSwxeW5LCJuIQB36PROJigYmzLuiMgSUAXH8+8b
         Kl2ICUUxXx0/UquOWYQMhs9kX3e4mr7wEXjmnVYFIjHAZc5JbU5Ri3Z0LCM1e2U80Bwg
         SFuL/4/sKIFGsXbSdhlj0Ord+e1WZ3EU3MCB61J97VtohzeHopQW4Wt4FeGOJs+OciMf
         9oLA==
X-Gm-Message-State: AOJu0YyEMPwcwQiAIiqUN/FYPdW+HKu8FsFoxOkHI9qoL9fsBFKasD6X
	QKQlkBatOCZbTpMpK33CiNo6gNn/3lPsyQdr5oeJqS0zvm6UAMJ6WchGLxJV5W3lqGw=
X-Gm-Gg: ASbGncsIcZggyBVc25JbgN3XWrQ6NPSzBt1h1u5E6Gk+80bfr2kGkDW2Hk+pl86QxyP
	xsD0oKCzBFxoIBkmy1NSpC9x9VARJXoiPelZ7QMj8KdLWWbWSuKteeh6mnmtqt5JF5/Ai2xuLS0
	HsMN8NecLACcxceFHB3Vh4e2FhWJWmUrMV2xYpcMtRqq8SUuLGXfuTKkxluj1kEr3zgFENHEBUf
	kJDvfuwMOrRrkFnLU/3V1eAH0PoqWFjGQC/6YpV0wKoJ8rR9m5cd1JU8FyIoklScGkX95XaCkFA
	xBiXO+uh/Wj7QCqnGbBEl2r+e2ZVdS0U63eox5EJh/RN4IBK0SScaWXNZauNAnr47iBh5Hyos+n
	O/ZKzZmjDhs4PqMqSmu9nOa9rsk0hSWo/ZC3MouB0XFOrwZ9Qvw==
X-Google-Smtp-Source: AGHT+IG3g/r5+Z44VCwqW8bkfFPUWtY+KFSor7fLqkk/9p70DkqbZxuqtb7Kgq+CTTE5OETkMakrhg==
X-Received: by 2002:a05:6000:4203:b0:3a4:f7ae:7801 with SMTP id ffacd0b85a97d-3d0fbdc8122mr2137741f8f.8.1756572525902;
        Sat, 30 Aug 2025 09:48:45 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf274dde69sm7818129f8f.14.2025.08.30.09.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 09:48:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Aug 2025 18:48:32 +0200
Subject: [PATCH v2 3/5] iio: adc: exynos_adc: Drop platform data support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-s3c-cleanup-adc-v2-3-4f8299343d32@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3178;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=6AT9ywUCC32xDJqdhfxsK5Br7bqJJTl+mGHOc7ie3tI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBosytk+UfhpJZqsZdbJJIvPyy0MxlR8ZzP7Y9vk
 SaMD1TerjOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLMrZAAKCRDBN2bmhouD
 1xDHD/0XrX2T5NZEXND6PIik1dMDmd+0HGE2tUYES27XFPsmniDxAgSEe6eVzk9lgqe21JZJIc1
 LcsHr7luK3WjAUNcGYdK9aHIC9n97w6ANM/pqV+4LNHb+ZJaT2EA4yoa72a3vhHpROsEkoqycY4
 uDUyvzYWoY4YczYfj5PT53HZiBeMTPKP0HhmTl4Dyo7ip1UGM9PdgU5OSYmF0D6nB0dYjvI8+ZM
 zF8A+FGUtP6a5oSE2M0QJqfPOuKXEXX/Zdjs5Gx1W8mub0mnfQZbO7iX9L6ASlIhF037rIw0F2S
 mDlh8XipmgQIo+suj0MbhueFwkS9zhGP1oMimFhJUsd0Oidg5VLIHYmPV19XMCSgbTwChCdcjlT
 C6XINIdpWP36Qc8S/2rL/bP0lXLTEqqDlAGDHKhm+yto3OeZIGwqEIzKgEiP64ZZ7zdv/dcsYal
 CDkGJlMhxKa/FH7Zc3JBJ9GzIefC2NE1Wc9RCRd/dptcFJJgDz2ghqblRzlIfsUmtGQniVxcjw4
 8lOfUgWqxA+ltVIXYaFEzZKKo8BGDeVgF5hil3sn7LwO37UM4R4JEtL3CDAs5deIMXNUUyDZJ46
 bH7bcFxXb6Z/cG9Q/Ju62WPMus5oiQSl9FFMLAEaxO/jTNdfWpNBpyHYcWhJN4f3IGMxeUuiC6E
 zQ2aBWIdFVu3qPA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

There are no Samsung Exynos SoC ADC driver users which bind via platform
ID, thus platform data is never set and can be dropped.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v2:
1. Drop touchscreen-s3c2410.h
---
 drivers/iio/adc/exynos_adc.c                      | 11 +----------
 include/linux/platform_data/touchscreen-s3c2410.h | 22 ----------------------
 2 files changed, 1 insertion(+), 32 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 30f6d8436e775a8d2177951b436cd45152307ea2..d21a9f3621d96c8051f2062aa6a069e8c29faf9b 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -29,8 +29,6 @@
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 
-#include <linux/platform_data/touchscreen-s3c2410.h>
-
 /* S3C/EXYNOS4412/5250 ADC_V1 registers definitions */
 #define ADC_V1_CON(x)		((x) + 0x00)
 #define ADC_V1_DLY(x)		((x) + 0x08)
@@ -106,7 +104,6 @@ struct exynos_adc {
 	struct clk		*clk;
 	struct clk		*sclk;
 	unsigned int		irq;
-	unsigned int		delay;
 	struct regulator	*vdd;
 
 	struct completion	completion;
@@ -213,7 +210,7 @@ static void exynos_adc_v1_init_hw(struct exynos_adc *info)
 	writel(con1, ADC_V1_CON(info->regs));
 
 	/* set touchscreen delay */
-	writel(info->delay, ADC_V1_DLY(info->regs));
+	writel(10000, ADC_V1_DLY(info->regs));
 }
 
 static void exynos_adc_v1_exit_hw(struct exynos_adc *info)
@@ -556,7 +553,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
 {
 	struct exynos_adc *info = NULL;
 	struct device_node *np = pdev->dev.of_node;
-	struct s3c2410_ts_mach_info *pdata = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = NULL;
 	int ret;
 	int irq;
@@ -657,11 +653,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	if (info->data->init_hw)
 		info->data->init_hw(info);
 
-	if (pdata)
-		info->delay = pdata->delay;
-	else
-		info->delay = 10000;
-
 	ret = of_platform_populate(np, exynos_adc_match, NULL, &indio_dev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed adding child nodes\n");
diff --git a/include/linux/platform_data/touchscreen-s3c2410.h b/include/linux/platform_data/touchscreen-s3c2410.h
deleted file mode 100644
index bf8d3b9d7c6a98fc2392786df2c0cdf128047645..0000000000000000000000000000000000000000
--- a/include/linux/platform_data/touchscreen-s3c2410.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2005 Arnaud Patard <arnaud.patard@rtp-net.org>
-*/
-
-#ifndef __TOUCHSCREEN_S3C2410_H
-#define __TOUCHSCREEN_S3C2410_H
-
-struct s3c2410_ts_mach_info {
-	int delay;
-	int presc;
-	int oversampling_shift;
-	void (*cfg_gpio)(struct platform_device *dev);
-};
-
-extern void s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *);
-extern void s3c64xx_ts_set_platdata(struct s3c2410_ts_mach_info *);
-
-/* defined by architecture to configure gpio */
-extern void s3c24xx_ts_cfg_gpio(struct platform_device *dev);
-
-#endif /*__TOUCHSCREEN_S3C2410_H */

-- 
2.48.1


