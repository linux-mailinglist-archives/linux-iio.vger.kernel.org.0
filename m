Return-Path: <linux-iio+bounces-12752-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 893429DAE47
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 21:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C622821BE
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 20:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1435202F88;
	Wed, 27 Nov 2024 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vOwLSy3t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB0420125E
	for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732737777; cv=none; b=DZISkOE7XAF/Yq7Wn6LP4EoZWCeswBBXat9azplLsJFPwTPsPqwtJNSXULaBmM7fZH24HCiNHmf8HRE4KwtlC6ajq+q6UPZ6iHDmOx3DQ7coIDODMVbN2BCqdD/SDuWDP5l848H0GX43qyk1eg79C3KSH2cUxuXSRl0r1TvgrhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732737777; c=relaxed/simple;
	bh=4BVmwrO6f4rSKD973mZxI9Fej/ysGUFCFf4JkT7hFMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kSkybjfEZ0SawRUOfYG9AIoL1euDn6P6Dvd8Tip+kYH18YEGYNz4u9UPZn1h7zM3vn1bA6G6WEy4qE56gFXgOUhO6Jj2bv2vyiWy5LvyOuIJ/WNdbY29JCDfelRECLeXUkNzPzUCNz3VtNM7Uk7IKfPBtvGJxUQVFssvOvBzsA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vOwLSy3t; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-29737adb604so119302fac.1
        for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 12:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732737773; x=1733342573; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbWcnHlTYjWOWnztnkEnNQiK3S2MaaLIm+X0q0D6Zgs=;
        b=vOwLSy3tt+x/2O78l8wnlizGahL+Jra/WPWfkRurJAQgoWmnv+8itY6XYE0o75DPye
         8ecXtbOCQO/SED9CZmewDUWyyYC9U7g6iQ/GQGfWyHMyD2/X19unjIQzZHgZzwhU4qFz
         inmmkP8W4wX67J58V2hEcEyqLKiHRk46caTy1SsSeBbDVCplBDjXIuS7BMXNiqzcyO6/
         DB+pQXccBSXvUKffgfLCZ+jRqD2ufKuen6+8S9n45sahLP/CSUMWC/gSd0MH1QROt1KD
         KjH49aM2C8QpVom1u4CUWUaUWdMnwUURNUBW8/v552tr0RlC3ThFy0q2He9oQEG3yJKp
         EHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732737773; x=1733342573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbWcnHlTYjWOWnztnkEnNQiK3S2MaaLIm+X0q0D6Zgs=;
        b=GUr3pdtSbioYWksMZk0tcmmtyQpIHNZeBRTLxTodLLjQ6lkVDGg1CQdERsC7V9yJPO
         0y5YW7ee0RX3dHTdwBh3zx8Md0Ljiq4bomggXgr5djCoVsLkcDOYE/ao6owm35tbCLzK
         EHGkz49dvzehUnUrAb0FUp/jhZ7l+mQ1J/z53IH1fHK0LHF3gm6JGzU1PjZ03lHO2yfr
         IgWmQd8XleqmmRFg8bdHPBvGG8NoflCnnuiqRYQrbalnh+aqagrkmzrCZ7nUwqrzBTqV
         Y76dGigVCde4/JdSR8BHtX2UGMyoUIwsN3debGezqrD7XhFfPszuon7tJojtApHodXVj
         ZzVA==
X-Forwarded-Encrypted: i=1; AJvYcCXWc8FhAQHTzOA3DZ2Nb9/wsVvRDPXnbWuhXL8jCvk2tmRKgZWMCX7qpRZX3i25Nv5YuggHzXwXQyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmPaJ2CRdhXgz5xuvienxXLGN8aa6rI4BfZ1hqTVQlHTbEnVxs
	4nF12FotHBthB6YQhvjblNFwCa7QEYCAajEjslLNuvs0G5ISNnUkNtRAEePIo0k=
