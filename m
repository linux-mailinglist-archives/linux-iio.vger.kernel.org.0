Return-Path: <linux-iio+bounces-12563-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540149D6BB2
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 23:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB9FBB2265B
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 22:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CE319F42F;
	Sat, 23 Nov 2024 22:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0KD3cLd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A66F1862A;
	Sat, 23 Nov 2024 22:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732399314; cv=none; b=h4q5Hg6KKZACu+Uhfg2i2sUoOuvuY5wjjac97uv8qtkhps0aiZl6sqtmp4MHVxNElnKro+eG/Qbc0ZtsNwHN6Yeeq7OgyZ1DLgB44ktT47WC6N2vzDm8Tsj3uBWPuoz6nWjxS7E2H5wn+fmb9aZvorVqMeV36Zp9Tho4q+Dy1j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732399314; c=relaxed/simple;
	bh=Qc7GgOVJTlNUqM4hrJsCVFiJ6WrhgFo+UtOX/oNgwZw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gr/cBbyPmDRbyJV8OU/ns362gm3cL4GXXMZcvRfPJ/Jacd2tuGLBAmVe+FgYUz4BKWA9ohCw7cqnwTeB5/SYGKSzAJw391FEE2w4zv8bld5nX3I/gqnaZddoEshOt8xf3y5jtuw4JYqRtp6BaS9QWXph3msMbKuLpNL90UUK1u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0KD3cLd; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d413def36cso25705026d6.3;
        Sat, 23 Nov 2024 14:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732399312; x=1733004112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sTXm56p8RBq1M4ykDPiGEs2Y+aiYwh8JuLxWApDmdM4=;
        b=k0KD3cLdF4cohcm0OQtvVxE4DQPRyHBApIxzTqUGbrq9FrHZtdZhiLFsCU/sYc/J3W
         MMm5bvycKqWTyaGD73bQzFEdK5zIPV76hbAHsoTMN0NNmE8y9zKNZhZoMcw/cwGmbBzB
         7DDJYN8w9dEQkA9da6GRnKZ8brAFW2AKqn+75tfK+CCsHZ0fYO/LOgt0CoDJDQrMP4fv
         QUNNa1qnz4GF0aVWxj+18i/vTa2CXk1zjOF5unSqJ8tLBJ84vgrwqrsHL/Wc2CTuXRA4
         A1IEoOXnOgdmMHmetaBlW8FnTCxEvctHH0nZa/3lwsqxVV6ep4C94+XpCzY9EISwh2cX
         tR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732399312; x=1733004112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTXm56p8RBq1M4ykDPiGEs2Y+aiYwh8JuLxWApDmdM4=;
        b=tz8JT5jvpyz2tVBYBrtLlv5Hjel4yUBYv7WJL5AYtEQl2z+SISL6OC3qSuhWPRSBmU
         Jfh7pXahZ1bx8BfWbBg/zhUkew80gtrmw6bjeNZC/hsv9mS3G+laOgCpLtzhz5oXs6Vu
         4I2jrQWyE3jXmutZdEHAKWejVKJ0im//prZ2pv/tc5jS1IxF7KwHKQVX5wtH5pDEDVu2
         HPHNcQujetdN78G7+82Dvt2ey/zJLebWZuS8p5FdSWK26LXO75T5Pxvi3nhHcyR1xRuq
         oGEM+BKCeO+Gon2cl7dZe5D0UgP4CZmnTxH2KMmgJN1sk2w8xyPFiM5iP9lT3hmcGTcn
         PSnw==
X-Forwarded-Encrypted: i=1; AJvYcCUIoyq5TcGFnKnb5qfRyVASk+VOxJaJYnftB+37z8EIgwutgCs/ougecpziZgx2zqVWDy/B3lA0fTc=@vger.kernel.org, AJvYcCVK696mjJ01FLJIft+r2pRMLN2uWMBekW9xadeFW4gkteP0E9eHpeDoJev3e6RaRs7+SJxUI6PZy4LPuKds@vger.kernel.org
X-Gm-Message-State: AOJu0YzGWpg4T5BHzL5t10Fjo6KLW47x7PTrY31dAS7tVVcVqixjN3BO
	XpKcZHLC79wwh594BiB71xHJN5vWI5IuWQkDJHTX02/oakDHvvkv
X-Gm-Gg: ASbGncuL4Z8uhu+0XUi2Gx8bNwPIh6aUjE3sJzcbF3zUKc7Jhli53YVG5AN7KdapLtY
	Pb9YLSIywk+6/4rYrGRtJDbKFtGGfQAmXfs4Zgh4KxMy/v3AXq7QpjZPgmGbieJI4Kwc+k/MDDx
	HZtuVGyuDsZqr+auh8eakB6MsVyKy/hiuxUlQQW56/FjDmbe2jqbOh35o6Y3E5ng3rM/96VJp6w
	rFDeVmK9Gn23+sJn2dtVFnywo9MOaJXLsMUgSHVFS+VqtXIDIPm4CMfvLyVhJX7XyWEzBBo
