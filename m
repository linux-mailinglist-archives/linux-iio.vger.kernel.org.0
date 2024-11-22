Return-Path: <linux-iio+bounces-12490-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 513DE9D5E37
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 12:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C7E1F22723
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 11:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E165F1DE8B5;
	Fri, 22 Nov 2024 11:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mkqtbUyp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4E61DE3DF
	for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732275254; cv=none; b=ozkMoIrToPt79IqzVl5MnFjIihYm6zpoppKnPe8svlZNVFkSb+aWd0hm/ShBaNHvpnLbFuXwPNwHVQn5zh4ctK6E1qWVK28sYG1WR7JoWDcsOAjWRZwlikeis756lXe0yoFkEhaWXoOI/8uxHw5Jsk9uuyhp1YHv3p7DWgGFASk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732275254; c=relaxed/simple;
	bh=qCxgBxDixx+y8W8lK/MrUMri31nDKcjFNuZWUz++lzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sW8RQIWPdrYLQ6yaEmmBPJnGPQfNkGsCT6PuWAzFfNlOHWceYGmTVsRWC721WJCJ+uvyGTL+GaGx8FaagVbKbwdhxlFwGyhVDmMOffZABskonBtDSdMbbyiKjA1HVH5cArRsexUnxRrTZ6dDvzEDfMT7p6gMtZqHqreaZ+NRY+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mkqtbUyp; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-432d86a3085so17711595e9.2
        for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 03:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732275250; x=1732880050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tuSFNPk2cB5aapm6IULPvIIFlRmzQ+hDSbD7xiuHLo=;
        b=mkqtbUyp23TyjZUxDfIHINaTHHjO4/EFH4p+bNt9gCVOLd7NGzgWBSm4UNL39/2zRP
         VSa4xRcMFEWgwgGDm+mGagR2+uQsR8Mm5HsV46T8ne51iYrIdV9wbHHF9p9/Vd+MejAe
         ud29kjSDXQMbqDIyQFDxtudimhq7ow9RQfFp3FRHWtxQkirKKsxOjUZWE8RVDEzV7Gnc
         R5eF8ceftMC7OPJKonRSBUwktY28GXsHIriwcD5/XrNpvtncSL0l347KyfotdoY2YjFQ
         amVlltOglGJ8COeBmvQNEI2TKz3/4N9Iz2mwOl09+MaSwD2dLR4wXWxDqd6pL4gRocgX
         hERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732275250; x=1732880050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tuSFNPk2cB5aapm6IULPvIIFlRmzQ+hDSbD7xiuHLo=;
        b=Hes02n1QRx1g7cpwS25uLU3QLzs1DwQwcNaaUfKTj6HvkY0iB9HnfxlnS/N+94rcgB
         t7USgcTDyPdpvXx3w1h1c406zc4VwhLCT+cUpEwoa3IJfFK7IvzLCR821cPgUWriaSw/
         REXUttRJPVnCYjjv75uBbuUU4uI1zP3xjJi3ca0DeldeYXqqbBoPQUSr9MyCwEHF1jeY
         r4q1xVpnjK/GDO0J0kcyorWdPe+Xpkw/XSYubLv+N5hG4oeWLBrjdT88IW9ZzX8MLKmn
         XYwoo0ABvaaaIxLCeahb/hhPUdgQ/i2hbq16Epg4jmFquFOCzLmk919uPej/u+Ypqinc
         Q3Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVrLe0oWeMO5chXm9qH3EiFRHO4iC02+MVQDQsmPjFiJb8v07eG/bLGjdBuUG3hlE2QUW/lI3F3nL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4xeADW+A7pOusMuTzicvDKAHllgsqmKTSlW4CGRrfB6oaWXBH
	se6uBaQZxaEs0QFWsajNd742Z3yiB2ugMTd32zNwO6vpHx45Ng4zeRIH53o8kBA=
