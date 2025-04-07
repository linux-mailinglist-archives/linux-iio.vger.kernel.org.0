Return-Path: <linux-iio+bounces-17724-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A03E9A7D58D
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 09:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FEE6175514
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 07:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F84322A4FE;
	Mon,  7 Apr 2025 07:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YkbkOu9+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED96F22D798
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 07:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744010299; cv=none; b=jVRH6B9vfo+QLsphYyHT8lgeNddbBN0MmOGAqVi4d53qrEQcqJmjE60M3O8KYW+HCRcpRsQ87leDcY9cT/+/tB959B426o8FJTBLR8jD1C2CzpSig0+lbTKowQgA8mgfRUHBlyCOpuquNgSgjcU1dwSyZGjgYYVBmoByEY4w0NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744010299; c=relaxed/simple;
	bh=zj5ug8ovlw9ZHzpl55Bg/sdI8fliJrYCQ7ucoIA4J1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qWrWCDNVC4LvInTaXWKTJM7tI5CFoUkGCbYAjB920gdkLEnHU2iiUqeNaSae3LNKf258rId0NuAOrdS2PABZydl4J9d48YLEe5yxcnzsNAMN4iE2PEBOdAP0SMKJ+0oLGHnH13YaTY5JARWoMYVrM6QaLb/dZC1VpNiPz/Vbvsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YkbkOu9+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso36713395e9.1
        for <linux-iio@vger.kernel.org>; Mon, 07 Apr 2025 00:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1744010295; x=1744615095; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xERYxzCdXFfBQqpEHcpUJZIcd8NycAIVtZHrNbldPXo=;
        b=YkbkOu9+gUfz5sHPnxvAqEDd2ngzGo0eV4eP2LA0aBXhzE5oL2ByezBTbJnksq2WeE
         g1bfMjo962y0OuOSYZjUkcV6r3gLIiYCtp12qgo1oStqTQ4l/BAboJH06FFWpYv6r4Gz
         5wJJBJHITpCOQvkzvKsQSYZ4mYTP3T9hZ7YYb85YfYIO5pdKLuA+B/blL9F3lDm2J8G2
         vOqk7HgUhZ6h+v0TzHrKRQcUsO8T1l/KvGWr08nfLgsXCusxgwmTO7Canc7iqjg86vMi
         AfQ8QImmaUcZTyVFnYat5vHal/Vx5DmDNjYijDm3aD8Rl4qo2VIHiw6vbXVVHMjj8KzP
         51oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744010295; x=1744615095;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xERYxzCdXFfBQqpEHcpUJZIcd8NycAIVtZHrNbldPXo=;
        b=tw2Yj8azvPbpI6/5oos07BuCoGL+mpqYirybSEq1pjU40rTmup+5yHvG3iotpsLiI6
         lwKspX3gBZFNoiUp1yjUNiYr0vR7qVjcaYB2op0O46xVQaUwA3WJSYXGLYiWxnnIOxZ6
         T18Fp/QC4Hftuat9jwzR0vM/tQQRsK4+6iD8+UHKWkQ8JQ5QwImpn3/OdAf8RpM1QoHa
         z2DDGIka/lSdMwXf+tS2NWcXFV+CMm6eC9DpJbNKodQY78kx81PpISeTdyGkQme2Fy1d
         LFFYw8f0rvrtkcUDKXo71jY/VC+CyP06egI8xtDcZcVIiiuDOADiSv/dtUA+mZqevqKQ
         gPMA==
X-Gm-Message-State: AOJu0YzpN8uqZ4vfLJJHtBje+opKSPHBdSZfSdXgc51R4p7BoHOrivEd
	Kub0mSwN0qbBspItB/1MRUGHCQcdkULgo3AruEw3zucV0NLLKrRXRKRFcIxTF+M=
X-Gm-Gg: ASbGncsGYWmartRNtQEbf87ILh7DRG3YOlZHbhXmokb3Vo7bm2lImXUBbKiuTSc9+ql
	yB/KGPyMNCcsWga2xEQUrKJ6xknlkOx3QS/6ojgdYQuQ8TZ32BeDbpRfZgc5lL9sfD553swoPgJ
	0+MuVdJaGQneFcUaj78AV+L+6s+uWY/VI7PHfcyOCA6PglzrG7lSMINqxLPLmT8yZo8kAsX7SJ0
	rcOeWM5xDmGVc/o23m/M6oBAPptEBf8erN02bqC7FyJD90VmdQPE7zVbBMYqSe+wAkPXmu1X4Zi
	8LZJ77eNlSXQnks5gmc183BqUObgVaMjKrHMFA==
