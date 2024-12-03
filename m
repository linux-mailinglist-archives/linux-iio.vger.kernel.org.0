Return-Path: <linux-iio+bounces-13003-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A9F9E1A2F
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 12:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9312854C7
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 11:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224F41E378A;
	Tue,  3 Dec 2024 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GRIh3KCp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84A91E47B9
	for <linux-iio@vger.kernel.org>; Tue,  3 Dec 2024 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223697; cv=none; b=VGiyL8HNbIfWqQTOPCaKg+0edMi5/tslQWRM0JOcbeVXR1rADU/f+JbXgDoH1oNNVTYLOSI0aBsFst5/MCVL83ZmGjtPx7okYrwbSuTTNrj2YJW5mxTC0sXFkjOCEyI+2WRcnQs4c+9o+VH4jxRjWI+pDc2spG2FWplBdwmFsa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223697; c=relaxed/simple;
	bh=KqvwXZaRvv9GSGI/LYFDg6O+kYZP0S5RykbY4ZVAHHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBLidW8F7TN96p5g9raqO4GRErZShkSnbdwutH5nG9LDtmi0Tp3ifkNSbFuWe7Sa2EyY82Z7i8wTF/6W6ZX5LGOBMvSYAev0nOazbjHhWx6lzF0IhnTtjZMcVz5OF7XpcnMJz9HSls7Q3j+5heN7afurvHZOp7kGdXCFerHZmW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GRIh3KCp; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53dd2fdcebcso6142000e87.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Dec 2024 03:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733223694; x=1733828494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctE89N3s2vVR3/cExZ7Wbv+dOP1/6k5QsDXLkjRGfvM=;
        b=GRIh3KCpZeEEFGVVF8JoYJMqhi91yDF1gu6qc29xhDflbdFZ7l3d5+vNcOi32makkV
         h0hYEudZ2guITehTsRenB3wahMDdsCUW2KSJak2ePz/9b2qTPhR+QNIYfvkezlTpOINE
         PC4oR2yLWVhmS22cqpsa8nroTNC/LXz39azh5XPCZpRI22HHK2daFwp/lPBZmLy+SDmT
         279/Br+5xbmUnXT7NjG8+5UY3F2NAhILOY4IxYK3yzcvLJP2TUsixkjRNU6XiR2/XVQ4
         OcNB++/QzLrb14kAhPL+mS6Ifqz5Iou2Ro6WvwXWkftXYXm2t7YI0eIYOFqYOxE+/sQj
         FPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733223694; x=1733828494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctE89N3s2vVR3/cExZ7Wbv+dOP1/6k5QsDXLkjRGfvM=;
        b=C+32zIVi1oDA/PY1NTA/iw0AD33jihJx0RYi9hIFK0znqajGrUwahyfBf9axhPi6/Q
         0Ua4mIhmFJ72g4hsrXfSfdd01rmBMnYEWwbnCLKmigMH327OWBr0kdQoIJYIBLlK5TcO
         eGW9UguD9gKorF+6GKngaGWZTaW8Oyo0cpa2Nl+6l76O0FaS0iaoNwKm39un4f6B/12L
         ewkgofsAV37Nm0n8n87+AuQtnddJhQ19M33AIHazr0WOkyya8F9oq2dLtsT0ZczeDD3J
         gDx5BgJsE41I1eu8Q9owcIy34ec/d92syVLmULY7VZe4o1+R+9VYe/YNqcLQTPzrrmy5
         oDIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX187fN3jX7mweFxNRtTZuqcPu9jdfvtYPSNPn+Q+eWfMRi4NcD0vvchLTzhaL6O3oJgxnJiBtz1UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPDUOb6abZ2hkG2EA1lBprWSQgrmrkQUIOxzOkHVQJIHU4W8KE
	E1OovHKm6nAq4bkOz5ALSeZRBd8Ou0QPoZ3/i267ae8+KHbiQR2VOOZ+ZxYxYN2TSfZmCbJj0vd
	CK3A=
X-Gm-Gg: ASbGncvAMqVvetGO7N9CfRyEOPV6pUjlGis75eqZQnSvzB6Kb5YplwsB/ztQ1ui81bi
	qQxHu/GBj5WkBMhED1cmS44cAj5OSX2QdHDN4+eu7Z/x5xeSvF2/DQBYVEdcCTGnU+pTKtZZSG5
	GUyCLtKIsjtRY5b/TLXtJAr1mfAbGRMqcTh5P4Lo8xNTrRZYEuIShj24+nt12sEUHB7XomQswMn
	HmhJNnLrlQTfZQwwrWsut17AXGngaAQOClw1TNPcC/uLdt0pVwLac65ZhT4jxLCrWrPkpU4F8hi
	+4qPlREUsRN59jd6jbXvOLJuAEd4UbbrrzOfhiQ=
X-Google-Smtp-Source: AGHT+IHsPNuYhaahBNgHfcXZEdudCHNRA3EHAE+VN6V0jqV2L1tl1aPCJFUBcnC3hNwY1xo8je48KQ==
X-Received: by 2002:a05:6512:2216:b0:53d:e3a6:ae82 with SMTP id 2adb3069b0e04-53e129f3236mr1165623e87.14.1733223693884;
        Tue, 03 Dec 2024 03:01:33 -0800 (PST)
Received: from localhost (p200300f65f242d005bbc9b581c6b9666.dip0.t-ipconnect.de. [2003:f6:5f24:2d00:5bbc:9b58:1c6b:9666])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f32589sm189216425e9.28.2024.12.03.03.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:01:33 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Renato Lui Geh <renatogeh@gmail.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	devicetree@vger.kernel.org,
	Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Alexandru Ardelean <aardelean@baylibre.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v5 09/10] iio: adc: ad7124: Add error reporting during probe
Date: Tue,  3 Dec 2024 12:00:29 +0100
Message-ID: <20241203110019.1520071-21-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203110019.1520071-12-u.kleine-koenig@baylibre.com>
References: <20241203110019.1520071-12-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7578; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=KqvwXZaRvv9GSGI/LYFDg6O+kYZP0S5RykbY4ZVAHHY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnTuTg21u9PBaHL9RvbdKYINTvca8kYaTJvCcrL 1ugRtmXPMCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ07k4AAKCRCPgPtYfRL+ TjsPCACWsD4/oslP+HjQsLo0TX9mOqEfFwVb9e8aY+MT0q0PgRuW+Rmb5HDUtNrmdN3kms38WFL 0VLCbui6Ef8kw+E57IlYnCDiogbY7UQOAirKtKvQKNIZmJkE4Qbq/WcOJlvG08DHGx4gsuCPeiu VGGeJ7SBafshtTw4z+B+s06jjLrGTIORDWTmW8rttgOvs4XtbJIgg8ah4Er5nye5h1HD0mw8kgX aIj975K3TkA9Zz5J8XWFJr/3295T6YAmkssPpkJu0EjjPgSuVR3FVFc1tOdu4Zi2Bs4jRcd2Nns TZkRysdA+7Hh5OVcksGnKF3EL+RyM9kDz6JnQ1faFwymESc/
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


