Return-Path: <linux-iio+bounces-6177-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7589041CD
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2024 18:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57EBF1F26335
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2024 16:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9214597B;
	Tue, 11 Jun 2024 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ttODX372"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E07040849
	for <linux-iio@vger.kernel.org>; Tue, 11 Jun 2024 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124748; cv=none; b=aa246t35udi5tfFus9R9Yne5yLwRGmkijtp0lEcWMdhIRgWjlgD7ykzDjW5gqIvHyRF/AIaGdJdG2PSxSQ/vRIl2A99NqbfqrEG/ycVZSN/hcR3/66NXRi2mx577+14UQQdLZleWY3xSGfwLwZsYVKEc6scFRMSOKX8RO3FDUM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124748; c=relaxed/simple;
	bh=iF6S2W90vm9UaWfLBA0TcfKewIDsA1QJ4nyIoauKnQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uocTl8ZDUnV/SgUg4OlMTXPD5GbXk92zX0xS484gZs295ovK71SfRUuFlsxLn5SeP2QvRfo4lrPjMB8M14LAY0Wtouj09QIVQYMDa9ar3k5qCROM2fyY9kQl7ytWEFyftxc11DP/et0kOzYgzZ4p7SdzxFnjaTVzx+j2r4dG7ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ttODX372; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b06bdbf9fdso7734196d6.0
        for <linux-iio@vger.kernel.org>; Tue, 11 Jun 2024 09:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718124742; x=1718729542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yekUCk10zk+HE2YIl2d9Yyk2apenK6ihXk9wEFyZLB0=;
        b=ttODX372r9A9j6yktaHgijDCfBzOYco7J70g5RFM4Y7gbpfEa4fhvA1sUuWmtIh4jf
         UOBKy/OwJu3k8m3xz949aIid4Oq8l5EILP6rVHJC84RBJMJH/KVpNgw77QWUnI6fdY94
         U+qcMGTpADwCkjJuM4vQcBlc1bwG2n2eylKBIyM3MzhPaWGuIfEQhjhn9oADl/craQ41
         mRi7BULx5kWk5tmooEd8XED4PpKbxHJDObCrSs87wSFp20Yxo4Rz+C4CcirD+RCoiULH
         lWeBMJFPkmeGzlArY+1HS0+hq3VMMQG4aNf7JeVBW8fPfSiA5sS0LXgmhPERrE0bq6fy
         DDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718124742; x=1718729542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yekUCk10zk+HE2YIl2d9Yyk2apenK6ihXk9wEFyZLB0=;
        b=eYuRysGCkEVLxFpBeucGCbGdX5VJQrhVhfzfqu2bHLpXdIFgYRTOL4Y2Cx2Y7mHXKV
         reL0XSW9WpvaRyBYhSL4xvahhJ2PO3Oa1b86kbfPKWor7XqtHuRv0oKqpWgY34thUV/K
         yKyE5dkAqT3nERnyzakAlqfHa1iyW4q345CMw867slLpQfY5QzQroaBiUU0dRzqPA7kX
         AHbeL3MKtvG4C+mQGJcZ9Z63jOwRC9PB71QP4N2kkBKHW/HRzL1ve6xpyO56iXE9fdSh
         rRv4Qc67/mccFGZriJccvvC64M16g7TI6I8LgMvX79GJKC++zUYvz4lzInLaFYfFgu4F
         sv4w==
X-Forwarded-Encrypted: i=1; AJvYcCVPrWdLO6TRyg4tTo3XvKViPzLOWKljhBcCillY2LbmmIBkFTIG33wqem2IrMxSWAI3/FSG4n23pypGHlvvGP2zwsukDLN0HSZ+
X-Gm-Message-State: AOJu0Yz46Kwv6aeLnX4hyFvL3+s01H+P8CuN55dDlEG6QFssOeM3h0af
	kViuHkSxXiMlREbiV2675YxpZfCL0lP5QHe1vCFj60hSqlskiRE7csiCmedchJo=
X-Google-Smtp-Source: AGHT+IEK02/Y5tguqi1RkXMzMQjj5wd0lRXZ6VmQNH/VH1KpwmTv/Qs3zNXbzaQ3LPhZ7qfj+cki9g==
X-Received: by 2002:a05:6214:5248:b0:6b0:7d9a:79fe with SMTP id 6a1803df08f44-6b07d9a7fc7mr64780726d6.35.1718124742093;
        Tue, 11 Jun 2024 09:52:22 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b071aaa3a6sm33815806d6.47.2024.06.11.09.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 09:52:21 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: Lucas Stankus <lucas.p.stankus@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Rokosov <ddrokosov@sberdevices.ru>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Saravanan Sekar <sravanhome@gmail.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
	Crt Mori <cmo@melexis.com>
Cc: Trevor Gamblin <tgamblin@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-amlogic@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [RESEND][PATCH] iio: simplify with regmap_set_bits(), regmap_clear_bits()
Date: Tue, 11 Jun 2024 12:52:06 -0400
Message-ID: <20240611165214.4091591-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Simplify the way regmap is accessed in iio drivers.

Instead of using regmap_update_bits() and passing the mask twice, use
regmap_set_bits().

Instead of using regmap_update_bits() and passing val = 0, use
regmap_clear_bits().

Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
CC list got suppressed on first submission, so resending. Sorry about
that.

 drivers/iio/accel/adxl313_core.c              |   4 +-
 drivers/iio/accel/adxl313_spi.c               |   4 +-
 drivers/iio/accel/fxls8962af-core.c           |  18 ++--
 drivers/iio/accel/kxsd9.c                     |   6 +-
 drivers/iio/accel/msa311.c                    |   6 +-
 drivers/iio/adc/ad4130.c                      |   4 +-
 drivers/iio/adc/axp20x_adc.c                  |   5 +-
 drivers/iio/adc/axp288_adc.c                  |   4 +-
 drivers/iio/adc/bcm_iproc_adc.c               |   8 +-
 drivers/iio/adc/berlin2-adc.c                 |  24 ++---
 drivers/iio/adc/cpcap-adc.c                   |  44 +++-----
 drivers/iio/adc/fsl-imx25-gcq.c               |  16 ++-
 drivers/iio/adc/ina2xx-adc.c                  |   3 +-
 drivers/iio/adc/intel_mrfld_adc.c             |   4 +-
 drivers/iio/adc/meson_saradc.c                | 101 ++++++++----------
 drivers/iio/adc/mp2629_adc.c                  |  19 ++--
 drivers/iio/adc/qcom-spmi-rradc.c             |  50 +++++----
 drivers/iio/adc/rn5t618-adc.c                 |   5 +-
 drivers/iio/adc/sc27xx_adc.c                  |  41 ++++---
 drivers/iio/adc/stm32-dfsdm-adc.c             |  29 +++--
 drivers/iio/dac/ltc2688.c                     |   5 +-
 drivers/iio/dac/stm32-dac-core.c              |   5 +-
 drivers/iio/gyro/bmg160_core.c                |   4 +-
 drivers/iio/gyro/mpu3050-core.c               |  33 +++---
 drivers/iio/health/afe4403.c                  |   9 +-
 drivers/iio/health/afe4404.c                  |   9 +-
 drivers/iio/health/max30100.c                 |   5 +-
 drivers/iio/health/max30102.c                 |   5 +-
 .../imu/inv_icm42600/inv_icm42600_buffer.c    |  14 ++-
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |   9 +-
 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   |   4 +-
 .../iio/imu/inv_icm42600/inv_icm42600_spi.c   |   4 +-
 drivers/iio/light/adux1020.c                  |  13 ++-
 drivers/iio/light/iqs621-als.c                |   4 +-
 drivers/iio/light/isl29018.c                  |   6 +-
 drivers/iio/light/st_uvis25_core.c            |   4 +-
 drivers/iio/light/veml6030.c                  |   4 +-
 drivers/iio/magnetometer/ak8974.c             |  11 +-
 drivers/iio/magnetometer/mmc35240.c           |   8 +-
 drivers/iio/pressure/bmp280-core.c            |   4 +-
 drivers/iio/proximity/sx9324.c                |   5 +-
 drivers/iio/proximity/sx9360.c                |   5 +-
 drivers/iio/proximity/sx9500.c                |  12 +--
 drivers/iio/proximity/sx_common.c             |   9 +-
 drivers/iio/temperature/mlx90632.c            |   4 +-
 drivers/iio/trigger/stm32-timer-trigger.c     |  34 +++---
 46 files changed, 273 insertions(+), 351 deletions(-)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 4de0a41bd679..1dad3a8d0c29 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -362,8 +362,8 @@ static int adxl313_setup(struct device *dev, struct adxl313_data *data,
 			return ret;
 
 		/* Enables full resolution */
-		ret = regmap_update_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
-					 ADXL313_FULL_RES, ADXL313_FULL_RES);
+		ret = regmap_set_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
+				      ADXL313_FULL_RES);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl313_spi.c
index b7cc15678a2b..97ebe55acb2e 100644
--- a/drivers/iio/accel/adxl313_spi.c
+++ b/drivers/iio/accel/adxl313_spi.c
@@ -57,8 +57,8 @@ static int adxl313_spi_setup(struct device *dev, struct regmap *regmap)
 			return ret;
 	}
 
-	return regmap_update_bits(regmap, ADXL313_REG_POWER_CTL,
-				  ADXL313_I2C_DISABLE, ADXL313_I2C_DISABLE);
+	return regmap_set_bits(regmap, ADXL313_REG_POWER_CTL,
+			       ADXL313_I2C_DISABLE);
 }
 
 static int adxl313_spi_probe(struct spi_device *spi)
diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 4fbc01bda62e..d25e31613413 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -228,8 +228,8 @@ static int fxls8962af_power_off(struct fxls8962af_data *data)
 
 static int fxls8962af_standby(struct fxls8962af_data *data)
 {
-	return regmap_update_bits(data->regmap, FXLS8962AF_SENS_CONFIG1,
-				  FXLS8962AF_SENS_CONFIG1_ACTIVE, 0);
+	return regmap_clear_bits(data->regmap, FXLS8962AF_SENS_CONFIG1,
+				 FXLS8962AF_SENS_CONFIG1_ACTIVE);
 }
 
 static int fxls8962af_active(struct fxls8962af_data *data)
@@ -785,9 +785,8 @@ static int fxls8962af_reset(struct fxls8962af_data *data)
 	unsigned int reg;
 	int ret;
 
