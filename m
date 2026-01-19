Return-Path: <linux-iio+bounces-27969-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83329D3AC8C
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 15:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F13A43019974
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 14:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD763803FE;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSv55gNY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ED637F0E4;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833450; cv=none; b=TDsO8iaVE2vON7TbYF6ZalWx01fGa7WUj1IrEmkcQfurCiCngZY0u8aehEcDhXA7ojSgKuJs4bfpYR3Xr9D/24gSuT5Ah7z1ackKG63N4mcw+1kRk6gpq2QPRVlpr1LPJIvYxl5R3XtfyxuHLGkxeoMneS7pIM4OwjewcHjvGFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833450; c=relaxed/simple;
	bh=HcN7gZXwRIuh+bGj1eRaqviXm4njZCLh8953XUGFkX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ioiEs9OPSVvTZASj9oznrvtOrox/vclC0jbjSPvwI8NTsn/hlt7+VG56SmGS39b2ef2irViiVnQApzhrqduXC+8yEalq3HaRO5tTrb5qHABUVgW8uIAiblB4beiCqTOVK85WCJHdYlVWh8WlJ8KWMaoVSkP/CXqyjbeMoqGWSw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSv55gNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58C93C2BCB5;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768833450;
	bh=HcN7gZXwRIuh+bGj1eRaqviXm4njZCLh8953XUGFkX8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lSv55gNYrLoQa1gcWrYZQP4DkyWfjpFZEr9jy31a0iNr//831mi4PqzzeW6ZpzEeW
	 qRLmrLwLl1uc4dv5ea44yWM+/97L4RjDBKJG6/oxwJAkBj2gD86g1lJKuTcEuECUJb
	 7tdbdwYsvLPdLKCGWas0OZT1bNj8fIIdB8P5RaVF8dyiz6H9Fr5d4NqfQeK5w7bS9x
	 J7YMIlvDGI5P1HKUgUYk1PLiTHuVuqG3t4BjN1XQ9bZwphoaIoP7fucXUaUxEStKRn
	 dflB63jALEXUrXsr/tn9fTBtUpZ9HlZESekYivcLXsGVEQaKzYuxP9uchxeG+zfL/g
	 xdzIrZu3QR3XQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEAFD29C35;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 19 Jan 2026 14:37:01 +0000
Subject: [PATCH 7/7] iio: amplifiers: ad8366: add device tree support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-iio-ad8366-update-v1-7-8044e23e964a@analog.com>
References: <20260119-iio-ad8366-update-v1-0-8044e23e964a@analog.com>
In-Reply-To: <20260119-iio-ad8366-update-v1-0-8044e23e964a@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768833448; l=12768;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=67Y4OSTw7ChBFBUHIGLRt2epU3S1rrY4JV+HtSrHjes=;
 b=ZqhL2dzr6U3CVOo5V95jN2ttiEnrPnbSIEvCppMlRB6EALHfUoTZmzRnB4HAxrirWfAB7fMbd
 Ty9AUNhE+XkDM4vflyQkc2xeeYYofSPNSppuNeE3Fk6+2+qxwzh0rvw
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Device-tree support achieved dropping the enum ID in favor of an extended
chip info table:
- gain step and number of channels moved to chip info
- pack_code function added to describe how SPI buffer is populated

