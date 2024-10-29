Return-Path: <linux-iio+bounces-11547-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7E59B4348
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 08:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B59AB22505
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 07:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D1B2038B7;
	Tue, 29 Oct 2024 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rlx0rM9l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2820E202F92
	for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 07:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730187548; cv=none; b=rXEZiwPi+pzUAnGpAHqj7q0xrGxsm2Samk3/sXAanvy/PwqBo3uK3b3h5LV882tR/S2RI0KjiX6sHbAP5hpx/N1nlxTH4lZW6Xib0JfQbkFv7PKA6XR2z5CfboVG1EhYbLPFSPR0Eo3TepzoXhXzLnlUA1FRSDJZHndBHtN8/tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730187548; c=relaxed/simple;
	bh=IW7rBfJDFC+nKog3s3s8Fih6Q9vHfUoFcdI1qORZ9ao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rb4Tl3+UnmGDR74QbKXY/YNm3N2SO92YzdfTiqJZflFmHnMSQfNIeLGoMi163uzJD1+1v2Yv+/wF6dXJ/65aSwGJm8BE1g5ePIJTriyspQMNlpzeNRu3USW0t/++7udE6L/m7rdH9iZysUDSYiPTVT4j4UNFJDeCaPFtPxOd9Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rlx0rM9l; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37f52925fc8so3642575f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 00:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730187543; x=1730792343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGjr3jCM4WIEDdHWWWRVwSpY3SH8z2NT/sPqnMjB+CM=;
        b=rlx0rM9l98BEBMVL6WCwX84E2801iAa8K9X7auXvhI+2BKro6QqtoBxcmqwztPr53p
         0yMVePRAvHm6R5fYNQnIQGk6A6uNEVX9OjD60T2PxEWMb5k02ufZTLu6ypMQDGFiQl4L
         wx0T0FlV+E6WWaCKFFBPAG51EhA+VAdwVnt8bpLtgW2b/5T/sKPfWwZvynOT3F1M/T7U
         +CrtGekE3UZDodtJv8ZYkEASchElswvDThh16Ovf1WdY5NObwbG+y+/4U7LBHPQi/4fu
         QEuWIiP3fMF4MYtiEoxVyi23GGpWKa2nUq8lVNR8YwuozJVFf1VzsdEDc9tM+ASy/Agd
         etog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730187543; x=1730792343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGjr3jCM4WIEDdHWWWRVwSpY3SH8z2NT/sPqnMjB+CM=;
        b=ZmmVV59NlrTGaKR7bZj8bRVe/u+Y/sE1j0L4NH9YHqwjcCOQDWnkSKcGDrxqn0m/4H
         QMG9B9BwIU43TMKPtZVhD2GF8yXGUk9EfXYNj9vEVZkhgB/pZWN+S/xGy+YMu4LwWY6D
         zDVdbTQ9cqW323eX1ujTdKt6FfZxX22b1HLWaDk8rzCH8F0QjkrWEeDzhSgOjttxKknv
         pJSA8O/iWsuG4HdwifncNd7b1aOeTp4Ae9+WVYSYRQztiYQ/3S+uufvMiEiBBvltSKJm
         xrvcQcdee3BypIDdVaua4c2+UAxhasPrgax2Ij0O3Gw5NXBjfyZDP9VNW4NT/PUTMvmq
         6f3A==
X-Gm-Message-State: AOJu0YyJGrqQGF9AbepP9XFCNwkZ/6UupWZ9WuaeDJDhAXBKzCxFUFA+
	OpgIfzpZ4rBH1Od19VCZSoh3ZBx4u2IIZFzlo7CbGakYBxxZwluxn0+l/Hdy04w=
X-Google-Smtp-Source: AGHT+IG7DEIOkZmGbruw9L+flf9HSU7FIfvkxW5iIso8YxWUFRncRG4s4ANz3+2mfN0voS1hwmwfdQ==
X-Received: by 2002:adf:fd0a:0:b0:37d:2ceb:ef92 with SMTP id ffacd0b85a97d-38061162d5amr7713512f8f.27.1730187543481;
        Tue, 29 Oct 2024 00:39:03 -0700 (PDT)
Received: from axelh-ThinkPad-T450s.home (lfbn-nic-1-251-169.w2-15.abo.wanadoo.fr. [2.15.94.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b714fesm11692939f8f.71.2024.10.29.00.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 00:39:02 -0700 (PDT)
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
Date: Tue, 29 Oct 2024 08:38:54 +0100
Message-Id: <20241029073857.753782-4-ahaslam@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029073857.753782-1-ahaslam@baylibre.com>
References: <20241029073857.753782-1-ahaslam@baylibre.com>
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
 drivers/iio/dac/ad5791.c | 110 +++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 57 deletions(-)

diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index 553431bf0232..f6b9a40241f3 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -61,11 +61,14 @@
 
 /**
  * struct ad5791_chip_info - chip specific information
+ * @name:		name of the dac chip
+ * @channel:		channel specification
  * @get_lin_comp:	function pointer to the device specific function
  */
-
 struct ad5791_chip_info {
-	int (*get_lin_comp)	(unsigned int span);
+	const char *name;
+	const struct iio_chan_spec channel;
+	int (*get_lin_comp)(unsigned int span);
 };
 
 /**
@@ -98,13 +101,6 @@ struct ad5791_state {
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
@@ -228,20 +224,6 @@ static int ad5780_get_lin_comp(unsigned int span)
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
@@ -289,30 +271,34 @@ static const struct iio_chan_spec_ext_info ad5791_ext_info[] = {
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
@@ -400,9 +386,9 @@ static int ad5791_probe(struct spi_device *spi)
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
@@ -416,10 +402,9 @@ static int ad5791_probe(struct spi_device *spi)
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
@@ -448,19 +433,30 @@ static void ad5791_remove(struct spi_device *spi)
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


