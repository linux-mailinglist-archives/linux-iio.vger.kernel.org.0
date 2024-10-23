Return-Path: <linux-iio+bounces-11039-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D839AD8C1
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 01:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF3F2842B0
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 23:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083801FDFB6;
	Wed, 23 Oct 2024 23:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CpzOMGl8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A324D200138
	for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 23:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727685; cv=none; b=kL1Q8S+1hs2ebmKkmiTlusOiHmZCTii647NYRMthEwyxU8WG8Z5a4bv4lj8wDCsgc147OaXUIm3ypfyVhwRIQ+r5F9nTzgYOBg7xjT2HX9Le68INI4faMTNo2zgzDfJ1gmixXIGtZc+NglZ5WnInGQhLyDL4uS+72XcGKQPbjww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727685; c=relaxed/simple;
	bh=JtWsVW1/ip3tWEUoknaHJGDygDmPAYBD4bgqX9vG02Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tS/mQj+WBaKNzPZ87OF/mqzuHEGFFxC9GdsKdCIbp9EOC5j1zgzlZFlpPagZ0xCQkvHxpI7SrCSorb9OQWr7O4lnZobh77f7vXHo4JIxOITYy3RwsMhvH6PqrHDOf8e+NA7YBwSicX4WAQISAiJNKGCaNrzjV0CiQxJBLL/3Sv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CpzOMGl8; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7180d9d0dcbso173481a34.3
        for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 16:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729727683; x=1730332483; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11WZ5IF5KUkagJDeN3d2nVfidgojedjqvRS83nA7Gyo=;
        b=CpzOMGl8oBhdlSnTxb8e2+tfug+urxNZPDsTvSDP8Y2BTc1xDMVaI+AQ2TCltswb64
         5U3+2GQyI5o0BJqKuUszaFRufSGXcXue///V82qptpuaxK0vOfspCO7BMf5sdDE1zHVS
         8p+Se0p3AUJB4F76TbCWiXWrG0nG2akIHKawydlHBG1Qid4BU5CL49TFmWIR5WSPwuc/
         5nKWHCFoBf130W5ZIGW0TmnTIudb/TuPOY1HKcO+wudLGR6QxIKONxQU9PLv+z9USUOH
         6apP0YseakEuVfhkANHEQKrVgCjCBMru/+sv290cGBhPj63ZgBjesRTtbYVrbJXa1Fxn
         tIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729727683; x=1730332483;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11WZ5IF5KUkagJDeN3d2nVfidgojedjqvRS83nA7Gyo=;
        b=hRYdLlYbFXZdiJIfRaT8GAx5X7jG3fYbbLKqIp1s+2KnWOLLjnp1wxfRuUAmHDfQFQ
         3xq4QZmpCJwjtObxxjRcuqaXAwMwXIz0eGdrrKRA6UMDUpzB/5jwDtmP7VkD452vgqbJ
         e6uHnGi/RJuWRqzIwzTIMkbx+ILXbATc5+WoKi0Yl2flwBDMV5LobFevX0PD3bF2RtOa
         rmtBjlcTI9esVNkMZ99B0jpKHe69BMokmx9WEgQfpquUrqJo91Fv38zkDVc+ahyTgQGR
         xIsAiL6BCBxdsHubNvNvaEAuC3b4pcrhIpALx8bJYsdSpO3p+rGN7CPgJifc1CR36hTA
         de8w==
X-Forwarded-Encrypted: i=1; AJvYcCXWnW4btBCjRxk0GKN2v5htPhrckJiejjRpHMlOdMVFvg2+rmk83qPkZUNPL81zmEX4QD33Azu/irs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ZN+olEhWumIJkV4iHmKcvjhUdQlB93II/HuZIfdfmALf7V2o
	6ynNFXI6ZIYsGzMth5JbogbjwHkAhuPkqczFFwgC4HEoymdfjS2pAQgWt3ekIfY=
X-Google-Smtp-Source: AGHT+IHPtJ7lzyKKMxRzAqXtGDZhRStmKcjf90mmLH4koSMdK6Z/hi1YrpCJ0SuS0YG7xtlRaOdYZw==
X-Received: by 2002:a05:6830:314c:b0:715:4e38:a1ab with SMTP id 46e09a7af769-7184b32308bmr4590372a34.22.1729727682667;
        Wed, 23 Oct 2024 16:54:42 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2b25bsm132002eaf.39.2024.10.23.16.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 16:54:41 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 18:54:06 -0500
Subject: [PATCH 02/11] iio: dac: ad5380: drop driver remove callbacks
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-iio-regulator-refactor-round-5-v1-2-d0bd396b3f50@baylibre.com>
References: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
In-Reply-To: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Drop use of the driver remove callbacks in the ad5380 driver.

By making use of a few more devm_ helpers, we can avoid the need for
remove callbacks entirely.