X-Google-Smtp-Source: AGHT+IFtRwblBwIEchtvA8k1duTNZwKxIZCvCCS+rybE1gUfbu8eZ5wc9Hm4N7OETrLYq1shI7lMyg==
X-Received: by 2002:a05:600c:848d:b0:43c:f969:13c0 with SMTP id 5b1f17b1804b1-43ecfa1874emr97612425e9.29.1744010295108;
        Mon, 07 Apr 2025 00:18:15 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:8c64:734d:705a:39a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1630f21sm125224455e9.8.2025.04.07.00.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 00:18:14 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 07 Apr 2025 09:18:10 +0200
Subject: [PATCH 2/7] iio: dac: ad5592r: use lock guards
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-gpiochip-set-rv-iio-v1-2-8431b003a145@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8324;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=2uyDg2/H9YP2L1NNh1G5LpCHDDV8ztorbvs/2/ecsX4=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBn83wy4EKKAN4IT+1wGpxG8/g59bpkVKrkrSsHo
 anjZ3dgIoWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ/N8MgAKCRARpy6gFHHX
 cuASEACJFjDu9M7qv5gdKRWtmCsVlBsr60Jlm4BBEqONkXR+siD7+/XLoWtl+eUmVN/0u5mOJ0L
 tMapa/tA2lJVSR5Z0e5onE37TIgk9IB7rMDr7uv2LS9x9HQnbqN8okLJKDe8MSivhJZjo8G76+v
 C7wsxYInkHGAwxLu9OWXqTqbRQtpdpTxOExpy4i8QA73SfdXaRnQgMimfqHY/Jx6DhTnhfuQPAP
 YmJyc2uaQ4ijREHovqMKjbDJhqD4RY8OepQoKYxYhvqTSDj4YtVr/HHUXjQZlC9gdcVVPHnKiRZ
 52i07IKFULK6d70Sj/kQ2zsNS5OT8QGfDIjlopJ9D8oaywhllmndXQiO7TgJqNmuPbR7wXbxhMg
 Td1XCvwqp4FD2EixWUMpjR1fPa5CBE/aCKxj/j/9s/KOOerZtL+ugv5rUnAnldwShHhByP/PgeD
 VztS6VfQDe6+DVlsaQz4n3oP02o/dRyXVyTOtRtnpbMYG9L0sn4/zznjp0NZM8/xdPVwF0hTP+Y
 DcS3YTzB3Ksd9zrjSySZy/MJbJTzvYgbviQFWMKz14I1wvM7ccoEfhQlXaoX1AOY/hbUm0UJrpt
 jtDvJvAPY+vfEpPcW8m+vOFN7QmodINivWh6vRER80kWoP3ngF3LDeuigtOvDIe8ZNi/qSPqykm
 lzm3OLjDsqXOVpw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use lock guards from linux/cleanup.h to simplify the code and remove
some labels.

Note that we need to initialize some variables even though it's not
technically required as scoped_guards() are implemented as for loops.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/iio/dac/ad5592r-base.c | 119 ++++++++++++++++-------------------------
 1 file changed, 47 insertions(+), 72 deletions(-)

diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index fe4c35689d4d..bbe3b52c6a12 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
 #include <linux/module.h>
@@ -24,16 +25,14 @@ static int ad5592r_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct ad5592r_state *st = gpiochip_get_data(chip);
 	int ret = 0;
-	u8 val;
+	u8 val = 0;
 
-	mutex_lock(&st->gpio_lock);
-
-	if (st->gpio_out & BIT(offset))
-		val = st->gpio_val;
-	else
-		ret = st->ops->gpio_read(st, &val);
-
-	mutex_unlock(&st->gpio_lock);
+	scoped_guard(mutex, &st->gpio_lock) {
+		if (st->gpio_out & BIT(offset))
+			val = st->gpio_val;
+		else
+			ret = st->ops->gpio_read(st, &val);
+	}
 
 	if (ret < 0)
 		return ret;
@@ -45,7 +44,7 @@ static void ad5592r_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct ad5592r_state *st = gpiochip_get_data(chip);
 
-	mutex_lock(&st->gpio_lock);
+	guard(mutex)(&st->gpio_lock);
 
 	if (value)
 		st->gpio_val |= BIT(offset);