X-Gm-Gg: ASbGncs+NwTPbDN3FQ7DL2e3QXK0wWu9bWPj5bEOZ7yGviZUyPzW7jiLkrQ42WYZEI4
	9c8a42YooZsKH/IQvFIpkRpk4LYy6tWDaqr/Ayeskqn2rSabYzEOFOtyyasF28H69p4jpomJlmi
	MnXE6JJzdtDCMDzjIvVsXMBVLmknlBNJ6NuAkJuAcgS4ipZVS4MoUemkBueTnD20Iu3QrieNTO/
	kyXg60p33f9tfdjTX2lADys2Dcee83iK51ZYkqP6Oets+gdqOloVRMGLYK/gMNHYh+Fo2+Lut/S
	9cE=
X-Google-Smtp-Source: AGHT+IG0xSQQczfw1MBYfP1IbOz9h1rNpki04/dVS/jrGKj3U4UCN3FQRWAtELh+V92EjbTtaCiTUw==
X-Received: by 2002:a5d:47a7:0:b0:382:4f9e:7133 with SMTP id ffacd0b85a97d-38260b6b368mr1942027f8f.29.1732275250063;
        Fri, 22 Nov 2024 03:34:10 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb264cdsm2175392f8f.49.2024.11.22.03.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 03:34:09 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Alexandru Ardelean <aardelean@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Dumitru Ceclan <dumitru.ceclan@analog.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 09/10] iio: adc: ad7124: Add error reporting during probe
Date: Fri, 22 Nov 2024 12:33:28 +0100
Message-ID: <20241122113322.242875-21-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7778; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=qCxgBxDixx+y8W8lK/MrUMri31nDKcjFNuZWUz++lzg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnQGwZNAPzt5O6mPx4+5+TJ79e1jLHjpFwPDOiu WZ2FuooQX6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ0BsGQAKCRCPgPtYfRL+ ToacCACuSFXKAh8doGeDRWHNZrj2ioMYJI1vneDBabW3J8IRRG/UsVFzZg+nDRFjmSHfVkA2qB1 zhyXskkUdoQD1cLeVCyWlKBHfj48GdRYLfCVI+JZyArqaZzg4OetkwGWuzDK32uQsgJG89Wo1cM XXMFyajf3dX4m0fFVTux7OBPEuSUv2DKbN9Ty80gvyDfYISUL77oIEYCE8LoRHuHFoWvreqlh+B g6qbcV/hxMk6nnn8t3s81FY4y0vzLvNUJvJduEAJXWlWN7aqUM0Y1O0TOiw6840xhRkAVbdL/lq NATT3oTJt4zpFvlg8t+zHd/osf3WADkDO8DcHSctoEMHjU60
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

A driver that silently fails to probe is annoying and hard to debug. So
add messages in the error paths of the probe function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 78 +++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index b17c3dbeaeba..fdbe2806bf11 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -360,20 +360,21 @@ static int ad7124_find_free_config_slot(struct ad7124_state *st)
 	return free_cfg_slot;
 }
 