-	ret = regmap_update_bits(data->regmap, FXLS8962AF_SENS_CONFIG1,
-				 FXLS8962AF_SENS_CONFIG1_RST,
-				 FXLS8962AF_SENS_CONFIG1_RST);
+	ret = regmap_set_bits(data->regmap, FXLS8962AF_SENS_CONFIG1,
+			      FXLS8962AF_SENS_CONFIG1_RST);
 	if (ret)
 		return ret;
 
@@ -830,9 +829,8 @@ static int fxls8962af_buffer_postenable(struct iio_dev *indio_dev)
 	fxls8962af_standby(data);
 
 	/* Enable buffer interrupt */
-	ret = regmap_update_bits(data->regmap, FXLS8962AF_INT_EN,
-				 FXLS8962AF_INT_EN_BUF_EN,
-				 FXLS8962AF_INT_EN_BUF_EN);
+	ret = regmap_set_bits(data->regmap, FXLS8962AF_INT_EN,
+			      FXLS8962AF_INT_EN_BUF_EN);
 	if (ret)
 		return ret;
 
@@ -851,8 +849,8 @@ static int fxls8962af_buffer_predisable(struct iio_dev *indio_dev)
 	fxls8962af_standby(data);
 
 	/* Disable buffer interrupt */
-	ret = regmap_update_bits(data->regmap, FXLS8962AF_INT_EN,
-				 FXLS8962AF_INT_EN_BUF_EN, 0);
+	ret = regmap_clear_bits(data->regmap, FXLS8962AF_INT_EN,
+				FXLS8962AF_INT_EN_BUF_EN);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index ba99649fe195..03ce032e06ff 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -370,10 +370,8 @@ static int kxsd9_power_down(struct kxsd9_state *st)
 	 * make sure we conserve power even if there are others users on the
 	 * regulators.
 	 */
-	ret = regmap_update_bits(st->map,
-				 KXSD9_REG_CTRL_B,
-				 KXSD9_CTRL_B_ENABLE,
-				 0);
+	ret = regmap_clear_bits(st->map, KXSD9_REG_CTRL_B,
+				KXSD9_CTRL_B_ENABLE);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
index b8ddbfd98f11..40e605c57adb 100644
--- a/drivers/iio/accel/msa311.c
+++ b/drivers/iio/accel/msa311.c
@@ -1034,10 +1034,8 @@ static int msa311_chip_init(struct msa311_priv *msa311)
 				     "failed to unmap map0/map1 interrupts\n");
 
 	/* Disable all axes by default */
-	err = regmap_update_bits(msa311->regs, MSA311_ODR_REG,
-				 MSA311_GENMASK(F_X_AXIS_DIS) |
-				 MSA311_GENMASK(F_Y_AXIS_DIS) |
-				 MSA311_GENMASK(F_Z_AXIS_DIS), 0);
+	err = regmap_clear_bits(msa311->regs, MSA311_ODR_REG,
+				MSA311_GENMASK(F_X_AXIS_DIS) | MSA311_GENMASK(F_Y_AXIS_DIS) | MSA311_GENMASK(F_Z_AXIS_DIS));
 	if (err)
 		return dev_err_probe(dev, err, "can't enable all axes\n");
 
diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index aaf1fb0ac447..e134d6497827 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -1883,8 +1883,8 @@ static int ad4130_setup(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(st->regmap, AD4130_FIFO_CONTROL_REG,
-				 AD4130_FIFO_CONTROL_HEADER_MASK, 0);
+	ret = regmap_clear_bits(st->regmap, AD4130_FIFO_CONTROL_REG,
+				AD4130_FIFO_CONTROL_HEADER_MASK);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index d6c51b0f48e3..00c1a01cac63 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -712,9 +712,8 @@ static int axp20x_probe(struct platform_device *pdev)
 	regmap_write(info->regmap, AXP20X_ADC_EN1, info->data->adc_en1_mask);
 
 	if (info->data->adc_en2_mask)
-		regmap_update_bits(info->regmap, AXP20X_ADC_EN2,
-				   info->data->adc_en2_mask,
-				   info->data->adc_en2_mask);
+		regmap_set_bits(info->regmap, AXP20X_ADC_EN2,
+				info->data->adc_en2_mask);
 
 	/* Configure ADCs rate */
 	info->data->adc_rate(info, 100);
diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
index 49fff1cabd0d..f135cf2362df 100644
--- a/drivers/iio/adc/axp288_adc.c
+++ b/drivers/iio/adc/axp288_adc.c
@@ -247,8 +247,8 @@ static int axp288_adc_initialize(struct axp288_adc_info *info)
 		return ret;
 
 	/* Turn on the ADC for all channels except TS, leave TS as is */
-	return regmap_update_bits(info->regmap, AXP20X_ADC_EN1,
-				  AXP288_ADC_EN_MASK, AXP288_ADC_EN_MASK);
+	return regmap_set_bits(info->regmap, AXP20X_ADC_EN1,
+			       AXP288_ADC_EN_MASK);
 }
 
 static const struct iio_info axp288_adc_iio_info = {
diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 5bc514bd5ebc..6bc149c51414 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -357,8 +357,8 @@ static int iproc_adc_enable(struct iio_dev *indio_dev)
 	int ret;
 
 	/* Set i_amux = 3b'000, select channel 0 */
-	ret = regmap_update_bits(adc_priv->regmap, IPROC_ANALOG_CONTROL,
-				IPROC_ADC_CHANNEL_SEL_MASK, 0);
+	ret = regmap_clear_bits(adc_priv->regmap, IPROC_ANALOG_CONTROL,
+				IPROC_ADC_CHANNEL_SEL_MASK);
 	if (ret) {
 		dev_err(&indio_dev->dev,
 			"failed to write IPROC_ANALOG_CONTROL %d\n", ret);
@@ -543,8 +543,8 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	if (adc_priv->irqno < 0)
 		return adc_priv->irqno;
 
-	ret = regmap_update_bits(adc_priv->regmap, IPROC_REGCTL2,
-				IPROC_ADC_AUXIN_SCAN_ENA, 0);
+	ret = regmap_clear_bits(adc_priv->regmap, IPROC_REGCTL2,
+				IPROC_ADC_AUXIN_SCAN_ENA);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to write IPROC_REGCTL2 %d\n", ret);
 		return ret;
diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
index a4e7c7eff5ac..4cdddc6e36e9 100644
--- a/drivers/iio/adc/berlin2-adc.c
+++ b/drivers/iio/adc/berlin2-adc.c
@@ -129,8 +129,8 @@ static int berlin2_adc_read(struct iio_dev *indio_dev, int channel)
 					       msecs_to_jiffies(1000));
 
 	/* Disable the interrupts */
-	regmap_update_bits(priv->regmap, BERLIN2_SM_ADC_STATUS,
-			   BERLIN2_SM_ADC_STATUS_INT_EN(channel), 0);
+	regmap_clear_bits(priv->regmap, BERLIN2_SM_ADC_STATUS,
+			  BERLIN2_SM_ADC_STATUS_INT_EN(channel));
 
 	if (ret == 0)
 		ret = -ETIMEDOUT;
@@ -139,8 +139,8 @@ static int berlin2_adc_read(struct iio_dev *indio_dev, int channel)
 		return ret;
 	}
 
-	regmap_update_bits(priv->regmap, BERLIN2_SM_CTRL,
-			   BERLIN2_SM_CTRL_ADC_START, 0);
+	regmap_clear_bits(priv->regmap, BERLIN2_SM_CTRL,
+			  BERLIN2_SM_CTRL_ADC_START);
 
 	data = priv->data;
 	priv->data_available = false;
@@ -180,8 +180,8 @@ static int berlin2_adc_tsen_read(struct iio_dev *indio_dev)
 					       msecs_to_jiffies(1000));
 
 	/* Disable interrupts */
-	regmap_update_bits(priv->regmap, BERLIN2_SM_TSEN_STATUS,
-			   BERLIN2_SM_TSEN_STATUS_INT_EN, 0);
+	regmap_clear_bits(priv->regmap, BERLIN2_SM_TSEN_STATUS,
+			  BERLIN2_SM_TSEN_STATUS_INT_EN);
 
 	if (ret == 0)
 		ret = -ETIMEDOUT;
@@ -190,8 +190,8 @@ static int berlin2_adc_tsen_read(struct iio_dev *indio_dev)
 		return ret;
 	}
 
-	regmap_update_bits(priv->regmap, BERLIN2_SM_TSEN_CTRL,
-			   BERLIN2_SM_TSEN_CTRL_START, 0);
+	regmap_clear_bits(priv->regmap, BERLIN2_SM_TSEN_CTRL,
+			  BERLIN2_SM_TSEN_CTRL_START);
 
 	data = priv->data;
 	priv->data_available = false;
@@ -284,8 +284,7 @@ static const struct iio_info berlin2_adc_info = {
 
 static void berlin2_adc_powerdown(void *regmap)
 {
-	regmap_update_bits(regmap, BERLIN2_SM_CTRL,
-			   BERLIN2_SM_CTRL_ADC_POWER, 0);
+	regmap_clear_bits(regmap, BERLIN2_SM_CTRL, BERLIN2_SM_CTRL_ADC_POWER);
 
 }
 
@@ -339,9 +338,8 @@ static int berlin2_adc_probe(struct platform_device *pdev)
 	indio_dev->num_channels = ARRAY_SIZE(berlin2_adc_channels);
 
 	/* Power up the ADC */
-	regmap_update_bits(priv->regmap, BERLIN2_SM_CTRL,
-			   BERLIN2_SM_CTRL_ADC_POWER,
-			   BERLIN2_SM_CTRL_ADC_POWER);
+	regmap_set_bits(priv->regmap, BERLIN2_SM_CTRL,
+			BERLIN2_SM_CTRL_ADC_POWER);
 
 	ret = devm_add_action_or_reset(&pdev->dev, berlin2_adc_powerdown,
 				       priv->regmap);
diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
index b6c4ef70484e..8fabf748c36b 100644
--- a/drivers/iio/adc/cpcap-adc.c
+++ b/drivers/iio/adc/cpcap-adc.c
@@ -385,9 +385,8 @@ static irqreturn_t cpcap_adc_irq_thread(int irq, void *data)
 	struct cpcap_adc *ddata = iio_priv(indio_dev);
 	int error;
 
-	error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
-				   CPCAP_BIT_ADTRIG_DIS,
-				   CPCAP_BIT_ADTRIG_DIS);
+	error = regmap_set_bits(ddata->reg, CPCAP_REG_ADCC2,
+				CPCAP_BIT_ADTRIG_DIS);
 	if (error)
 		return IRQ_NONE;
 
