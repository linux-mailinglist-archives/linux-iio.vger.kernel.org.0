Return-Path: <linux-iio+bounces-5034-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D25B8C4CD7
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 09:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342792825DB
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 07:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945FE2E65B;
	Tue, 14 May 2024 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQSe22sp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2719715E81;
	Tue, 14 May 2024 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671399; cv=none; b=jc/+WK/QOOLPaluVFhrd4oYtmYnIrgQ9RQ0JPq2tONHcsvyVkw30fTFyolFAdHvfFOohi4xzndP29w63GZYRhFE0iItdNg9upXQb+2F0df0jUilPj/V9k5csk0uHazCX8Rt11CV4/hAuGPocpWN9OZjcv4f3AZLtltYkdM6CsMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671399; c=relaxed/simple;
	bh=paYawFWnTJFb6ePxm+BbCSjAzmbIV+TuG48eBjngQYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JW+bdI26CPpT3emRNCXHsoJLLIrmFLTxvEGr9Y2T0eUqxyUtdJby6S5P+1Tv+fdqs/Xgw6otGyUohGZrKZu82NBnTgJXzVj0i9Z5RY2hUpWmkQH0fyh9Wp4y46vefvmfCpKe5cHjkMGKS7k7iZzcQwKwaOH8JE+hCLcFbyYQtr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQSe22sp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BCB6C4DDE0;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715671398;
	bh=paYawFWnTJFb6ePxm+BbCSjAzmbIV+TuG48eBjngQYY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vQSe22spFNASu5loRy/QOK1+Z7SKv559vKaaCtvEMmOPVRi0geh7GWHES1k8uqR9w
	 vegRF56enpCXlL6q2+jHfthqaLOC3QBF8l7A8yGDJ0wUAz4GhDEknTqm12zXxB+w9w
	 e6QfnGymTK8NvcRXiF8CO1ia9ZfKrRNWNXtZVjcPwCNMESs1r3YGv7Upm9wSZnuZlf
	 nNWseXr64nZ+zPBhC5GpUrT2x2mtrYNw+bzmZgh+Xj47+wLhUUZ5KEYiTJsgw/8iBZ
	 NC06X0QpEHw5Ouos19PbMsW8cBDJX8SI1BBM+LGpwLc0KrxLPAsx+WL/2tDxoTTvC8
	 8O9Zf7+SH+iJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C764C25B7E;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Tue, 14 May 2024 10:22:53 +0300
Subject: [PATCH v2 8/9] iio: adc: ad7173: Add support for AD411x devices
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240514-ad4111-v2-8-29be6a55efb5@analog.com>
References: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
In-Reply-To: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715671396; l=19105;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=Q95BBBYQyG9OitwPAn83HdRNI5BigJXhNErbP2of0gQ=;
 b=AY5z89iRI3CotsVmOuIHDA5kVXyrfYBlCn3RPC8aaSwwkJGgepxdgeo6A6NRkdnrrPKfJu4fc
 hFv2IDDH1s9AjnqqaOTiSCAVyiHy6pBjTXN7n84BGtZZz1qbkxS6NzY
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

Add support for AD4111/AD4112/AD4114/AD4115/AD4116.

The AD411X family encompasses a series of low power, low noise, 24-bit,
sigma-delta analog-to-digital converters that offer a versatile range of
specifications.

This family of ADCs integrates an analog front end suitable for processing
both fully differential and single-ended, bipolar voltage inputs
addressing a wide array of industrial and instrumentation requirements.

- All ADCs have inputs with a precision voltage divider with a division
  ratio of 10.
- AD4116 has 5 low level inputs without a voltage divider.
- AD4111 and AD4112 support current inputs (0 mA to 20 mA) using a 50ohm
  shunt resistor.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 316 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 288 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index d66b47e1a186..f049d79380ac 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * AD717x family SPI ADC driver
+ * AD717x and AD411x family SPI ADC driver
  *
  * Supported devices:
