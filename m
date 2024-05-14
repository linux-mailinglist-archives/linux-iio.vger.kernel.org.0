Return-Path: <linux-iio+bounces-5044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1FE8C55BB
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 14:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7199C28E479
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 12:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D777710A;
	Tue, 14 May 2024 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIBAgJhv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF17076033;
	Tue, 14 May 2024 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715688206; cv=none; b=HIjhU3IkNePkQR9Q18l1OmpPODArvNqC1ZGKWLjESpLeV8O3v5V04BelsOpht0anCniireJRpcSHVxnrOGjknzHLcmeAcVyXLq9kuL3gooNy8cdy/ApFHvo1/BE3hTgrEw/PX8G5UoBD8kNfIefzFEvB4FHVzksQWKLCwNhxYuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715688206; c=relaxed/simple;
	bh=ikxE01aoGV4tRcZ7NfOLDfnea7FzmDvezDsUlqxjp3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rHnQNZ8O1lmkBsf8D2lZHQYzihkVtUfB1O3+FWoRHV0VRt83/ISqxWym6o4kJq92lJmBrxFwcRtFvPXa+Xubp6jLE6ldny7m3eCUAvxxc+MruTE5A/nbTRJGgZHMPjed0PdWXAHTRQKjpKg4+KfdSp5JFFEOxLEvZ4Y2i2hugwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIBAgJhv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41ff5e3dc3bso29384635e9.1;
        Tue, 14 May 2024 05:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715688203; x=1716293003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sa7AlJjKWENRhUjEnOGX/dr50bh+bVd2TQ8DfybLZfk=;
        b=aIBAgJhvxYlLhnVG+P9++8xdbg8re/hLxwoVgCIS2XlmadefzzfPLjyX5LU2D3FEAf
         p8rLbVktli7Jo2MWPEBvxquC6nsk2A/qSdHKuaSWSaglFJ4To5Xuwk71MeMJKvI9uDYB
         nN/8D8oXjyoLELr4ncCeyeK9O5LMTXBd6QLwECvTINRUm7Jo0jBWRShRjQMYhRJafSUI
         PE63UT7cYh8mduoTYHoFmMuJEQUvjyM4X20bi83/e+x+nBxG+53xDuzKYf6cO7CCACrQ
         JeWqQLZk4AR3ODWjQDGY2jEsnSqpB9E+uV/2DCNHIqs9CpH+f18T83i2oZnYpXmtDd5m
         ZFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715688203; x=1716293003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sa7AlJjKWENRhUjEnOGX/dr50bh+bVd2TQ8DfybLZfk=;
        b=NpGQ6HN5PA2d8eqzwbp1Yod9mHr2cWWoGJaXMNh2+ehBZx8AYeXDCBXfxZ+o8Gz4qV
         3OAj6Bopirl0fdFxMh0UOELpWzJ8jqloZmXj+9JReuJ2ti4zuscMpOtbyUQbW79g9/jR
         9nhfs3VEE+J1pQpzbBh8pOrZfzapNqYu/0E5gKypRlz0idF2Ho47jwcQC7mZcgVaUm6c
         dVvun1ZBKzAYNNJBL5Us16jQd3aF7EpekEDyK4HVNS/zhubVOSZuAOhIz2zDqcONO4EV
         U4n0JqPQWWoKitYV3Z63IRl5f7mb0u1/v693XPSdVFP8Q9018EmfBFxlx8kRVCNk/F8c
         wnzg==
X-Forwarded-Encrypted: i=1; AJvYcCUmHXBazAmRC7IwJ/fns01L/BpBoFLTsuQW+HaW7bLesMwtV1zPCJaI5bR8AD7uz3ghzpKHj9jbIHIeuU8Glf8LvmwD2Xh4FggoDodz3pjFgbOvAsqWZvSla/ttpZhZdwvMwrP9bhDtsF3o+yxZG8lEfJNql3HRPJv3DxDzr0OlRiTIeg==
X-Gm-Message-State: AOJu0YzIkCuv+LldtKpr11JVn3hmE+RoE3iPHAlvyg0EHGgXLE+Q+bJ9
	sGoLc/3zCw+d/uUaItbrGiqLWDmuUS/M/w1lJgs+ITQjCBfR+MURl0CnX1RY