@@ -424,23 +423,17 @@ static void cpcap_adc_setup_calibrate(struct cpcap_adc *ddata,
 	if (error)
 		return;
 
-	error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
-				   CPCAP_BIT_ATOX_PS_FACTOR |
-				   CPCAP_BIT_ADC_PS_FACTOR1 |
-				   CPCAP_BIT_ADC_PS_FACTOR0,
-				   0);
+	error = regmap_clear_bits(ddata->reg, CPCAP_REG_ADCC2,
+				  CPCAP_BIT_ATOX_PS_FACTOR | CPCAP_BIT_ADC_PS_FACTOR1 | CPCAP_BIT_ADC_PS_FACTOR0);
 	if (error)
 		return;
 
-	error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
-				   CPCAP_BIT_ADTRIG_DIS,
-				   CPCAP_BIT_ADTRIG_DIS);
+	error = regmap_set_bits(ddata->reg, CPCAP_REG_ADCC2,
+				CPCAP_BIT_ADTRIG_DIS);
 	if (error)
 		return;
 
-	error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
-				   CPCAP_BIT_ASC,
-				   CPCAP_BIT_ASC);
+	error = regmap_set_bits(ddata->reg, CPCAP_REG_ADCC2, CPCAP_BIT_ASC);
 	if (error)
 		return;
 
@@ -455,8 +448,8 @@ static void cpcap_adc_setup_calibrate(struct cpcap_adc *ddata,
 		dev_err(ddata->dev,
 			"Timeout waiting for calibration to complete\n");
 
-	error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC1,
-				   CPCAP_BIT_CAL_MODE, 0);
+	error = regmap_clear_bits(ddata->reg, CPCAP_REG_ADCC1,
+				  CPCAP_BIT_CAL_MODE);
 	if (error)
 		return;
 }
@@ -602,26 +595,23 @@ static void cpcap_adc_setup_bank(struct cpcap_adc *ddata,
 		return;
 
 	if (req->timing == CPCAP_ADC_TIMING_IMM) {
-		error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
-					   CPCAP_BIT_ADTRIG_DIS,
-					   CPCAP_BIT_ADTRIG_DIS);
+		error = regmap_set_bits(ddata->reg, CPCAP_REG_ADCC2,
+					CPCAP_BIT_ADTRIG_DIS);
 		if (error)
 			return;
 
-		error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
-					   CPCAP_BIT_ASC,
-					   CPCAP_BIT_ASC);
+		error = regmap_set_bits(ddata->reg, CPCAP_REG_ADCC2,
+					CPCAP_BIT_ASC);
 		if (error)
 			return;
 	} else {
-		error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
-					   CPCAP_BIT_ADTRIG_ONESHOT,
-					   CPCAP_BIT_ADTRIG_ONESHOT);
+		error = regmap_set_bits(ddata->reg, CPCAP_REG_ADCC2,
+					CPCAP_BIT_ADTRIG_ONESHOT);
 		if (error)
 			return;
 
-		error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
-					   CPCAP_BIT_ADTRIG_DIS, 0);
+		error = regmap_clear_bits(ddata->reg, CPCAP_REG_ADCC2,
+					  CPCAP_BIT_ADTRIG_DIS);
 		if (error)
 			return;
 	}
diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index b680690631db..b3f037510e35 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -87,13 +87,13 @@ static irqreturn_t mx25_gcq_irq(int irq, void *data)
 	regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
 
 	if (stats & MX25_ADCQ_SR_EOQ) {
-		regmap_update_bits(priv->regs, MX25_ADCQ_MR,
-				   MX25_ADCQ_MR_EOQ_IRQ, MX25_ADCQ_MR_EOQ_IRQ);
+		regmap_set_bits(priv->regs, MX25_ADCQ_MR,
+				MX25_ADCQ_MR_EOQ_IRQ);
 		complete(&priv->completed);
 	}
 
 	/* Disable conversion queue run */
-	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FQS, 0);
+	regmap_clear_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FQS);
 
 	/* Acknowledge all possible irqs */
 	regmap_write(priv->regs, MX25_ADCQ_SR, MX25_ADCQ_SR_FRR |
@@ -115,11 +115,10 @@ static int mx25_gcq_get_raw_value(struct device *dev,
 	regmap_write(priv->regs, MX25_ADCQ_ITEM_7_0,
 		     MX25_ADCQ_ITEM(0, chan->channel));
 
-	regmap_update_bits(priv->regs, MX25_ADCQ_MR, MX25_ADCQ_MR_EOQ_IRQ, 0);
+	regmap_clear_bits(priv->regs, MX25_ADCQ_MR, MX25_ADCQ_MR_EOQ_IRQ);
 
 	/* Trigger queue for one run */
-	regmap_update_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FQS,
-			   MX25_ADCQ_CR_FQS);
+	regmap_set_bits(priv->regs, MX25_ADCQ_CR, MX25_ADCQ_CR_FQS);
 
 	time_left = wait_for_completion_interruptible_timeout(
 		&priv->completed, MX25_GCQ_TIMEOUT);
@@ -272,9 +271,8 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 				   MX25_ADCQ_CFG_REFN_MASK,
 				   refp | refn);
 	}
-	regmap_update_bits(priv->regs, MX25_ADCQ_CR,
-			   MX25_ADCQ_CR_FRST | MX25_ADCQ_CR_QRST,
-			   MX25_ADCQ_CR_FRST | MX25_ADCQ_CR_QRST);
+	regmap_set_bits(priv->regs, MX25_ADCQ_CR,
+			MX25_ADCQ_CR_FRST | MX25_ADCQ_CR_QRST);
 
 	regmap_write(priv->regs, MX25_ADCQ_CR,
 		     MX25_ADCQ_CR_PDMSK | MX25_ADCQ_CR_QSM_FQS);
diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 9e52207352fb..727e390bd979 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -1046,8 +1046,7 @@ static void ina2xx_remove(struct i2c_client *client)
 	iio_device_unregister(indio_dev);
 
 	/* Powerdown */
-	ret = regmap_update_bits(chip->regmap, INA2XX_CONFIG,
-				 INA2XX_MODE_MASK, 0);
+	ret = regmap_clear_bits(chip->regmap, INA2XX_CONFIG, INA2XX_MODE_MASK);
 	if (ret)
 		dev_warn(&client->dev, "Failed to power down device (%pe)\n",
 			 ERR_PTR(ret));
diff --git a/drivers/iio/adc/intel_mrfld_adc.c b/drivers/iio/adc/intel_mrfld_adc.c
index c7f40ae6e608..0590a126f321 100644
--- a/drivers/iio/adc/intel_mrfld_adc.c
+++ b/drivers/iio/adc/intel_mrfld_adc.c
@@ -81,8 +81,8 @@ static int mrfld_adc_single_conv(struct iio_dev *indio_dev,
 
 	reinit_completion(&adc->completion);
 
-	regmap_update_bits(regmap, BCOVE_MADCIRQ, BCOVE_ADCIRQ_ALL, 0);
-	regmap_update_bits(regmap, BCOVE_MIRQLVL1, BCOVE_LVL1_ADC, 0);
+	regmap_clear_bits(regmap, BCOVE_MADCIRQ, BCOVE_ADCIRQ_ALL);
+	regmap_clear_bits(regmap, BCOVE_MIRQLVL1, BCOVE_LVL1_ADC);
 
 	ret = regmap_read_poll_timeout(regmap, BCOVE_GPADCREQ, req,
 				       !(req & BCOVE_GPADCREQ_BUSY),
diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 13b473d8c6c7..c7a078de1678 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -546,35 +546,31 @@ static void meson_sar_adc_start_sample_engine(struct iio_dev *indio_dev)
 
 	reinit_completion(&priv->done);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
-			   MESON_SAR_ADC_REG0_FIFO_IRQ_EN,
-			   MESON_SAR_ADC_REG0_FIFO_IRQ_EN);
+	regmap_set_bits(priv->regmap, MESON_SAR_ADC_REG0,
+			MESON_SAR_ADC_REG0_FIFO_IRQ_EN);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
-			   MESON_SAR_ADC_REG0_SAMPLE_ENGINE_ENABLE,
-			   MESON_SAR_ADC_REG0_SAMPLE_ENGINE_ENABLE);
+	regmap_set_bits(priv->regmap, MESON_SAR_ADC_REG0,
+			MESON_SAR_ADC_REG0_SAMPLE_ENGINE_ENABLE);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
-			   MESON_SAR_ADC_REG0_SAMPLING_START,
-			   MESON_SAR_ADC_REG0_SAMPLING_START);
+	regmap_set_bits(priv->regmap, MESON_SAR_ADC_REG0,
+			MESON_SAR_ADC_REG0_SAMPLING_START);
 }
 
 static void meson_sar_adc_stop_sample_engine(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
-			   MESON_SAR_ADC_REG0_FIFO_IRQ_EN, 0);
+	regmap_clear_bits(priv->regmap, MESON_SAR_ADC_REG0,
+			  MESON_SAR_ADC_REG0_FIFO_IRQ_EN);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
-			   MESON_SAR_ADC_REG0_SAMPLING_STOP,
-			   MESON_SAR_ADC_REG0_SAMPLING_STOP);
+	regmap_set_bits(priv->regmap, MESON_SAR_ADC_REG0,
+			MESON_SAR_ADC_REG0_SAMPLING_STOP);
 
 	/* wait until all modules are stopped */
 	meson_sar_adc_wait_busy_clear(indio_dev);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
-			   MESON_SAR_ADC_REG0_SAMPLE_ENGINE_ENABLE, 0);
+	regmap_clear_bits(priv->regmap, MESON_SAR_ADC_REG0,
+			  MESON_SAR_ADC_REG0_SAMPLE_ENGINE_ENABLE);
 }
 
 static int meson_sar_adc_lock(struct iio_dev *indio_dev)
@@ -586,9 +582,8 @@ static int meson_sar_adc_lock(struct iio_dev *indio_dev)
 
 	if (priv->param->has_bl30_integration) {
 		/* prevent BL30 from using the SAR ADC while we are using it */
-		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELAY,
-				   MESON_SAR_ADC_DELAY_KERNEL_BUSY,
-				   MESON_SAR_ADC_DELAY_KERNEL_BUSY);
+		regmap_set_bits(priv->regmap, MESON_SAR_ADC_DELAY,
+				MESON_SAR_ADC_DELAY_KERNEL_BUSY);
 
 		udelay(1);
 