Also make use of dev_err_probe() while at it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad5380.c | 61 +++++++++++-------------------------------------
 1 file changed, 13 insertions(+), 48 deletions(-)

diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index 7d1d7053c29e..392a1c7aee03 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -339,14 +339,14 @@ static const struct ad5380_chip_info ad5380_chip_info_tbl[] = {
 	},
 };
 
-static int ad5380_alloc_channels(struct iio_dev *indio_dev)
+static int ad5380_alloc_channels(struct device *dev, struct iio_dev *indio_dev)
 {
 	struct ad5380_state *st = iio_priv(indio_dev);
 	struct iio_chan_spec *channels;
 	unsigned int i;
 
-	channels = kcalloc(st->chip_info->num_channels,
-			   sizeof(struct iio_chan_spec), GFP_KERNEL);
+	channels = devm_kcalloc(dev, st->chip_info->num_channels,
+				sizeof(struct iio_chan_spec), GFP_KERNEL);
 
 	if (!channels)
 		return -ENOMEM;
@@ -377,7 +377,6 @@ static int ad5380_probe(struct device *dev, struct regmap *regmap,
 	}
 
 	st = iio_priv(indio_dev);
-	dev_set_drvdata(dev, indio_dev);
 
 	st->chip_info = &ad5380_chip_info_tbl[type];
 	st->regmap = regmap;
@@ -389,20 +388,16 @@ static int ad5380_probe(struct device *dev, struct regmap *regmap,
 
 	mutex_init(&st->lock);
 
-	ret = ad5380_alloc_channels(indio_dev);
-	if (ret) {
-		dev_err(dev, "Failed to allocate channel spec: %d\n", ret);
-		return ret;
-	}
+	ret = ad5380_alloc_channels(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to allocate channel spec\n");
 
 	if (st->chip_info->int_vref == 2500)
 		ctrl |= AD5380_CTRL_INT_VREF_2V5;
 
 	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
-	if (ret < 0 && ret != -ENODEV) {
-		dev_err(dev, "Failed to get vref voltage: %d\n", ret);
-		goto error_free_reg;
-	}
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "Failed to get vref voltage\n");
 	if (ret == -ENODEV) {
 		st->vref = st->chip_info->int_vref;
 		ctrl |= AD5380_CTRL_INT_VREF_EN;
@@ -411,32 +406,14 @@ static int ad5380_probe(struct device *dev, struct regmap *regmap,
 	}
 
 	ret = regmap_write(st->regmap, AD5380_REG_SF_CTRL, ctrl);
-	if (ret) {
-		dev_err(dev, "Failed to write to device: %d\n", ret);
-		goto error_free_reg;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to write to device\n");
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(dev, "Failed to register iio device: %d\n", ret);
-		goto error_free_reg;
-	}
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register iio device\n");
 
 	return 0;
-
-error_free_reg:
-	kfree(indio_dev->channels);
-
-	return ret;
-}
-
-static void ad5380_remove(struct device *dev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-
-	iio_device_unregister(indio_dev);
-
-	kfree(indio_dev->channels);
 }
 
 static bool ad5380_reg_false(struct device *dev, unsigned int reg)
@@ -470,11 +447,6 @@ static int ad5380_spi_probe(struct spi_device *spi)
 	return ad5380_probe(&spi->dev, regmap, id->driver_data, id->name);
 }
 
-static void ad5380_spi_remove(struct spi_device *spi)
-{
-	ad5380_remove(&spi->dev);
-}
-
 static const struct spi_device_id ad5380_spi_ids[] = {
 	{ "ad5380-3", ID_AD5380_3 },
 	{ "ad5380-5", ID_AD5380_5 },
@@ -501,7 +473,6 @@ static struct spi_driver ad5380_spi_driver = {
 		   .name = "ad5380",
 	},
 	.probe = ad5380_spi_probe,
-	.remove = ad5380_spi_remove,
 	.id_table = ad5380_spi_ids,
 };
 
@@ -543,11 +514,6 @@ static int ad5380_i2c_probe(struct i2c_client *i2c)
 	return ad5380_probe(&i2c->dev, regmap, id->driver_data, id->name);
 }
 
-static void ad5380_i2c_remove(struct i2c_client *i2c)
-{
-	ad5380_remove(&i2c->dev);
-}
-
 static const struct i2c_device_id ad5380_i2c_ids[] = {
 	{ "ad5380-3", ID_AD5380_3 },
 	{ "ad5380-5", ID_AD5380_5 },
@@ -574,7 +540,6 @@ static struct i2c_driver ad5380_i2c_driver = {
 		   .name = "ad5380",
 	},
 	.probe = ad5380_i2c_probe,
-	.remove = ad5380_i2c_remove,
 	.id_table = ad5380_i2c_ids,
 };
 

-- 
2.43.0


