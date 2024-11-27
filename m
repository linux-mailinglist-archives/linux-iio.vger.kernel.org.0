Return-Path: <linux-iio+bounces-12743-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54089DAA49
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 16:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964D62818E8
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 15:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F941E1041;
	Wed, 27 Nov 2024 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ccsCnZGw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F083322F19
	for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732719623; cv=none; b=cbnWu/z5tWho9vzDYQIomT9dmvhHl4kNOQN/9UtkdU/vbKPn+sAF8nR3+Lt5n50H5gEaJ/iEt39pAQjmyjB00v0LlLysSOTFUge5mc3khCpO4xvVVzrTBh6nqkE9D39eJ8wHvlA1X766DKL3WfXY0qyQAryXsTYOWymYAOe9Xjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732719623; c=relaxed/simple;
	bh=yMC8oQsqpS+1AeWzQh+HkzdplhBqgZBlb2Nm13CGO5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bURYC0qtMyyb2LjXvkQiuV4YRFBQ3fs3vg2q9WpBNmCC7IUh10byCm8ITnIakmJ9sZ4lqBo/MQXnqtIWiBmCuaSHH/cri2dv76mHkQnO8znOfTaIQNcFPzrF0k37bgWWE/V5QkxzRp7k6Rae152iz4Lldc6VgWxt7OhaRiIyjsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ccsCnZGw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a0fd9778so27711435e9.0
        for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 07:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732719619; x=1733324419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Srg/Ufkkj8rWTSfunjRyWG6zErlFNDfrLKeOeqz39H4=;
        b=ccsCnZGwqT4VqbkGmVXvx3/OsAS4F6tD8SXZkQ2avjdPCyxgHA2M+VFn+1YyRaFH0v
         dGYQ7TIV8YymRdbB22hJ7mGbvKMMa2gIKFiCSCT3p1+/ciXf21DRcgOXzR83VZu5kEbd
         98N/ALn6lXXDDleyXWxwCnYghzsBENR5DbvZ2KOV4NAxewfh6DfZJo2DiK0BruAAUtr2
         Z0EsorKdLw6H6C6t5OZK4QGxDlbH85lXo9jLK67OUOkw6oeN3Igx3/tp7sLKmmiIJOuj
         T/k5hziN9RdD6dkRSiv79xnOlvrYFaNd7KVHYpj9tHAvg+t0fW1aSLCqgM6op5mOh+iy
         4b+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732719619; x=1733324419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Srg/Ufkkj8rWTSfunjRyWG6zErlFNDfrLKeOeqz39H4=;
        b=HxOclbibMp0rt7kzLGe/xTSh/OQydCnZ1G6yXpE1s2O6HMZSLdPAAZHKdskRsdl/CI
         qq6tUsdgEojlrzEj7VU9wPKKGg2PpWxYYR7iTZrYMBWeyCd8m0RJIrbVV6sh0NZlzduI
         IXosgYRC3kKejym6yWAyYpZqFqRxG1Z3yzxFU+hYbye0qsxpP+pBJ04l6qyyXo2/n+Z4
         SPrnxrWXbLqEdFGtqFGImTxinFSmlRWND0T2nJdolB2cx+2WSatQ3mp2kqDcndIC8OLT
         qFj7y69ePO6F7m3YOoN1rncwZ9H4383r5X9g7eB2vHrKAKOYeFpmVd6QGWyzPMghbkLD
         fHIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5sJu7DUKzlU0Yi18+SQVLWhfx6Dk+KoFjbsP45POH9cNykvOlO1U6KJYK4LJ5pnQqPfSj2Q+3RpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/FJ5IhjNyFKLSHvIZnuWRCgRlGZ/Zb2ROIY9Ky1i4H7JbPoRu
	/2KfrVZWVB6IPcWL+5GFz0APxE1Q6Qo/UoI68SVAHr0puAF9btf9A04qntDnsXY=