@@ -614,8 +609,8 @@ static void meson_sar_adc_unlock(struct iio_dev *indio_dev)
 
 	if (priv->param->has_bl30_integration)
 		/* allow BL30 to use the SAR ADC again */
-		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELAY,
-				   MESON_SAR_ADC_DELAY_KERNEL_BUSY, 0);
+		regmap_clear_bits(priv->regmap, MESON_SAR_ADC_DELAY,
+				  MESON_SAR_ADC_DELAY_KERNEL_BUSY);
 
 	mutex_unlock(&priv->lock);
 }
@@ -869,17 +864,16 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 	 * disable this bit as seems to be only relevant for Meson6 (based
 	 * on the vendor driver), which we don't support at the moment.
 	 */
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
-			   MESON_SAR_ADC_REG0_ADC_TEMP_SEN_SEL, 0);
+	regmap_clear_bits(priv->regmap, MESON_SAR_ADC_REG0,
+			  MESON_SAR_ADC_REG0_ADC_TEMP_SEN_SEL);
 
 	/* disable all channels by default */
 	regmap_write(priv->regmap, MESON_SAR_ADC_CHAN_LIST, 0x0);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
-			   MESON_SAR_ADC_REG3_CTRL_SAMPLING_CLOCK_PHASE, 0);
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
-			   MESON_SAR_ADC_REG3_CNTL_USE_SC_DLY,
-			   MESON_SAR_ADC_REG3_CNTL_USE_SC_DLY);
+	regmap_clear_bits(priv->regmap, MESON_SAR_ADC_REG3,
+			  MESON_SAR_ADC_REG3_CTRL_SAMPLING_CLOCK_PHASE);
+	regmap_set_bits(priv->regmap, MESON_SAR_ADC_REG3,
+			MESON_SAR_ADC_REG3_CNTL_USE_SC_DLY);
 
 	/* delay between two samples = (10+1) * 1uS */
 	regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELAY,
@@ -914,21 +908,17 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 			   MESON_SAR_ADC_CHAN_10_SW_CHAN1_MUX_SEL_MASK,
 			   regval);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_CHAN_10_SW,
-			   MESON_SAR_ADC_CHAN_10_SW_CHAN0_XP_DRIVE_SW,
-			   MESON_SAR_ADC_CHAN_10_SW_CHAN0_XP_DRIVE_SW);
+	regmap_set_bits(priv->regmap, MESON_SAR_ADC_CHAN_10_SW,
+			MESON_SAR_ADC_CHAN_10_SW_CHAN0_XP_DRIVE_SW);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_CHAN_10_SW,
-			   MESON_SAR_ADC_CHAN_10_SW_CHAN0_YP_DRIVE_SW,
-			   MESON_SAR_ADC_CHAN_10_SW_CHAN0_YP_DRIVE_SW);
+	regmap_set_bits(priv->regmap, MESON_SAR_ADC_CHAN_10_SW,
+			MESON_SAR_ADC_CHAN_10_SW_CHAN0_YP_DRIVE_SW);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_CHAN_10_SW,
-			   MESON_SAR_ADC_CHAN_10_SW_CHAN1_XP_DRIVE_SW,
-			   MESON_SAR_ADC_CHAN_10_SW_CHAN1_XP_DRIVE_SW);
+	regmap_set_bits(priv->regmap, MESON_SAR_ADC_CHAN_10_SW,
+			MESON_SAR_ADC_CHAN_10_SW_CHAN1_XP_DRIVE_SW);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_CHAN_10_SW,
-			   MESON_SAR_ADC_CHAN_10_SW_CHAN1_YP_DRIVE_SW,
-			   MESON_SAR_ADC_CHAN_10_SW_CHAN1_YP_DRIVE_SW);
+	regmap_set_bits(priv->regmap, MESON_SAR_ADC_CHAN_10_SW,
+			MESON_SAR_ADC_CHAN_10_SW_CHAN1_YP_DRIVE_SW);
 
 	/*
 	 * set up the input channel muxes in MESON_SAR_ADC_AUX_SW
@@ -944,12 +934,10 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 	regmap_write(priv->regmap, MESON_SAR_ADC_AUX_SW, regval);
 
 	if (priv->temperature_sensor_calibrated) {
-		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
-				   MESON_SAR_ADC_DELTA_10_TS_REVE1,
-				   MESON_SAR_ADC_DELTA_10_TS_REVE1);
-		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
-				   MESON_SAR_ADC_DELTA_10_TS_REVE0,
-				   MESON_SAR_ADC_DELTA_10_TS_REVE0);
+		regmap_set_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
+				MESON_SAR_ADC_DELTA_10_TS_REVE1);
+		regmap_set_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
+				MESON_SAR_ADC_DELTA_10_TS_REVE0);
 
 		/*
 		 * set bits [3:0] of the TSC (temperature sensor coefficient)
@@ -976,10 +964,10 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 					   regval);
 		}
 	} else {
-		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
-				   MESON_SAR_ADC_DELTA_10_TS_REVE1, 0);
-		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
-				   MESON_SAR_ADC_DELTA_10_TS_REVE0, 0);
+		regmap_clear_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
+				  MESON_SAR_ADC_DELTA_10_TS_REVE1);
+		regmap_clear_bits(priv->regmap, MESON_SAR_ADC_DELTA_10,
+				  MESON_SAR_ADC_DELTA_10_TS_REVE0);
 	}
 
 	regval = FIELD_PREP(MESON_SAR_ADC_REG3_CTRL_CONT_RING_COUNTER_EN,
@@ -1062,9 +1050,8 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
 
 	meson_sar_adc_set_bandgap(indio_dev, true);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
-			   MESON_SAR_ADC_REG3_ADC_EN,
-			   MESON_SAR_ADC_REG3_ADC_EN);
+	regmap_set_bits(priv->regmap, MESON_SAR_ADC_REG3,
+			MESON_SAR_ADC_REG3_ADC_EN);
 
 	udelay(5);
 
@@ -1079,8 +1066,8 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
 	return 0;
 
 err_adc_clk:
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
-			   MESON_SAR_ADC_REG3_ADC_EN, 0);
+	regmap_clear_bits(priv->regmap, MESON_SAR_ADC_REG3,
+			  MESON_SAR_ADC_REG3_ADC_EN);
 	meson_sar_adc_set_bandgap(indio_dev, false);
 	regulator_disable(priv->vref);
 err_vref:
@@ -1104,8 +1091,8 @@ static void meson_sar_adc_hw_disable(struct iio_dev *indio_dev)
 
 	clk_disable_unprepare(priv->adc_clk);
 
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
-			   MESON_SAR_ADC_REG3_ADC_EN, 0);
+	regmap_clear_bits(priv->regmap, MESON_SAR_ADC_REG3,
+		          MESON_SAR_ADC_REG3_ADC_EN);
 
 	meson_sar_adc_set_bandgap(indio_dev, false);
 
diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
index 7c66c2cd5be2..5f672765d4a2 100644
--- a/drivers/iio/adc/mp2629_adc.c
+++ b/drivers/iio/adc/mp2629_adc.c
@@ -131,9 +131,8 @@ static int mp2629_adc_probe(struct platform_device *pdev)
 	info->dev = dev;
 	platform_set_drvdata(pdev, indio_dev);
 
-	ret = regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
-				MP2629_ADC_START | MP2629_ADC_CONTINUOUS,
-				MP2629_ADC_START | MP2629_ADC_CONTINUOUS);
+	ret = regmap_set_bits(info->regmap, MP2629_REG_ADC_CTRL,
+			      MP2629_ADC_START | MP2629_ADC_CONTINUOUS);
 	if (ret) {
 		dev_err(dev, "adc enable fail: %d\n", ret);
 		return ret;
@@ -163,10 +162,9 @@ static int mp2629_adc_probe(struct platform_device *pdev)
 	iio_map_array_unregister(indio_dev);
 
 fail_disable:
-	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
-					 MP2629_ADC_CONTINUOUS, 0);
-	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
-					 MP2629_ADC_START, 0);
+	regmap_clear_bits(info->regmap, MP2629_REG_ADC_CTRL,
+			  MP2629_ADC_CONTINUOUS);
+	regmap_clear_bits(info->regmap, MP2629_REG_ADC_CTRL, MP2629_ADC_START);
 
 	return ret;
 }
@@ -180,10 +178,9 @@ static void mp2629_adc_remove(struct platform_device *pdev)
 
 	iio_map_array_unregister(indio_dev);
 
-	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
-					 MP2629_ADC_CONTINUOUS, 0);
-	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
-					 MP2629_ADC_START, 0);
+	regmap_clear_bits(info->regmap, MP2629_REG_ADC_CTRL,
+			  MP2629_ADC_CONTINUOUS);
+	regmap_clear_bits(info->regmap, MP2629_REG_ADC_CTRL, MP2629_ADC_START);
 }
 
 static const struct of_device_id mp2629_adc_of_match[] = {
diff --git a/drivers/iio/adc/qcom-spmi-rradc.c b/drivers/iio/adc/qcom-spmi-rradc.c
index 56a713766954..1402df68dd52 100644
--- a/drivers/iio/adc/qcom-spmi-rradc.c
+++ b/drivers/iio/adc/qcom-spmi-rradc.c
@@ -358,15 +358,15 @@ static int rradc_enable_continuous_mode(struct rradc_chip *chip)
 	int ret;
 
 	/* Clear channel log */
-	ret = regmap_update_bits(chip->regmap, chip->base + RR_ADC_LOG,
-				 RR_ADC_LOG_CLR_CTRL, RR_ADC_LOG_CLR_CTRL);
+	ret = regmap_set_bits(chip->regmap, chip->base + RR_ADC_LOG,
+			      RR_ADC_LOG_CLR_CTRL);
 	if (ret < 0) {
 		dev_err(chip->dev, "log ctrl update to clear failed:%d\n", ret);
 		return ret;
 	}
 
-	ret = regmap_update_bits(chip->regmap, chip->base + RR_ADC_LOG,
-				 RR_ADC_LOG_CLR_CTRL, 0);
+	ret = regmap_clear_bits(chip->regmap, chip->base + RR_ADC_LOG,
+				RR_ADC_LOG_CLR_CTRL);
 	if (ret < 0) {
 		dev_err(chip->dev, "log ctrl update to not clear failed:%d\n",
 			ret);
@@ -374,9 +374,8 @@ static int rradc_enable_continuous_mode(struct rradc_chip *chip)
 	}
 
 	/* Switch to continuous mode */
