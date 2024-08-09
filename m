Return-Path: <linux-iio+bounces-8349-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5141194CEB7
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 12:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B611C223B4
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 10:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD911922FC;
	Fri,  9 Aug 2024 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/GF28fz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2938C1922DD;
	Fri,  9 Aug 2024 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723199609; cv=none; b=StFypLWaUY5JvkNBPzQmJn/M9mOcimU0zMdEnY6HGp00YAQl4J5HIxV54v6/jgdhj1d1YbiTI7JVARmmo1lN0aEgqEBk4eI9yApOtvVWtSojjrF+B/PP5TRbgFg9hzax+Z9VVpx0yQuPAx07/sZxtCWkmng0VXhx0BzqF/NusxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723199609; c=relaxed/simple;
	bh=geVEm2YehZbOESu8VR6yjnHQDT1Lw9EqxnbH3cILeYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cqb16CF+D8BheWv6LBKRQrncRAVq80EhqqvfMnIVeluhg5siKrk1e+B1IaYku3AxUVhEHNuHEtxVnikT2D4Qw192evVkASRH43Jtck44ByjKOImHZB295Qb2TlPZ4JWl+qrDCxwxl9T/eTHHXSsm4QdU6NIV09bAPXLKqi+4MIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/GF28fz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFA2BC4AF0E;
	Fri,  9 Aug 2024 10:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723199608;
	bh=geVEm2YehZbOESu8VR6yjnHQDT1Lw9EqxnbH3cILeYs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=u/GF28fzW9/ueizSev1IJ1Hc4DfNsPvoSv3ImqmF/5aOJRUez/F1cT0S+8tluDwVH
	 nBEwnbeI71WlhQiMZXXBddJqPzd2txoI/EkAm2yjj1nEOTDBkzPW7oilM7LEwR4fwt
	 1w417XnIom4fmSbGQ/jjC/VmeFBgL+ecFptzU01eAbNiRXJGiLR46z65135cd3ksJP
	 2iX3+Y1ggD1rq1W6sv8O88M5d1+GIHsJkfGv6r1jQBM2oT8+699TdIUczerCdQJztT
	 rnzdF+/1RpDGLo5YULNruAapP4wlhEAFK4XJ5ZKUNXynApxNl4kwkcDJY5qIpEwYTA
	 7tVpwL6Vu9D8w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B4DC3DA4A;
	Fri,  9 Aug 2024 10:33:28 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Fri, 09 Aug 2024 13:33:25 +0300
Subject: [PATCH v2 2/2] iio: adc: ad7173: add support for ad4113
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240809-ad4113-v2-2-2a70c101a1f4@analog.com>
References: <20240809-ad4113-v2-0-2a70c101a1f4@analog.com>
In-Reply-To: <20240809-ad4113-v2-0-2a70c101a1f4@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: mitrutzceclan@gmail.com, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dumitru Ceclan <dumitru.ceclan@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723199607; l=4113;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=XNirFVk/IgAks7eJNE8bejsqAHhIlbFNHDBB4sRAHMA=;
 b=xP1OxyAi3LACR6xX59ytuCCBbvHT405z2WuQJV4HmLYM6yP6l+OK7bToljCSxKYAtTZepXWbL
 8J9flSGgzExA2V4OP39/oc0ODkVyl6ARlm4b/dqMzCOd6i2fs5qmIfI
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

This commit adds support for the AD4113 ADC.
The AD4113 is a low power, low noise, 16-bit, Σ-Δ analog-to-digital
converter (ADC) that integrates an analog front end (AFE) for four
fully differential or eight single-ended inputs.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index a854f2d30174..3ac09d326472 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -3,7 +3,7 @@
  * AD717x and AD411x family SPI ADC driver
  *
  * Supported devices:
- *  AD4111/AD4112/AD4114/AD4115/AD4116
+ *  AD4111/AD4112/AD4113/AD4114/AD4115/AD4116
  *  AD7172-2/AD7172-4/AD7173-8/AD7175-2
  *  AD7175-8/AD7176-2/AD7177-2
  *
@@ -84,6 +84,7 @@
 #define AD4111_ID			AD7173_ID
 #define AD4112_ID			AD7173_ID
 #define AD4114_ID			AD7173_ID
+#define AD4113_ID			0x31D0
 #define AD4116_ID			0x34d0
 #define AD4115_ID			0x38d0
 #define AD7175_8_ID			0x3cd0
@@ -170,6 +171,7 @@ struct ad7173_device_info {
 	bool has_temp;
 	/* ((AVDD1 − AVSS)/5) */
 	bool has_pow_supply_monitoring;
+	bool data_reg_only_16bit;
 	bool has_input_buf;
 	bool has_int_ref;
 	bool has_ref2;
@@ -294,6 +296,24 @@ static const struct ad7173_device_info ad4112_device_info = {
 	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
 };
 
+static const struct ad7173_device_info ad4113_device_info = {
+	.name = "ad4113",
+	.id = AD4113_ID,
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
 static const struct ad7173_device_info ad4114_device_info = {
 	.name = "ad4114",
 	.id = AD4114_ID,
@@ -988,6 +1008,13 @@ static const struct iio_info ad7173_info = {
 	.update_scan_mode = ad7173_update_scan_mode,
 };
 
+static const struct iio_scan_type ad4113_scan_type = {
+	.sign = 'u',
+	.realbits = 16,
+	.storagebits = 16,
+	.endianness = IIO_BE,
+};
+
 static const struct iio_chan_spec ad7173_channel_template = {
 	.type = IIO_VOLTAGE,
 	.indexed = 1,
@@ -1229,6 +1256,8 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
 		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
 		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
+		if (st->info->data_reg_only_16bit)
+			chan_arr[chan_index].scan_type = ad4113_scan_type;
 
 		chan_index++;
 	}
@@ -1309,6 +1338,9 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 			chan_st_priv->ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
 		}
 
+		if (st->info->data_reg_only_16bit)
+			chan_arr[chan_index].scan_type = ad4113_scan_type;
+
 		chan_index++;
 	}
 	return 0;
@@ -1437,6 +1469,7 @@ static int ad7173_probe(struct spi_device *spi)
 static const struct of_device_id ad7173_of_match[] = {
 	{ .compatible = "adi,ad4111",	.data = &ad4111_device_info },
 	{ .compatible = "adi,ad4112",	.data = &ad4112_device_info },
+	{ .compatible = "adi,ad4113",	.data = &ad4113_device_info },
 	{ .compatible = "adi,ad4114",	.data = &ad4114_device_info },
 	{ .compatible = "adi,ad4115",	.data = &ad4115_device_info },
 	{ .compatible = "adi,ad4116",	.data = &ad4116_device_info },
@@ -1454,6 +1487,7 @@ MODULE_DEVICE_TABLE(of, ad7173_of_match);
 static const struct spi_device_id ad7173_id_table[] = {
 	{ "ad4111",   (kernel_ulong_t)&ad4111_device_info },
 	{ "ad4112",   (kernel_ulong_t)&ad4112_device_info },
+	{ "ad4113",   (kernel_ulong_t)&ad4113_device_info },
 	{ "ad4114",   (kernel_ulong_t)&ad4114_device_info },
 	{ "ad4115",   (kernel_ulong_t)&ad4115_device_info },
 	{ "ad4116",   (kernel_ulong_t)&ad4116_device_info },

-- 
2.43.0