X-Gm-Gg: ASbGncsPFRylkX228/Hq+3sHZRKV/j87oV2IgDcHzZ0yxHyMZaiZ0xQSjnI7PAVRjPv
	GUZ0s/c8j9pFdlOT9CDjyg8dNLwuC6APRrsBKiWK5nndkg8Kx3m8Fh9muSO7xLBY+ZsBaeCZMOX
	uZsz4b+NdxM2WVQFrZ+xiLnWs7ruDesdoXXAcyBEELjho7Zq5fWbVHNEeQWnySuebKftpTNZKJh
	6mdYqBkEmhIDEXzyRftaFgJR+0+GNoqjWzs8uirhz8xkVfx9flXvKPEdlSxMsAdzms95c+im8Bp
	XqXG
X-Google-Smtp-Source: AGHT+IF5axebCRwBuEQ3JhIYMmZij6PxuI3EWl9eu3ZvHctGZaWrtYzGuI0jHdZz/5RjtpH3aCwB1g==
X-Received: by 2002:a05:600c:3596:b0:434:a386:6cf with SMTP id 5b1f17b1804b1-434a9dbbc00mr30559655e9.2.1732719619323;
        Wed, 27 Nov 2024 07:00:19 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4d42sm23279815e9.37.2024.11.27.07.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:00:18 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v4 09/10] iio: adc: ad7124: Add error reporting during probe
Date: Wed, 27 Nov 2024 15:59:38 +0100
Message-ID: <20241127145929.679408-21-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127145929.679408-12-u.kleine-koenig@baylibre.com>
References: <20241127145929.679408-12-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7836; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=yMC8oQsqpS+1AeWzQh+HkzdplhBqgZBlb2Nm13CGO5E=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnRzPqde8OlZgEfcrMj39TnJDm/UoufDLQ7LYBv iTRi7FUkoCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ0cz6gAKCRCPgPtYfRL+ Th8kB/9lArYNHBOknpasZVAJAYa1RWdgeoD8lz+SykBAfD/66Iwa98G0qcc4W7Y3RYcAKhGjxgT OS0neu1ajv/bwMSGvYodT5uHpLz64k10uJ/rbUqfDIfmatcoThbp0wDuE2lZyQ2uOSsSWXWKMFC l/rjG9r30tcTHogHIaThIqnca3NDpxyKXnVZNSXUdIVTpZIx/pAJSrQKIAFaGZl4e3B7FirGGcd CCj2EdVOGjtmF4K3RcBxbcFEVMLC0RN0odQ631JmDs47c/WcvCKwPjOmDiMjGbdq8sCKi8gROcO H1MirgowmMHff7r7oT2OzuQDlHwd5VSM1KOf8jJzpeNwJc0u
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

A driver that silently fails to probe is annoying and hard to debug. So
add messages in the error paths of the probe function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 79 ++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index b17c3dbeaeba..50b8ffa2dbe5 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -360,20 +360,21 @@ static int ad7124_find_free_config_slot(struct ad7124_state *st)
 	return free_cfg_slot;
 }
 