X-Google-Smtp-Source: AGHT+IG1PZv5YOxQMvoy0pL9eOxPBmMPv+OdHDffcmKNQbmO/5jt1P68iXfcYogmvbpXAvJXkfKxrQ==
X-Received: by 2002:adf:e4c7:0:b0:34d:e252:b57d with SMTP id ffacd0b85a97d-3504a73217emr9942037f8f.17.1715688203152;
        Tue, 14 May 2024 05:03:23 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a105:8300:5179:8171:3530:3b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b896a06sm13593927f8f.27.2024.05.14.05.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:03:22 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	marcelo.schmitt@analog.com,
	bigunclemax@gmail.com,
	dlechner@baylibre.com,
	okan.sahin@analog.com,
	fr0st61te@gmail.com,
	alisa.roman@analog.com,
	marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com,
	liambeguin@gmail.com
Subject: [PATCH v8 6/6] iio: adc: ad7192: Add AD7194 support
Date: Tue, 14 May 2024 15:02:22 +0300
Message-Id: <20240514120222.56488-7-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240514120222.56488-1-alisa.roman@analog.com>
References: <20240514120222.56488-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike the other AD719Xs, AD7194 has configurable channels. The user can
dynamically configure them in the devicetree.

Add sigma_delta_info member to chip_info structure. Since AD7194 is the
only chip that has no channel sequencer, num_slots should remain
undefined.

Also modify config AD7192 description for better scaling.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/Kconfig  |  11 ++-
 drivers/iio/adc/ad7192.c | 147 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 150 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 8db68b80b391..74fecc284f1a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -88,12 +88,17 @@ config AD7173
 	  called ad7173.
 
 config AD7192
-	tristate "Analog Devices AD7190 AD7192 AD7193 AD7195 ADC driver"
+	tristate "Analog Devices AD7192 and similar ADC driver"
 	depends on SPI
 	select AD_SIGMA_DELTA
 	help
