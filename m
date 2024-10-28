Return-Path: <linux-iio+bounces-11420-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C539B2879
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 08:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148162823E1
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 07:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489E6191F7F;
	Mon, 28 Oct 2024 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xNeF7o7d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C789F190493
	for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099492; cv=none; b=mgHGR4Wpa6BNInWvdZK6jN0N3led/zhw8tSXiHEhNNh4QfUk9mltsvWPwDfw9/UFAu0t/rxg3mjBlEOzkUGpBclJ2+lkmx4p64M+biUlyqfAdB79Ub6WHGyAcHZInrLVxftRRHTcQBhWrARkm/tQ7Qax4Jj8ofcGVYKgqyHSYSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099492; c=relaxed/simple;
	bh=q0Rk1gyCTVaE9ieBiZ9Ha35zqb9X17plsNeIZIHefeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hDJpIzqYAzeMiv3YYbs7PwH2KN8++egGQtmd4A6eMlEnoAZ3x8Mco9EynuUOk+uUE+jJNdGsuvOrzIlNzzVdRTnBs8eaLDDdQfMcumSP7sRSs+0VpbnrIJQPh1IPFHSYinW6e8n99FYjjzS/MMbHx4YYJQlNAvYZuUWcEWfuzlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xNeF7o7d; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so3637527f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 00:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730099487; x=1730704287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aJObb17l9QQWEMB2X2r9azU+cKThC8Szkobzv4AFnM=;
        b=xNeF7o7dKD9Z4tdp8Am/pAMkqzw2NTVhpfjIUMGXz5Tx9nWTx+2EpWGJ26v7wj2dSJ
         PNvwuNhQ75JxWLPyCY90Ft1fAuthAHnIsbUKn8F/IT/0m0R34+0RugbjV78qhz4xrErf
         YhtBpPEYOsK3lyIshQGRL7jU71ouT+0sZVeCv1EXa4fMaF0Z6WA1x1wqjB+/JOyJ+0IP
         9WutXdPL7EDPJBiN0S7ov0X+hHo/kuTvD/7gX8FuwBXaEpFsnDzoiGWHbXVpG/dPlyq6
         MltuQoZgbGTUCFzouxoswhYbWhbK0ZhkxIDRnLv5Dbg++U5+BMMeHZ0az/Rs7dYg4jpp
         eceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730099487; x=1730704287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aJObb17l9QQWEMB2X2r9azU+cKThC8Szkobzv4AFnM=;
        b=FE/IXDFPH2vZPYIz6zzn3higfABNXUbz9HrbLhSTCSTdcLHbpg9D/LmZzYqX0iAO6h
         2RtPLoXp1PDoV7eRjv475UJph601uVX/mGBfw9YM7982obE5LQuaaT5Rnx6mrCiKmuqC
         lxX4VBxTwThUqR2CoDkPzXsR7HMWxvrLZF8/wxurYd2BRs6fUebjmtnBI5BzSTDPPdAD
         zM3hItTBUfs28FmwOn6j2zqzL2O2MpJAQqRE11nDsqePx6BGAYuLUNYcLWT0AHuS+BTK
         klQJnC1Gi+txXck9MZSMOqsjrD2Iy+7mxs1IRSehA85KbQ4hBmMBpGSiJRFMNfTdCQtk
         A88Q==
X-Gm-Message-State: AOJu0YzkGaTua3T3SOufmP5KVvU0KPKvAE5xkFV1Ew5hxao8I9bYvndr
	0L7tsc+5vL1W3r8ZcpnieKCH9IWI9lrGGgSaQtd2kQJDJjdFOKd7ourl4jTmvL4=
X-Google-Smtp-Source: AGHT+IFEPKa7Esk0IjQZ9kbGemFFEKjcSbzAHz9z0VoU4SdrKcB4GQruoqeO0+NgV2NSQo8GqDf1lw==
X-Received: by 2002:a5d:614f:0:b0:37d:50e3:e7 with SMTP id ffacd0b85a97d-38061248aebmr7203636f8f.52.1730099486986;
        Mon, 28 Oct 2024 00:11:26 -0700 (PDT)
