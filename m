Return-Path: <linux-iio+bounces-24039-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 030B7B556CB
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 21:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60475C112B
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 19:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D752C33CE82;
	Fri, 12 Sep 2025 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fa1PYumc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCA32882BC
	for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757704216; cv=none; b=I7/qj63y2IPOwVpq7+3wsr7tCHMl79t2Gww8RhPInz1FcASftKCnw7pF5O2xDabHI2ZXwoOS5r/2/wRSRTgGNY8scA5DzL1CMxPPv0EbPmUW0a13lmaYK8I+inz2/5jrD549S+riPoAt/JxCWzIwJqRyM8aNqwjmH63ZBLU2xH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757704216; c=relaxed/simple;
	bh=jWptYni8EFrlcW6nfL6q6FvYQn3bWuQlLBU4mOdMqyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cojh4afE2K484LC1+Da/+dJPinuLxt6KKWZPYVKCAv1BA0C2sCs2jGRxc5yhuYya5pMC8JYVGOQTTEpJmvuKz4cWl6IrQrYmPM/8BY+kucbzI3iKtHH3c38ndoADVerioX0Sv82WRpnaYTVbYrTIWLwlKODZh0ZTDPBV8L6Kx6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fa1PYumc; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-753a9c8dabeso411283a34.3
        for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 12:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757704213; x=1758309013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SnsbF8iFpF2Vu2W4L2Lrm4Q+zZ7NoOPgyEvQrpZE3Mo=;
        b=fa1PYumceY3DQImPv5FKPJTW7kfaEaGsvpmpIHzyHcfbf0QCg4auEfaK5wCsUfhcT3
         vAWu8BpGN07r+Wz/WLlS8KcORoCphpFI5mzKn7XvUlnhYcexjToGgboZRmCL6+gEdlH4
         bMDTQRdIAY4afa+zNliNAOA5DXi7TQXngYOrnMDDre6FaRrakTgeKYP4ZjrSUvQLXMHO
         vhWBe+osCcO/SC7FobYNV8zaNXKSQRr4F7UeLWgAvsFrP4vxQRBiniRbGrcwCMjHZ2YR
         kSjAB4cOHOsdYAVUKjduYnNEhqrL5JyBcPTj0rUVdnJYqg3IAjjngGXoMwPGsQvLf3Bt
         lbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757704213; x=1758309013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnsbF8iFpF2Vu2W4L2Lrm4Q+zZ7NoOPgyEvQrpZE3Mo=;
        b=CS3pZKmUPgiyt081LulcWDj9YFngOx8IvKpb3DYfrfPkVrYKY6VabJpL1/ErSih91T
         Cyrv1qnAD0neXCI1xfeKQ+imanN7O92h/8goDYF4s6Ka0juddEgShJ85clZGIkSh+GXf
         m2d5vs+iNgaks+19VZzP1rqDlakhls3KlIDX8ercfd0Oqh7Fr0i7MUkzNTQWtLsM3wIa
         aI6aQWufYyU0kW5yjnBMdM406CXPGKXw3b7vSDcL7eHHKc0nWSBx4kW1ng5JifgIQ4TQ
         1jYlYl/t5jt2hUlhKyZWrDLFiEv7dHFJEQEFg2bQ6zWRE7xMbMxY5gnSXgQ60NVT/y2Z
         s8eg==
X-Gm-Message-State: AOJu0YxpP3vvaOtfZzmdkIGjmdwG7dHZE1cD/+RV6ev6NHM8s3DNPfXb
	uKFmnRVB20hWttIOCFZkPS62p9mAtUbIb8C0vCKltN8aJjN/R/4xpVVXRYDIE4RtSw4=
X-Gm-Gg: ASbGncsksncwuaMcNWOi0ubEEi4p/KsV5SmkfqiaV+OUqZpY5Ghx9SL9umGsgkTw19s
	a4BRYwf5k3RyGCaOkzWWjNjBgOVR5NSEVrIPlmox61+nX528MhMuX488cYLTPut57bgohDg1wgX
	LgAnFBWXAoBILniQLBCiRCNHx38uIL9af9vY0Rzlq0TxGQRJGM5Pufrq6+TrSog9vxeNW15/el0
	AKWmdqEUhVIcG1yBX7fruYPPTWeOocX3C2kju3xRpDRMQIYxy+nuDFM2WKp2YjQssltvH1MnASW
	rwUzc0oofFcrfOzXG8WiHhaK+wQCkzmFAEtE4oql19ig0O9ngilp5R4VAJP83IXE33AEIWRM0qg
	kf5f4LaFvZAoo9rEOD+Tps4t7UJ11
