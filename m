Return-Path: <linux-iio+bounces-14109-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A253FA098C2
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 18:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51CF3188B0FF
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 17:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CCA214238;
	Fri, 10 Jan 2025 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZvkIdHlX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C6D213E7D
	for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736530818; cv=none; b=kRDRzhW5mKcA9YyvdkRUa2kZBkuDCVc0gmuG2E7TKCuoPl+OLjI+PVKmvF3jm3JAt8D/blVOhudx6Vxfmpg2IOpRHAMdlmoR1AhXcvF6PJKF7Qkhi+1+OjwqsaYLFXYIbu0dF8usSpQjiwkP4WSFtwjapbDAkUP+U0iUQW1kx+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736530818; c=relaxed/simple;
	bh=ezpa4lmc7COFUrj/dpxuduxQWeAY856e//w1Ffinljk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cXTapc+9iovSnMRqQPxbdbdjuQ0WrOKw2DEl5YP9mLlBTKxy0rQoqV7WU6iDO/dSFcFrQpmbA5tiKFQXyRDfvzNZPXePKesTSgnRWspPRa4fR/9vddbASbSMwHSqZYegTeKgWrZzAqRqj+Rjye0VW53TQ2CvNpNNWiIwQxl88/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZvkIdHlX; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3eba583fbe8so631928b6e.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 09:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736530815; x=1737135615; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2WarB2DVEPhDUQ8fzbEG+74huWRFT9tjmACbL3KjyZ8=;
        b=ZvkIdHlXlh6MeCPXvATYWey9RLTDqbvrrLNDLoSe4rBdzs6l9YvRaSIP3kr9EIlc7W
         MkxvRBLp7LHSbUKBED/qUCvnUXZlA3e9zTjvKHN3ZLIVoKeH/35HNyJBM9ajz3YkvTqU
         lFXSUwwxxfjtgmZMJ4crdBKE/qBmH3qOj5dke0clCrD6DbbYfYp3+QY8m1jnuWocZ5HZ
         VKuoc2ft6LlJ+1Ou1LadPrUtqxau8xW3or5fCrRhp0E0CLhz46diOSxPvSm62Ozz/QZK
         9TuYTYhSlp23GoP2yF5QAT2YS3ObjPKH1+mY9032Lv7v6ADMy0FopBtJlFCk+tCygb6E
         BKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736530815; x=1737135615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WarB2DVEPhDUQ8fzbEG+74huWRFT9tjmACbL3KjyZ8=;
        b=Bkt3YtkbPQrCHD/ea0nyUcKUfQGK1Ja4sv1wzb3GIGA0n3qej6TI6FeI6CVeHXO77u
         ODTX9BQDzmQXmU14XKpNDMiRC2F8Jp6KHu7rWLYFQJj9X4K1PaaSmkz4SADnw+RN2j8N
         zcVZbdZyF7f6f+ZDXrnxjXmhPAsWcB5NgEdxMSKEEuXMtyxsOHnx/oUI/n2Ow0JXy7Jq
         I8GeFyrvR9yvs+FUr72KD0OJAWxZWBSBTC3K0/VEX0lyJN4TgnT9yEp6K8zv/VWqs9Ob
         NZPGiliO9FyI1kAy2D7I390ud/LUNlksrIF4ypCFK3C45jQXzlaGLXR80va8rqovApMV
         pN9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFj2benVu10REJXO4YvJ/jFDjxzGqgUq+ipS5z7Mpp/SxG/gKKy6sh3YlwpxBUJUXMAHnLdhCkTJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxESIDYhB+lT3ZQMhUaPIjoUBzSN803bFu1W+fpfYmPSobHaFpo
	9IyESgOhKMuNbQqmhc3271DzHXsGm412wNufvbroaDscm6L4Zt2nR7LG7YwWJDk=
X-Gm-Gg: ASbGncs3xnofecl/gZZzxBHjFboadqvI50hWONAU2yQ03IeSHmsHVAIaH9TDYPSV5iy
	PXp4jRX1Uwzj4lvKAlAp1w2HpsXCe3HLn2zrB1Zuje7b+8JSo5HhZrtC+fIRya8/NfX48rUq8zE
	9AGlflA0nev4h9aQ/md+3CBPYxjxa6J28fAybDcAB2jVqQQHnCol9GbLnt02zfbRtZnEfjH2DuT
	KCPEGc8qjUlAOEvJuF44Im2qbLgvj5B125je4PTTm483X2deBjz1JHesQy6bFFnBBrZm+EiHbve
	H8ZPLsAy8qS9