-	  Say yes here to build support for Analog Devices AD7190,
-	  AD7192, AD7193 or AD7195 SPI analog to digital converters (ADC).
+	  Say yes here to build support for Analog Devices SPI analog to digital
+	  converters (ADC):
+	  - AD7190
+	  - AD7192
+	  - AD7193
+	  - AD7194
+	  - AD7195
 	  If unsure, say N (but it's safe to say "Y").
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 7160929d32c9..fe2d8d55fa76 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * AD7190 AD7192 AD7193 AD7195 SPI ADC driver
+ * AD7192 and similar SPI ADC driver
  *
  * Copyright 2011-2015 Analog Devices Inc.
  */
@@ -129,10 +129,22 @@
 #define AD7193_CH_AIN8		0x480 /* AIN7 - AINCOM */
 #define AD7193_CH_AINCOM	0x600 /* AINCOM - AINCOM */
 
+#define AD7194_CH_POS(x)	(((x) - 1) << 4)
+#define AD7194_CH_NEG(x)	((x) - 1)
+#define AD7194_CH(p)		(BIT(10) | AD7194_CH_POS(p))
+				  /* 10th bit corresponds to CON18(Pseudo) */
+#define AD7194_DIFF_CH(p, n)	(AD7194_CH_POS(p) | AD7194_CH_NEG(n))
+#define AD7194_CH_TEMP		0x100 /* Temp sensor */
+#define AD7194_CH_BASE_NR	2
+#define AD7194_CH_AIN_START	1
+#define AD7194_CH_AIN_NR	16
+#define AD7194_CH_MAX_NR	272
+
 /* ID Register Bit Designations (AD7192_REG_ID) */
 #define CHIPID_AD7190		0x4
 #define CHIPID_AD7192		0x0
 #define CHIPID_AD7193		0x2
+#define CHIPID_AD7194		0x3
 #define CHIPID_AD7195		0x6
 #define AD7192_ID_MASK		GENMASK(3, 0)
 
@@ -170,6 +182,7 @@ enum {
 	ID_AD7190,
 	ID_AD7192,
 	ID_AD7193,
+	ID_AD7194,
 	ID_AD7195,
 };
 
@@ -178,7 +191,9 @@ struct ad7192_chip_info {
 	const char			*name;
 	const struct iio_chan_spec	*channels;
 	u8				num_channels;
+	const struct ad_sigma_delta_info	*sigma_delta_info;
 	const struct iio_info		*info;
+	int (*parse_channels)(struct iio_dev *indio_dev);
 };
 
 struct ad7192_state {
@@ -346,6 +361,18 @@ static const struct ad_sigma_delta_info ad7192_sigma_delta_info = {
 	.irq_flags = IRQF_TRIGGER_FALLING,
 };
 
+static const struct ad_sigma_delta_info ad7194_sigma_delta_info = {
+	.set_channel = ad7192_set_channel,
+	.append_status = ad7192_append_status,
+	.disable_all = ad7192_disable_all,
+	.set_mode = ad7192_set_mode,
+	.has_registers = true,
+	.addr_shift = 3,
+	.read_mask = BIT(6),
+	.status_ch_mask = GENMASK(3, 0),
+	.irq_flags = IRQF_TRIGGER_FALLING,
+};
+
 static const struct ad_sd_calib_data ad7192_calib_arr[8] = {
 	{AD7192_MODE_CAL_INT_ZERO, AD7192_CH_AIN1},
 	{AD7192_MODE_CAL_INT_FULL, AD7192_CH_AIN1},
@@ -937,6 +964,14 @@ static const struct iio_info ad7192_info = {
 	.update_scan_mode = ad7192_update_scan_mode,
 };
 
+static const struct iio_info ad7194_info = {
+	.read_raw = ad7192_read_raw,
+	.write_raw = ad7192_write_raw,
+	.write_raw_get_fmt = ad7192_write_raw_get_fmt,
+	.read_avail = ad7192_read_avail,
+	.validate_trigger = ad_sd_validate_trigger,
+};
+
 static const struct iio_info ad7195_info = {
 	.read_raw = ad7192_read_raw,
 	.write_raw = ad7192_write_raw,
@@ -1028,12 +1063,96 @@ static const struct iio_chan_spec ad7193_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(14),
 };
 
+static int ad7194_validate_ain_channel(struct device *dev, u32 ain)
+{
+	if (!in_range(ain, AD7194_CH_AIN_START, AD7194_CH_AIN_NR))
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid AIN channel: %u\n", ain);
+
+	return 0;
+}
+
+static int ad7194_parse_channels(struct iio_dev *indio_dev)
+{
+	struct device *dev = indio_dev->dev.parent;
+	struct iio_chan_spec *ad7194_channels;
+	const struct iio_chan_spec ad7194_chan = AD7193_CHANNEL(0, 0, 0);
+	const struct iio_chan_spec ad7194_chan_diff = AD7193_DIFF_CHANNEL(0, 0, 0, 0);
+	const struct iio_chan_spec ad7194_chan_temp = AD719x_TEMP_CHANNEL(0, 0);
+	const struct iio_chan_spec ad7194_chan_timestamp = IIO_CHAN_SOFT_TIMESTAMP(0);
+	unsigned int num_channels, index = 0;
+	u32 ain[2];
+	int ret;
+
+	num_channels = device_get_child_node_count(dev);
+	if (num_channels > AD7194_CH_MAX_NR)
+		return dev_err_probe(dev, -EINVAL,
+				     "Too many channels: %u\n", num_channels);
+
+	num_channels += AD7194_CH_BASE_NR;
+
+	ad7194_channels = devm_kcalloc(dev, num_channels,
+				       sizeof(*ad7194_channels), GFP_KERNEL);
+	if (!ad7194_channels)
+		return -ENOMEM;
+
+	indio_dev->channels = ad7194_channels;
+	indio_dev->num_channels = num_channels;
+
+	device_for_each_child_node_scoped(dev, child) {
+		ret = fwnode_property_read_u32_array(child, "diff-channels",
+						     ain, ARRAY_SIZE(ain));
+		if (ret == 0) {
+			ret = ad7194_validate_ain_channel(dev, ain[0]);
+			if (ret)
+				return ret;
+
+			ret = ad7194_validate_ain_channel(dev, ain[1]);
+			if (ret)
+				return ret;
+
+			*ad7194_channels = ad7194_chan_diff;
+			ad7194_channels->scan_index = index++;
+			ad7194_channels->channel = ain[0];
+			ad7194_channels->channel2 = ain[1];
+			ad7194_channels->address = AD7194_DIFF_CH(ain[0], ain[1]);
+		} else {
+			ret = fwnode_property_read_u32(child, "single-channel",
+						       &ain[0]);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "Missing channel property\n");
+
+			ret = ad7194_validate_ain_channel(dev, ain[0]);
+			if (ret)
+				return ret;
+
+			*ad7194_channels = ad7194_chan;
+			ad7194_channels->scan_index = index++;
+			ad7194_channels->channel = ain[0];
+			ad7194_channels->address = AD7194_CH(ain[0]);
+		}
+		ad7194_channels++;
+	}
+
+	*ad7194_channels = ad7194_chan_temp;
+	ad7194_channels->scan_index = index++;
+	ad7194_channels->address = AD7194_CH_TEMP;
+	ad7194_channels++;
+
+	*ad7194_channels = ad7194_chan_timestamp;
+	ad7194_channels->scan_index = index;
+
+	return 0;
+}
+
 static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
 	[ID_AD7190] = {
 		.chip_id = CHIPID_AD7190,
 		.name = "ad7190",
 		.channels = ad7192_channels,
 		.num_channels = ARRAY_SIZE(ad7192_channels),
+		.sigma_delta_info = &ad7192_sigma_delta_info,
 		.info = &ad7192_info,
 	},
 	[ID_AD7192] = {
@@ -1041,6 +1160,7 @@ static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
 		.name = "ad7192",
 		.channels = ad7192_channels,
 		.num_channels = ARRAY_SIZE(ad7192_channels),
+		.sigma_delta_info = &ad7192_sigma_delta_info,
 		.info = &ad7192_info,
 	},
 	[ID_AD7193] = {
@@ -1048,13 +1168,22 @@ static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
 		.name = "ad7193",
 		.channels = ad7193_channels,
 		.num_channels = ARRAY_SIZE(ad7193_channels),
+		.sigma_delta_info = &ad7192_sigma_delta_info,
 		.info = &ad7192_info,
 	},
+	[ID_AD7194] = {
+		.chip_id = CHIPID_AD7194,
+		.name = "ad7194",
+		.info = &ad7194_info,
+		.sigma_delta_info = &ad7194_sigma_delta_info,
+		.parse_channels = ad7194_parse_channels,
+	},
 	[ID_AD7195] = {
 		.chip_id = CHIPID_AD7195,
 		.name = "ad7195",
 		.channels = ad7192_channels,
 		.num_channels = ARRAY_SIZE(ad7192_channels),
+		.sigma_delta_info = &ad7192_sigma_delta_info,
 		.info = &ad7195_info,
 	},
 };
@@ -1161,11 +1290,17 @@ static int ad7192_probe(struct spi_device *spi)
 	st->chip_info = spi_get_device_match_data(spi);
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = st->chip_info->channels;
-	indio_dev->num_channels = st->chip_info->num_channels;
 	indio_dev->info = st->chip_info->info;
+	if (st->chip_info->parse_channels) {
+		ret = st->chip_info->parse_channels(indio_dev);
+		if (ret)
+			return ret;
+	} else {
+		indio_dev->channels = st->chip_info->channels;
+		indio_dev->num_channels = st->chip_info->num_channels;
+	}
 
-	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7192_sigma_delta_info);
+	ret = ad_sd_init(&st->sd, indio_dev, spi, st->chip_info->sigma_delta_info);
 	if (ret)
 		return ret;
 
