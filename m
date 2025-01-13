Return-Path: <linux-iio+bounces-14329-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5DCA0C3F3
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 22:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2112F168563
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 21:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BCE1F942D;
	Mon, 13 Jan 2025 21:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U4evbOXj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CB11F8EFB
	for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 21:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736804612; cv=none; b=tZTFV57BGPlY2UBYn4ODd+7MXpU5B0dETwE5YsAaB5fKnRVT9yuKFPMPzrHyPVQe0r3F/6Z8qC2cYIsyyTEwOgfKQm2+Dfj1S9MyWT6d7FahDGQ+wv8w6k22uIcpn5PtUSRnPgY6UHCcc7A8TNOJf4mukTF/1Sb6QwEFThadtSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736804612; c=relaxed/simple;
	bh=RwybvySzMDyDADp+ldKkuxnWZZzr/uh8rhwJvNlUelE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fuhx4xxHqPr7OoVc+U+b6C/0IqzS5It0PygTzFcvN+qT7p/Eb6x0Usg486OnbyFic4JMrZbh/IqjyWvcKN2ir0kG03ahWKzUh0Gu9XQVr58OX7Do1V+MggewcydSAkerLwryOJE+9hisEiaYxk4fKDUBblh1Dmt7kJzpDKCHW60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=U4evbOXj; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3eb880e5ac2so2657231b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 13:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736804609; x=1737409409; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZl72tO//AZAOMrmNAEartHULlMOgP7HOkjgJ8DKKTA=;
        b=U4evbOXjACSFtdPrwnF2zaKtn7xW26RfyURUutSLNHcvg3kdKvgmcVHSxtbFbzHVdT
         tFPG9R1k6HCG4lUVmRu+RHrJT3vHT4s44+q5/Fr0aatQo/DLB9uHDk5t0E8gpL63ZNdF
         h7RahLrRLjrDrO941MX9z/YRtbdnbs1ZLao7rt6e2J/9+T9CUjKmv6T/qlP58JDmogor
         v2cA6k99cUnJFFayLTulhjhgwEpz7W+f6r/XnljbRRkEsAqW4HX/bmiEUevW/HApHzoQ
         cnTmaBiHbE+DPbPRxkCPAoE1J5QPeEGg1v6nYtqJVGdVGDUPEnz+OUfzS8zF1JmijvMO
         PnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736804609; x=1737409409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZl72tO//AZAOMrmNAEartHULlMOgP7HOkjgJ8DKKTA=;
        b=G2dNQ+Nlrbd8yivztJ4G6cjbVPXOLQVe2CQ4vbC2eSWx4iBytLHOZoTyStvogWAJ4G
         HWO2R10xEu/1jPr+yWKxpt7Fze8KfIgNU0f24pssvlsm1Ft//b6n30+HI3uOeSCDh75x
         s6W4aFHkdfPFmDJohYL5JNWFRgu80hSoSIV4RsHmQxaB+B9ompbb6C/2qCm4Iw995jfb
         RXtYkyt+/pvHUHPdDJRBRptlwBaB9f6EJkOx0Wm6R5hm9h6uUlssJpCnsc3SAXOzJ+ZN
         fbvPxEJb0t5U5oENWyOYGd2H1SF44Gfwx00LXePmp7sWY/gr/JNKFYV7LHiZXLwKozLP
         SFuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxAd6nbWQiDRYaa92TsxqPAOaqxVwR7v3cGY4XscKvAfBicK+9A9W1Rin5FOzkd8kj880NzjGlM/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeICNwDZAKWkAWW9TrtHZyDRLlYRva02ek32O11EX/MwdovrY7
	2Lwr+9PrwMQmgkLYXZaJZAYSe/OUYTNwyEKhSm3Rh+L939apllvQfN7lDnqxmqI=
X-Gm-Gg: ASbGncvj01idaoiabrfVvOGoW6kV7m+KyfZmo3Z+nGlQQJLU4lhtGMJRyCPMmnZcdU+
	883GkTne0WM4lvC/V2ZkA+/oK6BzMXKfCWu1uvFaedobLg/SMd1FSXbc/rK7k/1c/zDiOj0UZ9U
	ujHbm1tuft6qn1CYc0tSIkGWw1D6hXCHz7YYq+QWwmAiYsU1TIfQ6JsDZJKCj9em1PkqR9dWE+U
	xkYuXYXCKREJ0gQCjGnf+edVhe9+URpiSF4mdH4X+cwX6+fHDeATI0LqU7yTTgKGF9i6DxMTQ0P
	CSUbLLP1KIoU
X-Google-Smtp-Source: AGHT+IET+OdxnogbFJPMg4v3T/8OBvjFS4R6xtteziA+K9iVRdHpEWl6jTpjLnySob5uSFMF8qC8WA==
X-Received: by 2002:a05:6808:2dca:b0:3ea:5be6:a68a with SMTP id 5614622812f47-3ef2ec2680dmr12983450b6e.15.1736804609103;
        Mon, 13 Jan 2025 13:43:29 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f882624f77sm3606806eaf.7.2025.01.13.13.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 13:43:27 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 13 Jan 2025 15:43:19 -0600
Subject: [PATCH v4 2/2] iio: adc: ad7173: don't make copy of
 ad_sigma_delta_info struct
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250113-iio-adc-ad7313-fix-non-const-info-struct-v4-2-b63be3ecac4a@baylibre.com>
References: <20250113-iio-adc-ad7313-fix-non-const-info-struct-v4-0-b63be3ecac4a@baylibre.com>
In-Reply-To: <20250113-iio-adc-ad7313-fix-non-const-info-struct-v4-0-b63be3ecac4a@baylibre.com>
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

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes:
* Adapted for reworked patch adding has_named_irqs field.
* Dropped Tested-by due to significant changes in the previous patch.

v3 changes:
* Rebased on iio/testing and fixed merge conflicts.
---
 drivers/iio/adc/ad7173.c | 482 +++++++++++++++++++++++++----------------------
 1 file changed, 255 insertions(+), 227 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index bb9cddd8c9d33f81df95e5001d62a8ceb684d348..8b438c689594d11091fee9e67a7fab4eb5af8afd 100644
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
@@ -864,7 +642,23 @@ static int ad7173_disable_one(struct ad_sigma_delta *sd, unsigned int chan)
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
+	.has_named_irqs = true,
+	.addr_shift = 0,
+	.read_mask = BIT(6),
+	.status_ch_mask = GENMASK(3, 0),
+	.data_reg = AD7173_REG_DATA,
+	.num_resetclks = 64,
+	.num_slots = 4,
+};
+
+static const struct ad_sigma_delta_info ad7173_sigma_delta_info_8_slots = {
 	.set_channel = ad7173_set_channel,
 	.append_status = ad7173_append_status,
 	.disable_all = ad7173_disable_all,
@@ -877,6 +671,242 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info = {
 	.status_ch_mask = GENMASK(3, 0),
 	.data_reg = AD7173_REG_DATA,
 	.num_resetclks = 64,
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
@@ -1547,9 +1577,7 @@ static int ad7173_probe(struct spi_device *spi)
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