-	ret = regmap_update_bits(chip->regmap, chip->base + RR_ADC_CTL,
-				 RR_ADC_CTL_CONTINUOUS_SEL,
-				 RR_ADC_CTL_CONTINUOUS_SEL);
+	ret = regmap_set_bits(chip->regmap, chip->base + RR_ADC_CTL,
+			      RR_ADC_CTL_CONTINUOUS_SEL);
 	if (ret < 0)
 		dev_err(chip->dev, "Update to continuous mode failed:%d\n",
 			ret);
@@ -389,8 +388,8 @@ static int rradc_disable_continuous_mode(struct rradc_chip *chip)
 	int ret;
 
 	/* Switch to non continuous mode */
-	ret = regmap_update_bits(chip->regmap, chip->base + RR_ADC_CTL,
-				 RR_ADC_CTL_CONTINUOUS_SEL, 0);
+	ret = regmap_clear_bits(chip->regmap, chip->base + RR_ADC_CTL,
+				RR_ADC_CTL_CONTINUOUS_SEL);
 	if (ret < 0)
 		dev_err(chip->dev, "Update to non-continuous mode failed:%d\n",
 			ret);
@@ -434,8 +433,8 @@ static int rradc_read_status_in_cont_mode(struct rradc_chip *chip,
 		return -EINVAL;
 	}
 
