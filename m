Return-Path: <linux-iio+bounces-8494-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD4F952E0C
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 14:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C966B1F24CFB
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 12:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8F217A592;
	Thu, 15 Aug 2024 12:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fa4yzF+E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF29017C9A1
	for <linux-iio@vger.kernel.org>; Thu, 15 Aug 2024 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723723935; cv=none; b=ZJOA8vIJ/lK71CLzpMG+qPl9//T7W+Djak//il/gFuAG7xKVFG68XYDHzOJOHQjSIb6nyjS191x5ujcj2nZGiylSWp29kYXGZZOrAlW643sj3xQ8GENGiHQf53LF/VmOr+76T3sQsJv7E2cGxz4EhbbRCs6607CVLYl8uMpTsxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723723935; c=relaxed/simple;
	bh=mzJbwcOvbairLbN592J/ttZQ0Yv4RcpSamoG1D3d/tg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AtMBaNKFamoJxC5GNBA7eY8AcsOAqQ/tPvurE1yj8FxdBlTwXT3zzUzV2qq/gY/xTktz2c4ra+I2wd24Nb29+Y+os7HfZQPcn+IRL81+dhF48j0IQhAmFsA4gXtWkhjIIKNMBgvNJPv7vnLPQEOVeYE1xIvpM4OvEALaytY2U0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fa4yzF+E; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3717d31e377so397273f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 15 Aug 2024 05:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723723930; x=1724328730; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8fSDi2GHN2YrxJr4eF+NeYwdpamgEmYEWBmJVW6wVs=;
        b=fa4yzF+E6vr0V5H0EFpOpsS1mg8FS/KTeh3rEnMOyrbcchLzqMw9QTPDfYjoK4V+2r
         /2f5oPE7jzOjyPZ2zpNzqJaVhTJVQmjm1D7Oc+4PP47j4ysi8JPjk9EC+D72dVWbRLL6
         +1olvzeUDfnx9xrcQdJPMUs7YOCC3sSrC4W6F+voUseHXWhYCzG3YFweapKbru4H9G6P
         c5UZaiPVhu0+Q8OfefWUWEQoCdIkIm8LIBUexmdYbNZ/hoetXRr3SPcjVPXYYW11dR7A
         aKG4RBEptxb0bQ/YZLSH3KhkuUYgFAiH8JTTkmrnZ4o00g9ndlolKpcxSWbcX5a3rQjm
         lMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723723930; x=1724328730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8fSDi2GHN2YrxJr4eF+NeYwdpamgEmYEWBmJVW6wVs=;
        b=UDXPiNbPLpLjZE3Ig4Fd+gaxqDNGyY1ksEiP/tY+MKBgK+UyHfehAmZniNwdjfSOH8
         04PyQLwkzCVpC1inhkjhuionHwiIXy2gkCZjwvVtbExdTpDzk/hudh4ATyadacFvPj1G
         WG1B5GyAnLeUEZR/NF3KCorNitUSte5+bJarQUzYdHbHcPghjhH7agJnZERjDl74YWmv
         W6ytnyBf6+6l3g1LIbHWktm5VMvDDRNB/Ot+2o0JPhgyrwu7WG9qxqjOr7Q0Lbhh+6eD
         c0lYiYozQkpnnl9wRaPpO/qXcOX8nANKSvFF/a1GK+L+jZWvSi3EBXIAebd82s3JLfMG
         uVig==
X-Forwarded-Encrypted: i=1; AJvYcCUHaLUym9lklEMMDvjxTtCGgTj07YsYqjX482xf0nT122nm4TbI5jSiyPfSMfcIGTj+QvQx7zvhN5qJsdBhJHNghsZTZ2OoyUfp
X-Gm-Message-State: AOJu0Yx9TBCOZ8VhsnfV/vuaIJOvz20SQZaZ8amWSKWss1KFxcs9JivK
	dUKgG7z2uTypSzNoDrP8BV7MT50AF/uxrPJO4Sf+75MrjnLyGbRzkyyyC1c/sBs=
X-Google-Smtp-Source: AGHT+IECG2dNbDZmDOHkasqBXlPcKukr3iyjIer4i7vO08/59t/MlT1dgAEUsqgWTqnAUiquKqGNaQ==
X-Received: by 2002:adf:b60a:0:b0:371:8688:1660 with SMTP id ffacd0b85a97d-371868818f1mr1605052f8f.51.1723723929645;
        Thu, 15 Aug 2024 05:12:09 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897926sm1365082f8f.87.2024.08.15.05.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:12:09 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Thu, 15 Aug 2024 12:12:01 +0000