+/* Only called during probe, so dev_err_probe() can be used */
 static int ad7124_init_config_vref(struct ad7124_state *st, struct ad7124_channel_config *cfg)
 {
 	unsigned int refsel = cfg->refsel;
+	struct device *dev = &st->sd.spi->dev;
 
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
 
@@ -752,6 +752,7 @@ static const struct iio_info ad7124_info = {
 	.attrs = &ad7124_attrs_group,
 };
 
+/* Only called during probe, so dev_err_probe() can be used */
 static int ad7124_soft_reset(struct ad7124_state *st)
 {
 	unsigned int readval, timeout;
@@ -766,7 +767,7 @@ static int ad7124_soft_reset(struct ad7124_state *st)
 	do {
 		ret = ad_sd_read_reg(&st->sd, AD7124_STATUS, 1, &readval);
 		if (ret < 0)
-			return ret;
+			return dev_err_probe(&st->sd.spi->dev, ret, "Error reading status register\n");
 
 		if (!(readval & AD7124_STATUS_POR_FLAG_MSK))
 			return 0;
@@ -775,9 +776,7 @@ static int ad7124_soft_reset(struct ad7124_state *st)
 		usleep_range(100, 2000);
 	} while (--timeout);
 
-	dev_err(&st->sd.spi->dev, "Soft reset failed\n");
-
-	return -EIO;
+	return dev_err_probe(&st->sd.spi->dev, -EIO, "Soft reset failed\n");
 }
 
 static int ad7124_check_chip_id(struct ad7124_state *st)
@@ -787,23 +786,20 @@ static int ad7124_check_chip_id(struct ad7124_state *st)
 
 	ret = ad_sd_read_reg(&st->sd, AD7124_ID, 1, &readval);
 	if (ret < 0)
-		return ret;
+		return dev_err_probe(&st->sd.spi->dev, ret,
+				     "Failure to read ID register\n");
 
 	chip_id = AD7124_DEVICE_ID_GET(readval);
 	silicon_rev = AD7124_SILICON_REV_GET(readval);
 
-	if (chip_id != st->chip_info->chip_id) {
-		dev_err(&st->sd.spi->dev,
-			"Chip ID mismatch: expected %u, got %u\n",
-			st->chip_info->chip_id, chip_id);
-		return -ENODEV;
-	}
+	if (chip_id != st->chip_info->chip_id)
+		return dev_err_probe(&st->sd.spi->dev, -ENODEV,
+				     "Chip ID mismatch: expected %u, got %u\n",
+				     st->chip_info->chip_id, chip_id);
 
-	if (silicon_rev == 0) {
-		dev_err(&st->sd.spi->dev,
-			"Silicon revision empty. Chip may not be present\n");
-		return -ENODEV;
-	}
+	if (silicon_rev == 0)
+		return dev_err_probe(&st->sd.spi->dev, -ENODEV,
+				     "Silicon revision empty. Chip may not be present\n");
 
 	return 0;
 }
@@ -862,16 +858,18 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
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
@@ -909,11 +907,12 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 static int ad7124_setup(struct ad7124_state *st)
 {
 	unsigned int fclk, power_mode;
+	struct device *dev = &st->sd.spi->dev;
 	int i, ret;
 
 	fclk = clk_get_rate(st->mclk);
 	if (!fclk)
-		return -EINVAL;
+		return dev_err_probe(dev, -EINVAL, "Failed to get mclk rate\n");
 
 	/* The power mode changes the master clock frequency */
 	power_mode = ad7124_find_closest_match(ad7124_master_clk_freq_hz,
@@ -922,7 +921,7 @@ static int ad7124_setup(struct ad7124_state *st)
 	if (fclk != ad7124_master_clk_freq_hz[power_mode]) {
 		ret = clk_set_rate(st->mclk, fclk);
 		if (ret)
-			return ret;
+			return dev_err_probe(dev, ret, "Failed to set mclk rate\n");
 	}
 
 	/* Set the power mode */
@@ -953,7 +952,7 @@ static int ad7124_setup(struct ad7124_state *st)
 
 	ret = ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_control);
 	if (ret < 0)
-		return ret;
+		return dev_err_probe(dev, ret, "Failed to setup CONTROL register\n");
 
 	return ret;
 }
@@ -968,11 +967,12 @@ static int ad7124_probe(struct spi_device *spi)
 	const struct ad7124_chip_info *info;
 	struct ad7124_state *st;
 	struct iio_dev *indio_dev;
+	struct device *dev = &spi->dev;
 	int i, ret;
 
 	info = spi_get_device_match_data(spi);
 	if (!info)
-		return -ENODEV;
+		return dev_err_probe(dev, -ENODEV, "Failed to get match data\n");
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
@@ -1007,36 +1007,42 @@ static int ad7124_probe(struct spi_device *spi)
 
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