X-Google-Smtp-Source: AGHT+IEulcuGJ6JOxxLEa8SXk0qrBqgDn16Fo34FpvWPLYMbUEpBiKmFYFa8I0gELauBVk5KtiE+uA==
X-Received: by 2002:a05:6830:d0a:b0:746:d995:4e72 with SMTP id 46e09a7af769-7535269888emr2201134a34.6.1757704212575;
        Fri, 12 Sep 2025 12:10:12 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524986c872sm1172564a34.15.2025.09.12.12.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:10:11 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 12 Sep 2025 14:09:32 -0500
Subject: [PATCH v2 3/4] iio: adc: ad7173: support changing filter type
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250912-iio-adc-ad7137-add-filter-support-v2-3-bd32dfa3d761@baylibre.com>
References: <20250912-iio-adc-ad7137-add-filter-support-v2-0-bd32dfa3d761@baylibre.com>
In-Reply-To: <20250912-iio-adc-ad7137-add-filter-support-v2-0-bd32dfa3d761@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12423;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=jWptYni8EFrlcW6nfL6q6FvYQn3bWuQlLBU4mOdMqyk=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoxHADGPMGATQHMAD7rHbvuiH/iXBLiulPwANH4
 XlpkaD+WAqJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMRwAwAKCRDCzCAB/wGP
 wENYCACPQIuCTE19ahiqh3rF/JnRYmYWG8lSMUE9+tSRrpCywd7KkOyyZGVfy1H8RH1fsM6EMZZ
 qHTnOBJq94SDCc1wrnOoxZjNJK75R1BFH3pJK0CCVL60hQp7MZBxp3aaJEt/O+rLhAimK14jvBL
 M1bGnq4jWaQ/xfH7UZnFGGREHc90zO/qs7eBWreAsHim2YmGQrq435b8/J1vTv7CGq56hLz1t4T
 DU6ufo2doN1wrnwY2BD76AoS5kwhoXzY5AJ895hCqht9cA6E2IzsTpKYASMHY1aT0X/N2o4buHP
 YPLB6h0Thdkb7yy4yDHffqcGiISs5o+HOAMVQCHfCOgF8tGC
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for changing the filter type to the ad7173 driver.

This family of chips by default uses a sinc5+sinc1 filter. There are
also optional post-filters that can be added in this configuration for
various 50/60Hz rejection purposes. The sinc3 filter doesn't have any
post-filters and handles the output data rate (ODR) a bit differently.
Here, we've opted to use SINC3_MAPx to get the maximum possible
sampling frequencies with the SINC3 filter.

Adding support consists of adding the filter_type and
filter_type_available attributes, making the sampling_frequency
attribute aware of the filter type, and programming the filter
parameters when we configure the channel of the ADC for reading
a sample.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7173.c | 186 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 181 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 80734ae25f9df31d846e242ab7142251e4ee588d..48947210a1036f0efef048050890db3d260f67ce 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -8,6 +8,7 @@
  *  AD7175-8/AD7176-2/AD7177-2
  *
  * Copyright (C) 2015, 2024 Analog Devices, Inc.
+ * Copyright (C) 2025 BayLibre, SAS
  */
 
 #include <linux/array_size.h>
@@ -149,7 +150,12 @@
 					       (pin2) < st->info->num_voltage_in && \
 					       (pin2) >= st->info->num_voltage_in_div)
 
-#define AD7173_FILTER_ODR0_MASK		GENMASK(5, 0)
+#define AD7173_FILTER_SINC3_MAP		BIT(15)
+#define AD7173_FILTER_SINC3_MAP_DIV	GENMASK(14, 0)
+#define AD7173_FILTER_ENHFILTEN		BIT(11)
+#define AD7173_FILTER_ENHFILT_MASK	GENMASK(10, 8)
+#define AD7173_FILTER_ORDER		BIT(6)
+#define AD7173_FILTER_ODR_MASK		GENMASK(5, 0)
 #define AD7173_MAX_CONFIGS		8
 #define AD4111_OW_DET_THRSH_MV		300
 
@@ -190,6 +196,15 @@ struct ad7173_device_info {
 	u8 num_gpios;
 };
 