+/* Only called during probe, so dev_err_probe() can be used */
 static int ad7124_init_config_vref(struct ad7124_state *st, struct ad7124_channel_config *cfg)
 {
+	struct device *dev = &st->sd.spi->dev;
 	unsigned int refsel = cfg->refsel;
 
 	switch (refsel) {
 	case AD7124_REFIN1:
 	case AD7124_REFIN2:
 	case AD7124_AVDD_REF:
-		if (IS_ERR(st->vref[refsel])) {
-			dev_err(&st->sd.spi->dev,
-				"Error, trying to use external voltage reference without a %s regulator.\n",
-				ad7124_ref_names[refsel]);
-			return PTR_ERR(st->vref[refsel]);
-		}
+		if (IS_ERR(st->vref[refsel]))
+			return dev_err_probe(dev, PTR_ERR(st->vref[refsel]),
+					     "Error, trying to use external voltage reference without a %s regulator.\n",
+					     ad7124_ref_names[refsel]);
+
 		cfg->vref_mv = regulator_get_voltage(st->vref[refsel]);
 		/* Conversion from uV to mV */
 		cfg->vref_mv /= 1000;
@@ -384,8 +385,7 @@ static int ad7124_init_config_vref(struct ad7124_state *st, struct ad7124_channe
 		st->adc_control |= AD7124_ADC_CTRL_REF_EN(1);
 		return 0;
 	default:
-		dev_err(&st->sd.spi->dev, "Invalid reference %d\n", refsel);
-		return -EINVAL;
+		return dev_err_probe(dev, -EINVAL, "Invalid reference %d\n", refsel);
 	}
 }
 
@@ -752,8 +752,10 @@ static const struct iio_info ad7124_info = {
 	.attrs = &ad7124_attrs_group,
 };
 
+/* Only called during probe, so dev_err_probe() can be used */
 static int ad7124_soft_reset(struct ad7124_state *st)
 {
+	struct device *dev = &st->sd.spi->dev;
 	unsigned int readval, timeout;
 	int ret;
 
@@ -766,7 +768,7 @@ static int ad7124_soft_reset(struct ad7124_state *st)
 	do {
 		ret = ad_sd_read_reg(&st->sd, AD7124_STATUS, 1, &readval);
 		if (ret < 0)
-			return ret;
+			return dev_err_probe(dev, ret, "Error reading status register\n");
 
 		if (!(readval & AD7124_STATUS_POR_FLAG_MSK))
 			return 0;
@@ -775,35 +777,30 @@ static int ad7124_soft_reset(struct ad7124_state *st)
 		usleep_range(100, 2000);
 	} while (--timeout);
 
-	dev_err(&st->sd.spi->dev, "Soft reset failed\n");
-
-	return -EIO;
+	return dev_err_probe(dev, -EIO, "Soft reset failed\n");
 }
 
 static int ad7124_check_chip_id(struct ad7124_state *st)
 {
+	struct device *dev = &st->sd.spi->dev;
 	unsigned int readval, chip_id, silicon_rev;
 	int ret;
 
 	ret = ad_sd_read_reg(&st->sd, AD7124_ID, 1, &readval);
 	if (ret < 0)
-		return ret;
+		return dev_err_probe(dev, ret, "Failure to read ID register\n");
 
 	chip_id = AD7124_DEVICE_ID_GET(readval);
 	silicon_rev = AD7124_SILICON_REV_GET(readval);
 
-	if (chip_id != st->chip_info->chip_id) {
-		dev_err(&st->sd.spi->dev,
-			"Chip ID mismatch: expected %u, got %u\n",
-			st->chip_info->chip_id, chip_id);
-		return -ENODEV;
-	}
+	if (chip_id != st->chip_info->chip_id)
+		return dev_err_probe(dev, -ENODEV,
+				     "Chip ID mismatch: expected %u, got %u\n",
+				     st->chip_info->chip_id, chip_id);
 
-	if (silicon_rev == 0) {
-		dev_err(&st->sd.spi->dev,
-			"Silicon revision empty. Chip may not be present\n");
-		return -ENODEV;
-	}
+	if (silicon_rev == 0)
+		return dev_err_probe(dev, -ENODEV,
+				     "Silicon revision empty. Chip may not be present\n");
 
 	return 0;
 }
@@ -862,16 +859,18 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 	device_for_each_child_node_scoped(dev, child) {
 		ret = fwnode_property_read_u32(child, "reg", &channel);
 		if (ret)
-			return ret;
+			return dev_err_probe(dev, ret,
+					     "Failed to parse reg property of %pfwP\n", child);
 
 		if (channel >= indio_dev->num_channels)
 			return dev_err_probe(dev, -EINVAL,
-				"Channel index >= number of channels\n");
+					     "Channel index >= number of channels in %pfwP\n", child);
 
 		ret = fwnode_property_read_u32_array(child, "diff-channels",
 						     ain, 2);
 		if (ret)
-			return ret;
+			return dev_err_probe(dev, ret,
+					     "Failed to parse diff-channels property of %pfwP\n", child);
 
 		if (!ad7124_valid_input_select(ain[0], st->chip_info) ||
 		    !ad7124_valid_input_select(ain[1], st->chip_info))
@@ -908,12 +907,13 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 
 static int ad7124_setup(struct ad7124_state *st)
 {
+	struct device *dev = &st->sd.spi->dev;
 	unsigned int fclk, power_mode;
 	int i, ret;
 
 	fclk = clk_get_rate(st->mclk);
 	if (!fclk)
-		return -EINVAL;
+		return dev_err_probe(dev, -EINVAL, "Failed to get mclk rate\n");
 
 	/* The power mode changes the master clock frequency */
 	power_mode = ad7124_find_closest_match(ad7124_master_clk_freq_hz,
@@ -922,7 +922,7 @@ static int ad7124_setup(struct ad7124_state *st)
 	if (fclk != ad7124_master_clk_freq_hz[power_mode]) {
 		ret = clk_set_rate(st->mclk, fclk);
 		if (ret)
-			return ret;
+			return dev_err_probe(dev, ret, "Failed to set mclk rate\n");
 	}
 
 	/* Set the power mode */
@@ -953,7 +953,7 @@ static int ad7124_setup(struct ad7124_state *st)
 
 	ret = ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_control);
 	if (ret < 0)
-		return ret;
+		return dev_err_probe(dev, ret, "Failed to setup CONTROL register\n");
 
 	return ret;
 }
@@ -966,13 +966,14 @@ static void ad7124_reg_disable(void *r)
 static int ad7124_probe(struct spi_device *spi)
 {
 	const struct ad7124_chip_info *info;
+	struct device *dev = &spi->dev;
 	struct ad7124_state *st;
 	struct iio_dev *indio_dev;
 	int i, ret;
 
 	info = spi_get_device_match_data(spi);
 	if (!info)
-		return -ENODEV;
+		return dev_err_probe(dev, -ENODEV, "Failed to get match data\n");
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
@@ -1007,36 +1008,42 @@ static int ad7124_probe(struct spi_device *spi)
 
 		ret = regulator_enable(st->vref[i]);
 		if (ret)
-			return ret;
+			return dev_err_probe(dev, ret, "Failed to enable regulator #%d\n", i);
 
 		ret = devm_add_action_or_reset(&spi->dev, ad7124_reg_disable,
 					       st->vref[i]);
 		if (ret)
-			return ret;
+			return dev_err_probe(dev, ret, "Failed to register disable handler for regulator #%d\n", i);
 	}
 
 	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
 	if (IS_ERR(st->mclk))
-		return PTR_ERR(st->mclk);
+		return dev_err_probe(dev, PTR_ERR(st->mclk), "Failed to get mclk\n");
 
 	ret = ad7124_soft_reset(st);
 	if (ret < 0)
+		/* ad7124_soft_reset() already emitted an error message */
 		return ret;
 
 	ret = ad7124_check_chip_id(st);
 	if (ret)
+		/* ad7124_check_chip_id() already emitted an error message */
 		return ret;
 
 	ret = ad7124_setup(st);
 	if (ret < 0)
+		/* ad7124_setup() already emitted an error message */
 		return ret;
 
 	ret = devm_ad_sd_setup_buffer_and_trigger(&spi->dev, indio_dev);
 	if (ret < 0)
-		return ret;
+		return dev_err_probe(dev, ret, "Failed to setup triggers\n");
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to register iio device\n");
 
+	return 0;
 }
 
 static const struct of_device_id ad7124_of_match[] = {
-- 
2.45.2