Received: from axelh-ThinkPad-T450s.home (lfbn-nic-1-251-169.w2-15.abo.wanadoo.fr. [2.15.94.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3c236sm8615383f8f.35.2024.10.28.00.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 00:11:26 -0700 (PDT)
From: ahaslam@baylibre.com
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Axel Haslam <ahaslam@baylibre.com>
Subject: [PATCH 3/6] iio: dac: ad5791: Include chip_info in device match tables
Date: Mon, 28 Oct 2024 08:11:15 +0100
Message-Id: <20241028071118.699951-4-ahaslam@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028071118.699951-1-ahaslam@baylibre.com>
References: <20241028071118.699951-1-ahaslam@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Axel Haslam <ahaslam@baylibre.com>

Include a chip info struct in device SPI and device OF match tables to
provide channel definitions for each particular ADC model and drop
device enum.

Suggested-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/iio/dac/ad5791.c | 107 +++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 56 deletions(-)

diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index 553431bf0232..a11e81211669 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -65,7 +65,9 @@
  */
 
 struct ad5791_chip_info {
-	int (*get_lin_comp)	(unsigned int span);
+	const char *name;
+	const struct iio_chan_spec channel;
+	int (*get_lin_comp)(unsigned int span);
 };
 
 /**
@@ -98,13 +100,6 @@ struct ad5791_state {
 	} data[3] __aligned(IIO_DMA_MINALIGN);
 };
 
-enum ad5791_supported_device_ids {
-	ID_AD5760,
-	ID_AD5780,
-	ID_AD5781,
-	ID_AD5791,
-};
-
 static int ad5791_spi_write(struct ad5791_state *st, u8 addr, u32 val)
 {
 	st->data[0].d32 = cpu_to_be32(AD5791_CMD_WRITE |
@@ -228,20 +223,6 @@ static int ad5780_get_lin_comp(unsigned int span)
 	else
 		return AD5780_LINCOMP_10_20;
 }
-static const struct ad5791_chip_info ad5791_chip_info_tbl[] = {
-	[ID_AD5760] = {
-		.get_lin_comp = ad5780_get_lin_comp,
-	},
-	[ID_AD5780] = {
-		.get_lin_comp = ad5780_get_lin_comp,
-	},
-	[ID_AD5781] = {
-		.get_lin_comp = ad5791_get_lin_comp,
-	},
-	[ID_AD5791] = {
-		.get_lin_comp = ad5791_get_lin_comp,
-	},
-};
 
 static int ad5791_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
@@ -289,30 +270,34 @@ static const struct iio_chan_spec_ext_info ad5791_ext_info[] = {
 	{ },
 };
 
-#define AD5791_CHAN(bits, _shift) {			\
-	.type = IIO_VOLTAGE,				\
-	.output = 1,					\
-	.indexed = 1,					\
-	.address = AD5791_ADDR_DAC0,			\
-	.channel = 0,					\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
-		BIT(IIO_CHAN_INFO_OFFSET),		\
-	.scan_type = {					\
-		.sign = 'u',				\
-		.realbits = (bits),			\
-		.storagebits = 24,			\
-		.shift = (_shift),			\
-	},						\
-	.ext_info = ad5791_ext_info,			\
+#define AD5791_DEFINE_CHIP_INFO(_name, bits, _shift, _lin_comp)		\
+static const struct ad5791_chip_info _name##_chip_info = {		\
+	.name = #_name,							\
+	.get_lin_comp = &(_lin_comp),					\
+	.channel = {							\
+			.type = IIO_VOLTAGE,				\
+			.output = 1,					\
+			.indexed = 1,					\
+			.address = AD5791_ADDR_DAC0,			\
+			.channel = 0,					\
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
+				BIT(IIO_CHAN_INFO_OFFSET),		\
+			.scan_type = {					\
+				.sign = 'u',				\
+				.realbits = (bits),			\
+				.storagebits = 24,			\
+				.shift = (_shift),			\
+			},						\
+			.ext_info = ad5791_ext_info,			\
+	},								\
 }
 
-static const struct iio_chan_spec ad5791_channels[] = {
-	[ID_AD5760] = AD5791_CHAN(16, 4),
-	[ID_AD5780] = AD5791_CHAN(18, 2),
-	[ID_AD5781] = AD5791_CHAN(18, 2),
-	[ID_AD5791] = AD5791_CHAN(20, 0)
-};
+AD5791_DEFINE_CHIP_INFO(ad5760, 16, 4, ad5780_get_lin_comp);
+AD5791_DEFINE_CHIP_INFO(ad5780, 18, 2, ad5780_get_lin_comp);
+AD5791_DEFINE_CHIP_INFO(ad5781, 18, 2, ad5791_get_lin_comp);
+AD5791_DEFINE_CHIP_INFO(ad5790, 20, 0, ad5791_get_lin_comp);
+AD5791_DEFINE_CHIP_INFO(ad5791, 20, 0, ad5791_get_lin_comp);
 
 static int ad5791_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
@@ -400,9 +385,9 @@ static int ad5791_probe(struct spi_device *spi)
 	if (ret)
 		goto error_disable_reg_neg;
 
-	st->chip_info =	&ad5791_chip_info_tbl[spi_get_device_id(spi)
-					      ->driver_data];
-
+	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return dev_err_probe(&spi->dev, -EINVAL, "no chip info\n");
 
 	st->ctrl = AD5761_CTRL_LINCOMP(st->chip_info->get_lin_comp(st->vref_mv))
 		  | (use_rbuf_gain2 ? 0 : AD5791_CTRL_RBUF) |
@@ -416,10 +401,9 @@ static int ad5791_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 	indio_dev->info = &ad5791_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels
-		= &ad5791_channels[spi_get_device_id(spi)->driver_data];
+	indio_dev->channels = &st->chip_info->channel;
 	indio_dev->num_channels = 1;
-	indio_dev->name = spi_get_device_id(st->spi)->name;
+	indio_dev->name = st->chip_info->name;
 	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_disable_reg_neg;
@@ -448,19 +432,30 @@ static void ad5791_remove(struct spi_device *spi)
 		regulator_disable(st->reg_vss);
 }
 
+static const struct of_device_id ad5791_of_match[] = {
+	{ .compatible = "adi,ad5760", .data = &ad5760_chip_info },
+	{ .compatible = "adi,ad5780", .data = &ad5780_chip_info },
+	{ .compatible = "adi,ad5781", .data = &ad5781_chip_info },
+	{ .compatible = "adi,ad5790", .data = &ad5790_chip_info },
+	{ .compatible = "adi,ad5791", .data = &ad5791_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad5791_of_match);
+
 static const struct spi_device_id ad5791_id[] = {
-	{"ad5760", ID_AD5760},
-	{"ad5780", ID_AD5780},
-	{"ad5781", ID_AD5781},
-	{"ad5790", ID_AD5791},
-	{"ad5791", ID_AD5791},
-	{}
+	{ "ad5760", (kernel_ulong_t)&ad5760_chip_info },
+	{ "ad5780", (kernel_ulong_t)&ad5780_chip_info },
+	{ "ad5781", (kernel_ulong_t)&ad5781_chip_info },
+	{ "ad5790", (kernel_ulong_t)&ad5790_chip_info },
+	{ "ad5791", (kernel_ulong_t)&ad5791_chip_info },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad5791_id);
 
 static struct spi_driver ad5791_driver = {
 	.driver = {
 		   .name = "ad5791",
+		   .of_match_table = ad5791_of_match,
 		   },
 	.probe = ad5791_probe,
 	.remove = ad5791_remove,
-- 
2.34.1


