Return-Path: <linux-iio+bounces-17729-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B012A7D625
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 09:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AEC81893DBE
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 07:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A2322A4CC;
	Mon,  7 Apr 2025 07:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Mc4JEn/j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AF222A1D4
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 07:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744010747; cv=none; b=ps1JCsjYZbH2sG0QKOGHAzvHYnBh4GPOvLJkHncuISd7IQpRI0vRVW9AE1592BJMei8z0ReICguaApALVWjNA4lpVmnbepOqKb+S+Ocd3QKzqXi/jodpD4J4WbKGnFLfNaGXkd8tYKTRNvI61Kzjaza+vgSX+RPdk/kG2mRCsX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744010747; c=relaxed/simple;
	bh=5kdF5oVUy/yps6X9BImufh8OuKxxdQ4BjJ7Qv2H6pxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tr9cbApbQribCsCj4AmBF3QW6/RYsJYn7mjLwzfnW7tbzbu8WEHKGOzdL7bFRQ/3PMHSQzkq7Fz25nf35yIOTr3dG0wL+pxJdGD/STZ41bFftnTrxH1nFLeDt95dpiQeDrMSQfx7TdC1p4sQxmwsTtTCzE30lhIvEpzd5KDURq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Mc4JEn/j; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54c0fa6d455so4883917e87.1
        for <linux-iio@vger.kernel.org>; Mon, 07 Apr 2025 00:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1744010744; x=1744615544; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/lQSP02uZhzaqZfFDZ+bFMWR2NaVs5b5QtoM2HpE7Y=;
        b=Mc4JEn/jaH4+byKmTOfYr7sZYeQTiFpoDkDfNbEYtx57ntC7WJAGuzhhEJj4B0l5N7
         7pVWEQBsYWfl4c3XuB3pquMkCR7MKzg/ghZe22tVcxkiZ0J/MIbTfo6DYDqgR/sjfld3
         Zr3YHkLaSt/+gWe6u2UrFYv4TCCFNKXLvJYf5xxqgYvF7PH/ZZOtCPxia4KczhzKmEoT
         6zVunA4NYxZ8xng4CsCLt/QxZkg/UNIqUuAwvrueXRkotq22wyVwRYMO3vPB07ZO0y20
         uTgs5BIMiJ8o1CiGTaZIUnF7i+m0HRZXwghk7B8teOA1GCTVgPuNB1ExvH3lm37zT+V2
         YG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744010744; x=1744615544;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/lQSP02uZhzaqZfFDZ+bFMWR2NaVs5b5QtoM2HpE7Y=;
        b=kk0e2VRXCecF4BwVe00Ftjzldig4QlHCT7lDxaN0s+ws5vdbsT3+zLqg2CFFPD91Kh
         h9DfA3E6eeD3YAR17+mnQ8RxgNXclzssdkvdg1f65mr1UatcGlcOVN3QV/DcAz8fV6WX
         qTa+sj4rRztxbyEophF8oSPr7evnRjLhInJeAgNo/PqQ2IeK0QzlOmjPXGPwTn3XQIOG
         MFZn9eb04pFnsOOHs1ixTrZCgnAzERtcJUiKb8YbpMdzaI4vJ48KAaTAGbBVMaFBx4GA
         VaiBKg81vArWwyO/IgImOlVdd0XPL65a9Eyu34Y1NOtn4krzpgk4py/l0ORGt6E6yQSN
         rvKg==
X-Gm-Message-State: AOJu0Yw05yOsO6KWn2ECUlkdah4eN6WbH2uJ1B0f//2/HCDpROO5bfPI
	qR9FSoRxnFbFIAHx8fetbRqwX/nR/Tp6xzztNaVo4wHsaK5Tf5EmPU6ioZqRvWkLq71e1znf+uk
	uyb4=
X-Gm-Gg: ASbGnctbz+UyIhhBC9o13NSA46VQpsREOZ8v7RcigQm80+DXfCjltiBkK0QWtD8o+vY
	tNhj/8fSIOPJMPZTNcdFlHOBoyxC64VoHJWwars00Tm1++tdbPR4Xai2336/VHJWtcunrWgeZ0i
	npZ46Sqcv9sbCHtsE/y2PVP2T1P/yGg9SDY2lKkT5LpLHtskLG7zZYHrSbzEZmotvb1ausXGF4s
	pqIf7zUVpq+tD9lGusxq+emc67zrvwSyWuuQMmmNFcuvKa9o4jyVFOXsP2liv5fq7YeObKFe9J7
	dtN3dMv1WT1yILHeroEId0bzPPsjjsE3oJpR2K4zKlO8edsR
