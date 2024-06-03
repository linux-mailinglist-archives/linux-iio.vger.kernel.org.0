Return-Path: <linux-iio+bounces-5698-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1458D872F
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 18:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529FE284128
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 16:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECFB13777F;
	Mon,  3 Jun 2024 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSdLCzhr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1069136E2B;
	Mon,  3 Jun 2024 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431794; cv=none; b=kz+5AlCbammZ69drfYGJncSN413yl71M0V+YfkuNhgZIWgO+Ngo4Td9cB+O0Ndb/bV0DJRrMl7o3wjJCzWBtHO3GOit65nvCjzYuAzrIvl6dHU0twM+2K1A/5/8WOJ/M5+h/LlMMfZXQSK4RRBrqB6j0MVkmokIzBIcqmE40h3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431794; c=relaxed/simple;
	bh=e6JJ/U38jD0shlga7AQ5dXpM6jG+iiRcbuzVxcnkKTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YKcMUAnjwOBWC0yG2EpU1fPl0MEd+40XWvSKWGRm81D7aNFSw/HniBrKZyAnjuyXA/IJOuq6qrtTgyeASwwKPPWlCnMZ4UYS0NF0M50+cRnfSXTmCDwtvmEdPaS7KHY9BtnvuT30zwJZJ0lXxvCP7mKJt9TV7C2Blm84N7BixH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSdLCzhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D29CC4AF14;
	Mon,  3 Jun 2024 16:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717431794;
	bh=e6JJ/U38jD0shlga7AQ5dXpM6jG+iiRcbuzVxcnkKTg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dSdLCzhrDI0t8AZTdcZLHxAUvc764RK4gQtIYo1msVYeteLxig1Q25t25gqiS6gYT
	 ZZDEVx6yfBxpW0xssOXW+sKqgnr5O6a0rjoQ9C3C6C4Qk7okI+NBiiegc7u0PvmVqh
	 RS2RArRAQwUE2HyCK78T9Vw1C2Qwh1vGx4gQHChQbM5RMaNcNL4QT4hqa42Dpr4DNg
	 GRV2IkzgJ41RWw6JOfPx2Ghk568VHAGN8WVI/+r5vfiEfNuqe4zQUKfWcmEVfbF7re
	 9q1S6oBEUe6gsVWou/3Xrf87ks8OCmCJMnYWOYGWtJjlwxeM+LHHEAWSmMGIjRKBZ4
	 RwjyP847PfLhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5416DC27C50;
	Mon,  3 Jun 2024 16:23:14 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Mon, 03 Jun 2024 19:23:07 +0300
Subject: [PATCH v5 9/9] iio: adc: ad7173: Add support for AD411x devices
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240603-ad4111-v5-9-9a9c54d9ac78@analog.com>
References: <20240603-ad4111-v5-0-9a9c54d9ac78@analog.com>
In-Reply-To: <20240603-ad4111-v5-0-9a9c54d9ac78@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717431792; l=20049;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=5qSXTFZXs/HAG5EeV47BFdysGaPIbhNxZA/2HjKKA38=;
 b=lte670VCO8YF4HlR/kSybfn5b+EFeV2IbYupPCSzZbaZPhLc30WhMVB2A22zZp6hIrDkpPNoO
 xf9xtw5eOpTDGSLDuioVQMou0VbhB8fQe4SbOlEAWdlsMcX8fhZUvW+
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
 drivers/iio/adc/ad7173.c | 328 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 296 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index fb18acc83f39..45784e4bd27e 100644
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
@@ -82,6 +83,11 @@
 #define AD7175_2_ID			0x0cd0
 #define AD7172_4_ID			0x2050
 #define AD7173_ID			0x30d0
+#define AD4111_ID			AD7173_ID
+#define AD4112_ID			AD7173_ID
+#define AD4114_ID			AD7173_ID
+#define AD4116_ID			0x34d0
+#define AD4115_ID			0x38d0
 #define AD7175_8_ID			0x3cd0
 #define AD7177_ID			0x4fd0
 #define AD7173_ID_MASK			GENMASK(15, 4)
@@ -112,6 +118,7 @@
 
 #define AD7173_GPO12_DATA(x)	BIT((x) + 0)
 #define AD7173_GPO23_DATA(x)	BIT((x) + 4)