With this, switch cases on the device type were dropped:
- simplified read_raw and write_raw callbacks
- number of channels retrieved from chip info in probe function

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 303 +++++++++++++++++-----------------------
 1 file changed, 129 insertions(+), 174 deletions(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index d3fd8d44eae7..484ab2b6196c 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -27,6 +27,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/bitrev.h>
 
 #include <linux/iio/iio.h>
@@ -46,9 +47,14 @@ enum ad8366_type {
 	ID_HMC1119,
 };
 
+struct ad8366_state;
+
 struct ad8366_info {
 	int gain_min;
 	int gain_max;
+	int gain_step;
+	int num_channels;
+	size_t (*pack_code)(struct ad8366_state *st);
 };
 
 struct ad8366_state {
@@ -66,153 +72,142 @@ struct ad8366_state {
 	unsigned char		data[2] __aligned(IIO_DMA_MINALIGN);
 };
 
+static int ad8366_write_code(struct ad8366_state *st)
+{
+	const struct ad8366_info *inf = st->info;
+
+	return spi_write(st->spi, st->data, inf->pack_code(st));
+}
+
+static size_t ad8366_pack_code(struct ad8366_state *st)
+{
+	u8 ch_a = bitrev8(st->ch[0] & 0x3F);
+	u8 ch_b = bitrev8(st->ch[1] & 0x3F);
+
+	st->data[0] = ch_b >> 4;
+	st->data[1] = (ch_b << 4) | (ch_a >> 2);
+	return 2;
+}
+
+static size_t simple_pack_code(struct ad8366_state *st)
+{
+	st->data[0] = st->ch[0];
+	return 1;
+}
+
+static size_t adrf5731_pack_code(struct ad8366_state *st)
+{
+	st->data[0] = st->ch[0] << 2;
+	return 1;
+}
+
+static size_t hmc271_pack_code(struct ad8366_state *st)
+{
+	st->data[0] = bitrev8(st->ch[0] & 0x1F) >> 3;
+	return 1;
+}
+
 static const struct ad8366_info ad8366_infos[] = {
 	[ID_AD8366] = {
 		.gain_min = 4500,
 		.gain_max = 20500,
+		.gain_step = 253,
+		.num_channels = 2,
+		.pack_code = ad8366_pack_code,
 	},
 	[ID_ADA4961] = {
 		.gain_min = -6000,
 		.gain_max = 15000,
+		.gain_step = -1000,
+		.num_channels = 1,
+		.pack_code = simple_pack_code,
 	},
 	[ID_ADL5240] = {
 		.gain_min = -11500,
 		.gain_max = 20000,
+		.gain_step = 500,
+		.num_channels = 1,
+		.pack_code = simple_pack_code,
 	},
 	[ID_ADRF5720] = {
 		.gain_min = -31500,
 		.gain_max = 0,
+		.gain_step = -500,
+		.num_channels = 1,
+		.pack_code = simple_pack_code,
 	},
 	[ID_ADRF5730] = {
 		.gain_min = -31500,
 		.gain_max = 0,
+		.gain_step = -500,
+		.num_channels = 1,
+		.pack_code = simple_pack_code,
 	},
 	[ID_ADRF5731] = {
 		.gain_min = -30000,
 		.gain_max = 0,
+		.gain_step = -2000,
+		.num_channels = 1,
+		.pack_code = adrf5731_pack_code,
 	},
 	[ID_HMC271] = {
 		.gain_min = -31000,
 		.gain_max = 0,
+		.gain_step = 1000,
+		.num_channels = 1,
+		.pack_code = hmc271_pack_code,
 	},
 	[ID_HMC792] = {
 		.gain_min = -15750,
 		.gain_max = 0,
+		.gain_step = 250,
+		.num_channels = 1,
+		.pack_code = simple_pack_code,
 	},
 	[ID_HMC1018] = {
 		.gain_min = -31000,
 		.gain_max = 0,
+		.gain_step = 1000,
+		.num_channels = 1,
+		.pack_code = simple_pack_code,
 	},
 	[ID_HMC1019] = {
 		.gain_min = -15500,
 		.gain_max = 0,
+		.gain_step = 500,
+		.num_channels = 1,
+		.pack_code = simple_pack_code,
 	},
 	[ID_HMC1119] = {
 		.gain_min = -31750,
 		.gain_max = 0,
+		.gain_step = -250,
+		.num_channels = 1,
+		.pack_code = simple_pack_code,
 	},
 };
 
-static int ad8366_write(struct iio_dev *indio_dev,
-			unsigned char ch_a, unsigned char ch_b)
-{
-	struct ad8366_state *st = iio_priv(indio_dev);
-	int ret;
-
-	switch (st->type) {
-	case ID_AD8366:
-		ch_a = bitrev8(ch_a & 0x3F);
-		ch_b = bitrev8(ch_b & 0x3F);
-
-		st->data[0] = ch_b >> 4;
-		st->data[1] = (ch_b << 4) | (ch_a >> 2);
-		break;
-	case ID_ADA4961:
-		st->data[0] = ch_a & 0x1F;
-		break;
-	case ID_ADL5240:
-	case ID_ADRF5720:
-	case ID_ADRF5730:
-	case ID_ADRF5731:
-		st->data[0] = (ch_a & 0x3F);
-		break;
-	case ID_HMC271:
-		st->data[0] = bitrev8(ch_a & 0x1F) >> 3;
-		break;
-	case ID_HMC792:
-	case ID_HMC1018:
-	case ID_HMC1019:
-	case ID_HMC1119:
-		st->data[0] = ch_a;
-		break;
-	}
-
-	ret = spi_write(st->spi, st->data, indio_dev->num_channels);
-	if (ret < 0)
-		dev_err(&indio_dev->dev, "write failed (%d)", ret);
-
-	return ret;
-}
-
 static int ad8366_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
 			   int *val2,
-			   long m)
+			   long mask)
 {
 	struct ad8366_state *st = iio_priv(indio_dev);
-	int ret;
-	int code, gain = 0;
+	const struct ad8366_info *inf = st->info;
+	int gain = inf->gain_step > 0 ? inf->gain_min : inf->gain_max;
 
 	guard(mutex)(&st->lock);
 
-	switch (m) {
+	switch (mask) {
 	case IIO_CHAN_INFO_HARDWAREGAIN:
-		code = st->ch[chan->channel];
-
-		switch (st->type) {
-		case ID_AD8366:
-			gain = code * 253 + 4500;
-			break;
-		case ID_ADA4961:
-			gain = 15000 - code * 1000;
-			break;
-		case ID_ADL5240:
-			gain = 20000 - 31500 + code * 500;
-			break;
-		case ID_ADRF5720:
-		case ID_ADRF5730:
-			gain = -1 * code * 500;
-			break;
-		case ID_ADRF5731:
-			gain = -1 * code * 500;
-			break;
-		case ID_HMC792:
-			gain = -1 * code * 500;
-			break;
-		case ID_HMC271:
-		case ID_HMC1018:
-			gain = -31000 + code * 1000;
-			break;
-		case ID_HMC1019:
-			gain = -15500 + code * 500;
-			break;
-		case ID_HMC1119:
-			gain = -1 * code * 250;
-			break;
-		}
-
-		/* Values in dB */
+		gain += inf->gain_step * st->ch[chan->channel];
 		*val = gain / 1000;
 		*val2 = (gain % 1000) * 1000;
-
-		ret = IIO_VAL_INT_PLUS_MICRO_DB;
-		break;
+		return IIO_VAL_INT_PLUS_MICRO_DB;
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-	return ret;
 };
 
 static int ad8366_write_raw(struct iio_dev *indio_dev,
@@ -223,10 +218,8 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
 {
 	struct ad8366_state *st = iio_priv(indio_dev);
 	const struct ad8366_info *inf = st->info;
-	int code = 0, gain;
-	int ret;
+	int code, gain, gain_base;
 
-	/* Values in dB */
 	if (val < 0)
 		gain = (val * 1000) - (val2 / 1000);
 	else
@@ -235,50 +228,18 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
 	if (gain > inf->gain_max || gain < inf->gain_min)
 		return -EINVAL;
 
-	switch (st->type) {
-	case ID_AD8366:
-		code = (gain - 4500) / 253;
-		break;
-	case ID_ADA4961:
-		code = (15000 - gain) / 1000;
-		break;
-	case ID_ADL5240:
-		code = ((gain - 500 - 20000) / 500) & 0x3F;
-		break;
-	case ID_ADRF5720:
-	case ID_ADRF5730:
-		code = (abs(gain) / 500) & 0x3F;
-		break;
-	case ID_ADRF5731:
-		code = (abs(gain) / 500) & 0x3C;
-		break;
-	case ID_HMC792:
-		code = (abs(gain) / 500) & 0x3F;
-		break;
-	case ID_HMC271:
-	case ID_HMC1018:
-		code = ((gain - 1000) / 1000) & 0x1F;
-		break;
-	case ID_HMC1019:
-		code = ((gain - 500) / 500) & 0x1F;
-		break;
-	case ID_HMC1119:
-		code = (abs(gain) / 250) & 0x7F;
-		break;
-	}
+	gain_base = inf->gain_step > 0 ? inf->gain_min : inf->gain_max;
+	code = DIV_ROUND_CLOSEST(gain - gain_base, inf->gain_step);
 
 	guard(mutex)(&st->lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_HARDWAREGAIN:
 		st->ch[chan->channel] = code;
-		ret = ad8366_write(indio_dev, st->ch[0], st->ch[1]);
-		break;
+		return ad8366_write_code(st);
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-	return ret;
 }
 
 static int ad8366_write_raw_get_fmt(struct iio_dev *indio_dev,
@@ -312,10 +273,6 @@ static const struct iio_chan_spec ad8366_channels[] = {
 	AD8366_CHAN(1),
 };
 
-static const struct iio_chan_spec ada4961_channels[] = {
-	AD8366_CHAN(0),
-};
-
 static int ad8366_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -329,7 +286,9 @@ static int ad8366_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 	st->spi = spi;
-	st->type = spi_get_device_id(spi)->driver_data;
+	st->info = spi_get_device_match_data(spi);
+	if (!st->info)
+		return -EINVAL;
 
 	ret = devm_regulator_get_enable(dev, "vcc");
 	if (ret)
@@ -339,44 +298,23 @@ static int ad8366_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	switch (st->type) {
-	case ID_AD8366:
-		indio_dev->channels = ad8366_channels;
-		indio_dev->num_channels = ARRAY_SIZE(ad8366_channels);
-		break;
-	case ID_ADA4961:
-	case ID_ADL5240:
-	case ID_HMC271:
-	case ID_HMC792:
-	case ID_HMC1119:
-	case ID_ADRF5720:
-	case ID_ADRF5730:
-	case ID_ADRF5731:
-	case ID_HMC1018:
-	case ID_HMC1019:
-		st->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
-		if (IS_ERR(st->reset_gpio))
-			return dev_err_probe(dev, PTR_ERR(st->reset_gpio),
-					     "Failed to get reset GPIO\n");
+	st->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(st->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->reset_gpio),
+				     "Failed to get reset GPIO\n");
 
-		st->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
-		if (IS_ERR(st->enable_gpio))
-			return dev_err_probe(dev, PTR_ERR(st->enable_gpio),
-					     "Failed to get enable GPIO\n");
+	st->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(st->enable_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->enable_gpio),
+				     "Failed to get enable GPIO\n");
 
-		indio_dev->channels = ada4961_channels;
-		indio_dev->num_channels = ARRAY_SIZE(ada4961_channels);
-		break;
-	default:
-		return dev_err_probe(dev, -EINVAL, "Invalid device ID\n");
-	}
-
-	st->info = &ad8366_infos[st->type];
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad8366_info;
+	indio_dev->channels = ad8366_channels;
+	indio_dev->num_channels = st->info->num_channels;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = ad8366_write(indio_dev, 0, 0);
+	ret = ad8366_write_code(st);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed to write initial gain\n");
 
@@ -384,24 +322,41 @@ static int ad8366_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad8366_id[] = {
-	{"ad8366",  ID_AD8366},
-	{"ada4961", ID_ADA4961},
-	{"adrf5720", ID_ADRF5720},
-	{"adrf5730", ID_ADRF5730},
-	{"adrf5731", ID_ADRF5731},
-	{"adl5240", ID_ADL5240},
-	{"hmc271a", ID_HMC271},
-	{"hmc792a", ID_HMC792},
-	{"hmc1018a", ID_HMC1018},
-	{"hmc1019a", ID_HMC1019},
-	{"hmc1119", ID_HMC1119},
+	{"ad8366", (kernel_ulong_t)&ad8366_infos[ID_AD8366]},
+	{"ada4961", (kernel_ulong_t)&ad8366_infos[ID_ADA4961]},
+	{"adrf5720", (kernel_ulong_t)&ad8366_infos[ID_ADRF5720]},
+	{"adrf5730", (kernel_ulong_t)&ad8366_infos[ID_ADRF5730]},
+	{"adrf5731", (kernel_ulong_t)&ad8366_infos[ID_ADRF5731]},
+	{"adl5240", (kernel_ulong_t)&ad8366_infos[ID_ADL5240]},
+	{"hmc271a", (kernel_ulong_t)&ad8366_infos[ID_HMC271]},
+	{"hmc792a", (kernel_ulong_t)&ad8366_infos[ID_HMC792]},
+	{"hmc1018a", (kernel_ulong_t)&ad8366_infos[ID_HMC1018]},
+	{"hmc1019a", (kernel_ulong_t)&ad8366_infos[ID_HMC1019]},
+	{"hmc1119", (kernel_ulong_t)&ad8366_infos[ID_HMC1119]},
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad8366_id);
 
+static const struct of_device_id ad8366_of_match[] = {
+	{ .compatible = "adi,ad8366", .data = &ad8366_infos[ID_AD8366] },
+	{ .compatible = "adi,ada4961", .data = &ad8366_infos[ID_ADA4961] },
+	{ .compatible = "adi,adrf5720", .data = &ad8366_infos[ID_ADRF5720] },
+	{ .compatible = "adi,adrf5730", .data = &ad8366_infos[ID_ADRF5730] },
+	{ .compatible = "adi,adrf5731", .data = &ad8366_infos[ID_ADRF5731] },
+	{ .compatible = "adi,adl5240", .data = &ad8366_infos[ID_ADL5240] },
+	{ .compatible = "adi,hmc271a", .data = &ad8366_infos[ID_HMC271] },
+	{ .compatible = "adi,hmc792a", .data = &ad8366_infos[ID_HMC792] },
+	{ .compatible = "adi,hmc1018a", .data = &ad8366_infos[ID_HMC1018] },
+	{ .compatible = "adi,hmc1019a", .data = &ad8366_infos[ID_HMC1019] },
+	{ .compatible = "adi,hmc1119", .data = &ad8366_infos[ID_HMC1119] },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad8366_of_match);
+
 static struct spi_driver ad8366_driver = {
 	.driver = {
-		.name	= KBUILD_MODNAME,
+		.name		= KBUILD_MODNAME,
+		.of_match_table	= ad8366_of_match,
 	},
 	.probe		= ad8366_probe,
 	.id_table	= ad8366_id,

-- 
2.43.0



