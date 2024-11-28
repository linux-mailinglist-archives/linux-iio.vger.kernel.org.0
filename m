Return-Path: <linux-iio+bounces-12780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38F79DB828
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 13:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6332164608
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 12:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FC61AB6ED;
	Thu, 28 Nov 2024 12:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGI7+5oO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3561AA1E0;
	Thu, 28 Nov 2024 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732798718; cv=none; b=SZHeM/7JKVEzkDj/BmfRlpDtaT5T1JYA3P+xdv30v8CjXTjyRCXQjFHVVIuZDnVMzXaeTrdiGzouNjbSqCSQycD0Ho6G+aSdhjVDMTXGNKmDMN81mJSV3Ra0nepQ2hjdrSSHgzyZwjqE1X4Le7oWQ4v+3bRUrvgsI6ofSa1n/Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732798718; c=relaxed/simple;
	bh=OVRm53299Oh2RBtSDM/Cw/Sa4S8tUwXVvN9qZ8E+CJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSBtoFNO4fr8aftk77g9HKmip3HskhUj6I/AW5vrfbyw03PQPyXRoYqjGXbU8P55QDcFmpQwSsaHGwHHC3SkJ50UU/eS4tP4m1bzWBirQw46erciNJS90x+QTclOzvEwKRoeVNN3zPsgznXv7jjXgaI7FPR7cw2ynmHu/6CEshw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGI7+5oO; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38231e9d518so566440f8f.0;
        Thu, 28 Nov 2024 04:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732798715; x=1733403515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXGhOrQavhFBrDDrZb+1U4b8mAecq/hLNguuuXdg22g=;
        b=dGI7+5oONOulya2RnwNBBM7KCBya8B7LHgJgVbIlLtTfXBJ+FBK6bH1ZYs3n4T/k7e
         N4F35GF2v2QY2IJykuYsQ2VZDyBH9MwIxE2sMZc20Aw7BrXMpfg0pMraJmvhwNpGVdz6
         m3D9qmW+Lus91ku0xl64sDV6lcKuFZBUvOsrNhuec/AsT5dMHFUDdhXPAEhlR5aiMSx0
         cyr1oeuY4VHrj8xdwxWgGIEMQYHzi73QZyL+w/u9RhEqY7EiuogydkmmekiH1B7yM+kr
         cLs+ZBL4suZItJ9RbAoeRaU4HBWMLeQAC0qp9VP9P9IK1dJAGBXEip0U8X7Yj51VStzF
         CIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732798715; x=1733403515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXGhOrQavhFBrDDrZb+1U4b8mAecq/hLNguuuXdg22g=;
        b=gXHYhYf5/WyI+i0mesClV07U1XrRSwCcwT7ByM3vqUx686I+yQVaewCxATbCFmPbp3
         bvO0RRCvUQcmy1aGIeuTax9TPMqVw5xd+o1RG3xN8oSmSymNXG6VekXlKsRwZF1CIFwu
         H8CPoVLGCJCN3tzaf9InRTxNA50dCUPX2JYLVh+p/kL2nJvSfPFcvM6pCAN+suV5idjU
         oHUSRFEmKuo7/q9CpcHA64SrdjcCZemH8nlWZqZtAMQ3NRWWJSU5A3DrPd4OMwVxKhOn
         4ioPzaEbizB/xU8gnIduk0DOe+Dkb57bqq45MfF34wN1Y808GfLCeiGFdwW17KGSEP+b
         y1pg==
X-Forwarded-Encrypted: i=1; AJvYcCU3JkVW2EexSdkgN9gIArX9/R2c3MLxZ7Cs+4zPMvc6LBxMKNFUMCBXRNzwumqebqeZvqGRyuT7MICm@vger.kernel.org, AJvYcCXJTtnAWDcpaVIc1Pb3VgV4P5h5WcytAWpxF+AUijN2i5pQGJTYEAwhxteuv0bCb8dmKuu5ke6WA/KtMfeX@vger.kernel.org, AJvYcCXNPfNhtl/t32ZudErbdoBNB3J8KnJxXDASEQlEjkd2jPfNnYvOcAi9qD95/8SsaQ/9xpsImf9KZv1B@vger.kernel.org
X-Gm-Message-State: AOJu0YyOlUgCPMgTKcYWhNFUmM9ZFBAJVtLP9p6kB0Gcf9FIBfuoCpvw
	ShHtT11cp1J3OdbekY+Q+BjkzIvmg7NnXSZzGOj5W3faaCIbpQyG
X-Gm-Gg: ASbGncvFC7TrPooXeGfX8w1/UTqUJn4i0wijnWMNGu9tnuDbpO42oE1+D8l4dSTvCVA
	8eXT58QURSNuAFMCaFRNKpY2HwEk5fuzggVM5YphOqsFHp8POCr4wcD9sH3V2M1LFQ/xOoy3UfX
	Trxi8IW6A6cQ4TBJZiw5iEu82xTJwMv6lSrzoEOBcr7gJdBSoLua51xIzU5c3+XSIPj8L611uCD
	dP5J0e+vGwgx2sPnnRg/0HNVPSjswtRkmwt4Cc2ECWJmOy0UOaF