X-Google-Smtp-Source: AGHT+IHZJ6eZKGM0X4E3G3AiVSKpRFA9oT3UOJNHqKpzBidSstN5tYKbajNmdPvNjyMO/2yji8ci1g==
X-Received: by 2002:a05:600c:4f0e:b0:43b:c0fa:f9dd with SMTP id 5b1f17b1804b1-43ecf9c3224mr81160555e9.25.1744010300476;
        Mon, 07 Apr 2025 00:18:20 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:8c64:734d:705a:39a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1630f21sm125224455e9.8.2025.04.07.00.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 00:18:20 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 07 Apr 2025 09:18:15 +0200
Subject: [PATCH 7/7] iio: addac: ad74115: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-gpiochip-set-rv-iio-v1-7-8431b003a145@linaro.org>
References: <20250407-gpiochip-set-rv-iio-v1-0-8431b003a145@linaro.org>
In-Reply-To: <20250407-gpiochip-set-rv-iio-v1-0-8431b003a145@linaro.org>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1869;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=GM/OUTdtJwVfHBffPnM20PvdLToT9f+xlEL0CqiIT9o=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBn83w0zT2RcvbxxdDl95J1of6Esp1CJCtG4NnBT
 9KjTKwWSzGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ/N8NAAKCRARpy6gFHHX
 cuv7D/wJ8rQB9Y9DlVg0wZNX4DBaBKetOrAncRCE3OlQmy2QTip8kUA5d2j0dZOLtaYHSuznZ5Y
 ADpgEA95zc1bdV+9kVNSlvEL3nek/u4FYhCBOq7JyMHxGw7BzrS5yGEClJBcswxBIVyZcuMsLK2
 qN93D+ck9WHRZBZE8U8RSOnGXfPUgFTRMSvDOp6DkGPOFfNYauVIudkYRurEjPHNyoezOEQwjxF
 ymy7wzw+lx0gvHkiCXF1LmnmL/e/j2tvJ9XO11pT9tmabmgyMMUaJI6sL+N3N2oLPq/ma+1fLc0
 BnSQks+2lCnB+XVkUTahI+AB+IuIW3yifmZGt3cxK82Wcnjhf2uXswwx8p8W/zCq91/P1rc5L5C
 OCLyH2t3VJMdgkT+qm5LM+RaLkS/Xuq1JYGj/fWtiQy210zvBS32EghCDXv371F1DL4CS5KgtzO
 p/hRzaa6j4vd6MSG8NwXNImPXTUQqIvbdV+DENtr/RYKX8PXmky3LRt5MOvxjtP0x1EUw12SUSL
 ARiECEfbnshwoV1PZN9yywQMSDV3iKFs2vUcSF/5LkHqRa7NDni5yZOlHqWguvxcsxT0Zspi+OV
 VhrRnAS/zN1qr+lqepcZa8lDehr40lw0wA3gKwdz8haFRXS0asf24nMmq9uvTLBL1aRPJQGnuYt
 Gw4w2DyrGQIBw6w==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/iio/addac/ad74115.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
index a7e480f2472d..2a809e07526b 100644
--- a/drivers/iio/addac/ad74115.c
+++ b/drivers/iio/addac/ad74115.c
@@ -542,18 +542,16 @@ static int ad74115_gpio_get(struct gpio_chip *gc, unsigned int offset)
 	return FIELD_GET(AD74115_GPIO_CONFIG_GPI_DATA, val);
 }
 
-static void ad74115_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
+static int ad74115_gpio_set(struct gpio_chip *gc, unsigned int offset,
+			    int value)
 {
 	struct ad74115_state *st = gpiochip_get_data(gc);
-	struct device *dev = &st->spi->dev;
-	int ret;
 
-	ret = regmap_update_bits(st->regmap, AD74115_GPIO_CONFIG_X_REG(offset),
-				 AD74115_GPIO_CONFIG_GPO_DATA,
-				 FIELD_PREP(AD74115_GPIO_CONFIG_GPO_DATA, value));
-	if (ret)
-		dev_err(dev, "Failed to set GPIO %u output value, err: %d\n",
-			offset, ret);
+	return regmap_update_bits(st->regmap,
+				  AD74115_GPIO_CONFIG_X_REG(offset),
+				  AD74115_GPIO_CONFIG_GPO_DATA,
+				  FIELD_PREP(AD74115_GPIO_CONFIG_GPO_DATA,
+					     value));
 }
 
 static int ad74115_set_comp_debounce(struct ad74115_state *st, unsigned int val)
@@ -1580,7 +1578,7 @@ static int ad74115_setup_gpio_chip(struct ad74115_state *st)
 		.direction_input = ad74115_gpio_direction_input,
 		.direction_output = ad74115_gpio_direction_output,
 		.get = ad74115_gpio_get,
-		.set = ad74115_gpio_set,
+		.set_rv = ad74115_gpio_set,
 	};
 
 	return devm_gpiochip_add_data(dev, &st->gc, st);

-- 
2.45.2