X-Google-Smtp-Source: AGHT+IHwaDfV1oVZjshMQqgput4KO/RhIrIMFQsBtq4zu1BHrnOtGbjeB/uPQuJ2P/Cp8Ar7T0Qjug==
X-Received: by 2002:a05:6214:19ef:b0:6d4:20fa:83f1 with SMTP id 6a1803df08f44-6d45134d114mr137061356d6.37.1732399312180;
        Sat, 23 Nov 2024 14:01:52 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451b4a0a5sm25789426d6.106.2024.11.23.14.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 14:01:51 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	lars@metafoo.de,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	u.kleine-koenig@baylibre.com,
	tgamblin@baylibre.com,
	fabrice.gasnier@st.com,
	benjamin.gaignard@linaro.org,
	lee@kernel.org,
	linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH v5] iio: trigger: stm32-timer-trigger: Add check for clk_enable()
Date: Sat, 23 Nov 2024 22:01:49 +0000
Message-Id: <20241123220149.30655-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add check for the return value of clk_enable() in order to catch the
potential exception.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v4 -> v5:

1. Add a default in the switch.

v3 -> v4:

1. Place braces around the case body.

v2 -> v3:

1. Use guard() to simplify the resulting code.

v1 -> v2:

1. Remove unsuitable dev_err_probe().
---
 drivers/iio/trigger/stm32-timer-trigger.c | 49 ++++++++++++++---------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 0684329956d9..67528ec7d0a5 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -119,7 +119,7 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 			     unsigned int frequency)
 {
 	unsigned long long prd, div;
-	int prescaler = 0;
+	int prescaler = 0, ret;
 	u32 ccer;
 
 	/* Period and prescaler values depends of clock rate */
@@ -150,10 +150,12 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 	if (ccer & TIM_CCER_CCXE)
 		return -EBUSY;
 
-	mutex_lock(&priv->lock);
+	guard(mutex)(&priv->lock);
 	if (!priv->enabled) {
 		priv->enabled = true;
-		clk_enable(priv->clk);
+		ret = clk_enable(priv->clk);
+		if (ret)
+			return ret;
 	}
 
 	regmap_write(priv->regmap, TIM_PSC, prescaler);
@@ -173,7 +175,6 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 
 	/* Enable controller */
 	regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
-	mutex_unlock(&priv->lock);
 
 	return 0;
 }
@@ -307,7 +308,7 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
 	struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
 	struct iio_trigger *trig = to_iio_trigger(dev);
 	u32 mask, shift, master_mode_max;
-	int i;
+	int i, ret;
 
 	if (stm32_timer_is_trgo2_name(trig->name)) {
 		mask = TIM_CR2_MMS2;
@@ -322,15 +323,16 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
 	for (i = 0; i <= master_mode_max; i++) {
 		if (!strncmp(master_mode_table[i], buf,
 			     strlen(master_mode_table[i]))) {
-			mutex_lock(&priv->lock);
+			guard(mutex)(&priv->lock);
 			if (!priv->enabled) {
 				/* Clock should be enabled first */
 				priv->enabled = true;
-				clk_enable(priv->clk);
+				ret = clk_enable(priv->clk);
+				if (ret)
+					return ret;
 			}
 			regmap_update_bits(priv->regmap, TIM_CR2, mask,
 					   i << shift);
-			mutex_unlock(&priv->lock);
 			return len;
 		}
 	}
@@ -482,6 +484,7 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 				   int val, int val2, long mask)
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -491,12 +494,14 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 		/* fixed scale */
 		return -EINVAL;
 
-	case IIO_CHAN_INFO_ENABLE:
-		mutex_lock(&priv->lock);
+	case IIO_CHAN_INFO_ENABLE: {
+		guard(mutex)(&priv->lock);
 		if (val) {
 			if (!priv->enabled) {
 				priv->enabled = true;
-				clk_enable(priv->clk);
+				ret = clk_enable(priv->clk);
+				if (ret)
+					return ret;
 			}
 			regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
 		} else {
@@ -506,11 +511,12 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 				clk_disable(priv->clk);
 			}
 		}
-		mutex_unlock(&priv->lock);
+
 		return 0;
 	}
-
-	return -EINVAL;
+	default:
+		return -EINVAL;
+	}
 }
 
 static int stm32_counter_validate_trigger(struct iio_dev *indio_dev,
@@ -601,7 +607,7 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
 				 unsigned int mode)
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
-	int sms = stm32_enable_mode2sms(mode);
+	int sms = stm32_enable_mode2sms(mode), ret;
 
 	if (sms < 0)
 		return sms;
@@ -609,12 +615,15 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
 	 * Triggered mode sets CEN bit automatically by hardware. So, first
 	 * enable counter clock, so it can use it. Keeps it in sync with CEN.
 	 */
-	mutex_lock(&priv->lock);
-	if (sms == 6 && !priv->enabled) {
-		clk_enable(priv->clk);
-		priv->enabled = true;
+	scoped_guard(mutex, &priv->lock) {
+		if (sms == 6 && !priv->enabled) {
+			ret = clk_enable(priv->clk);
+			if (ret)
+				return ret;
+
+			priv->enabled = true;
+		}
 	}
-	mutex_unlock(&priv->lock);
 
 	regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS, sms);
 
-- 
2.25.1