X-Google-Smtp-Source: AGHT+IHp6F0r+EDXhHXXQKMfwVptsCJSH4AhVCDh8ZWKQfM8PMaQRFrFsR7JRmt71/BIYAa2FaWAXg==
X-Received: by 2002:a05:6000:1562:b0:382:383e:84e2 with SMTP id ffacd0b85a97d-385c6edb2a4mr6480529f8f.46.1732798714803;
        Thu, 28 Nov 2024 04:58:34 -0800 (PST)
Received: from spiri.. ([2a02:2f0e:3506:d600:5f69:ea1c:6c79:3753])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd68d08sm1611853f8f.70.2024.11.28.04.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 04:58:34 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v1 3/3] iio: adc: ad7192: Add sync gpio
Date: Thu, 28 Nov 2024 14:55:03 +0200
Message-ID: <20241128125811.11913-4-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128125811.11913-1-alisa.roman@analog.com>
References: <20241128125811.11913-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the SYNC pin of AD719x devices. This pin is controlled
through a GPIO. The pin allows synchronization of digital filters and
analog modulators when using multiple devices.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 112 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 955e9eff0099..542db7280e99 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/device.h>
+#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
@@ -196,6 +197,7 @@ struct ad7192_chip_info {
 	u8				num_channels;
 	const struct ad_sigma_delta_info	*sigma_delta_info;
 	const struct iio_info		*info;
+	const struct iio_info		*info_sync;
 	int (*parse_channels)(struct iio_dev *indio_dev);
 };
 
@@ -216,6 +218,8 @@ struct ad7192_state {
 	struct mutex			lock;	/* protect sensor state */
 	u8				syscalib_mode[8];
 
+	struct gpio_desc		*sync_gpio;
+
 	struct ad_sigma_delta		sd;
 };
 
@@ -783,6 +787,36 @@ static void ad7192_update_filter_freq_avail(struct ad7192_state *st)
 	st->filter_freq_avail[3][0] = DIV_ROUND_CLOSEST(fadc * 272, 1024);
 }
 
+static ssize_t sync_gpio_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad7192_state *st = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%d\n", gpiod_get_value(st->sync_gpio));
+}
+
+static ssize_t sync_gpio_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf,
+			       size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad7192_state *st = iio_priv(indio_dev);
+	int val;
+	int ret;
+
+	ret = kstrtoint(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	if (st->sync_gpio)
+		gpiod_set_value(st->sync_gpio, val);
+
+	return len;
+}
+
 static IIO_DEVICE_ATTR(bridge_switch_en, 0644,
 		       ad7192_show_bridge_switch, ad7192_set,
 		       AD7192_REG_GPOCON);
@@ -791,25 +825,57 @@ static IIO_DEVICE_ATTR(ac_excitation_en, 0644,
 		       ad7192_show_ac_excitation, ad7192_set,
 		       AD7192_REG_CONF);
 
+static IIO_DEVICE_ATTR_RW(sync_gpio, 0);
+
 static struct attribute *ad7192_attributes[] = {
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
 	NULL
 };
 
+static struct attribute *ad7192_attributes_sync[] = {
+	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
+	&iio_dev_attr_sync_gpio.dev_attr.attr,
+	NULL
+};
+
 static const struct attribute_group ad7192_attribute_group = {
 	.attrs = ad7192_attributes,
 };
 