-	ret = regmap_update_bits(chip->regmap, chip->base + chan->trigger_addr,
-				 chan->trigger_mask, chan->trigger_mask);
+	ret = regmap_set_bits(chip->regmap, chip->base + chan->trigger_addr,
+			      chan->trigger_mask);
 	if (ret < 0) {
 		dev_err(chip->dev,
 			"Failed to apply trigger for channel '%s' ret=%d\n",
@@ -469,8 +468,8 @@ static int rradc_read_status_in_cont_mode(struct rradc_chip *chip,
 	rradc_disable_continuous_mode(chip);
 
 disable_trigger:
-	regmap_update_bits(chip->regmap, chip->base + chan->trigger_addr,
-			   chan->trigger_mask, 0);
+	regmap_clear_bits(chip->regmap, chip->base + chan->trigger_addr,
+			  chan->trigger_mask);
 
 	return ret;
 }
@@ -481,17 +480,16 @@ static int rradc_prepare_batt_id_conversion(struct rradc_chip *chip,
 {
 	int ret;
 
-	ret = regmap_update_bits(chip->regmap, chip->base + RR_ADC_BATT_ID_CTRL,
-				 RR_ADC_BATT_ID_CTRL_CHANNEL_CONV,
-				 RR_ADC_BATT_ID_CTRL_CHANNEL_CONV);
+	ret = regmap_set_bits(chip->regmap, chip->base + RR_ADC_BATT_ID_CTRL,
+			      RR_ADC_BATT_ID_CTRL_CHANNEL_CONV);
 	if (ret < 0) {
 		dev_err(chip->dev, "Enabling BATT ID channel failed:%d\n", ret);
 		return ret;
 	}
 
-	ret = regmap_update_bits(chip->regmap,
-				 chip->base + RR_ADC_BATT_ID_TRIGGER,
-				 RR_ADC_TRIGGER_CTL, RR_ADC_TRIGGER_CTL);
+	ret = regmap_set_bits(chip->regmap,
+			      chip->base + RR_ADC_BATT_ID_TRIGGER,
+			      RR_ADC_TRIGGER_CTL);
 	if (ret < 0) {
 		dev_err(chip->dev, "BATT_ID trigger set failed:%d\n", ret);
 		goto out_disable_batt_id;
@@ -500,12 +498,12 @@ static int rradc_prepare_batt_id_conversion(struct rradc_chip *chip,
 	ret = rradc_read_status_in_cont_mode(chip, chan_address);
 
 	/* Reset registers back to default values */
-	regmap_update_bits(chip->regmap, chip->base + RR_ADC_BATT_ID_TRIGGER,
-			   RR_ADC_TRIGGER_CTL, 0);
+	regmap_clear_bits(chip->regmap, chip->base + RR_ADC_BATT_ID_TRIGGER,
+			  RR_ADC_TRIGGER_CTL);
 
 out_disable_batt_id:
-	regmap_update_bits(chip->regmap, chip->base + RR_ADC_BATT_ID_CTRL,
-			   RR_ADC_BATT_ID_CTRL_CHANNEL_CONV, 0);
+	regmap_clear_bits(chip->regmap, chip->base + RR_ADC_BATT_ID_CTRL,
+			  RR_ADC_BATT_ID_CTRL_CHANNEL_CONV);
 
 	return ret;
 }
@@ -965,9 +963,9 @@ static int rradc_probe(struct platform_device *pdev)
 
 	if (batt_id_delay >= 0) {
 		batt_id_delay = FIELD_PREP(BATT_ID_SETTLE_MASK, batt_id_delay);
-		ret = regmap_update_bits(chip->regmap,
-					 chip->base + RR_ADC_BATT_ID_CFG,
-					 batt_id_delay, batt_id_delay);
+		ret = regmap_set_bits(chip->regmap,
+				      chip->base + RR_ADC_BATT_ID_CFG,
+				      batt_id_delay);
 		if (ret < 0) {
 			dev_err(chip->dev,
 				"BATT_ID settling time config failed:%d\n",
diff --git a/drivers/iio/adc/rn5t618-adc.c b/drivers/iio/adc/rn5t618-adc.c
index 6bf32907f01d..ce5f3011fe00 100644
--- a/drivers/iio/adc/rn5t618-adc.c
+++ b/drivers/iio/adc/rn5t618-adc.c
@@ -137,9 +137,8 @@ static int rn5t618_adc_read(struct iio_dev *iio_dev,
 
 	init_completion(&adc->conv_completion);
 	/* single conversion */
-	ret = regmap_update_bits(adc->rn5t618->regmap, RN5T618_ADCCNT3,
-				 RN5T618_ADCCNT3_GODONE,
-				 RN5T618_ADCCNT3_GODONE);
+	ret = regmap_set_bits(adc->rn5t618->regmap, RN5T618_ADCCNT3,
+			      RN5T618_ADCCNT3_GODONE);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index b4a2e057d80f..2535c2c3e60b 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -508,13 +508,13 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 		}
 	}
 
-	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
-				 SC27XX_ADC_EN, SC27XX_ADC_EN);
+	ret = regmap_set_bits(data->regmap, data->base + SC27XX_ADC_CTL,
+			      SC27XX_ADC_EN);
 	if (ret)
 		goto regulator_restore;
 
-	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_INT_CLR,
-				 SC27XX_ADC_IRQ_CLR, SC27XX_ADC_IRQ_CLR);
+	ret = regmap_set_bits(data->regmap, data->base + SC27XX_ADC_INT_CLR,
+			      SC27XX_ADC_IRQ_CLR);
 	if (ret)
 		goto disable_adc;
 
@@ -537,8 +537,8 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 	if (ret)
 		goto disable_adc;
 
-	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
-				 SC27XX_ADC_CHN_RUN, SC27XX_ADC_CHN_RUN);
+	ret = regmap_set_bits(data->regmap, data->base + SC27XX_ADC_CTL,
+			      SC27XX_ADC_CHN_RUN);
 	if (ret)
 		goto disable_adc;
 
@@ -559,8 +559,8 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 	value &= SC27XX_ADC_DATA_MASK;
 
 disable_adc:
-	regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
-			   SC27XX_ADC_EN, 0);
+	regmap_clear_bits(data->regmap, data->base + SC27XX_ADC_CTL,
+			  SC27XX_ADC_EN);
 regulator_restore:
 	if ((data->var_data->set_volref) && (channel == 30 || channel == 31)) {
 		ret_volref = regulator_set_voltage(data->volref,
@@ -765,15 +765,14 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
 {
 	int ret;
 
-	ret = regmap_update_bits(data->regmap, data->var_data->module_en,
-				 SC27XX_MODULE_ADC_EN, SC27XX_MODULE_ADC_EN);
+	ret = regmap_set_bits(data->regmap, data->var_data->module_en,
+			      SC27XX_MODULE_ADC_EN);
 	if (ret)
 		return ret;
 
 	/* Enable ADC work clock and controller clock */
-	ret = regmap_update_bits(data->regmap, data->var_data->clk_en,
-				 SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN,
-				 SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN);
+	ret = regmap_set_bits(data->regmap, data->var_data->clk_en,
+			      SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN);
 	if (ret)
 		goto disable_adc;
 
@@ -789,11 +788,11 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
 	return 0;
 
 disable_clk:
-	regmap_update_bits(data->regmap, data->var_data->clk_en,
-			   SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN, 0);
+	regmap_clear_bits(data->regmap, data->var_data->clk_en,
+			  SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN);
 disable_adc:
-	regmap_update_bits(data->regmap, data->var_data->module_en,
-			   SC27XX_MODULE_ADC_EN, 0);
+	regmap_clear_bits(data->regmap, data->var_data->module_en,
+			  SC27XX_MODULE_ADC_EN);
 
 	return ret;
 }
@@ -803,11 +802,11 @@ static void sc27xx_adc_disable(void *_data)
 	struct sc27xx_adc_data *data = _data;
 
 	/* Disable ADC work clock and controller clock */
-	regmap_update_bits(data->regmap, data->var_data->clk_en,
-			   SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN, 0);
+	regmap_clear_bits(data->regmap, data->var_data->clk_en,
+			  SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN);
 
-	regmap_update_bits(data->regmap, data->var_data->module_en,
-			   SC27XX_MODULE_ADC_EN, 0);
+	regmap_clear_bits(data->regmap, data->var_data->module_en,
+			  SC27XX_MODULE_ADC_EN);
 }
 
 static const struct sc27xx_adc_variant_data sc2731_data = {
diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 9a47d2c87f05..fabd654245f5 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -759,8 +759,7 @@ static int stm32_dfsdm_start_conv(struct iio_dev *indio_dev,
 	return 0;
 
 filter_unconfigure:
-	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
-			   DFSDM_CR1_CFG_MASK, 0);
+	regmap_clear_bits(regmap, DFSDM_CR1(adc->fl_id), DFSDM_CR1_CFG_MASK);
 stop_channels:
 	stm32_dfsdm_stop_channel(indio_dev);
 
@@ -774,8 +773,7 @@ static void stm32_dfsdm_stop_conv(struct iio_dev *indio_dev)
 
 	stm32_dfsdm_stop_filter(adc->dfsdm, adc->fl_id);
 
-	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
-			   DFSDM_CR1_CFG_MASK, 0);
+	regmap_clear_bits(regmap, DFSDM_CR1(adc->fl_id), DFSDM_CR1_CFG_MASK);
 
 	stm32_dfsdm_stop_channel(indio_dev);
 }
@@ -951,16 +949,14 @@ static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
 
 	if (adc->nconv == 1 && !indio_dev->trig) {
 		/* Enable regular DMA transfer*/
-		ret = regmap_update_bits(adc->dfsdm->regmap,
-					 DFSDM_CR1(adc->fl_id),
-					 DFSDM_CR1_RDMAEN_MASK,
-					 DFSDM_CR1_RDMAEN_MASK);
+		ret = regmap_set_bits(adc->dfsdm->regmap,
+				      DFSDM_CR1(adc->fl_id),
+				      DFSDM_CR1_RDMAEN_MASK);
 	} else {
 		/* Enable injected DMA transfer*/
-		ret = regmap_update_bits(adc->dfsdm->regmap,
-					 DFSDM_CR1(adc->fl_id),
-					 DFSDM_CR1_JDMAEN_MASK,
-					 DFSDM_CR1_JDMAEN_MASK);
+		ret = regmap_set_bits(adc->dfsdm->regmap,
+				      DFSDM_CR1(adc->fl_id),
+				      DFSDM_CR1_JDMAEN_MASK);
 	}
 
 	if (ret < 0)
@@ -981,8 +977,8 @@ static void stm32_dfsdm_adc_dma_stop(struct iio_dev *indio_dev)
 	if (!adc->dma_chan)
 		return;
 
-	regmap_update_bits(adc->dfsdm->regmap, DFSDM_CR1(adc->fl_id),
-			   DFSDM_CR1_RDMAEN_MASK | DFSDM_CR1_JDMAEN_MASK, 0);
+	regmap_clear_bits(adc->dfsdm->regmap, DFSDM_CR1(adc->fl_id),
+			  DFSDM_CR1_RDMAEN_MASK | DFSDM_CR1_JDMAEN_MASK);
 	dmaengine_terminate_all(adc->dma_chan);
 }
 
@@ -1305,9 +1301,8 @@ static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
 	if (status & DFSDM_ISR_ROVRF_MASK) {
 		if (int_en & DFSDM_CR2_ROVRIE_MASK)
 			dev_warn(&indio_dev->dev, "Overrun detected\n");
-		regmap_update_bits(regmap, DFSDM_ICR(adc->fl_id),
-				   DFSDM_ICR_CLRROVRF_MASK,
-				   DFSDM_ICR_CLRROVRF_MASK);
+		regmap_set_bits(regmap, DFSDM_ICR(adc->fl_id),
+				DFSDM_ICR_CLRROVRF_MASK);
 	}
 
 	return IRQ_HANDLED;
diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
index c4b1ba30f935..af50d2a95898 100644
--- a/drivers/iio/dac/ltc2688.c
+++ b/drivers/iio/dac/ltc2688.c
@@ -860,9 +860,8 @@ static int ltc2688_setup(struct ltc2688_state *st, struct regulator *vref)
 		/* bring device out of reset */
 		gpiod_set_value_cansleep(gpio, 0);
 	} else {
-		ret = regmap_update_bits(st->regmap, LTC2688_CMD_CONFIG,
-					 LTC2688_CONFIG_RST,
-					 LTC2688_CONFIG_RST);
+		ret = regmap_set_bits(st->regmap, LTC2688_CMD_CONFIG,
+				      LTC2688_CONFIG_RST);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac-core.c
index e150ac729154..2d567073996b 100644
--- a/drivers/iio/dac/stm32-dac-core.c
+++ b/drivers/iio/dac/stm32-dac-core.c
@@ -200,9 +200,8 @@ static int stm32_dac_core_resume(struct device *dev)
 
 	if (priv->common.hfsel) {
 		/* restore hfsel (maybe lost under low power state) */
-		ret = regmap_update_bits(priv->common.regmap, STM32_DAC_CR,
-					 STM32H7_DAC_CR_HFSEL,
-					 STM32H7_DAC_CR_HFSEL);
+		ret = regmap_set_bits(priv->common.regmap, STM32_DAC_CR,
+				      STM32H7_DAC_CR_HFSEL);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 0e2eb0e98235..10728d5ccae3 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -285,8 +285,8 @@ static int bmg160_chip_init(struct bmg160_data *data)
 	data->slope_thres = val;
 
 	/* Set default interrupt mode */
-	ret = regmap_update_bits(data->regmap, BMG160_REG_INT_EN_1,
-				 BMG160_INT1_BIT_OD, 0);
+	ret = regmap_clear_bits(data->regmap, BMG160_REG_INT_EN_1,
+				BMG160_INT1_BIT_OD);
 	if (ret < 0) {
 		dev_err(dev, "Error updating bits in reg_int_en_1\n");
 		return ret;
diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index a791ba3a693a..ff1c81553045 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -197,8 +197,8 @@ static int mpu3050_start_sampling(struct mpu3050 *mpu3050)
 	int i;
 
 	/* Reset */
-	ret = regmap_update_bits(mpu3050->map, MPU3050_PWR_MGM,
-				 MPU3050_PWR_MGM_RESET, MPU3050_PWR_MGM_RESET);
+	ret = regmap_set_bits(mpu3050->map, MPU3050_PWR_MGM,
+			      MPU3050_PWR_MGM_RESET);
 	if (ret)
 		return ret;
 
@@ -513,12 +513,8 @@ static irqreturn_t mpu3050_trigger_handler(int irq, void *p)
 				 "FIFO overflow! Emptying and resetting FIFO\n");
 			fifo_overflow = true;
 			/* Reset and enable the FIFO */
-			ret = regmap_update_bits(mpu3050->map,
-						 MPU3050_USR_CTRL,
-						 MPU3050_USR_CTRL_FIFO_EN |
-						 MPU3050_USR_CTRL_FIFO_RST,
-						 MPU3050_USR_CTRL_FIFO_EN |
-						 MPU3050_USR_CTRL_FIFO_RST);
+			ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
+					      MPU3050_USR_CTRL_FIFO_EN | MPU3050_USR_CTRL_FIFO_RST);
 			if (ret) {
 				dev_info(mpu3050->dev, "error resetting FIFO\n");
 				goto out_trigger_unlock;
@@ -799,10 +795,8 @@ static int mpu3050_hw_init(struct mpu3050 *mpu3050)
 	u64 otp;
 
 	/* Reset */
-	ret = regmap_update_bits(mpu3050->map,
-				 MPU3050_PWR_MGM,
-				 MPU3050_PWR_MGM_RESET,
-				 MPU3050_PWR_MGM_RESET);
+	ret = regmap_set_bits(mpu3050->map, MPU3050_PWR_MGM,
+			      MPU3050_PWR_MGM_RESET);
 	if (ret)
 		return ret;
 
@@ -872,8 +866,8 @@ static int mpu3050_power_up(struct mpu3050 *mpu3050)
 	msleep(200);
 
 	/* Take device out of sleep mode */
-	ret = regmap_update_bits(mpu3050->map, MPU3050_PWR_MGM,
-				 MPU3050_PWR_MGM_SLEEP, 0);
+	ret = regmap_clear_bits(mpu3050->map, MPU3050_PWR_MGM,
+				MPU3050_PWR_MGM_SLEEP);
 	if (ret) {
 		regulator_bulk_disable(ARRAY_SIZE(mpu3050->regs), mpu3050->regs);
 		dev_err(mpu3050->dev, "error setting power mode\n");
@@ -895,8 +889,8 @@ static int mpu3050_power_down(struct mpu3050 *mpu3050)
 	 * then we would be wasting power unless we go to sleep mode
 	 * first.
 	 */
-	ret = regmap_update_bits(mpu3050->map, MPU3050_PWR_MGM,
-				 MPU3050_PWR_MGM_SLEEP, MPU3050_PWR_MGM_SLEEP);
+	ret = regmap_set_bits(mpu3050->map, MPU3050_PWR_MGM,
+			      MPU3050_PWR_MGM_SLEEP);
 	if (ret)
 		dev_err(mpu3050->dev, "error putting to sleep\n");
 
@@ -997,11 +991,8 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
 			return ret;
 
 		/* Reset and enable the FIFO */
-		ret = regmap_update_bits(mpu3050->map, MPU3050_USR_CTRL,
-					 MPU3050_USR_CTRL_FIFO_EN |
-					 MPU3050_USR_CTRL_FIFO_RST,
-					 MPU3050_USR_CTRL_FIFO_EN |
-					 MPU3050_USR_CTRL_FIFO_RST);
+		ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
+				      MPU3050_USR_CTRL_FIFO_EN | MPU3050_USR_CTRL_FIFO_RST);
 		if (ret)
 			return ret;
 
diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 1dbe48dae74e..52326dc521ac 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -422,9 +422,8 @@ static int afe4403_suspend(struct device *dev)
 	struct afe4403_data *afe = iio_priv(indio_dev);
 	int ret;
 
-	ret = regmap_update_bits(afe->regmap, AFE440X_CONTROL2,
-				 AFE440X_CONTROL2_PDN_AFE,
-				 AFE440X_CONTROL2_PDN_AFE);
+	ret = regmap_set_bits(afe->regmap, AFE440X_CONTROL2,
+			      AFE440X_CONTROL2_PDN_AFE);
 	if (ret)
 		return ret;
 
@@ -449,8 +448,8 @@ static int afe4403_resume(struct device *dev)
 		return ret;
 	}
 
-	ret = regmap_update_bits(afe->regmap, AFE440X_CONTROL2,
-				 AFE440X_CONTROL2_PDN_AFE, 0);
+	ret = regmap_clear_bits(afe->regmap, AFE440X_CONTROL2,
+				AFE440X_CONTROL2_PDN_AFE);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 7768b07ef7a6..51f4be39d20b 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -430,9 +430,8 @@ static int afe4404_suspend(struct device *dev)
 	struct afe4404_data *afe = iio_priv(indio_dev);
 	int ret;
 
-	ret = regmap_update_bits(afe->regmap, AFE440X_CONTROL2,
-				 AFE440X_CONTROL2_PDN_AFE,
-				 AFE440X_CONTROL2_PDN_AFE);
+	ret = regmap_set_bits(afe->regmap, AFE440X_CONTROL2,
+			      AFE440X_CONTROL2_PDN_AFE);
 	if (ret)
 		return ret;
 
@@ -457,8 +456,8 @@ static int afe4404_resume(struct device *dev)
 		return ret;
 	}
 
-	ret = regmap_update_bits(afe->regmap, AFE440X_CONTROL2,
-				 AFE440X_CONTROL2_PDN_AFE, 0);
+	ret = regmap_clear_bits(afe->regmap, AFE440X_CONTROL2,
+				AFE440X_CONTROL2_PDN_AFE);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index 6236b4d96137..c1867c2ef8e2 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -363,9 +363,8 @@ static int max30100_get_temp(struct max30100_data *data, int *val)
 	int ret;
 
 	/* start acquisition */
-	ret = regmap_update_bits(data->regmap, MAX30100_REG_MODE_CONFIG,
-				 MAX30100_REG_MODE_CONFIG_TEMP_EN,
-				 MAX30100_REG_MODE_CONFIG_TEMP_EN);
+	ret = regmap_set_bits(data->regmap, MAX30100_REG_MODE_CONFIG,
+			      MAX30100_REG_MODE_CONFIG_TEMP_EN);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 6616729af5b7..07a343e35a81 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -448,9 +448,8 @@ static int max30102_get_temp(struct max30102_data *data, int *val, bool en)
 	}
 
 	/* start acquisition */
