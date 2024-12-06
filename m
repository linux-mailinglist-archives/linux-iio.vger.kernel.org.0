Return-Path: <linux-iio+bounces-13178-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A431F9E7766
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 18:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DBB528897D
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 17:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4376204563;
	Fri,  6 Dec 2024 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xOwP/wL8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEBC204569
	for <linux-iio@vger.kernel.org>; Fri,  6 Dec 2024 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506174; cv=none; b=LLvwTfaSErfUPS0blpDcwryXuy9c8et4vVBXN0eLJWQA4ipTkTxDUYcuEcCBnI2Ujvo8mpF2OKpwoUWB0Bo/HEgyvxxz8Y5pt/NNQ/psxX7SXAv4dmYuSlHUEH6mu7A0Sis4IHJFM4e6plkIpFMdh2d9sqGs2XJxBK9nmqWTi/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506174; c=relaxed/simple;
	bh=KqvwXZaRvv9GSGI/LYFDg6O+kYZP0S5RykbY4ZVAHHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eRCPYRxXTxKII+fs6HVVlKQQfV8bNPSeGQ8AKtBcvGFD7yS+NJ3ejmNQv9Al9IxEgwNTeEhC2vmlNOSE16eV9BEqfx8Iylazk0dIaZtoQrKOakLqZpc0R4dcL31b8RKJMVPs7kNmIOX1OXx9Q6v0DzhziGeGfXxI/Ew8u7Egx5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xOwP/wL8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a0fd9778so22888255e9.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Dec 2024 09:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733506168; x=1734110968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctE89N3s2vVR3/cExZ7Wbv+dOP1/6k5QsDXLkjRGfvM=;
        b=xOwP/wL8c7+QZztnolyn20WjvICX5G53FuoMQVs0shfggbsyxmq3rrxlLpABfkpQbu
         Deaz7zcn0ok9BRpTnKV++PyMEc+YvpDZxuepFx1FSqvxxjcLbOzQt1zujAsJyqfQ03Th
         IIdhTW4cscGiFBWqQrGkKfJ+KKa2Sbs0WHtMNswoYju1W0+tcOCYs4KoTSloPPRXEfBL
         5oCbhkEz7G65WOchxIp6W/dUbkTK/KV9L5FvuD+3pGkNvtcxBwelZ3EkWm6SdD+9OC0v
         r6xrrKN6tZAGJLkU8GRxFx+WDOAH1TntAhfx/kvNMw8hWtFnwDThgjJ9hrvzafLYkhil
         4lzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733506168; x=1734110968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctE89N3s2vVR3/cExZ7Wbv+dOP1/6k5QsDXLkjRGfvM=;
        b=OAxtZbd4jj71lRQ6p69ouazQUqyl1DttM1IJc7jiHF7jzYXqGWRAThrLBSCnhmGB/F
         kcvzW/KjJzv0GbwKIVWnig0T2dlvt0PgjRyn8x0pnVd7sz3c7x7F8KmQ18uUxL2FONci
         KtM4ZeyNb+tFcJi9KiYlJf35RNF75S0EEKdx4HvmwXzczrRfu3wY3WwA0AqvIt9ULVRz
         C9PV9cie7BuS/M38xtyfKDFUSuVXU4ZvBOuVFMbNUhCewoDK2gMcKXNnveILgj+QHqJx
         Z49mn+6/PEjlyGtJbu13OkrLsmDZFlJ1At/K46FNtCdddfZlidJpc/YQOez4FWWqO0xm
         9UcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9cY3qssFlI9FCzi3qPBQk1uGWs1p6QOMRleSlW9WfY/C0P+yCzA3R7zG8ZakO39z2eUe+hLs48Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2x5FBH5Dj7y0vgXjfJT3ugloLxQctZn6bah0P7zrAScpihnA9
	gB5+5oEERcEq02KmWJttePVPWPyvcgTdzTwo3YCZmR//KlujwFlyXAbW10LN3SY=
X-Gm-Gg: ASbGncvt9twc2v1l45evOJFZCtEWrIp/koJ6CAMqddDrWU0BsGOqOy2IqOiQbDYvAcY
	fsN5JHftdPIzsSqCXbrVe6zL9fEcQQd65tq3m4Rwpnb3W0+Bdsvtx64GsL2rFdSDf1+JG9nhrvv
	KH2IJtyNQBAsyVrGCe+1VrQAg4wCIYKKmVWiIF6grW8OyHWKlyakFeL3i94rLQr7yv965P/HKpx
	XHuhaX1bhWhFEBIq2ogayZFmssP+stawctgT16ljROpjCvHSVc+o9vLraqasgq1JHe4IIt4APQJ
	kh5n
X-Google-Smtp-Source: AGHT+IHfwSMZrpO3YDagRcdFwtIkyddibfUy2IpP9eNUwrOK5Nz/rF+Pzujpu78Lgdbc6rWhkXEljw==
X-Received: by 2002:a05:6000:787:b0:385:effc:a279 with SMTP id ffacd0b85a97d-3862b403a90mr2954791f8f.58.1733506168448;
        Fri, 06 Dec 2024 09:29:28 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5273131sm98625195e9.12.2024.12.06.09.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 09:29:27 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alexandru Ardelean <aardelean@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Renato Lui Geh <renatogeh@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v6 09/10] iio: adc: ad7124: Add error reporting during probe
Date: Fri,  6 Dec 2024 18:28:41 +0100
Message-ID:  <55e24392f1e4d5b9896f00a52a93c1c4b1feac43.1733504533.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
References: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7578; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=KqvwXZaRvv9GSGI/LYFDg6O+kYZP0S5RykbY4ZVAHHY=; b=owGbwMvMwMXY3/A7olbonx/jabUkhvRgk5jbFc/v9QTs8pjk0WrbV8W1yVAxZ+Lemp6aT4YGL BsfTLfsZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAiXt7s/9T+Jn/Rs9nLae0k LhVbvOL7Eo4exhl/kwT++26df3nhu5dWrW/+cqYV/3O1+Zs0sTH0ravF+xrleqFdKXw/2j1fxJ3 om89SquARuUk3a0Ilk9uOrhcmAT5ib/+YlT7KEV98ZXkal+DVaZzRhp6fVCxENKd2TGZ6GZS5Pf DkgvoyXXUR0Vdfgl/eM/SW5HDUd52gzj2VZyr7858G9x12mfFrz4hOOL7VZM++GIGT+wSZWDoN+ SK//5qSENugESE5JY3nmVyfWpfPRjtJ3qytXpznruoLzOFbmtDSukLWV4/t2t6fUxR3vClRufRa SNE3RqCFRXnKEYuErysLv59jPDzl+Idpl+pTfh1K33MKAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

A driver that silently fails to probe is annoying and hard to debug. So
add messages in the error paths of the probe function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 76 +++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index b17c3dbeaeba..9405cb579324 100644
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
@@ -1007,17 +1008,17 @@ static int ad7124_probe(struct spi_device *spi)
 
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
@@ -1033,10 +1034,13 @@ static int ad7124_probe(struct spi_device *spi)
 
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