+static const struct attribute_group ad7192_attribute_group_sync = {
+	.attrs = ad7192_attributes_sync,
+};
+
+static struct attribute *ad7194_attributes_sync[] = {
+	&iio_dev_attr_sync_gpio.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group ad7194_attribute_group_sync = {
+	.attrs = ad7194_attributes_sync,
+};
+
 static struct attribute *ad7195_attributes[] = {
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
 	&iio_dev_attr_ac_excitation_en.dev_attr.attr,
 	NULL
 };
 
+static struct attribute *ad7195_attributes_sync[] = {
+	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
+	&iio_dev_attr_ac_excitation_en.dev_attr.attr,
+	&iio_dev_attr_sync_gpio.dev_attr.attr,
+	NULL
+};
+
 static const struct attribute_group ad7195_attribute_group = {
 	.attrs = ad7195_attributes,
 };
 
+static const struct attribute_group ad7195_attribute_group_sync = {
+	.attrs = ad7195_attributes_sync,
+};
+
 static unsigned int ad7192_get_temp_scale(bool unipolar)
 {
 	return unipolar ? 2815 * 2 : 2815;
@@ -1103,6 +1169,16 @@ static const struct iio_info ad7192_info = {
 	.update_scan_mode = ad7192_update_scan_mode,
 };
 
+static const struct iio_info ad7192_info_sync = {
+	.read_raw = ad7192_read_raw,
+	.write_raw = ad7192_write_raw,
+	.write_raw_get_fmt = ad7192_write_raw_get_fmt,
+	.read_avail = ad7192_read_avail,
+	.attrs = &ad7192_attribute_group_sync,
+	.validate_trigger = ad_sd_validate_trigger,
+	.update_scan_mode = ad7192_update_scan_mode,
+};
+
 static const struct iio_info ad7194_info = {
 	.read_raw = ad7192_read_raw,
 	.write_raw = ad7192_write_raw,
@@ -1111,6 +1187,15 @@ static const struct iio_info ad7194_info = {
 	.validate_trigger = ad_sd_validate_trigger,
 };
 
+static const struct iio_info ad7194_info_sync = {
+	.read_raw = ad7192_read_raw,
+	.write_raw = ad7192_write_raw,
+	.write_raw_get_fmt = ad7192_write_raw_get_fmt,
+	.read_avail = ad7192_read_avail,
+	.attrs = &ad7194_attribute_group_sync,
+	.validate_trigger = ad_sd_validate_trigger,
+};
+
 static const struct iio_info ad7195_info = {
 	.read_raw = ad7192_read_raw,
 	.write_raw = ad7192_write_raw,
@@ -1121,6 +1206,16 @@ static const struct iio_info ad7195_info = {
 	.update_scan_mode = ad7192_update_scan_mode,
 };
 
+static const struct iio_info ad7195_info_sync = {
+	.read_raw = ad7192_read_raw,
+	.write_raw = ad7192_write_raw,
+	.write_raw_get_fmt = ad7192_write_raw_get_fmt,
+	.read_avail = ad7192_read_avail,
+	.attrs = &ad7195_attribute_group_sync,
+	.validate_trigger = ad_sd_validate_trigger,
+	.update_scan_mode = ad7192_update_scan_mode,
+};
+
 #define __AD719x_CHANNEL(_si, _channel1, _channel2, _address, _type, \
 	_mask_all, _mask_type_av, _mask_all_av, _ext_info) \
 	{ \
@@ -1292,6 +1387,7 @@ static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
 		.num_channels = ARRAY_SIZE(ad7192_channels),
 		.sigma_delta_info = &ad7192_sigma_delta_info,
 		.info = &ad7192_info,
+		.info_sync = &ad7192_info_sync,
 	},
 	[ID_AD7192] = {
 		.chip_id = CHIPID_AD7192,
@@ -1300,6 +1396,7 @@ static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
 		.num_channels = ARRAY_SIZE(ad7192_channels),
 		.sigma_delta_info = &ad7192_sigma_delta_info,
 		.info = &ad7192_info,
+		.info_sync = &ad7192_info_sync,
 	},
 	[ID_AD7193] = {
 		.chip_id = CHIPID_AD7193,
@@ -1308,11 +1405,13 @@ static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
 		.num_channels = ARRAY_SIZE(ad7193_channels),
 		.sigma_delta_info = &ad7192_sigma_delta_info,
 		.info = &ad7192_info,
+		.info_sync = &ad7192_info_sync,
 	},
 	[ID_AD7194] = {
 		.chip_id = CHIPID_AD7194,
 		.name = "ad7194",
 		.info = &ad7194_info,
+		.info_sync = &ad7194_info_sync,
 		.sigma_delta_info = &ad7194_sigma_delta_info,
 		.parse_channels = ad7194_parse_channels,
 	},
@@ -1323,6 +1422,7 @@ static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
 		.num_channels = ARRAY_SIZE(ad7192_channels),
 		.sigma_delta_info = &ad7192_sigma_delta_info,
 		.info = &ad7195_info,
+		.info_sync = &ad7195_info_sync,
 	},
 };
 
@@ -1344,6 +1444,11 @@ static int ad7192_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 
+	st->sync_gpio = devm_gpiod_get_optional(dev, "sync", GPIOD_OUT_HIGH);
+	if (IS_ERR(st->sync_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->sync_gpio),
+				     "Failed to get sync gpio.\n");
+
 	/*
 	 * Regulator aincom is optional to maintain compatibility with older DT.
 	 * Newer firmware should provide a zero volt fixed supply if wired to
@@ -1399,7 +1504,12 @@ static int ad7192_probe(struct spi_device *spi)
 
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->info = st->chip_info->info;
+
+	if (st->sync_gpio)
+		indio_dev->info = st->chip_info->info_sync;
+	else
+		indio_dev->info = st->chip_info->info;
+
 	if (st->chip_info->parse_channels) {
 		ret = st->chip_info->parse_channels(indio_dev);
 		if (ret)
-- 
2.43.0