+#define AD4111_GPO01_DATA(x)	BIT((x) + 6)
 #define AD7173_GPO_DATA(x)	((x) < 2 ? AD7173_GPO12_DATA(x) : AD7173_GPO23_DATA(x))
 
 #define AD7173_INTERFACE_DATA_STAT	BIT(6)
@@ -130,26 +137,52 @@
 #define AD7173_VOLTAGE_INT_REF_uV	2500000
 #define AD7173_TEMP_SENSIIVITY_uV_per_C	477
 #define AD7177_ODR_START_VALUE		0x07
+#define AD4111_SHUNT_RESISTOR_OHM	50
+#define AD4111_DIVIDER_RATIO		10
+#define AD4111_CURRENT_CHAN_CUTOFF	16
+#define AD4111_VINCOM_INPUT		0X10
+
+/* pin <  num_voltage_in is a normal voltage input */
+/* pin >= num_voltage_in_div is a voltge input without a divider */
+#define AD4111_IS_VINCOM_MISMATCH(pin1, pin2) ((pin1) == AD4111_VINCOM_INPUT && \
+					       (pin2) < st->info->num_voltage_in && \
+					       (pin2) >= st->info->num_voltage_in_div)
 
 #define AD7173_FILTER_ODR0_MASK		GENMASK(5, 0)
 #define AD7173_MAX_CONFIGS		8
 
+enum ad4111_current_channels {
+	AD4111_CURRENT_IN0P_IN0N,
+	AD4111_CURRENT_IN1P_IN1N,
+	AD4111_CURRENT_IN2P_IN2N,
+	AD4111_CURRENT_IN3P_IN3N,
+};
+
 struct ad7173_device_info {
 	const unsigned int *sinc5_data_rates;
 	unsigned int num_sinc5_data_rates;
 	unsigned int odr_start_value;
+	/*
+	 * AD4116 has both inputs with a voltage divider and without.
+	 * These inputs cannot be mixed in the channel configuration.
+	 * Does not include the VINCOM input.
+	 */
+	unsigned int num_voltage_in_div;
 	unsigned int num_channels;
 	unsigned int num_configs;
-	unsigned int num_inputs;
+	unsigned int num_voltage_in;
 	unsigned int clock;
 	unsigned int id;
 	char *name;
+	bool has_current_inputs;
+	bool has_vincom_input;
 	bool has_temp;
 	/* ((AVDD1 − AVSS)/5) */
 	bool has_common_input;
 	bool has_input_buf;
 	bool has_int_ref;
 	bool has_ref2;
+	bool higher_gpio_bits;
 	u8 num_gpios;
 };
 