@@ -1202,6 +1337,7 @@ static const struct of_device_id ad7192_of_match[] = {
 	{ .compatible = "adi,ad7190", .data = &ad7192_chip_info_tbl[ID_AD7190] },
 	{ .compatible = "adi,ad7192", .data = &ad7192_chip_info_tbl[ID_AD7192] },
 	{ .compatible = "adi,ad7193", .data = &ad7192_chip_info_tbl[ID_AD7193] },
+	{ .compatible = "adi,ad7194", .data = &ad7192_chip_info_tbl[ID_AD7194] },
 	{ .compatible = "adi,ad7195", .data = &ad7192_chip_info_tbl[ID_AD7195] },
 	{}
 };
@@ -1211,6 +1347,7 @@ static const struct spi_device_id ad7192_ids[] = {
 	{ "ad7190", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7190] },
 	{ "ad7192", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7192] },
 	{ "ad7193", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7193] },
+	{ "ad7194", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7194] },
 	{ "ad7195", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7195] },
 	{}
 };
@@ -1227,6 +1364,6 @@ static struct spi_driver ad7192_driver = {
 module_spi_driver(ad7192_driver);
 
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
-MODULE_DESCRIPTION("Analog Devices AD7190, AD7192, AD7193, AD7195 ADC");
+MODULE_DESCRIPTION("Analog Devices AD7192 and similar ADC");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
-- 
2.34.1