@@ -53,8 +52,6 @@ static void ad5592r_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 		st->gpio_val &= ~BIT(offset);
 
 	st->ops->reg_write(st, AD5592R_REG_GPIO_SET, st->gpio_val);
-
-	mutex_unlock(&st->gpio_lock);
 }
 
 static int ad5592r_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
@@ -62,21 +59,16 @@ static int ad5592r_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 	struct ad5592r_state *st = gpiochip_get_data(chip);
 	int ret;
 
-	mutex_lock(&st->gpio_lock);
+	guard(mutex)(&st->gpio_lock);
 
 	st->gpio_out &= ~BIT(offset);
 	st->gpio_in |= BIT(offset);
 
 	ret = st->ops->reg_write(st, AD5592R_REG_GPIO_OUT_EN, st->gpio_out);
 	if (ret < 0)
-		goto err_unlock;
+		return ret;
 
-	ret = st->ops->reg_write(st, AD5592R_REG_GPIO_IN_EN, st->gpio_in);
-
-err_unlock:
-	mutex_unlock(&st->gpio_lock);
-
-	return ret;
+	return st->ops->reg_write(st, AD5592R_REG_GPIO_IN_EN, st->gpio_in);
 }
 
 static int ad5592r_gpio_direction_output(struct gpio_chip *chip,
@@ -85,7 +77,7 @@ static int ad5592r_gpio_direction_output(struct gpio_chip *chip,
 	struct ad5592r_state *st = gpiochip_get_data(chip);
 	int ret;
 
-	mutex_lock(&st->gpio_lock);
+	guard(mutex)(&st->gpio_lock);
 
 	if (value)
 		st->gpio_val |= BIT(offset);
@@ -97,18 +89,13 @@ static int ad5592r_gpio_direction_output(struct gpio_chip *chip,
 
 	ret = st->ops->reg_write(st, AD5592R_REG_GPIO_SET, st->gpio_val);
 	if (ret < 0)
-		goto err_unlock;
+		return ret;
 
 	ret = st->ops->reg_write(st, AD5592R_REG_GPIO_OUT_EN, st->gpio_out);
 	if (ret < 0)
-		goto err_unlock;
+		return ret;
 
-	ret = st->ops->reg_write(st, AD5592R_REG_GPIO_IN_EN, st->gpio_in);
-
-err_unlock:
-	mutex_unlock(&st->gpio_lock);
-
-	return ret;
+	return st->ops->reg_write(st, AD5592R_REG_GPIO_IN_EN, st->gpio_in);
 }
 
 static int ad5592r_gpio_request(struct gpio_chip *chip, unsigned offset)
@@ -171,10 +158,9 @@ static int ad5592r_reset(struct ad5592r_state *st)
 		udelay(1);
 		gpiod_set_value(gpio, 1);
 	} else {
-		mutex_lock(&st->lock);
-		/* Writing this magic value resets the device */
-		st->ops->reg_write(st, AD5592R_REG_RESET, 0xdac);
-		mutex_unlock(&st->lock);
+		scoped_guard(mutex, &st->lock)
+			/* Writing this magic value resets the device */
+			st->ops->reg_write(st, AD5592R_REG_RESET, 0xdac);
 	}
 
 	udelay(250);
@@ -249,45 +235,43 @@ static int ad5592r_set_channel_modes(struct ad5592r_state *st)
 		}
 	}
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	/* Pull down unused pins to GND */
 	ret = ops->reg_write(st, AD5592R_REG_PULLDOWN, pulldown);
 	if (ret)
-		goto err_unlock;
+		return ret;
 
 	ret = ops->reg_write(st, AD5592R_REG_TRISTATE, tristate);
 	if (ret)
-		goto err_unlock;
+		return ret;
 
 	/* Configure pins that we use */
 	ret = ops->reg_write(st, AD5592R_REG_DAC_EN, dac);
 	if (ret)
-		goto err_unlock;
+		return ret;
 
 	ret = ops->reg_write(st, AD5592R_REG_ADC_EN, adc);
 	if (ret)
-		goto err_unlock;
+		return ret;
 
 	ret = ops->reg_write(st, AD5592R_REG_GPIO_SET, st->gpio_val);
 	if (ret)
-		goto err_unlock;
+		return ret;
 
 	ret = ops->reg_write(st, AD5592R_REG_GPIO_OUT_EN, st->gpio_out);
 	if (ret)