+enum ad7173_filter_type {
+	AD7173_FILTER_SINC3,
+	AD7173_FILTER_SINC5_SINC1,
+	AD7173_FILTER_SINC5_SINC1_PF1,
+	AD7173_FILTER_SINC5_SINC1_PF2,
+	AD7173_FILTER_SINC5_SINC1_PF3,
+	AD7173_FILTER_SINC5_SINC1_PF4,
+};
+
 struct ad7173_channel_config {
 	/* Openwire detection threshold */
 	unsigned int openwire_thrsh_raw;
@@ -205,8 +220,10 @@ struct ad7173_channel_config {
 	struct_group(config_props,
 		bool bipolar;
 		bool input_buf;
+		u16 sinc3_odr_div;
 		u8 sinc5_odr_index;
 		u8 ref_sel;
+		enum ad7173_filter_type filter_type;
 	);
 };
 
@@ -266,6 +283,24 @@ static const unsigned int ad7175_sinc5_data_rates[] = {
 	5000,					/* 20    */
 };
 
+/**
+ * ad7173_sinc3_odr_div_from_odr() - Convert ODR to divider value
+ * @odr_millihz: ODR (sampling_frequency) in milliHz
+ * Returns: Divider value for SINC3 filter to pass.
+ */
+static u16 ad7173_sinc3_odr_div_from_odr(u32 odr_millihz)
+{
+	/*
+	 * Divider is f_MOD (1 MHz) / 32 / ODR. ODR freq is in milliHz, so
+	 * we need to convert f_MOD to the same units. When SING_CYC=1 or
+	 * multiple channels are enabled (currently always the case), there
+	 * is an additional factor of 3.
+	 */
+	u32 div = DIV_ROUND_CLOSEST(MEGA * MILLI, odr_millihz * 32 * 3);
+	/* Avoid divide by 0 and limit to register field size. */
+	return clamp(div, 1U, AD7173_FILTER_SINC3_MAP_DIV);
+}
+
 static unsigned int ad4111_current_channel_config[] = {
 	/* Ain sel: pos        neg    */
 	0x1E8, /* 15:IIN0+    8:IIN0− */
@@ -369,6 +404,47 @@ static const struct iio_enum ad7173_syscalib_mode_enum = {
 	.get = ad7173_get_syscalib_mode
 };
 
+static const char * const ad7173_filter_types_str[] = {
+	[AD7173_FILTER_SINC3] = "sinc3",
+	[AD7173_FILTER_SINC5_SINC1] = "sinc5+sinc1",
+	[AD7173_FILTER_SINC5_SINC1_PF1] = "sinc5+sinc1+pf1",
+	[AD7173_FILTER_SINC5_SINC1_PF2] = "sinc5+sinc1+pf2",
+	[AD7173_FILTER_SINC5_SINC1_PF3] = "sinc5+sinc1+pf3",
+	[AD7173_FILTER_SINC5_SINC1_PF4] = "sinc5+sinc1+pf4",
+};
+
+static int ad7173_set_filter_type(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  unsigned int val)
+{
+	struct ad7173_state *st = iio_priv(indio_dev);
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	st->channels[chan->address].cfg.filter_type = val;
+	st->channels[chan->address].cfg.live = false;
+
+	iio_device_release_direct(indio_dev);
+
+	return 0;
+}
+
+static int ad7173_get_filter_type(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan)
+{
+	struct ad7173_state *st = iio_priv(indio_dev);
+
+	return st->channels[chan->address].cfg.filter_type;
+}
+
+static const struct iio_enum ad7173_filter_type_enum = {
+	.items = ad7173_filter_types_str,
+	.num_items = ARRAY_SIZE(ad7173_filter_types_str),
+	.set = ad7173_set_filter_type,
+	.get = ad7173_get_filter_type,
+};
+
 static const struct iio_chan_spec_ext_info ad7173_chan_spec_ext_info[] = {
 	{
 		.name = "sys_calibration",
@@ -379,6 +455,16 @@ static const struct iio_chan_spec_ext_info ad7173_chan_spec_ext_info[] = {
 		 &ad7173_syscalib_mode_enum),
 	IIO_ENUM_AVAILABLE("sys_calibration_mode", IIO_SHARED_BY_TYPE,
 			   &ad7173_syscalib_mode_enum),
+	IIO_ENUM("filter_type", IIO_SEPARATE, &ad7173_filter_type_enum),
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_TYPE,
+			   &ad7173_filter_type_enum),
+	{ }
+};
+
+static const struct iio_chan_spec_ext_info ad7173_temp_chan_spec_ext_info[] = {
+	IIO_ENUM("filter_type", IIO_SEPARATE, &ad7173_filter_type_enum),
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_TYPE,
+			   &ad7173_filter_type_enum),
 	{ }
 };
 
@@ -582,14 +668,18 @@ static bool ad7173_setup_equal(const struct ad7173_channel_config *cfg1,
 		      sizeof(struct {
 				     bool bipolar;
 				     bool input_buf;
+				     u16 sinc3_odr_div;
 				     u8 sinc5_odr_index;
 				     u8 ref_sel;
+				     enum ad7173_filter_type filter_type;
 			     }));
 
 	return cfg1->bipolar == cfg2->bipolar &&
 	       cfg1->input_buf == cfg2->input_buf &&
+	       cfg1->sinc3_odr_div == cfg2->sinc3_odr_div &&
 	       cfg1->sinc5_odr_index == cfg2->sinc5_odr_index &&
-	       cfg1->ref_sel == cfg2->ref_sel;
+	       cfg1->ref_sel == cfg2->ref_sel &&
+	       cfg1->filter_type == cfg2->filter_type;
 }
 
 static struct ad7173_channel_config *
