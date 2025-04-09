Return-Path: <linux-iio+bounces-17861-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CA4A8205C
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 10:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779BB421A81
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 08:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F83125C71A;
	Wed,  9 Apr 2025 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="a7DwWriq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766F525DB03
	for <linux-iio@vger.kernel.org>; Wed,  9 Apr 2025 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744188058; cv=none; b=Zh4d5YWtlV3OVhekPzd59l6zG/25ZNTX/oyUgiLP7sMx6iJ7HCw2/2B2I4D+AVYkT2/XCOqLNJBdjhwMTrfMmL1684c9BKp0ne5rfQ+F8YZXtLpK4yLuGBMr4vNE+dEiG7vHMmW+5doH2x7pFG+++Q83v0wjVhheezdoMvYrzX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744188058; c=relaxed/simple;
	bh=5kdF5oVUy/yps6X9BImufh8OuKxxdQ4BjJ7Qv2H6pxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BCqMbiR3vmO3bqSECtvzNM+VpNipqZI6Y6hZ29M8Zd6/wUo2TTsXMsmhQr9FY3rl5y+dLv+f5Nb78UkKxYVlrym7I2c0f7IJq6xsFYilUrZzUCoYpMgh0kHaqHT8VAKMHNSvgzFJ5El13elpp7rDeatANjjSWVkzXzhDzfkrVg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=a7DwWriq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso59835155e9.1
        for <linux-iio@vger.kernel.org>; Wed, 09 Apr 2025 01:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1744188054; x=1744792854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/lQSP02uZhzaqZfFDZ+bFMWR2NaVs5b5QtoM2HpE7Y=;
        b=a7DwWriq7SA9IP07wBkGlbj2ecfCCciZhMRHFI9RnVowC/12yGyANaSrGpPFiIaB2c
         RdJb5gGQ6UvpVm/6oFukZSYJNHXOnAM4dHx5XNrZmH2LGULyuer4pDD9WT9k0wX1AuV+
         Zo/x6C0Z0wKPTweyOs5yhFfsRb6teyRSBGH+vx02q+hsJAqP+iox9lsYjJpM7H1zlWvA
         TddcvvX9Std4TraFeCSRuh22Id4rTjYn/fdyjhDzcyJmif/gqADKQyeGpUbfQbqYPzhR
         p0M7z0uWNEyX9blmJXGb+iN9F5PLevQ8Oa05GLkPn3jBCL6c3tsdgHfeRPRfJNJS9QXg
         yTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744188054; x=1744792854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/lQSP02uZhzaqZfFDZ+bFMWR2NaVs5b5QtoM2HpE7Y=;
        b=jOWu426KeLyUv0LnjDh6wp7bNh5Iw+uiOleoM2RUwvfXkmxTyKgpLUSdxZXSLNsuDp
         A59eDmT+dVXI7oRtANTaKcpE5ge6XXcijkMw2PhLaLUX00vLTtLj2cWXRb8bQxugxz03
         j1zFANmmQ4Jq49NyiNfNd2Kaj49L7P1mw5zf9nL1wzNJ8bMLSGpYXy5+3JqisTfjw2dv
         wPYwPmHZgZNBX1BKgqpUc1/W1WvxYFT0jex8alLfwrw7igxc4VfVJPkI0zyI8hnGkCFI
         8EoT0RpLk5ZUYgkW+hN/zFYiW5OQ0fj89itewmJHk/1XsC9F8LhwcIgYoVyUNOUTBxEE
         /FlA==
X-Gm-Message-State: AOJu0YzOKd0GOEZZrEJeysT9FVSlLqMSs2HxS5iC3+6Z40burcdcgZuD
	KqI20B4zG686XchyAwG1VBAF9+tFxrPnAzqTge0bUATMuXEop7QVj6mFR5zKdGw=
X-Gm-Gg: ASbGncuUmoy4S9Bq96af+eGz24XL8CKXp4lRSJtw3lqUbdePcFLYZhtYGmih0r9FqrV
	uK5iyIMdK+Lh/8b/4fGPojWZkdmlupSWVHUnMqIAfYjJphkFn5PszRNdTUCF9yV90TyPzytp4+e
	kkfqmI0hhvELigVhJubDJ5iCCnYNdXUg7uPE3IjsnuVrGNk3EDG0TU/8dJCF4lNRTSVIL6SIXza
	k2ph3LiOtl+ahdoxq19LkjKqMwdEm4bKmFyrszlEbTu0dIFDFNEAHCi+ylzJ7zzKLOfdskm7xa+
	AjsaYBzoxKZoivmqxdH4KtCngh0m2PGy1w==
X-Google-Smtp-Source: AGHT+IG8LQlB/qJ4dprLDxOBQIbHnBXUqk5P+Akfq9rXwsoYQVM14BJpyBXYL2o8LGSSr/sh82IgJg==
X-Received: by 2002:a05:600c:3b8f:b0:43c:ec28:d31b with SMTP id 5b1f17b1804b1-43f1fe16c7dmr15845665e9.10.1744188053670;
        Wed, 09 Apr 2025 01:40:53 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:7880:1c3f:3ac3:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c8219sm8726235e9.21.2025.04.09.01.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 01:40:53 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 09 Apr 2025 10:40:45 +0200
Subject: [PATCH v2 7/7] iio: addac: ad74115: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-gpiochip-set-rv-iio-v2-7-4b36428f39cb@linaro.org>
References: <20250409-gpiochip-set-rv-iio-v2-0-4b36428f39cb@linaro.org>
In-Reply-To: <20250409-gpiochip-set-rv-iio-v2-0-4b36428f39cb@linaro.org>
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
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBn9jKM+RDKnpk08jf6biIZ3iU+KYy4c1FpPVE9g
 ineY3ogU3uJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ/YyjAAKCRARpy6gFHHX
 crtWEADCEy9Fkv2WE4tKZ2plfQHL2JiepslTEmt6QhUmz6So59x/5RxyKgDu3LK85ixCUqiitQL
 3q7lufL7DXD2EX3Ai9owJsTIH+YHHC9pgD3o596P6gInTNQxn9derv4ukwZJOYhQ5IgAhzjzmpG
 ZT/fYog8HvtoUXTOYtZlmXKVoI23GIDf820V72btz1yz4Pp4HVspy3HALtUylwZpvLG7OvwpsCa
 oVkHg3j4j40BBqmkd7fWTCaNz6c0EdWVvtwL0VUEpuv5fWiL1kVtzznvCM7b7meTNE1lXjjS2hT
 4TLznQ3WjhVdFjmA329GHu9GBtPb2Y51r968yrfBQ7QcZiK+TjWq6+M5QRntMY/rMEkLN6uMzEC
 tzVRhY9HMzT5Gey6tto8zePpE03bgOdn2nkvV7M5PqbATGnKWKXda7Z4rd1lrANcU9ZyDklLAmf
 AokMsuxUbKxKpP9RfAjZKxZtZ5TcOroNFZTLY7qJWV6flXC4+Kglxe0Jd2Ook91qkuVtKBmSS3+
 QU7+Kcol9RRZV3pO+VABQvztImX3amgSer2m1HXZb/3yCutPB1PfnAbguPOGHbiWnETKr69q7nc
 vHr6TCmvDKeYRdTxJkZrgwLQ76O7CLQVK2pcJmwvKeGIBFLdeq3VTJjO8siiK/8+tTGwogsTiob
 Z55amYSelPNeVUQ==
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