@@ -191,6 +224,24 @@ struct ad7173_state {
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
@@ -206,13 +257,113 @@ static const unsigned int ad7175_sinc5_data_rates[] = {
 	5000,					/* 20    */
 };
 
+static unsigned int ad4111_current_channel_config[] = {
+	[AD4111_CURRENT_IN0P_IN0N] = 0x1E8,
+	[AD4111_CURRENT_IN1P_IN1N] = 0x1C9,
+	[AD4111_CURRENT_IN2P_IN2N] = 0x1AA,
+	[AD4111_CURRENT_IN3P_IN3N] = 0x18B,
+};
+
+static const struct ad7173_device_info ad4111_device_info = {
+	.name = "ad4111",
+	.id = AD4111_ID,
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
+static const struct ad7173_device_info ad4114_device_info = {
+	.name = "ad4114",
+	.id = AD4114_ID,
+	.num_voltage_in_div = 16,
+	.num_channels = 16,
+	.num_configs = 8,
+	.num_voltage_in = 16,
+	.num_gpios = 4,
+	.higher_gpio_bits = true,
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
+	.num_voltage_in_div = 16,
+	.num_channels = 16,
+	.num_configs = 8,
+	.num_voltage_in = 16,
+	.num_gpios = 4,
+	.higher_gpio_bits = true,
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
+	.num_voltage_in_div = 11,
+	.num_channels = 16,
+	.num_configs = 8,
+	.num_voltage_in = 16,
+	.num_gpios = 4,
+	.higher_gpio_bits = true,
+	.has_vincom_input = true,
+	.has_temp = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.clock = 4 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad4116_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad4116_sinc5_data_rates),
+};
+
 static const struct ad7173_device_info ad7172_2_device_info = {
 	.name = "ad7172-2",
 	.id = AD7172_2_ID,
-	.num_inputs = 5,
+	.num_voltage_in = 5,
 	.num_channels = 4,
 	.num_configs = 4,
 	.num_gpios = 2,
+	.higher_gpio_bits = false,
 	.has_temp = true,
 	.has_input_buf = true,
 	.has_int_ref = true,
@@ -225,10 +376,11 @@ static const struct ad7173_device_info ad7172_2_device_info = {
 static const struct ad7173_device_info ad7172_4_device_info = {
 	.name = "ad7172-4",
 	.id = AD7172_4_ID,
-	.num_inputs = 9,
+	.num_voltage_in = 9,
 	.num_channels = 8,
 	.num_configs = 8,
 	.num_gpios = 4,
+	.higher_gpio_bits = false,
 	.has_temp = false,
 	.has_input_buf = true,
 	.has_ref2 = true,
@@ -241,10 +393,11 @@ static const struct ad7173_device_info ad7172_4_device_info = {
 static const struct ad7173_device_info ad7173_8_device_info = {
 	.name = "ad7173-8",
 	.id = AD7173_ID,
-	.num_inputs = 17,
+	.num_voltage_in = 17,
 	.num_channels = 16,
 	.num_configs = 8,
 	.num_gpios = 4,
+	.higher_gpio_bits = false,
 	.has_temp = true,
 	.has_input_buf = true,
 	.has_int_ref = true,
@@ -258,10 +411,11 @@ static const struct ad7173_device_info ad7173_8_device_info = {
 static const struct ad7173_device_info ad7175_2_device_info = {
 	.name = "ad7175-2",
 	.id = AD7175_2_ID,
-	.num_inputs = 5,
+	.num_voltage_in = 5,
 	.num_channels = 4,
 	.num_configs = 4,
 	.num_gpios = 2,
+	.higher_gpio_bits = false,
 	.has_temp = true,
 	.has_input_buf = true,
 	.has_int_ref = true,
@@ -274,10 +428,11 @@ static const struct ad7173_device_info ad7175_2_device_info = {
 static const struct ad7173_device_info ad7175_8_device_info = {
 	.name = "ad7175-8",
 	.id = AD7175_8_ID,
-	.num_inputs = 17,
+	.num_voltage_in = 17,
 	.num_channels = 16,
 	.num_configs = 8,
 	.num_gpios = 4,
+	.higher_gpio_bits = false,
 	.has_temp = true,
 	.has_input_buf = true,
 	.has_int_ref = true,
@@ -291,10 +446,11 @@ static const struct ad7173_device_info ad7175_8_device_info = {
 static const struct ad7173_device_info ad7176_2_device_info = {
 	.name = "ad7176-2",
 	.id = AD7176_ID,
-	.num_inputs = 5,
+	.num_voltage_in = 5,
 	.num_channels = 4,
 	.num_configs = 4,
 	.num_gpios = 2,
+	.higher_gpio_bits = false,
 	.has_temp = false,
 	.has_input_buf = false,
 	.has_int_ref = true,
@@ -307,10 +463,11 @@ static const struct ad7173_device_info ad7176_2_device_info = {
 static const struct ad7173_device_info ad7177_2_device_info = {
 	.name = "ad7177-2",
 	.id = AD7177_ID,
-	.num_inputs = 5,
+	.num_voltage_in = 5,
 	.num_channels = 4,
 	.num_configs = 4,
 	.num_gpios = 2,
+	.higher_gpio_bits = false,
 	.has_temp = true,
 	.has_input_buf = true,
 	.has_int_ref = true,
@@ -360,6 +517,15 @@ static int ad7173_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
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
@@ -392,7 +558,10 @@ static int ad7173_gpio_init(struct ad7173_state *st)
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
@@ -692,18 +861,33 @@ static int ad7173_read_raw(struct iio_dev *indio_dev,
 
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
+			if (chan->channel < st->info->num_voltage_in_div)
+				*val *= AD4111_DIVIDER_RATIO;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		case IIO_CURRENT:
+			*val = ad7173_get_ref_voltage_milli(st, ch->cfg.ref_sel);
+			*val /= AD4111_SHUNT_RESISTOR_OHM;
+			*val2 = chan->scan_type.realbits - ch->cfg.bipolar;
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
@@ -712,10 +896,14 @@ static int ad7173_read_raw(struct iio_dev *indio_dev,
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
 
@@ -937,6 +1125,23 @@ static int ad7173_register_clk_provider(struct iio_dev *indio_dev)
 					   &st->int_clk_hw);
 }
 
+static int ad4111_validate_current_ain(struct ad7173_state *st,
+				       const unsigned int ain[AD7173_NO_AINS_PER_CHANNEL])
+{
+	struct device *dev = &st->sd.spi->dev;
+
+	if (!st->info->has_current_inputs)
+		return dev_err_probe(dev, -EINVAL,
+			"Model %s does not support current channels\n",
+			st->info->name);
+
+	if (ain[0] >= ARRAY_SIZE(ad4111_current_channel_config))
+		return dev_err_probe(dev, -EINVAL,
+			"For current channels single-channel must be <[0-3]>\n");
+
+	return 0;
+}
+
 static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
 					      unsigned int ain0, unsigned int ain1)
 {
@@ -944,16 +1149,31 @@ static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
 	bool special_input0, special_input1;
 
 	special_input0 = AD7173_IS_REF_INPUT(ain0) ||
-			(AD7173_IS_COM_INPUT(ain0) && st->info->has_common_input);
+			(AD7173_IS_COM_INPUT(ain0) && st->info->has_common_input) ||
+			ain0 == AD4111_VINCOM_INPUT;
 	special_input1 = AD7173_IS_REF_INPUT(ain1) ||
-			(AD7173_IS_COM_INPUT(ain1) && st->info->has_common_input);
+			(AD7173_IS_COM_INPUT(ain1) && st->info->has_common_input) ||
+			ain1 == AD4111_VINCOM_INPUT;
 
-	if ((ain0 >= st->info->num_inputs && !special_input0) ||
-	    (ain1 >= st->info->num_inputs && !special_input1))
+	if (st->info->has_vincom_input)
+		if (AD4111_IS_VINCOM_MISMATCH(ain0, ain1) ||
+		    AD4111_IS_VINCOM_MISMATCH(ain1, ain0))
+			return dev_err_probe(dev, -EINVAL,
+				"VINCOM must be paired with inputs having divider.\n");
+
+	if ((ain0 >= st->info->num_voltage_in && !special_input0) ||
+	    (ain1 >= st->info->num_voltage_in && !special_input1))
 		return dev_err_probe(dev, -EINVAL,
 				     "Input pin number out of range for pair (%d %d).\n",
 				     ain0, ain1);
 
+	if (!special_input0 && !special_input1 &&
+	    ((ain0 >= st->info->num_voltage_in_div) !=
+	     (ain1 >= st->info->num_voltage_in_div)))
+		return dev_err_probe(dev, -EINVAL,
+			"Both inputs must either have a voltage divider or not have: (%d %d).\n",
+			ain0, ain1);
+
 	return 0;
 }
 
@@ -984,7 +1204,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 	struct device *dev = indio_dev->dev.parent;
 	struct iio_chan_spec *chan_arr, *chan;
 	unsigned int ain[AD7173_NO_AINS_PER_CHANNEL], chan_index = 0;
-	int ref_sel, ret, num_channels;
+	int ref_sel, ret, is_current_chan, num_channels;
 
 	num_channels = device_get_child_node_count(dev);
 
@@ -1031,15 +1251,40 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 
 	device_for_each_child_node_scoped(dev, child) {
 		chan = &chan_arr[chan_index];
+		*chan = ad7173_channel_template;
 		chan_st_priv = &chans_st_arr[chan_index];
 		ret = fwnode_property_read_u32_array(child, "diff-channels",
 						     ain, ARRAY_SIZE(ain));
-		if (ret)
-			return ret;
+		if (ret) {
+			ret = fwnode_property_read_u32_array(child, "single-channel",
+							     ain, 1);
+			if (ret)
+				return dev_err_probe(dev, ret,
+					"Channel must define one of diff-channels or single-channel.\n");
 
-		ret = ad7173_validate_voltage_ain_inputs(st, ain[0], ain[1]);
-		if (ret)
-			return ret;
+			is_current_chan = fwnode_property_read_bool(child, "adi,current-channel");
+		} else {
+			chan->differential = true;
+		}
+
+		if (is_current_chan) {
+			ret = ad4111_validate_current_ain(st, ain);
+			if (ret)
+				return ret;
+			is_current_chan = true;
+		} else {
+			if (!chan->differential) {
+				ret = fwnode_property_read_u32_array(child,
+					"common-mode-channel", ain + 1, 1);
+				if (ret)
+					return dev_err_probe(dev, ret,
+						"common-mode-channel must be defined for single-ended channels.\n");
+			}
+			ret = ad7173_validate_voltage_ain_inputs(st, ain[0], ain[1]);
+			if (ret)
+				return ret;
+			is_current_chan = false;
+		}
 
 		ret = fwnode_property_match_property_string(child,
 							    "adi,reference-select",
@@ -1058,14 +1303,9 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 			st->adc_mode |= AD7173_ADC_MODE_REF_EN;
 		chan_st_priv->cfg.ref_sel = ref_sel;
 
-		*chan = ad7173_channel_template;
 		chan->address = chan_index;
 		chan->scan_index = chan_index;
 		chan->channel = ain[0];
-		chan->channel2 = ain[1];
-		chan->differential = true;
-
-		chan_st_priv->ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
 		chan_st_priv->chan_reg = chan_index;
 		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
 		chan_st_priv->cfg.odr = 0;
@@ -1074,6 +1314,20 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		if (chan_st_priv->cfg.bipolar)
 			chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
 
+		if (is_current_chan) {
+			chan->type = IIO_CURRENT;
+			chan->differential = false;
+			chan->channel2 = 0;
+			ain[1] = FIELD_GET(AD7173_CH_SETUP_AINNEG_MASK,
+					   ad4111_current_channel_config[ain[0]]);
+			ain[0] = FIELD_GET(AD7173_CH_SETUP_AINPOS_MASK,
+					   ad4111_current_channel_config[ain[0]]);
+		} else {
+			chan_st_priv->cfg.input_buf = st->info->has_input_buf;
+			chan->channel2 = ain[1];
+		}
+		chan_st_priv->ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
+
 		chan_index++;
 	}
 	return 0;
@@ -1200,6 +1454,11 @@ static int ad7173_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id ad7173_of_match[] = {
+	{ .compatible = "ad4111",	.data = &ad4111_device_info},
+	{ .compatible = "ad4112",	.data = &ad4112_device_info},
+	{ .compatible = "ad4114",	.data = &ad4114_device_info},
+	{ .compatible = "ad4115",	.data = &ad4115_device_info},
+	{ .compatible = "ad4116",	.data = &ad4116_device_info},
 	{ .compatible = "adi,ad7172-2", .data = &ad7172_2_device_info},
 	{ .compatible = "adi,ad7172-4", .data = &ad7172_4_device_info},
 	{ .compatible = "adi,ad7173-8", .data = &ad7173_8_device_info},
@@ -1212,6 +1471,11 @@ static const struct of_device_id ad7173_of_match[] = {
 MODULE_DEVICE_TABLE(of, ad7173_of_match);
 
 static const struct spi_device_id ad7173_id_table[] = {
+	{ "ad4111",   (kernel_ulong_t)&ad4111_device_info},
+	{ "ad4112",   (kernel_ulong_t)&ad4112_device_info},
+	{ "ad4114",   (kernel_ulong_t)&ad4114_device_info},
+	{ "ad4115",   (kernel_ulong_t)&ad4115_device_info},
+	{ "ad4116",   (kernel_ulong_t)&ad4116_device_info},
 	{ "ad7172-2", (kernel_ulong_t)&ad7172_2_device_info},
 	{ "ad7172-4", (kernel_ulong_t)&ad7172_4_device_info},
 	{ "ad7173-8", (kernel_ulong_t)&ad7173_8_device_info},
@@ -1236,5 +1500,5 @@ module_spi_driver(ad7173_driver);
 MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafo.de>");
 MODULE_AUTHOR("Dumitru Ceclan <dumitru.ceclan@analog.com>");
-MODULE_DESCRIPTION("Analog Devices AD7172/AD7173/AD7175/AD7176 ADC driver");
+MODULE_DESCRIPTION("Analog Devices AD7173 and similar ADC driver");
 MODULE_LICENSE("GPL");

-- 
2.43.0