Subject: [PATCH 7/8] iio: adc: ad7606: Switch to xxx_get_device_match_data
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-ad7606_add_iio_backend_support-v1-7-cea3e11b1aa4@baylibre.com>
References: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
In-Reply-To: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Guillaume Stols <gstols@baylibre.com>, 
 20240705211452.1157967-2-u.kleine-koenig@baylibre.com, 
 20240712171821.1470833-2-u.kleine-koenig@baylibre.com, 
 cover.1721040875.git.u.kleine-koenig@baylibre.com, aardelean@baylibre.com
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723723923; l=13866;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=mzJbwcOvbairLbN592J/ttZQ0Yv4RcpSamoG1D3d/tg=;
 b=xBft+6Y3H404nyXMc+9qiyy0VX26Tz2lw9fFxb8SAzrb802pcLqiky4+HcixpfwElNXeH+39M
 GY4H62Cj8dvBEjXc4c1Sk2hm+TX1+vH5Z9S4S+T6pnaBWU+FUcSlL7u
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

On the parallel version, the current implementation is only compatible
with id tables and won't work with fx_nodes. So in this commit, the goal
is to switch to use get_device_match_data, in order to simplify the
logic of retrieving chip data.

Also, chip info is moved in the .h file so to be accessible to all the
driver files that can set a pointer to the corresponding chip as the
driver data.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c     | 106 ++--------------------------------
 drivers/iio/adc/ad7606.h     | 132 ++++++++++++++++++++++++++++++++++++++++---
 drivers/iio/adc/ad7606_par.c |  22 ++++----
 drivers/iio/adc/ad7606_spi.c |  31 +++++-----
 4 files changed, 154 insertions(+), 137 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 2c9ddcd0ad77..99d5ca5c2348 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -43,14 +43,6 @@ static const unsigned int ad7616_sw_scale_avail[3] = {
 	76293, 152588, 305176
 };
 