+ *  AD4111/AD4112/AD4114/AD4115/AD4116
  *  AD7172-2/AD7172-4/AD7173-8/AD7175-2
  *  AD7175-8/AD7176-2/AD7177-2
  *
@@ -75,7 +76,9 @@
 #define AD7176_ID			0x0c90
 #define AD7175_2_ID			0x0cd0
 #define AD7172_4_ID			0x2050
-#define AD7173_ID			0x30d0
+#define AD7173_AD4111_AD4112_AD4114_ID	0x30d0
+#define AD4116_ID			0x34d0
+#define AD4115_ID			0x38d0
 #define AD7175_8_ID			0x3cd0
 #define AD7177_ID			0x4fd0
 #define AD7173_ID_MASK			GENMASK(15, 4)
@@ -106,6 +109,7 @@
 
 #define AD7173_GPO12_DATA(x)	BIT((x) + 0)
 #define AD7173_GPO23_DATA(x)	BIT((x) + 4)
+#define AD4111_GPO01_DATA(x)	BIT((x) + 6)
 #define AD7173_GPO_DATA(x)	((x) < 2 ? AD7173_GPO12_DATA(x) : AD7173_GPO23_DATA(x))
 
 #define AD7173_INTERFACE_DATA_STAT	BIT(6)
@@ -124,11 +128,20 @@
 #define AD7173_VOLTAGE_INT_REF_uV	2500000
 #define AD7173_TEMP_SENSIIVITY_uV_per_C	477
 #define AD7177_ODR_START_VALUE		0x07