-		goto err_unlock;
+		return ret;
 
 	ret = ops->reg_write(st, AD5592R_REG_GPIO_IN_EN, st->gpio_in);
 	if (ret)
-		goto err_unlock;
+		return ret;
 
 	/* Verify that we can read back at least one register */
 	ret = ops->reg_read(st, AD5592R_REG_ADC_EN, &read_back);
 	if (!ret && (read_back & 0xff) != adc)
 		ret = -EIO;
 
-err_unlock:
-	mutex_unlock(&st->lock);
 	return ret;
 }
 
@@ -316,11 +300,10 @@ static int ad5592r_write_raw(struct iio_dev *iio_dev,
 		if (!chan->output)
 			return -EINVAL;
 
-		mutex_lock(&st->lock);
+		guard(mutex)(&st->lock);
 		ret = st->ops->write_dac(st, chan->channel, val);
 		if (!ret)
 			st->cached_dac[chan->channel] = val;
-		mutex_unlock(&st->lock);
 		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		if (chan->type == IIO_VOLTAGE) {
@@ -335,7 +318,7 @@ static int ad5592r_write_raw(struct iio_dev *iio_dev,
 			else
 				return -EINVAL;
 
-			mutex_lock(&st->lock);
+			guard(mutex)(&st->lock);
 
 			ret = st->ops->reg_read(st, AD5592R_REG_CTRL,
 						&st->cached_gp_ctrl);
@@ -360,11 +343,8 @@ static int ad5592r_write_raw(struct iio_dev *iio_dev,
 						~AD5592R_REG_CTRL_ADC_RANGE;
 			}
 
-			ret = st->ops->reg_write(st, AD5592R_REG_CTRL,
-						 st->cached_gp_ctrl);
-			mutex_unlock(&st->lock);
-
-			return ret;
+			return st->ops->reg_write(st, AD5592R_REG_CTRL,
+						  st->cached_gp_ctrl);
 		}
 		break;
 	default:
@@ -379,15 +359,15 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
 			   int *val, int *val2, long m)
 {
 	struct ad5592r_state *st = iio_priv(iio_dev);
-	u16 read_val;
-	int ret, mult;
+	u16 read_val = 0;
+	int ret = 0, mult = 0;
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
 		if (!chan->output) {
-			mutex_lock(&st->lock);
-			ret = st->ops->read_adc(st, chan->channel, &read_val);
-			mutex_unlock(&st->lock);
+			scoped_guard(mutex, &st->lock)
+				ret = st->ops->read_adc(st, chan->channel,
+							&read_val);
 			if (ret)
 				return ret;
 
@@ -400,9 +380,8 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
 			read_val &= GENMASK(11, 0);
 
 		} else {
-			mutex_lock(&st->lock);
-			read_val = st->cached_dac[chan->channel];
-			mutex_unlock(&st->lock);
+			scoped_guard(mutex, &st->lock)
+				read_val = st->cached_dac[chan->channel];
 		}
 
 		dev_dbg(st->dev, "Channel %u read: 0x%04hX\n",
@@ -420,16 +399,14 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
 			return IIO_VAL_INT_PLUS_NANO;
 		}
 
-		mutex_lock(&st->lock);
-
-		if (chan->output)
-			mult = !!(st->cached_gp_ctrl &
-				AD5592R_REG_CTRL_DAC_RANGE);
-		else
-			mult = !!(st->cached_gp_ctrl &
-				AD5592R_REG_CTRL_ADC_RANGE);
-
-		mutex_unlock(&st->lock);
+		scoped_guard(mutex, &st->lock) {
+			if (chan->output)
+				mult = !!(st->cached_gp_ctrl &
+					AD5592R_REG_CTRL_DAC_RANGE);
+			else
+				mult = !!(st->cached_gp_ctrl &
+					AD5592R_REG_CTRL_ADC_RANGE);
+		}
 
 		*val *= ++mult;
 
@@ -439,15 +416,13 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
 	case IIO_CHAN_INFO_OFFSET:
 		ret = ad5592r_get_vref(st);
 
-		mutex_lock(&st->lock);
+		guard(mutex)(&st->lock);
 
 		if (st->cached_gp_ctrl & AD5592R_REG_CTRL_ADC_RANGE)
 			*val = (-34365 * 25) / ret;
 		else
 			*val = (-75365 * 25) / ret;
 
-		mutex_unlock(&st->lock);
-
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;

-- 
2.45.2