-	ret = regmap_update_bits(data->regmap, MAX30102_REG_TEMP_CONFIG,
-				 MAX30102_REG_TEMP_CONFIG_TEMP_EN,
-				 MAX30102_REG_TEMP_CONFIG_TEMP_EN);
+	ret = regmap_set_bits(data->regmap, MAX30102_REG_TEMP_CONFIG,
+			      MAX30102_REG_TEMP_CONFIG_TEMP_EN);
 	if (ret)
 		goto out;
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 63b85ec88c13..509fe6a3ae97 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -262,9 +262,8 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
 
 	/* restore watermark interrupt */
 	if (restore) {
-		ret = regmap_update_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,
-					 INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN,
-					 INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN);
+		ret = regmap_set_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,
+				      INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN);
 		if (ret)
 			return ret;
 	}
@@ -306,9 +305,8 @@ static int inv_icm42600_buffer_postenable(struct iio_dev *indio_dev)
 	}
 
 	/* set FIFO threshold interrupt */
-	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,
-				 INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN,
-				 INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN);
+	ret = regmap_set_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,
+			      INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN);
 	if (ret)
 		goto out_unlock;
 
@@ -363,8 +361,8 @@ static int inv_icm42600_buffer_predisable(struct iio_dev *indio_dev)
 		goto out_unlock;
 
 	/* disable FIFO threshold interrupt */
-	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,
-				 INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN, 0);
+	ret = regmap_clear_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,
+				INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN);
 	if (ret)
 		goto out_unlock;
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 96116a68ab29..bb302f5540cf 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -435,9 +435,8 @@ static int inv_icm42600_setup(struct inv_icm42600_state *st,
 		return ret;
 
 	/* sensor data in big-endian (default) */
-	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG0,
-				 INV_ICM42600_INTF_CONFIG0_SENSOR_DATA_ENDIAN,
-				 INV_ICM42600_INTF_CONFIG0_SENSOR_DATA_ENDIAN);
+	ret = regmap_set_bits(st->map, INV_ICM42600_REG_INTF_CONFIG0,
+			      INV_ICM42600_INTF_CONFIG0_SENSOR_DATA_ENDIAN);
 	if (ret)
 		return ret;
 
@@ -532,8 +531,8 @@ static int inv_icm42600_irq_init(struct inv_icm42600_state *st, int irq,
 		return ret;
 
 	/* Deassert async reset for proper INT pin operation (cf datasheet) */
-	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INT_CONFIG1,
-				 INV_ICM42600_INT_CONFIG1_ASYNC_RESET, 0);
+	ret = regmap_clear_bits(st->map, INV_ICM42600_REG_INT_CONFIG1,
+				INV_ICM42600_INT_CONFIG1_ASYNC_RESET);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
index 8d33504d770f..ebb31b385881 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
@@ -28,8 +28,8 @@ static int inv_icm42600_i2c_bus_setup(struct inv_icm42600_state *st)
 			   INV_ICM42600_INTF_CONFIG6_MASK,
 			   INV_ICM42600_INTF_CONFIG6_I3C_EN);
 
-	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG4,
-				 INV_ICM42600_INTF_CONFIG4_I3C_BUS_ONLY, 0);
+	ret = regmap_clear_bits(st->map, INV_ICM42600_REG_INTF_CONFIG4,
+				INV_ICM42600_INTF_CONFIG4_I3C_BUS_ONLY);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index cc2bf1799a46..eae5ff7a3cc1 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -27,8 +27,8 @@ static int inv_icm42600_spi_bus_setup(struct inv_icm42600_state *st)
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG4,
-				 INV_ICM42600_INTF_CONFIG4_I3C_BUS_ONLY, 0);
+	ret = regmap_clear_bits(st->map, INV_ICM42600_REG_INTF_CONFIG4,
+				INV_ICM42600_INTF_CONFIG4_I3C_BUS_ONLY);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
index aa4a6c78f0aa..34230e699d27 100644
--- a/drivers/iio/light/adux1020.c
+++ b/drivers/iio/light/adux1020.c
@@ -539,9 +539,8 @@ static int adux1020_write_event_config(struct iio_dev *indio_dev,
 		 * Trigger proximity interrupt when the intensity is above
 		 * or below threshold
 		 */
-		ret = regmap_update_bits(data->regmap, ADUX1020_REG_PROX_TYPE,
-					 ADUX1020_PROX_TYPE,
-					 ADUX1020_PROX_TYPE);
+		ret = regmap_set_bits(data->regmap, ADUX1020_REG_PROX_TYPE,
+				      ADUX1020_PROX_TYPE);
 		if (ret < 0)
 			goto fail;
 
@@ -748,8 +747,8 @@ static int adux1020_chip_init(struct adux1020_data *data)
 
 	dev_dbg(&client->dev, "Detected ADUX1020 with chip id: 0x%04x\n", val);
 
-	ret = regmap_update_bits(data->regmap, ADUX1020_REG_SW_RESET,
-				 ADUX1020_SW_RESET, ADUX1020_SW_RESET);
+	ret = regmap_set_bits(data->regmap, ADUX1020_REG_SW_RESET,
+			      ADUX1020_SW_RESET);
 	if (ret < 0)
 		return ret;
 
@@ -764,8 +763,8 @@ static int adux1020_chip_init(struct adux1020_data *data)
 		return ret;
 
 	/* Use LED_IREF for proximity mode */
-	ret = regmap_update_bits(data->regmap, ADUX1020_REG_LED_CURRENT,
-				 ADUX1020_LED_PIREF_EN, 0);
+	ret = regmap_clear_bits(data->regmap, ADUX1020_REG_LED_CURRENT,
+				ADUX1020_LED_PIREF_EN);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/iio/light/iqs621-als.c b/drivers/iio/light/iqs621-als.c
index 004ea890a4b2..6de33feada3a 100644
--- a/drivers/iio/light/iqs621-als.c
+++ b/drivers/iio/light/iqs621-als.c
@@ -86,8 +86,8 @@ static int iqs621_als_init(struct iqs621_als_private *iqs621_als)
 	if (iqs621_als->prox_en)
 		event_mask |= iqs62x->dev_desc->ir_mask;
 
-	return regmap_update_bits(iqs62x->regmap, IQS620_GLBL_EVENT_MASK,
-				  event_mask, 0);
+	return regmap_clear_bits(iqs62x->regmap, IQS620_GLBL_EVENT_MASK,
+				 event_mask);
 }
 
 static int iqs621_als_notifier(struct notifier_block *notifier,
diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index 43484c18b101..8dfc750e68c0 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -550,9 +550,9 @@ static int isl29018_chip_init(struct isl29018_chip *chip)
 			return -ENODEV;
 
 		/* Clear brownout bit */
-		status = regmap_update_bits(chip->regmap,
-					    ISL29035_REG_DEVICE_ID,
-					    ISL29035_BOUT_MASK, 0);
+		status = regmap_clear_bits(chip->regmap,
+					   ISL29035_REG_DEVICE_ID,
+					   ISL29035_BOUT_MASK);
 		if (status < 0)
 			return status;
 	}
diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
index d4e17079b2f4..fba3997574bb 100644
--- a/drivers/iio/light/st_uvis25_core.c
+++ b/drivers/iio/light/st_uvis25_core.c
@@ -330,8 +330,8 @@ static int st_uvis25_suspend(struct device *dev)
 	struct iio_dev *iio_dev = dev_get_drvdata(dev);
 	struct st_uvis25_hw *hw = iio_priv(iio_dev);
 
-	return regmap_update_bits(hw->regmap, ST_UVIS25_REG_CTRL1_ADDR,
-				  ST_UVIS25_REG_ODR_MASK, 0);
+	return regmap_clear_bits(hw->regmap, ST_UVIS25_REG_CTRL1_ADDR,
+				 ST_UVIS25_REG_ODR_MASK);
 }
 
 static int st_uvis25_resume(struct device *dev)
diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 043f233d9bdb..f7ccbce45f38 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -144,8 +144,8 @@ static const struct attribute_group veml6030_event_attr_group = {
 
 static int veml6030_als_pwr_on(struct veml6030_data *data)
 {
-	return regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
-				 VEML6030_ALS_SD, 0);
+	return regmap_clear_bits(data->regmap, VEML6030_REG_ALS_CONF,
+				 VEML6030_ALS_SD);
 }
 
 static int veml6030_als_shut_down(struct veml6030_data *data)
diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index c74d11943ec7..70172b918e16 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -327,10 +327,7 @@ static int ak8974_trigmeas(struct ak8974 *ak8974)
 	}
 
 	/* Force a measurement */
-	return regmap_update_bits(ak8974->map,
-				  AK8974_CTRL3,
-				  AK8974_CTRL3_FORCE,
-				  AK8974_CTRL3_FORCE);
+	return regmap_set_bits(ak8974->map, AK8974_CTRL3, AK8974_CTRL3_FORCE);
 }
 
 static int ak8974_await_drdy(struct ak8974 *ak8974)
@@ -438,10 +435,8 @@ static int ak8974_selftest(struct ak8974 *ak8974)
 	}
 
 	/* Trigger self-test */