@@ -630,6 +720,7 @@ static int ad7173_load_config(struct ad7173_state *st,
 {
 	unsigned int config;
 	int free_cfg_slot, ret;
+	u8 post_filter_enable, post_filter_select;
 
 	free_cfg_slot = ida_alloc_range(&st->cfg_slots_status, 0,
 					st->info->num_configs - 1, GFP_KERNEL);
@@ -649,8 +740,49 @@ static int ad7173_load_config(struct ad7173_state *st,
 	if (ret)
 		return ret;
 
+	/*
+	 * When SINC3_MAP flag is enabled, the rest of the register has a
+	 * different meaning. We are using this option to allow the most
+	 * possible sampling frequencies with SINC3 filter.
+	 */
+	if (cfg->filter_type == AD7173_FILTER_SINC3)
+		return ad_sd_write_reg(&st->sd, AD7173_REG_FILTER(free_cfg_slot), 2,
+				       FIELD_PREP(AD7173_FILTER_SINC3_MAP, 1) |
+				       FIELD_PREP(AD7173_FILTER_SINC3_MAP_DIV,
+						  cfg->sinc3_odr_div));
+
+	switch (cfg->filter_type) {
+	case AD7173_FILTER_SINC5_SINC1_PF1:
+		post_filter_enable = 1;
+		post_filter_select = 2;
+		break;
+	case AD7173_FILTER_SINC5_SINC1_PF2:
+		post_filter_enable = 1;
+		post_filter_select = 3;
+		break;
+	case AD7173_FILTER_SINC5_SINC1_PF3:
+		post_filter_enable = 1;
+		post_filter_select = 5;
+		break;
+	case AD7173_FILTER_SINC5_SINC1_PF4:
+		post_filter_enable = 1;
+		post_filter_select = 6;
+		break;
+	default:
+		post_filter_enable = 0;
+		post_filter_select = 0;
+		break;
+	}
+
 	return ad_sd_write_reg(&st->sd, AD7173_REG_FILTER(free_cfg_slot), 2,
-			       AD7173_FILTER_ODR0_MASK & cfg->sinc5_odr_index);
+			       FIELD_PREP(AD7173_FILTER_SINC3_MAP, 0) |
+			       FIELD_PREP(AD7173_FILTER_ENHFILT_MASK,
+					  post_filter_enable) |
+			       FIELD_PREP(AD7173_FILTER_ENHFILTEN,
+					  post_filter_select) |
+			       FIELD_PREP(AD7173_FILTER_ORDER, 0) |
+			       FIELD_PREP(AD7173_FILTER_ODR_MASK,
+					  cfg->sinc5_odr_index));
 }
 
 static int ad7173_config_channel(struct ad7173_state *st, int addr)
@@ -1183,6 +1315,13 @@ static int ad7173_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (st->channels[chan->address].cfg.filter_type == AD7173_FILTER_SINC3) {
+			/* Inverse operation of ad7173_sinc3_odr_div_from_odr() */
+			*val = MEGA;
+			*val2 = 3 * 32 * st->channels[chan->address].cfg.sinc3_odr_div;
+			return IIO_VAL_FRACTIONAL;
+		}
+
 		reg = st->channels[chan->address].cfg.sinc5_odr_index;
 
 		*val = st->info->sinc5_data_rates[reg] / MILLI;
@@ -1221,6 +1360,10 @@ static int ad7173_write_raw(struct iio_dev *indio_dev,
 	 *
 	 * This will cause the reading of CH1 to be actually done once every
 	 * 200.16ms, an effective rate of 4.99sps.
+	 *
+	 * Both the sinc5 and sinc3 rates are set here so that if the filter
+	 * type is changed, the requested rate will still be set (aside from
+	 * rounding differences).
 	 */
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		freq = val * MILLI + val2 / MILLI;
@@ -1230,6 +1373,7 @@ static int ad7173_write_raw(struct iio_dev *indio_dev,
 
 		cfg = &st->channels[chan->address].cfg;
 		cfg->sinc5_odr_index = i;
+		cfg->sinc3_odr_div = ad7173_sinc3_odr_div_from_odr(freq);
 		cfg->live = false;
 		break;
 
@@ -1246,17 +1390,40 @@ static int ad7173_update_scan_mode(struct iio_dev *indio_dev,
 				   const unsigned long *scan_mask)
 {
 	struct ad7173_state *st = iio_priv(indio_dev);
+	u16 sinc3_count = 0;
+	u16 sinc3_div = 0;
 	int i, j, k, ret;
 
 	for (i = 0; i < indio_dev->num_channels; i++) {
-		if (test_bit(i, scan_mask))
+		const struct ad7173_channel_config *cfg = &st->channels[i].cfg;
+
+		if (test_bit(i, scan_mask)) {
+			if (cfg->filter_type == AD7173_FILTER_SINC3) {
+				sinc3_count++;
+
+				if (sinc3_div == 0) {
+					sinc3_div = cfg->sinc3_odr_div;
+				} else if (sinc3_div != cfg->sinc3_odr_div) {
+					dev_err(&st->sd.spi->dev,
+						"All enabled channels must have the same sampling_frequency for sinc3 filter_type\n");
+					return -EINVAL;
+				}
+			}
+
 			ret = ad7173_set_channel(&st->sd, i);
-		else
+		} else {
 			ret = ad_sd_write_reg(&st->sd, AD7173_REG_CH(i), 2, 0);
+		}
 		if (ret < 0)
 			return ret;
 	}
 
+	if (sinc3_count && sinc3_count < bitmap_weight(scan_mask, indio_dev->num_channels)) {
+		dev_err(&st->sd.spi->dev,
+			"All enabled channels must have sinc3 filter_type\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * On some chips, there are more channels that setups, so if there were
 	 * more unique setups requested than the number of available slots,
@@ -1415,6 +1582,7 @@ static const struct iio_chan_spec ad7173_temp_iio_channel_template = {
 		.storagebits = 32,
 		.endianness = IIO_BE,
 	},
+	.ext_info = ad7173_temp_chan_spec_ext_info,
 };
 
 static void ad7173_disable_regulators(void *data)
@@ -1655,7 +1823,11 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		chan_st_priv->cfg.bipolar = false;
 		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
 		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
+		chan_st_priv->cfg.sinc3_odr_div = ad7173_sinc3_odr_div_from_odr(
+			st->info->sinc5_data_rates[st->info->odr_start_value]
+		);
 		chan_st_priv->cfg.sinc5_odr_index = st->info->odr_start_value;
+		chan_st_priv->cfg.filter_type = AD7173_FILTER_SINC5_SINC1;
 		chan_st_priv->cfg.openwire_comp_chan = -1;
 		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
 		if (st->info->data_reg_only_16bit)
@@ -1727,7 +1899,11 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		chan->scan_index = chan_index;
 		chan->channel = ain[0];
 		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
+		chan_st_priv->cfg.sinc3_odr_div = ad7173_sinc3_odr_div_from_odr(
+			st->info->sinc5_data_rates[st->info->odr_start_value]
+		);
 		chan_st_priv->cfg.sinc5_odr_index = st->info->odr_start_value;
+		chan_st_priv->cfg.filter_type = AD7173_FILTER_SINC5_SINC1;
 		chan_st_priv->cfg.openwire_comp_chan = -1;
 
 		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");

-- 
2.43.0