X-Google-Smtp-Source: AGHT+IHNheLZVynLM9Cglmh44SOGgj81MgONZG8jhYGj+SVYP5VuvxJxVMBQ8W3gcqGhYEbcBFU45Q==
X-Received: by 2002:a05:6808:1a0e:b0:3e3:bd1c:d584 with SMTP id 5614622812f47-3ef2ec6ddfbmr8373405b6e.9.1736530815097;
        Fri, 10 Jan 2025 09:40:15 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f03769a8f8sm842165b6e.26.2025.01.10.09.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 09:40:14 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jan 2025 11:40:07 -0600
Subject: [PATCH v3 2/2] iio: adc: ad7173: don't make copy of
 ad_sigma_delta_info struct
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250110-iio-adc-ad7313-fix-non-const-info-struct-v3-2-41e1c9cdd1a7@baylibre.com>
References: <20250110-iio-adc-ad7313-fix-non-const-info-struct-v3-0-41e1c9cdd1a7@baylibre.com>
In-Reply-To: <20250110-iio-adc-ad7313-fix-non-const-info-struct-v3-0-41e1c9cdd1a7@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Michael Walle <michael@walle.cc>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Guillaume Ranquet <granquet@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Use two separate static const struct ad_sigma_delta_info instances
instead of making a copy for each driver instance.

Typically in the IIO subsystem, we use multiple static const instances
of the same struct when there are different variants of the same family
of devices as opposed to making a copy for each driver instance and
modifying it.