-	ret = regmap_update_bits(ak8974->map,
-			AK8974_CTRL3,
-			AK8974_CTRL3_SELFTEST,
-			AK8974_CTRL3_SELFTEST);
+	ret = regmap_set_bits(ak8974->map, AK8974_CTRL3,
+			      AK8974_CTRL3_SELFTEST);
 	if (ret) {
 		dev_err(dev, "could not write CTRL3\n");
 		return ret;
diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 6b9f4b056191..ec35e9543a96 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -186,9 +186,8 @@ static int mmc35240_hw_set(struct mmc35240_data *data, bool set)
 	 * Recharge the capacitor at VCAP pin, requested to be issued
 	 * before a SET/RESET command.
 	 */
-	ret = regmap_update_bits(data->regmap, MMC35240_REG_CTRL0,
-				 MMC35240_CTRL0_REFILL_BIT,
-				 MMC35240_CTRL0_REFILL_BIT);
+	ret = regmap_set_bits(data->regmap, MMC35240_REG_CTRL0,
+			      MMC35240_CTRL0_REFILL_BIT);
 	if (ret < 0)
 		return ret;
 	usleep_range(MMC35240_WAIT_CHARGE_PUMP, MMC35240_WAIT_CHARGE_PUMP + 1);
@@ -198,8 +197,7 @@ static int mmc35240_hw_set(struct mmc35240_data *data, bool set)
 	else
 		coil_bit = MMC35240_CTRL0_RESET_BIT;
 
-	return regmap_update_bits(data->regmap, MMC35240_REG_CTRL0,
-				  coil_bit, coil_bit);
+	return regmap_set_bits(data->regmap, MMC35240_REG_CTRL0, coil_bit);
 
 }
 
diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 09f53d987c7d..ef7f546839e4 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1566,8 +1566,8 @@ static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
 			goto exit;
 
 		/* Disable programming mode bit */
-		ret = regmap_update_bits(data->regmap, BMP580_REG_NVM_ADDR,
-					 BMP580_NVM_PROG_EN, 0);
+		ret = regmap_clear_bits(data->regmap, BMP580_REG_NVM_ADDR,
+					BMP580_NVM_PROG_EN);
 		if (ret) {
 			dev_err(data->dev, "error resetting nvm write\n");
 			goto exit;
diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index aa0d14a49d5e..629f83c37d59 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -835,9 +835,8 @@ static int sx9324_init_compensation(struct iio_dev *indio_dev)
 	int ret;
 
 	/* run the compensation phase on all channels */
-	ret = regmap_update_bits(data->regmap, SX9324_REG_STAT2,
-				 SX9324_REG_STAT2_COMPSTAT_MASK,
-				 SX9324_REG_STAT2_COMPSTAT_MASK);
+	ret = regmap_set_bits(data->regmap, SX9324_REG_STAT2,
+			      SX9324_REG_STAT2_COMPSTAT_MASK);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 75a1c29f14eb..2b90bf45a201 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -672,9 +672,8 @@ static int sx9360_init_compensation(struct iio_dev *indio_dev)
 	int ret;
 
 	/* run the compensation phase on all channels */
-	ret = regmap_update_bits(data->regmap, SX9360_REG_STAT,
-				 SX9360_REG_STAT_COMPSTAT_MASK,
-				 SX9360_REG_STAT_COMPSTAT_MASK);
+	ret = regmap_set_bits(data->regmap, SX9360_REG_STAT,
+			      SX9360_REG_STAT_COMPSTAT_MASK);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 550e7d3cd5ee..49f4ccd8a5c4 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -209,7 +209,7 @@ static int sx9500_inc_users(struct sx9500_data *data, int *counter,
 		/* Bit is already active, nothing to do. */
 		return 0;
 
-	return regmap_update_bits(data->regmap, reg, bitmask, bitmask);
+	return regmap_set_bits(data->regmap, reg, bitmask);
 }
 
 static int sx9500_dec_users(struct sx9500_data *data, int *counter,
@@ -220,7 +220,7 @@ static int sx9500_dec_users(struct sx9500_data *data, int *counter,
 		/* There are more users, do not deactivate. */
 		return 0;
 
-	return regmap_update_bits(data->regmap, reg, bitmask, 0);
+	return regmap_clear_bits(data->regmap, reg, bitmask);
 }
 
 static int sx9500_inc_chan_users(struct sx9500_data *data, int chan)
@@ -795,8 +795,8 @@ static int sx9500_init_compensation(struct iio_dev *indio_dev)
 	int i, ret;
 	unsigned int val;
 
-	ret = regmap_update_bits(data->regmap, SX9500_REG_PROX_CTRL0,
-				 SX9500_CHAN_MASK, SX9500_CHAN_MASK);
+	ret = regmap_set_bits(data->regmap, SX9500_REG_PROX_CTRL0,
+			      SX9500_CHAN_MASK);
 	if (ret < 0)
 		return ret;
 
@@ -815,8 +815,8 @@ static int sx9500_init_compensation(struct iio_dev *indio_dev)
 	}
 
 out:
-	regmap_update_bits(data->regmap, SX9500_REG_PROX_CTRL0,
-			   SX9500_CHAN_MASK, 0);
+	regmap_clear_bits(data->regmap, SX9500_REG_PROX_CTRL0,
+			  SX9500_CHAN_MASK);
 	return ret;
 }
 
diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
index fe07d1444ac3..a95e9814aaf2 100644
--- a/drivers/iio/proximity/sx_common.c
+++ b/drivers/iio/proximity/sx_common.c
@@ -111,17 +111,16 @@ static int sx_common_enable_irq(struct sx_common_data *data, unsigned int irq)
 {
 	if (!data->client->irq)
 		return 0;
-	return regmap_update_bits(data->regmap, data->chip_info->reg_irq_msk,
-				  irq << data->chip_info->irq_msk_offset,
-				  irq << data->chip_info->irq_msk_offset);
+	return regmap_set_bits(data->regmap, data->chip_info->reg_irq_msk,
+			       irq << data->chip_info->irq_msk_offset);
 }
 
 static int sx_common_disable_irq(struct sx_common_data *data, unsigned int irq)
 {
 	if (!data->client->irq)
 		return 0;
-	return regmap_update_bits(data->regmap, data->chip_info->reg_irq_msk,
-				  irq << data->chip_info->irq_msk_offset, 0);
+	return regmap_clear_bits(data->regmap, data->chip_info->reg_irq_msk,
+				 irq << data->chip_info->irq_msk_offset);
 }
 
 static int sx_common_update_chan_en(struct sx_common_data *data,
diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 8a57be108620..e7de30f613d2 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -334,8 +334,8 @@ static int mlx90632_perform_measurement(struct mlx90632_data *data)
 	unsigned int reg_status;
 	int ret;
 
-	ret = regmap_update_bits(data->regmap, MLX90632_REG_STATUS,
-				 MLX90632_STAT_DATA_RDY, 0);
+	ret = regmap_clear_bits(data->regmap, MLX90632_REG_STATUS,
+				MLX90632_STAT_DATA_RDY);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index d76444030a28..0684329956d9 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -158,7 +158,7 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 
 	regmap_write(priv->regmap, TIM_PSC, prescaler);
 	regmap_write(priv->regmap, TIM_ARR, prd - 1);
-	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, TIM_CR1_ARPE);
+	regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE);
 
 	/* Force master mode to update mode */
 	if (stm32_timer_is_trgo2_name(trig->name))
@@ -169,10 +169,10 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 				   0x2 << TIM_CR2_MMS_SHIFT);
 
 	/* Make sure that registers are updated */
-	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
+	regmap_set_bits(priv->regmap, TIM_EGR, TIM_EGR_UG);
 
 	/* Enable controller */
-	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, TIM_CR1_CEN);
+	regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
 	mutex_unlock(&priv->lock);
 
 	return 0;
@@ -189,19 +189,19 @@ static void stm32_timer_stop(struct stm32_timer_trigger *priv,
 
 	mutex_lock(&priv->lock);
 	/* Stop timer */
-	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
-	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
+	regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE);
+	regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
 	regmap_write(priv->regmap, TIM_PSC, 0);
 	regmap_write(priv->regmap, TIM_ARR, 0);
 
 	/* Force disable master mode */
 	if (stm32_timer_is_trgo2_name(trig->name))
-		regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2, 0);
+		regmap_clear_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2);
 	else
-		regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS, 0);
+		regmap_clear_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS);
 
 	/* Make sure that registers are updated */
-	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
+	regmap_set_bits(priv->regmap, TIM_EGR, TIM_EGR_UG);
 
 	if (priv->enabled) {
 		priv->enabled = false;
@@ -498,11 +498,9 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 				priv->enabled = true;
 				clk_enable(priv->clk);
 			}
-			regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
-					   TIM_CR1_CEN);
+			regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
 		} else {
-			regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
-					   0);
+			regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
 			if (priv->enabled) {
 				priv->enabled = false;
 				clk_disable(priv->clk);
@@ -555,7 +553,7 @@ static int stm32_set_trigger_mode(struct iio_dev *indio_dev,
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
 
-	regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS, TIM_SMCR_SMS);
+	regmap_set_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS);
 
 	return 0;
 }
@@ -683,7 +681,7 @@ static ssize_t stm32_count_set_preset(struct iio_dev *indio_dev,
 		return ret;
 
 	/* TIMx_ARR register shouldn't be buffered (ARPE=0) */
-	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
+	regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE);
 	regmap_write(priv->regmap, TIM_ARR, preset);
 
 	return len;
@@ -757,9 +755,9 @@ static void stm32_timer_detect_trgo2(struct stm32_timer_trigger *priv)
 	 * Master mode selection 2 bits can only be written and read back when
 	 * timer supports it.
 	 */
-	regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2, TIM_CR2_MMS2);
+	regmap_set_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2);
 	regmap_read(priv->regmap, TIM_CR2, &val);
-	regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2, 0);
+	regmap_clear_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2);
 	priv->has_trgo2 = !!val;
 }
 
@@ -820,7 +818,7 @@ static void stm32_timer_trigger_remove(struct platform_device *pdev)
 	/* Check if nobody else use the timer, then disable it */
 	regmap_read(priv->regmap, TIM_CCER, &val);
 	if (!(val & TIM_CCER_CCXE))
-		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
+		regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
 
 	if (priv->enabled)
 		clk_disable(priv->clk);
@@ -841,7 +839,7 @@ static int stm32_timer_trigger_suspend(struct device *dev)
 		regmap_read(priv->regmap, TIM_SMCR, &priv->bak.smcr);
 
 		/* Disable the timer */
-		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
+		regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
 		clk_disable(priv->clk);
 	}
 

base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.45.2