X-Gm-Gg: ASbGncuMXt/9m7dXMxyq9p4EpgzfgkFeIi4YBRxpHGV16JGmB3SSVyXNxFodh30kWyt
	C3K31XJUJg7qB9lllf34bCfHLz0u1CySeZHDK6pkjU2j86KehZlUKmX0iNK+XLHXaRJHTEOokmj
	lOd+u9RePVJIaay4x/7ZkSVbDvAsEoncbkXOSllZNHhmeJ9yu7ohCLl2YN040mEY51KHVPTqeIe
	NTfSLd4nQBe0NrMSuVMGkt7b6z73pdp7/GWhBNOP4zukFNwKWdqxYNgWt28oLom+lr/FHSmv8n9
	SFmxmQ==
X-Google-Smtp-Source: AGHT+IFs2ZJ7yEiw0GlEDpEl5+AMqdHl/F1EcpzSZpGEb8Hj0v56W6tbRqGY1fGfcmhSEz/iXK+Kig==
X-Received: by 2002:a05:6870:f2a3:b0:27b:55af:ca2b with SMTP id 586e51a60fabf-29dc4019615mr4726485fac.11.1732737773557;
        Wed, 27 Nov 2024 12:02:53 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2971d6654e9sm5069542fac.24.2024.11.27.12.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 12:02:52 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 27 Nov 2024 14:01:55 -0600
Subject: [PATCH v2 3/3] iio: adc: ad7173: don't make copy of
 ad_sigma_delta_info struct
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-3-b6d7022b7466@baylibre.com>
References: <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-0-b6d7022b7466@baylibre.com>
In-Reply-To: <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-0-b6d7022b7466@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Michael Walle <michael@walle.cc>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Guillaume Ranquet <granquet@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Use two separate static const struct ad_sigma_delta_info instances
instead of making a copy for each driver instance.

Typically in the IIO subsystem, we use multiple static const instances
of the same struct when there are different variants of the same family
of devices as opposed to making a copy for each driver instance and
modifying it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

Whether this patch is an improvement or not is debatable. It makes
things a bit more verbose, but to me it seems more consistent with
how such cases are handled in the IIO subsystem. So take this one or
leave it.
---
 drivers/iio/adc/ad7173.c | 470 +++++++++++++++++++++++++----------------------
 1 file changed, 248 insertions(+), 222 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 52fce43e4ce1..04533b37d9ec 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -166,6 +166,7 @@ struct ad7173_device_info {
 	unsigned int clock;
 	unsigned int id;
 	char *name;
+	const struct ad_sigma_delta_info *sd_info;
 	bool has_current_inputs;
 	bool has_vincom_input;
 	bool has_temp;
@@ -199,7 +200,6 @@ struct ad7173_channel {
 
 struct ad7173_state {
 	struct ad_sigma_delta sd;
-	struct ad_sigma_delta_chip_info sigma_delta_info;
 	const struct ad7173_device_info *info;
 	struct ad7173_channel *channels;
 	struct regulator_bulk_data regulators[3];
@@ -258,223 +258,6 @@ static unsigned int ad4111_current_channel_config[] = {
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
@@ -753,7 +536,21 @@ static int ad7173_disable_one(struct ad_sigma_delta *sd, unsigned int chan)
 	return ad_sd_write_reg(sd, AD7173_REG_CH(chan), 2, 0);
 }
 
-static const struct ad_sigma_delta_info ad7173_sigma_delta_info = {
+static const struct ad_sigma_delta_info ad7173_sigma_delta_info_4_slots = {
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
+	.num_slots = 4,
+};
+
+static const struct ad_sigma_delta_info ad7173_sigma_delta_info_8_slots = {
 	.set_channel = ad7173_set_channel,
 	.append_status = ad7173_append_status,
 	.disable_all = ad7173_disable_all,
@@ -764,6 +561,237 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info = {
 	.read_mask = BIT(6),
 	.status_ch_mask = GENMASK(3, 0),
 	.data_reg = AD7173_REG_DATA,
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
@@ -1429,9 +1457,7 @@ static int ad7173_probe(struct spi_device *spi)
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