Tested-by: Guillaume Ranquet <granquet@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v3 changes:
* Rebased on iio/testing and fixed merge conflicts.
---
 drivers/iio/adc/ad7173.c | 481 +++++++++++++++++++++++++----------------------
 1 file changed, 254 insertions(+), 227 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index b92aca39d117a315d6b55951fba7c3b51787555a..4487841f994ff08f4da79d919fd61b0169922e51 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -171,6 +171,7 @@ struct ad7173_device_info {
 	unsigned int clock;
 	unsigned int id;
 	char *name;
+	const struct ad_sigma_delta_info *sd_info;
 	bool has_current_inputs;
 	bool has_vincom_input;
 	bool has_temp;
@@ -206,7 +207,6 @@ struct ad7173_channel {
 
 struct ad7173_state {
 	struct ad_sigma_delta sd;
-	struct ad_sigma_delta_info sigma_delta_info;
 	const struct ad7173_device_info *info;
 	struct ad7173_channel *channels;
 	struct regulator_bulk_data regulators[3];
@@ -265,228 +265,6 @@ static unsigned int ad4111_current_channel_config[] = {
 	0x18B, /* 12:IIN3+   11:IIN3− */
 };
 
-static const struct ad7173_device_info ad4111_device_info = {
-	.name = "ad4111",
-	.id = AD4111_ID,
-	.num_voltage_in_div = 8,
-	.num_channels = 16,
-	.num_configs = 8,
-	.num_voltage_in = 8,
-	.num_gpios = 2,
-	.higher_gpio_bits = true,
-	.has_temp = true,
-	.has_vincom_input = true,
-	.has_input_buf = true,
-	.has_current_inputs = true,
-	.has_int_ref = true,
-	.has_internal_fs_calibration = true,
-	.clock = 2 * HZ_PER_MHZ,
-	.sinc5_data_rates = ad7173_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
-};
-
-static const struct ad7173_device_info ad4112_device_info = {
-	.name = "ad4112",
-	.id = AD4112_ID,
-	.num_voltage_in_div = 8,
-	.num_channels = 16,
-	.num_configs = 8,
-	.num_voltage_in = 8,
-	.num_gpios = 2,
-	.higher_gpio_bits = true,
-	.has_vincom_input = true,
-	.has_temp = true,
-	.has_input_buf = true,
-	.has_current_inputs = true,
-	.has_int_ref = true,
-	.has_internal_fs_calibration = true,
-	.clock = 2 * HZ_PER_MHZ,
-	.sinc5_data_rates = ad7173_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
-};
-
-static const struct ad7173_device_info ad4113_device_info = {
-	.name = "ad4113",
-	.id = AD4113_ID,
-	.num_voltage_in_div = 8,
-	.num_channels = 16,
-	.num_configs = 8,
-	.num_voltage_in = 8,
-	.num_gpios = 2,
-	.data_reg_only_16bit = true,
-	.higher_gpio_bits = true,
-	.has_vincom_input = true,
-	.has_input_buf = true,
-	.has_int_ref = true,
-	.clock = 2 * HZ_PER_MHZ,
-	.sinc5_data_rates = ad7173_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
-};
-
-static const struct ad7173_device_info ad4114_device_info = {
-	.name = "ad4114",
-	.id = AD4114_ID,
-	.num_voltage_in_div = 16,
-	.num_channels = 16,
-	.num_configs = 8,
-	.num_voltage_in = 16,
-	.num_gpios = 4,
-	.has_vincom_input = true,
-	.has_temp = true,
-	.has_input_buf = true,
-	.has_int_ref = true,
-	.has_internal_fs_calibration = true,
-	.clock = 2 * HZ_PER_MHZ,
-	.sinc5_data_rates = ad7173_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
-};
-
-static const struct ad7173_device_info ad4115_device_info = {
-	.name = "ad4115",
-	.id = AD4115_ID,
-	.num_voltage_in_div = 16,
-	.num_channels = 16,
-	.num_configs = 8,
-	.num_voltage_in = 16,
-	.num_gpios = 4,
-	.has_vincom_input = true,
-	.has_temp = true,
-	.has_input_buf = true,
-	.has_int_ref = true,
-	.has_internal_fs_calibration = true,
-	.clock = 8 * HZ_PER_MHZ,
-	.sinc5_data_rates = ad4115_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad4115_sinc5_data_rates),
-};
-
-static const struct ad7173_device_info ad4116_device_info = {
-	.name = "ad4116",
-	.id = AD4116_ID,
-	.num_voltage_in_div = 11,
-	.num_channels = 16,
-	.num_configs = 8,
-	.num_voltage_in = 16,
-	.num_gpios = 4,
-	.has_vincom_input = true,
-	.has_temp = true,
-	.has_input_buf = true,
-	.has_int_ref = true,
-	.has_internal_fs_calibration = true,
-	.clock = 4 * HZ_PER_MHZ,
-	.sinc5_data_rates = ad4116_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad4116_sinc5_data_rates),
-};
-
-static const struct ad7173_device_info ad7172_2_device_info = {
-	.name = "ad7172-2",
-	.id = AD7172_2_ID,
-	.num_voltage_in = 5,
-	.num_channels = 4,
-	.num_configs = 4,
-	.num_gpios = 2,
-	.has_temp = true,
-	.has_input_buf = true,
-	.has_int_ref = true,
-	.has_pow_supply_monitoring = true,
-	.clock = 2 * HZ_PER_MHZ,
-	.sinc5_data_rates = ad7173_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
-};
-
-static const struct ad7173_device_info ad7172_4_device_info = {
-	.name = "ad7172-4",
-	.id = AD7172_4_ID,
-	.num_voltage_in = 9,
-	.num_channels = 8,
-	.num_configs = 8,
-	.num_gpios = 4,
-	.has_input_buf = true,
-	.has_ref2 = true,
-	.has_pow_supply_monitoring = true,
-	.clock = 2 * HZ_PER_MHZ,
-	.sinc5_data_rates = ad7173_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
-};
-
-static const struct ad7173_device_info ad7173_8_device_info = {
-	.name = "ad7173-8",
-	.id = AD7173_ID,
-	.num_voltage_in = 17,
-	.num_channels = 16,
-	.num_configs = 8,
-	.num_gpios = 4,
-	.has_temp = true,
-	.has_input_buf = true,
-	.has_int_ref = true,
-	.has_ref2 = true,
-	.clock = 2 * HZ_PER_MHZ,
-	.sinc5_data_rates = ad7173_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
-};
-
-static const struct ad7173_device_info ad7175_2_device_info = {
-	.name = "ad7175-2",
-	.id = AD7175_2_ID,
-	.num_voltage_in = 5,
-	.num_channels = 4,
-	.num_configs = 4,
-	.num_gpios = 2,
-	.has_temp = true,
-	.has_input_buf = true,
-	.has_int_ref = true,
-	.has_pow_supply_monitoring = true,
-	.clock = 16 * HZ_PER_MHZ,
-	.sinc5_data_rates = ad7175_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
-};
-
-static const struct ad7173_device_info ad7175_8_device_info = {
-	.name = "ad7175-8",
-	.id = AD7175_8_ID,
-	.num_voltage_in = 17,
-	.num_channels = 16,
-	.num_configs = 8,
-	.num_gpios = 4,
-	.has_temp = true,
-	.has_input_buf = true,
-	.has_int_ref = true,
-	.has_ref2 = true,
-	.has_pow_supply_monitoring = true,
-	.clock = 16 * HZ_PER_MHZ,
-	.sinc5_data_rates = ad7175_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
-};
-
-static const struct ad7173_device_info ad7176_2_device_info = {
-	.name = "ad7176-2",
-	.id = AD7176_ID,
-	.num_voltage_in = 5,
-	.num_channels = 4,
-	.num_configs = 4,
-	.num_gpios = 2,
-	.has_int_ref = true,
-	.clock = 16 * HZ_PER_MHZ,
-	.sinc5_data_rates = ad7175_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
-};
-
-static const struct ad7173_device_info ad7177_2_device_info = {
-	.name = "ad7177-2",
-	.id = AD7177_ID,
-	.num_voltage_in = 5,
-	.num_channels = 4,
-	.num_configs = 4,
-	.num_gpios = 2,
-	.has_temp = true,
-	.has_input_buf = true,
-	.has_int_ref = true,
-	.has_pow_supply_monitoring = true,
-	.clock = 16 * HZ_PER_MHZ,
-	.odr_start_value = AD7177_ODR_START_VALUE,
-	.sinc5_data_rates = ad7175_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
-};
-
 static const char *const ad7173_ref_sel_str[] = {
 	[AD7173_SETUP_REF_SEL_EXT_REF]    = "vref",
 	[AD7173_SETUP_REF_SEL_EXT_REF2]   = "vref2",
@@ -864,7 +642,7 @@ static int ad7173_disable_one(struct ad_sigma_delta *sd, unsigned int chan)
 	return ad_sd_write_reg(sd, AD7173_REG_CH(chan), 2, 0);
 }
 
-static const struct ad_sigma_delta_info ad7173_sigma_delta_info = {
+static const struct ad_sigma_delta_info ad7173_sigma_delta_info_4_slots = {
 	.set_channel = ad7173_set_channel,
 	.append_status = ad7173_append_status,
 	.disable_all = ad7173_disable_all,
@@ -876,6 +654,257 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info = {
 	.status_ch_mask = GENMASK(3, 0),
 	.data_reg = AD7173_REG_DATA,
 	.num_resetclks = 64,
+	.num_slots = 4,
+};
+
+static const struct ad_sigma_delta_info ad7173_sigma_delta_info_8_slots = {
+	.set_channel = ad7173_set_channel,
+	.append_status = ad7173_append_status,
+	.disable_all = ad7173_disable_all,
+	.disable_one = ad7173_disable_one,
+	.set_mode = ad7173_set_mode,
+	.has_registers = true,
+	.addr_shift = 0,
+	.read_mask = BIT(6),
+	.status_ch_mask = GENMASK(3, 0),
+	.data_reg = AD7173_REG_DATA,
+	.num_resetclks = 64,
+	.num_slots = 8,
+};
+
+static const struct ad7173_device_info ad4111_device_info = {
+	.name = "ad4111",
+	.id = AD4111_ID,
+	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.num_voltage_in_div = 8,
+	.num_channels = 16,
+	.num_configs = 8,
+	.num_voltage_in = 8,
+	.num_gpios = 2,
+	.higher_gpio_bits = true,
+	.has_temp = true,
+	.has_vincom_input = true,
+	.has_input_buf = true,
+	.has_current_inputs = true,
+	.has_int_ref = true,
+	.has_internal_fs_calibration = true,
+	.clock = 2 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7173_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad4112_device_info = {
+	.name = "ad4112",
+	.id = AD4112_ID,
+	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.num_voltage_in_div = 8,
+	.num_channels = 16,
+	.num_configs = 8,
+	.num_voltage_in = 8,
+	.num_gpios = 2,
+	.higher_gpio_bits = true,
+	.has_vincom_input = true,
+	.has_temp = true,
+	.has_input_buf = true,
+	.has_current_inputs = true,
+	.has_int_ref = true,
+	.has_internal_fs_calibration = true,
+	.clock = 2 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7173_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad4113_device_info = {
+	.name = "ad4113",
+	.id = AD4113_ID,
+	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.num_voltage_in_div = 8,
+	.num_channels = 16,
+	.num_configs = 8,
+	.num_voltage_in = 8,
+	.num_gpios = 2,
+	.data_reg_only_16bit = true,
+	.higher_gpio_bits = true,
+	.has_vincom_input = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.clock = 2 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7173_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad4114_device_info = {
+	.name = "ad4114",
+	.id = AD4114_ID,
+	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.num_voltage_in_div = 16,
+	.num_channels = 16,
+	.num_configs = 8,
+	.num_voltage_in = 16,
+	.num_gpios = 4,
+	.has_vincom_input = true,
+	.has_temp = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.has_internal_fs_calibration = true,
+	.clock = 2 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7173_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad4115_device_info = {
+	.name = "ad4115",
+	.id = AD4115_ID,
+	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.num_voltage_in_div = 16,
+	.num_channels = 16,
+	.num_configs = 8,
+	.num_voltage_in = 16,
+	.num_gpios = 4,
+	.has_vincom_input = true,
+	.has_temp = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.has_internal_fs_calibration = true,
+	.clock = 8 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad4115_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad4115_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad4116_device_info = {
+	.name = "ad4116",
+	.id = AD4116_ID,
+	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.num_voltage_in_div = 11,
+	.num_channels = 16,
+	.num_configs = 8,
+	.num_voltage_in = 16,
+	.num_gpios = 4,
+	.has_vincom_input = true,
+	.has_temp = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.has_internal_fs_calibration = true,
+	.clock = 4 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad4116_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad4116_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad7172_2_device_info = {
+	.name = "ad7172-2",
+	.id = AD7172_2_ID,
+	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.num_voltage_in = 5,
+	.num_channels = 4,
+	.num_configs = 4,
+	.num_gpios = 2,
+	.has_temp = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.has_pow_supply_monitoring = true,
+	.clock = 2 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7173_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad7172_4_device_info = {
+	.name = "ad7172-4",
+	.id = AD7172_4_ID,
+	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.num_voltage_in = 9,
+	.num_channels = 8,
+	.num_configs = 8,
+	.num_gpios = 4,
+	.has_input_buf = true,
+	.has_ref2 = true,
+	.has_pow_supply_monitoring = true,
+	.clock = 2 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7173_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad7173_8_device_info = {
+	.name = "ad7173-8",
+	.id = AD7173_ID,
+	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.num_voltage_in = 17,
+	.num_channels = 16,
+	.num_configs = 8,
+	.num_gpios = 4,
+	.has_temp = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.has_ref2 = true,
+	.clock = 2 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7173_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad7175_2_device_info = {
+	.name = "ad7175-2",
+	.id = AD7175_2_ID,
+	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.num_voltage_in = 5,
+	.num_channels = 4,
+	.num_configs = 4,
+	.num_gpios = 2,
+	.has_temp = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.has_pow_supply_monitoring = true,
+	.clock = 16 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7175_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad7175_8_device_info = {
+	.name = "ad7175-8",
+	.id = AD7175_8_ID,
+	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.num_voltage_in = 17,
+	.num_channels = 16,
+	.num_configs = 8,
+	.num_gpios = 4,
+	.has_temp = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.has_ref2 = true,
+	.has_pow_supply_monitoring = true,
+	.clock = 16 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7175_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad7176_2_device_info = {
+	.name = "ad7176-2",
+	.id = AD7176_ID,
+	.sd_info = &ad7173_sigma_delta_info_4_slots,
+	.num_voltage_in = 5,
+	.num_channels = 4,
+	.num_configs = 4,
+	.num_gpios = 2,
+	.has_int_ref = true,
+	.clock = 16 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7175_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad7177_2_device_info = {
+	.name = "ad7177-2",
+	.id = AD7177_ID,
+	.sd_info = &ad7173_sigma_delta_info_4_slots,
+	.num_voltage_in = 5,
+	.num_channels = 4,
+	.num_configs = 4,
+	.num_gpios = 2,
+	.has_temp = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.has_pow_supply_monitoring = true,
+	.clock = 16 * HZ_PER_MHZ,
+	.odr_start_value = AD7177_ODR_START_VALUE,
+	.sinc5_data_rates = ad7175_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
 };
 
 static int ad7173_setup(struct iio_dev *indio_dev)
@@ -1546,9 +1575,7 @@ static int ad7173_probe(struct spi_device *spi)
 	spi->mode = SPI_MODE_3;
 	spi_setup(spi);
 
-	st->sigma_delta_info = ad7173_sigma_delta_info;
-	st->sigma_delta_info.num_slots = st->info->num_configs;
-	ret = ad_sd_init(&st->sd, indio_dev, spi, &st->sigma_delta_info);
+	ret = ad_sd_init(&st->sd, indio_dev, spi, st->info->sd_info);
 	if (ret)
 		return ret;
 

-- 
2.43.0