-static const unsigned int ad7606_oversampling_avail[7] = {
-	1, 2, 4, 8, 16, 32, 64,
-};
-
-static const unsigned int ad7616_oversampling_avail[8] = {
-	1, 2, 4, 8, 16, 32, 64, 128,
-};
-
 static int ad7606_reset(struct ad7606_state *st)
 {
 	if (st->gpio_reset) {
@@ -415,96 +407,6 @@ static const struct attribute_group ad7606_attribute_group_range = {
 	.attrs = ad7606_attributes_range,
 };
 
-static const struct iio_chan_spec ad7605_channels[] = {
-	IIO_CHAN_SOFT_TIMESTAMP(4),
-	AD7605_CHANNEL(0),
-	AD7605_CHANNEL(1),
-	AD7605_CHANNEL(2),
-	AD7605_CHANNEL(3),
-};
-
-static const struct iio_chan_spec ad7606_channels[] = {
-	IIO_CHAN_SOFT_TIMESTAMP(8),
-	AD7606_CHANNEL(0),
-	AD7606_CHANNEL(1),
-	AD7606_CHANNEL(2),
-	AD7606_CHANNEL(3),
-	AD7606_CHANNEL(4),
-	AD7606_CHANNEL(5),
-	AD7606_CHANNEL(6),
-	AD7606_CHANNEL(7),
-};
-
-/*
- * The current assumption that this driver makes for AD7616, is that it's
- * working in Hardware Mode with Serial, Burst and Sequencer modes activated.
- * To activate them, following pins must be pulled high:
- *	-SER/PAR
- *	-SEQEN
- * And following pins must be pulled low:
- *	-WR/BURST
- *	-DB4/SER1W
- */
-static const struct iio_chan_spec ad7616_channels[] = {
-	IIO_CHAN_SOFT_TIMESTAMP(16),
-	AD7606_CHANNEL(0),
-	AD7606_CHANNEL(1),
-	AD7606_CHANNEL(2),
-	AD7606_CHANNEL(3),
-	AD7606_CHANNEL(4),
-	AD7606_CHANNEL(5),
-	AD7606_CHANNEL(6),
-	AD7606_CHANNEL(7),
-	AD7606_CHANNEL(8),
-	AD7606_CHANNEL(9),
-	AD7606_CHANNEL(10),
-	AD7606_CHANNEL(11),
-	AD7606_CHANNEL(12),
-	AD7606_CHANNEL(13),
-	AD7606_CHANNEL(14),
-	AD7606_CHANNEL(15),
-};
-
-static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
-	/* More devices added in future */
-	[ID_AD7605_4] = {
-		.channels = ad7605_channels,
-		.num_channels = 5,
-	},
-	[ID_AD7606_8] = {
-		.channels = ad7606_channels,
-		.num_channels = 9,
-		.oversampling_avail = ad7606_oversampling_avail,
-		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
-	},
-	[ID_AD7606_6] = {
-		.channels = ad7606_channels,
-		.num_channels = 7,
-		.oversampling_avail = ad7606_oversampling_avail,
-		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
-	},
-	[ID_AD7606_4] = {
-		.channels = ad7606_channels,
-		.num_channels = 5,
-		.oversampling_avail = ad7606_oversampling_avail,
-		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
-	},
-	[ID_AD7606B] = {
-		.channels = ad7606_channels,
-		.num_channels = 9,
-		.oversampling_avail = ad7606_oversampling_avail,
-		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
-	},
-	[ID_AD7616] = {
-		.channels = ad7616_channels,
-		.num_channels = 17,
-		.oversampling_avail = ad7616_oversampling_avail,
-		.oversampling_num = ARRAY_SIZE(ad7616_oversampling_avail),
-		.os_req_reset = true,
-		.init_delay_ms = 15,
-	},
-};
-
 static int ad7606_request_gpios(struct ad7606_state *st)
 {
 	struct device *dev = st->dev;
@@ -644,7 +546,7 @@ static void ad7606_pwm_disable(void *data)
 }
 
 int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
-		 const char *name, unsigned int id,
+		 const struct ad7606_chip_info *chip_info,
 		 const struct ad7606_bus_ops *bops)
 {
 	struct ad7606_state *st;
@@ -673,7 +575,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		return dev_err_probe(dev, ret,
 				     "Failed to enable specified AVcc supply\n");
 
-	st->chip_info = &ad7606_chip_info_tbl[id];
+	st->chip_info = chip_info;
 
 	if (st->chip_info->oversampling_num) {
 		st->oversampling_avail = st->chip_info->oversampling_avail;
@@ -696,7 +598,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 			indio_dev->info = &ad7606_info_no_os_or_range;
 	}
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->name = name;
+	indio_dev->name = chip_info->name;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
@@ -773,7 +675,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 					NULL,
 					&ad7606_interrupt,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					name, indio_dev);
+					chip_info->name, indio_dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 60bac1894a91..aab8fefb84be 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -40,8 +40,19 @@
 
 struct pwm_device		*cnvst_pwm;
 
+enum ad7606_supported_device_ids {
+	ID_AD7605_4,
+	ID_AD7606_8,
+	ID_AD7606_6,
+	ID_AD7606_4,
+	ID_AD7606B,
+	ID_AD7616,
+};
+
 /**
  * struct ad7606_chip_info - chip specific information
+ * @name		device name
+ * @id			device id
  * @channels:		channel specification
  * @num_channels:	number of channels
  * @oversampling_avail	pointer to the array which stores the available
@@ -52,6 +63,8 @@ struct pwm_device		*cnvst_pwm;
  *			after a restart
  */
 struct ad7606_chip_info {
+	enum ad7606_supported_device_ids id;
+	const char			*name;
 	const struct iio_chan_spec	*channels;
 	unsigned int			num_channels;
 	const unsigned int		*oversampling_avail;
@@ -151,16 +164,119 @@ struct ad7606_bus_ops {
 };
 
 int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
-		 const char *name, unsigned int id,
+		 const struct ad7606_chip_info *info,
 		 const struct ad7606_bus_ops *bops);
 