+#define AD4111_SHUNT_RESISTOR_OHM	50
+#define AD4111_DIVIDER_RATIO		10
+#define AD411X_VCOM_INPUT		0X10
+#define AD4111_CURRENT_CHAN_CUTOFF	16
 
 #define AD7173_FILTER_ODR0_MASK		GENMASK(5, 0)
 #define AD7173_MAX_CONFIGS		8
 
 enum ad7173_ids {
+	ID_AD4111,
+	ID_AD4112,
+	ID_AD4114,
+	ID_AD4115,
+	ID_AD4116,
 	ID_AD7172_2,
 	ID_AD7172_4,
 	ID_AD7173_8,
@@ -138,22 +151,44 @@ enum ad7173_ids {
 	ID_AD7177_2,
 };
 
+enum ad4111_current_channels {
+	AD4111_CURRENT_IN0P_IN0N,
+	AD4111_CURRENT_IN1P_IN1N,
+	AD4111_CURRENT_IN2P_IN2N,
+	AD4111_CURRENT_IN3P_IN3N,
+};
+
+enum ad7173_channel_types {
+	AD7173_CHAN_SINGLE_ENDED,
+	AD7173_CHAN_PSEUDO_DIFFERENTIAL,
+	AD7173_CHAN_DIFFERENTIAL,
+};
+
 struct ad7173_device_info {
 	const unsigned int *sinc5_data_rates;
 	unsigned int num_sinc5_data_rates;
 	unsigned int odr_start_value;
+	/*
+	 * AD4116 has both inputs with a volage divider and without.
+	 * These inputs cannot be mixed in the channel configuration.
+	 * Does not include the VCOM input.
+	 */
+	unsigned int num_voltage_inputs_with_divider;
 	unsigned int num_channels;
 	unsigned int num_configs;
-	unsigned int num_inputs;
+	unsigned int num_voltage_inputs;
 	unsigned int clock;
 	unsigned int id;
 	char *name;
+	bool has_current_inputs;
+	bool has_vcom_input;
 	bool has_temp;
 	/* ((AVDD1 − AVSS)/5) */
 	bool has_common_input;
 	bool has_input_buf;
 	bool has_int_ref;
 	bool has_ref2;
+	bool higher_gpio_bits;
 	u8 num_gpios;
 };
 
@@ -195,6 +230,24 @@ struct ad7173_state {
 #endif
 };
 
+static unsigned int ad4115_sinc5_data_rates[] = {
+	24845000, 24845000, 20725000, 20725000,	/*  0-3  */
+	15564000, 13841000, 10390000, 10390000,	/*  4-7  */
+	4994000,  2499000,  1000000,  500000,	/*  8-11 */
+	395500,   200000,   100000,   59890,	/* 12-15 */
+	49920,    20000,    16660,    10000,	/* 16-19 */
+	5000,	  2500,     2500,		/* 20-22 */
+};
+
+static unsigned int ad4116_sinc5_data_rates[] = {
+	12422360, 12422360, 12422360, 12422360,	/*  0-3  */
+	10362690, 10362690, 7782100,  6290530,	/*  4-7  */
+	5194800,  2496900,  1007600,  499900,	/*  8-11 */
+	390600,	  200300,   100000,   59750,	/* 12-15 */
+	49840,	  20000,    16650,    10000,	/* 16-19 */
+	5000,	  2500,	    1250,		/* 20-22 */
+};
+
 static const unsigned int ad7173_sinc5_data_rates[] = {
 	6211000, 6211000, 6211000, 6211000, 6211000, 6211000, 5181000, 4444000,	/*  0-7  */
 	3115000, 2597000, 1007000, 503800,  381000,  200300,  100500,  59520,	/*  8-15 */
@@ -210,14 +263,109 @@ static const unsigned int ad7175_sinc5_data_rates[] = {
 	5000,					/* 20    */
 };
 
+static unsigned int ad4111_current_channel_config[] = {
+	[AD4111_CURRENT_IN0P_IN0N] = 0x1E8,
+	[AD4111_CURRENT_IN1P_IN1N] = 0x1C9,
+	[AD4111_CURRENT_IN2P_IN2N] = 0x1AA,
+	[AD4111_CURRENT_IN3P_IN3N] = 0x18B,
+};
+
 static const struct ad7173_device_info ad7173_device_info[] = {
+	[ID_AD4111] = {
+		.name = "ad4111",
+		.id = AD7173_AD4111_AD4112_AD4114_ID,
+		.num_voltage_inputs_with_divider = 8,
+		.num_channels = 16,
+		.num_configs = 8,
+		.num_voltage_inputs = 8,
+		.num_gpios = 2,
+		.higher_gpio_bits = true,
+		.has_temp = true,
+		.has_vcom_input = true,
+		.has_input_buf = true,
+		.has_current_inputs = true,
+		.has_int_ref = true,
+		.clock = 2 * HZ_PER_MHZ,
+		.sinc5_data_rates = ad7173_sinc5_data_rates,
+		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+	},
+	[ID_AD4112] = {
+		.name = "ad4112",
+		.id = AD7173_AD4111_AD4112_AD4114_ID,
+		.num_voltage_inputs_with_divider = 8,
+		.num_channels = 16,
+		.num_configs = 8,
+		.num_voltage_inputs = 8,
+		.num_gpios = 2,
+		.higher_gpio_bits = true,
+		.has_vcom_input = true,
+		.has_temp = true,
+		.has_input_buf = true,
+		.has_current_inputs = true,
+		.has_int_ref = true,
+		.clock = 2 * HZ_PER_MHZ,
+		.sinc5_data_rates = ad7173_sinc5_data_rates,
+		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+	},
+	[ID_AD4114] = {
+		.name = "ad4114",
+		.id = AD7173_AD4111_AD4112_AD4114_ID,
+		.num_voltage_inputs_with_divider = 16,
+		.num_channels = 16,
+		.num_configs = 8,
+		.num_voltage_inputs = 16,
+		.num_gpios = 4,
+		.higher_gpio_bits = true,
+		.has_vcom_input = true,
+		.has_temp = true,
+		.has_input_buf = true,
+		.has_int_ref = true,
+		.clock = 2 * HZ_PER_MHZ,
+		.sinc5_data_rates = ad7173_sinc5_data_rates,
+		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+	},
+	[ID_AD4115] = {
+		.name = "ad4115",
+		.id = AD4115_ID,
+		.num_voltage_inputs_with_divider = 16,
+		.num_channels = 16,
+		.num_configs = 8,
+		.num_voltage_inputs = 16,
+		.num_gpios = 4,
+		.higher_gpio_bits = true,
+		.has_vcom_input = true,
+		.has_temp = true,
+		.has_input_buf = true,
+		.has_int_ref = true,
+		.clock = 8 * HZ_PER_MHZ,
+		.sinc5_data_rates = ad4115_sinc5_data_rates,
+		.num_sinc5_data_rates = ARRAY_SIZE(ad4115_sinc5_data_rates),
+	},
+	[ID_AD4116] = {
+		.name = "ad4116",
+		.id = AD4116_ID,
+		.num_voltage_inputs_with_divider = 11,
+		.num_channels = 16,
+		.num_configs = 8,
+		.num_voltage_inputs = 16,
+		.num_gpios = 4,
+		.higher_gpio_bits = true,
+		.has_vcom_input = true,
+		.has_temp = true,
+		.has_input_buf = true,
+		.has_int_ref = true,
+		.clock = 4 * HZ_PER_MHZ,
+		.sinc5_data_rates = ad4116_sinc5_data_rates,
+		.num_sinc5_data_rates = ARRAY_SIZE(ad4116_sinc5_data_rates),
+	},
 	[ID_AD7172_2] = {
 		.name = "ad7172-2",
 		.id = AD7172_2_ID,
-		.num_inputs = 5,
+		.num_voltage_inputs = 5,
 		.num_channels = 4,
 		.num_configs = 4,
 		.num_gpios = 2,
+		.higher_gpio_bits = false,
 		.has_temp = true,
 		.has_input_buf = true,
 		.has_int_ref = true,
@@ -229,10 +377,11 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 	[ID_AD7172_4] = {
 		.name = "ad7172-4",
 		.id = AD7172_4_ID,
-		.num_inputs = 9,
+		.num_voltage_inputs = 9,
 		.num_channels = 8,
 		.num_configs = 8,
 		.num_gpios = 4,
+		.higher_gpio_bits = false,
 		.has_temp = false,
 		.has_input_buf = true,
 		.has_ref2 = true,
@@ -243,11 +392,12 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 	},
 	[ID_AD7173_8] = {
 		.name = "ad7173-8",
-		.id = AD7173_ID,
-		.num_inputs = 17,
+		.id = AD7173_AD4111_AD4112_AD4114_ID,
+		.num_voltage_inputs = 17,
 		.num_channels = 16,
 		.num_configs = 8,
 		.num_gpios = 4,
+		.higher_gpio_bits = false,
 		.has_temp = true,
 		.has_input_buf = true,
 		.has_int_ref = true,
@@ -260,10 +410,11 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 	[ID_AD7175_2] = {
 		.name = "ad7175-2",
 		.id = AD7175_2_ID,
-		.num_inputs = 5,
+		.num_voltage_inputs = 5,
 		.num_channels = 4,
 		.num_configs = 4,
 		.num_gpios = 2,
+		.higher_gpio_bits = false,
 		.has_temp = true,
 		.has_input_buf = true,
 		.has_int_ref = true,
@@ -275,10 +426,11 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 	[ID_AD7175_8] = {
 		.name = "ad7175-8",
 		.id = AD7175_8_ID,
-		.num_inputs = 17,
+		.num_voltage_inputs = 17,
 		.num_channels = 16,
 		.num_configs = 8,
 		.num_gpios = 4,
+		.higher_gpio_bits = false,
 		.has_temp = true,
 		.has_input_buf = true,
 		.has_int_ref = true,
@@ -291,10 +443,11 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 	[ID_AD7176_2] = {
 		.name = "ad7176-2",
 		.id = AD7176_ID,
-		.num_inputs = 5,
+		.num_voltage_inputs = 5,
 		.num_channels = 4,
 		.num_configs = 4,
 		.num_gpios = 2,
+		.higher_gpio_bits = false,
 		.has_temp = false,
 		.has_input_buf = false,
 		.has_int_ref = true,
@@ -306,10 +459,11 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 	[ID_AD7177_2] = {
 		.name = "ad7177-2",
 		.id = AD7177_ID,
-		.num_inputs = 5,
+		.num_voltage_inputs = 5,
 		.num_channels = 4,
 		.num_configs = 4,
 		.num_gpios = 2,
+		.higher_gpio_bits = false,
 		.has_temp = true,
 		.has_input_buf = true,
 		.has_int_ref = true,
@@ -328,6 +482,12 @@ static const char *const ad7173_ref_sel_str[] = {
 	[AD7173_SETUP_REF_SEL_AVDD1_AVSS] = "avdd",
 };
 
+static const char *const ad7173_channel_types[] = {
+	[AD7173_CHAN_SINGLE_ENDED] = "single-ended",
+	[AD7173_CHAN_PSEUDO_DIFFERENTIAL] = "pseudo-differential",
+	[AD7173_CHAN_DIFFERENTIAL] = "differential",
+};
+
 static const char *const ad7173_clk_sel[] = {
 	"ext-clk", "xtal"
 };
@@ -360,6 +520,15 @@ static int ad7173_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
 	return 0;
 }
 
+static int ad4111_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
+			     unsigned int offset, unsigned int *reg,
+			     unsigned int *mask)
+{
+	*mask = AD4111_GPO01_DATA(offset);
+	*reg = base;
+	return 0;
+}
+
 static void ad7173_gpio_disable(void *data)
 {
 	struct ad7173_state *st = data;
@@ -392,7 +561,10 @@ static int ad7173_gpio_init(struct ad7173_state *st)
 	gpio_regmap.regmap = st->reg_gpiocon_regmap;
 	gpio_regmap.ngpio = st->info->num_gpios;
 	gpio_regmap.reg_set_base = AD7173_REG_GPIO;
-	gpio_regmap.reg_mask_xlate = ad7173_mask_xlate;
+	if (st->info->higher_gpio_bits)
+		gpio_regmap.reg_mask_xlate = ad4111_mask_xlate;
+	else
+		gpio_regmap.reg_mask_xlate = ad7173_mask_xlate;
 
 	st->gpio_regmap = devm_gpio_regmap_register(dev, &gpio_regmap);
 	ret = PTR_ERR_OR_ZERO(st->gpio_regmap);
@@ -687,18 +859,33 @@ static int ad7173_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		if (chan->type == IIO_TEMP) {
+
+		switch (chan->type) {
+		case IIO_TEMP:
 			temp = AD7173_VOLTAGE_INT_REF_uV * MILLI;
 			temp /= AD7173_TEMP_SENSIIVITY_uV_per_C;
 			*val = temp;
 			*val2 = chan->scan_type.realbits;
-		} else {
+			return IIO_VAL_FRACTIONAL_LOG2;
+		case IIO_VOLTAGE:
 			*val = ad7173_get_ref_voltage_milli(st, ch->cfg.ref_sel);
 			*val2 = chan->scan_type.realbits - !!(ch->cfg.bipolar);
+
+			if (chan->channel < st->info->num_voltage_inputs_with_divider)
+				*val *= AD4111_DIVIDER_RATIO;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		case IIO_CURRENT:
+			*val = ad7173_get_ref_voltage_milli(st, ch->cfg.ref_sel);
+			*val /= AD4111_SHUNT_RESISTOR_OHM;
+			*val2 = chan->scan_type.realbits - (ch->cfg.bipolar ? 1 : 0);
+			return IIO_VAL_FRACTIONAL_LOG2;
+		default:
+			return -EINVAL;
 		}
-		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_OFFSET:
-		if (chan->type == IIO_TEMP) {
+
+		switch (chan->type) {
+		case IIO_TEMP:
 			/* 0 Kelvin -> raw sample */
 			temp   = -ABSOLUTE_ZERO_MILLICELSIUS;
 			temp  *= AD7173_TEMP_SENSIIVITY_uV_per_C;
@@ -707,10 +894,14 @@ static int ad7173_read_raw(struct iio_dev *indio_dev,
 						       AD7173_VOLTAGE_INT_REF_uV *
 						       MILLI);
 			*val   = -temp;
-		} else {
+			return IIO_VAL_INT;
+		case IIO_VOLTAGE:
+		case IIO_CURRENT:
 			*val = -BIT(chan->scan_type.realbits - 1);
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
 		}
-		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		reg = st->channels[chan->address].cfg.odr;
 
@@ -926,13 +1117,37 @@ static int ad7173_register_clk_provider(struct iio_dev *indio_dev)
 					   &st->int_clk_hw);
 }
 
+static int ad4111_validate_current_ain(struct ad7173_state *st,
+				       unsigned int ain[2])
+{
+	struct device *dev = &st->sd.spi->dev;
+	int i;
+
+	if (!st->info->has_current_inputs)
+		return dev_err_probe(dev, -EINVAL,
+			"Model %s does not support current channels\n",
+			st->info->name);
+
+	for (i = 0; i < ARRAY_SIZE(ad4111_current_channel_config); i++)
+		if (ad4111_current_channel_config[i] == AD7173_CH_ADDRESS(ain[0], ain[1]))
+			return 0;
+
+	return dev_err_probe(dev, -EINVAL,
+		"Current channel configuration invalid (%d, %d).\n",
+		ain[0], ain[1]);
+}
+
 static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
 					      unsigned int ain[2])
 {
 	struct device *dev = &st->sd.spi->dev;
+	bool ain_selects_normal_input[] = {
+		ain[0] < st->info->num_voltage_inputs,
+		ain[1] < st->info->num_voltage_inputs
+	};
 
 	for (int i = 0; i < 2; i++) {
-		if (ain[i] < st->info->num_inputs)
+		if (ain_selects_normal_input[i])
 			continue;
 
 		if (ain[i] == AD7173_AIN_REF_POS || ain[i] == AD7173_AIN_REF_NEG)
@@ -943,11 +1158,27 @@ static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
 		    st->info->has_common_input)
 			continue;
 
+		if (st->info->has_vcom_input && ain[i] == AD411X_VCOM_INPUT) {
+			if (ain_selects_normal_input[(i + 1) % 2] &&
+			    ain[(i + 1) % 2] >= st->info->num_voltage_inputs_with_divider)
+				return dev_err_probe(dev, -EINVAL,
+					"VCOM must be paired with inputs having divider.\n");
+
+			continue;
+		}
+
 		return dev_err_probe(dev, -EINVAL,
 			"Input pin number out of range for pair (%d %d).\n",
 			ain[0], ain[1]);
 	}
 
+	if ((ain_selects_normal_input[0] && ain_selects_normal_input[1]) &&
+	    ((ain[0] >= st->info->num_voltage_inputs_with_divider) !=
+	     (ain[1] >= st->info->num_voltage_inputs_with_divider)))
+		return dev_err_probe(dev, -EINVAL,
+			"Both inputs must either have a voltage divider or not have: (%d %d).\n",
+			ain[0], ain[1]);
+
 	return 0;
 }
 
@@ -979,7 +1210,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 	struct device *dev = indio_dev->dev.parent;
 	struct iio_chan_spec *chan_arr, *chan;
 	unsigned int ain[2], chan_index = 0;
-	int ref_sel, ret, num_channels;
+	int ref_sel, ret, is_current_chan, num_channels;
 
 	num_channels = device_get_child_node_count(dev);
 
@@ -1032,9 +1263,16 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		if (ret)
 			return ret;
 
-		ret = ad7173_validate_voltage_ain_inputs(st, ain);
-		if (ret)
-			return ret;
+		is_current_chan = fwnode_property_read_bool(child, "adi,current-channel");
+		if (is_current_chan) {
+			ret = ad4111_validate_current_ain(st, ain);
+			if (ret)
+				return ret;
+		} else {
+			ret = ad7173_validate_voltage_ain_inputs(st, ain);
+			if (ret)
+				return ret;
+		}
 
 		ret = fwnode_property_match_property_string(child,
 							    "adi,reference-select",
@@ -1058,17 +1296,26 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		chan->scan_index = chan_index;
 		chan->channel = ain[0];
 		chan->channel2 = ain[1];
-		chan->differential = true;
-
 		chan_st_priv->ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
 		chan_st_priv->chan_reg = chan_index;
-		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
 		chan_st_priv->cfg.odr = 0;
-
 		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");
+
 		if (chan_st_priv->cfg.bipolar)
 			chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
 
+		if (is_current_chan)
+			chan->type = IIO_CURRENT;
+		else
+			chan_st_priv->cfg.input_buf = st->info->has_input_buf;
+
+		ret = fwnode_property_match_property_string(child,
+							    "adi,channel-type",
+							    ad7173_channel_types,
+							    ARRAY_SIZE(ad7173_channel_types));
+		chan->differential = (ret < 0 || ret == AD7173_CHAN_DIFFERENTIAL)
+					? true : false;
+
 		chan_index++;
 	}
 	return 0;
@@ -1195,6 +1442,14 @@ static int ad7173_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id ad7173_of_match[] = {
+	{ .compatible = "ad4111",
+	  .data = &ad7173_device_info[ID_AD4111]},
+	{ .compatible = "ad4112",
+	  .data = &ad7173_device_info[ID_AD4112]},
+	{ .compatible = "ad4114",
+	  .data = &ad7173_device_info[ID_AD4114]},
+	{ .compatible = "ad4115",
+	  .data = &ad7173_device_info[ID_AD4115]},
 	{ .compatible = "adi,ad7172-2",
 	  .data = &ad7173_device_info[ID_AD7172_2]},
 	{ .compatible = "adi,ad7172-4",
@@ -1214,6 +1469,11 @@ static const struct of_device_id ad7173_of_match[] = {
 MODULE_DEVICE_TABLE(of, ad7173_of_match);
 
 static const struct spi_device_id ad7173_id_table[] = {
+	{ "ad4111", (kernel_ulong_t)&ad7173_device_info[ID_AD4111]},
+	{ "ad4112", (kernel_ulong_t)&ad7173_device_info[ID_AD4112]},
+	{ "ad4114", (kernel_ulong_t)&ad7173_device_info[ID_AD4114]},
+	{ "ad4115", (kernel_ulong_t)&ad7173_device_info[ID_AD4115]},
+	{ "ad4116", (kernel_ulong_t)&ad7173_device_info[ID_AD4116]},
 	{ "ad7172-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7172_2]},
 	{ "ad7172-4", (kernel_ulong_t)&ad7173_device_info[ID_AD7172_4]},
 	{ "ad7173-8", (kernel_ulong_t)&ad7173_device_info[ID_AD7173_8]},
@@ -1238,5 +1498,5 @@ module_spi_driver(ad7173_driver);
 MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafo.de>");
 MODULE_AUTHOR("Dumitru Ceclan <dumitru.ceclan@analog.com>");
-MODULE_DESCRIPTION("Analog Devices AD7172/AD7173/AD7175/AD7176 ADC driver");
+MODULE_DESCRIPTION("Analog Devices AD717x and AD411x ADC driver");
 MODULE_LICENSE("GPL");

-- 
2.43.0