-enum ad7606_supported_device_ids {
-	ID_AD7605_4,
-	ID_AD7606_8,
-	ID_AD7606_6,
-	ID_AD7606_4,
-	ID_AD7606B,
-	ID_AD7616,
+static const unsigned int ad7606_oversampling_avail[7] = {
+	1, 2, 4, 8, 16, 32, 64,
+};
+
+static const unsigned int ad7616_oversampling_avail[8] = {
+	1, 2, 4, 8, 16, 32, 64, 128,
+};
+
+static const struct iio_chan_spec ad7605_channels[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+	AD7605_CHANNEL(0),
+	AD7605_CHANNEL(1),
+	AD7605_CHANNEL(2),
+	AD7605_CHANNEL(3),
+};
+
+static const struct iio_chan_spec ad7606_channels[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(8),
+	AD7606_CHANNEL(0),
+	AD7606_CHANNEL(1),
+	AD7606_CHANNEL(2),
+	AD7606_CHANNEL(3),
+	AD7606_CHANNEL(4),
+	AD7606_CHANNEL(5),
+	AD7606_CHANNEL(6),
+	AD7606_CHANNEL(7),
+};
+
+/*
+ * The current assumption that this driver makes for AD7616, is that it's
+ * working in Hardware Mode with Serial, Burst and Sequencer modes activated.
+ * To activate them, following pins must be pulled high:
+ *	-SER/PAR
+ *	-SEQEN
+ * And following pins must be pulled low:
+ *	-WR/BURST
+ *	-DB4/SER1W
+ */
+static const struct iio_chan_spec ad7616_channels[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(16),
+	AD7606_CHANNEL(0),
+	AD7606_CHANNEL(1),
+	AD7606_CHANNEL(2),
+	AD7606_CHANNEL(3),
+	AD7606_CHANNEL(4),
+	AD7606_CHANNEL(5),
+	AD7606_CHANNEL(6),
+	AD7606_CHANNEL(7),
+	AD7606_CHANNEL(8),
+	AD7606_CHANNEL(9),
+	AD7606_CHANNEL(10),
+	AD7606_CHANNEL(11),
+	AD7606_CHANNEL(12),
+	AD7606_CHANNEL(13),
+	AD7606_CHANNEL(14),
+	AD7606_CHANNEL(15),
+};
+
+static const struct ad7606_chip_info ad7605_4_info = {
+	.channels = ad7605_channels,
+	.num_channels = 5,
+	.name = "ad7605-4",
+	.id = ID_AD7605_4,
+};
+
+static const struct ad7606_chip_info ad7606_8_info = {
+	.channels = ad7606_channels,
+	.num_channels = 9,
+	.oversampling_avail = ad7606_oversampling_avail,
+	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
+	.name = "ad7606-8",
+	.id = ID_AD7606_8,
+};
+
+static const struct ad7606_chip_info ad7606_6_info = {
+	.channels = ad7606_channels,
+	.num_channels = 7,
+	.oversampling_avail = ad7606_oversampling_avail,
+	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
+	.name = "ad7606-6",
+	.id = ID_AD7606_6,
+};
+
+static const struct ad7606_chip_info ad7606_4_info = {
+	.channels = ad7606_channels,
+	.num_channels = 5,
+	.oversampling_avail = ad7606_oversampling_avail,
+	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
+	.name = "ad7606-4",
+	.id = ID_AD7606_4,
+};
+
+static const struct ad7606_chip_info ad7606b_info = {
+	.channels = ad7606_channels,
+	.num_channels = 9,
+	.oversampling_avail = ad7606_oversampling_avail,
+	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
+	.name = "ad7606B",
+	.id = ID_AD7606B,
+};
+
+static const struct ad7606_chip_info ad7616_info = {
+	.channels = ad7616_channels,
+	.num_channels = 17,
+	.oversampling_avail = ad7616_oversampling_avail,
+	.oversampling_num = ARRAY_SIZE(ad7616_oversampling_avail),
+	.os_req_reset = true,
+	.init_delay_ms = 15,
+	.name = "ad7616",
+	.id = ID_AD7616,
 };
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index d8408052262e..d83c0edc1e31 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -47,7 +47,7 @@ static const struct ad7606_bus_ops ad7606_par8_bops = {
 
 static int ad7606_par_probe(struct platform_device *pdev)
 {
-	const struct platform_device_id *id = platform_get_device_id(pdev);
+	const struct ad7606_chip_info *chip_info = platform_get_device_match_data(pdev);
 	struct resource *res;
 	void __iomem *addr;
 	resource_size_t remap_size;
@@ -64,26 +64,26 @@ static int ad7606_par_probe(struct platform_device *pdev)
 	remap_size = resource_size(res);
 
 	return ad7606_probe(&pdev->dev, irq, addr,
-			    id->name, id->driver_data,
+			    chip_info,
 			    remap_size > 1 ? &ad7606_par16_bops :
 			    &ad7606_par8_bops);
 }
 
 static const struct platform_device_id ad7606_driver_ids[] = {
-	{ .name	= "ad7605-4", .driver_data = ID_AD7605_4, },
-	{ .name	= "ad7606-4", .driver_data = ID_AD7606_4, },
-	{ .name	= "ad7606-6", .driver_data = ID_AD7606_6, },
-	{ .name	= "ad7606-8", .driver_data = ID_AD7606_8, },
+	{ .name	= "ad7605-4", .driver_data = (kernel_ulong_t)&ad7605_4_info, },
+	{ .name	= "ad7606-4", .driver_data = (kernel_ulong_t)&ad7606_4_info, },
+	{ .name	= "ad7606-6", .driver_data = (kernel_ulong_t)&ad7606_6_info, },
+	{ .name	= "ad7606-8", .driver_data = (kernel_ulong_t)&ad7606_8_info, },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, ad7606_driver_ids);
 
 static const struct of_device_id ad7606_of_match[] = {
-	{ .compatible = "adi,ad7605-4" },
-	{ .compatible = "adi,ad7606-4" },
-	{ .compatible = "adi,ad7606-6" },
-	{ .compatible = "adi,ad7606-8" },
-	{ },
+	{ .compatible = "adi,ad7605-4", .data = &ad7605_4_info },
+	{ .compatible = "adi,ad7606-4", .data = &ad7606_4_info },
+	{ .compatible = "adi,ad7606-6", .data = &ad7606_6_info },
+	{ .compatible = "adi,ad7606-8", .data = &ad7606_8_info },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7606_of_match);
 
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 287a0591533b..c23a7448f851 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -307,10 +307,10 @@ static const struct ad7606_bus_ops ad7606B_spi_bops = {
 
 static int ad7606_spi_probe(struct spi_device *spi)
 {
-	const struct spi_device_id *id = spi_get_device_id(spi);
+	const struct ad7606_chip_info *chip_info = spi_get_device_match_data(spi);
 	const struct ad7606_bus_ops *bops;
 
-	switch (id->driver_data) {
+	switch (chip_info->id) {
 	case ID_AD7616:
 		bops = &ad7616_spi_bops;
 		break;
@@ -323,28 +323,27 @@ static int ad7606_spi_probe(struct spi_device *spi)
 	}
 
 	return ad7606_probe(&spi->dev, spi->irq, NULL,
-			    id->name, id->driver_data,
-			    bops);
+			    chip_info, bops);
 }
 
 static const struct spi_device_id ad7606_id_table[] = {
-	{ "ad7605-4", ID_AD7605_4 },
-	{ "ad7606-4", ID_AD7606_4 },
-	{ "ad7606-6", ID_AD7606_6 },
-	{ "ad7606-8", ID_AD7606_8 },
-	{ "ad7606b",  ID_AD7606B },
-	{ "ad7616",   ID_AD7616 },
+	{ "ad7605-4", (kernel_ulong_t)&ad7605_4_info },
+	{ "ad7606-4", (kernel_ulong_t)&ad7606_4_info },
+	{ "ad7606-6", (kernel_ulong_t)&ad7606_6_info },
+	{ "ad7606-8", (kernel_ulong_t)&ad7606_8_info },
+	{ "ad7606b",  (kernel_ulong_t)&ad7606b_info },
+	{ "ad7616",   (kernel_ulong_t)&ad7616_info },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad7606_id_table);
 
 static const struct of_device_id ad7606_of_match[] = {
-	{ .compatible = "adi,ad7605-4" },
-	{ .compatible = "adi,ad7606-4" },
-	{ .compatible = "adi,ad7606-6" },
-	{ .compatible = "adi,ad7606-8" },
-	{ .compatible = "adi,ad7606b" },
-	{ .compatible = "adi,ad7616" },
+	{ .compatible = "adi,ad7605-4", &ad7605_4_info },
+	{ .compatible = "adi,ad7606-4", &ad7606_4_info },
+	{ .compatible = "adi,ad7606-6", &ad7606_6_info },
+	{ .compatible = "adi,ad7606-8", &ad7606_8_info },
+	{ .compatible = "adi,ad7606b", &ad7606b_info },
+	{ .compatible = "adi,ad7616", &ad7616_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ad7606_of_match);

-- 
2.34.1


