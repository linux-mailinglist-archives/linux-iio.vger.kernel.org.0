Return-Path: <linux-iio+bounces-19548-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EA6AB8CA2
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 18:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71181754A5
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 16:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EBA224242;
	Thu, 15 May 2025 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c65YE4H5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626F4221FBD;
	Thu, 15 May 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327057; cv=none; b=Jxv8F1T3cGKHzARSxFxBD8TrFTWkRBQPKJjMg822IzWU78188ozMrSGr1qd5PyGRCEDKkUDzH9M2PKeTlPauT7nXxbtX4KxpQyKNy2IbTn+EsD+GeUHlivwKsg+rkQ0Mw0UsJIVHn/Gnk6jfBZ+PRqvuW1IKL/qRIArR67MKTCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327057; c=relaxed/simple;
	bh=1+eGYVbGJoapxQqcgapJ0uZLQvVXvBJlQHYppvHEeOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RG3fB004cSYKTm2ERcfDCn3dEHXXchJJUQzDXneyE4CozTzUKKbqXShJ82mPC3qLVGjFWmXL5ZdYYiTWnB+ggvvaY0L8MIBq4Ad6rMl6KcRZ/Fn451tBrTWSWukm9eNIIBfAZksic0YTrpDfNx95OVzJUTfLhVBhl5mJN8Q8eHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c65YE4H5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71E9C4CEE7;
	Thu, 15 May 2025 16:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747327056;
	bh=1+eGYVbGJoapxQqcgapJ0uZLQvVXvBJlQHYppvHEeOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c65YE4H5dUhkJluDLmaLGMqEtsHt+RLs1aAGAjo0Jh0/rRSGNiimffvlEaObwwMXs
	 MP2rE711AEo1JyvKYuTqxNPpZvvzwlTie2pGPOEw+k+pEUaEqSIfUV/baSr6HspU6D
	 OLreP5JelybmY+tfqaXHo67sKeOOpYuKcAv8UWDMzVlVzwpzOrvahtOE69ty3ceLLR
	 ku7ydnIwu8K7RsdJU6LmTjL9NO/lvF7Qbjh8juCelt9ZazR1/0nH72U2iZnNy7DQoE
	 5srdXY6urISovtdv0fhfZNCrd+V4aeY+qhIuxvAk4pr+Bw/vIMX4/B9wZSo+OMaqJG
	 X98NI12GrpthQ==
Date: Thu, 15 May 2025 17:37:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, javier.carrasco.cruz@gmail.com, mazziesaccount@gmail.com,
 andriy.shevchenko@linux.intel.com, muditsharma.info@gmail.com,
 perdaniel.olsson@axis.com, emil.gedenryd@axis.com,
 mgonellabolduc@dimonoff.com, arthur.becker@sentec.com, clamor95@gmail.com,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: light: add support for veml6046x00 RGBIR
 color sensor
Message-ID: <20250515173728.1eaebd5c@jic23-huawei>
In-Reply-To: <20250505202313.205522-3-ak@it-klinger.de>
References: <20250505202313.205522-1-ak@it-klinger.de>
	<20250505202313.205522-3-ak@it-klinger.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 May 2025 22:23:12 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Add Vishay VEML6046X00 high accuracy RGBIR color sensor.
> 
> This sensor provides three colour (red, green and blue) as well as one
> infrared (IR) channel through I2C.
> 
> Support direct and buffered mode.
> 
> An optional interrupt for signaling green colour threshold underflow or
> overflow is not supported so far.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

A few minor additional comments from me.

> +
> +/*
> + * regmap fields
> + */

Not sure that comment adds anything as pretty obvious what these are.

> +struct veml6046x00_rf {
> +	struct regmap_field *int_en;
> +	struct regmap_field *mode;
> +	struct regmap_field *trig;
> +	struct regmap_field *it;
> +	struct regmap_field *pers;
> +};
> +
> +struct veml6046x00_data {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct iio_trigger *trig;
> +	struct veml6046x00_rf rf;
> +};
> +
> +struct veml6046x00_scan_buf {
> +	__le16 chans[4];
> +	aligned_s64 timestamp;
This structure is only used on one place. Maybe just define it there?
> +};
> +
> +/*
> + * Integration times
> + * Register value on veml6046x00 is identical with array index
> + * --> no separate table needed
> + */
> +static const int veml6046x00_it[][2] = {
> +	{ 0, 3125 },
> +	{ 0, 6250 },
> +	{ 0, 12500 },
> +	{ 0, 25000 },
> +	{ 0, 50000 },
> +	{ 0, 100000 },
> +	{ 0, 200000 },
> +	{ 0, 400000 },
> +};
> +
> +/*
> + * Gains here in the driver are not exactly the same as in the datasheet of the
> + * sensor. The gain in the driver is a combination of the gain of the sensor
> + * with the photodiode size (PD).
> + * The following combinations are possible:
> + *   gain(driver) = gain(sensor) * PD
> + *           0.25 = x0.5  * 1/2
> + *           0.33 = x0.66 * 1/2
> + *           0.5  = x0.5  * 2/2
> + *           0.66 = x0.66 * 2/2
> + *           1    = x1    * 2/2
> + *           2    = x2    * 2/2
> + */
> +
> +/*
> + * veml6046x00_gain_pd - translation from gain index (used in the driver) to
> + * gain (sensor) and PD
> + * @gain_sen:	Gain used in the sensor as described in the datasheet of the
> + *		sensor
> + * @pd:		Photodiode size in the sensor
> + */
> +struct veml6046x00_gain_pd {
> +	int gain_sen;
> +	int pd;
> +};
> +
> +#define VEML6046X00_GAIN_PD(_gain_sen, _pd)				\
> +{									\
> +	.gain_sen = (_gain_sen),					\
> +	.pd = (_pd),							\
> +}
> +
> +static const struct veml6046x00_gain_pd veml6046x00_gain_pd[] = {
> +	VEML6046X00_GAIN_PD(VEML6046X00_GAIN_0_5, VEML6046X00_PD_1_2),
	{ .gain_sel = VEML6046X00_GAIN_0_5, .pd = VEML6046X00_PD_1_2 },
is probably fine - that is I'm not sure the macro helps much over
just doing 
	{ VEML6046X00_GAIN_0_5, VEML6046X00_PD_1_2 },
etc but laying out which parameter is which as above is nice to have.

> +	VEML6046X00_GAIN_PD(VEML6046X00_GAIN_0_66, VEML6046X00_PD_1_2),
> +	VEML6046X00_GAIN_PD(VEML6046X00_GAIN_0_5, VEML6046X00_PD_2_2),
> +	VEML6046X00_GAIN_PD(VEML6046X00_GAIN_0_66, VEML6046X00_PD_2_2),
> +	VEML6046X00_GAIN_PD(VEML6046X00_GAIN_1, VEML6046X00_PD_2_2),
> +	VEML6046X00_GAIN_PD(VEML6046X00_GAIN_2, VEML6046X00_PD_2_2),
> +};
> +
> +/*
> + * Factors for lux / raw count in dependency of integration time (IT) as rows
> + * and driver gain in columns
> + * Columns:
> + * x0.25 x0.33 x0.5 x0.66 x1 x2
> + * Rows:
> + * 3.125 6.25 12.5 25 50 100 200 400ms
> + */
> +static const u32 veml6046x00_it_gains[][6][2] = {
> +{{5, 376000}, {4,  72700}, {2, 688000}, {2,  36400}, {1, 344000}, {0, 672000}},
> +{{2, 688000}, {2,  36350}, {1, 344000}, {1,  18200}, {0, 672000}, {0, 336000}},
> +{{1, 344000}, {1,  18175}, {0, 672000}, {0, 509100}, {0, 336000}, {0, 168000}},
> +{{0, 672000}, {0, 509087}, {0, 336000}, {0, 254550}, {0, 168000}, {0,  84000}},
> +{{0, 336000}, {0, 254543}, {0, 168000}, {0, 127275}, {0,  84000}, {0,  42000}},
> +{{0, 168000}, {0, 127271}, {0,  84000}, {0,  63637}, {0,  42000}, {0,  21000}},
> +{{0,  84000}, {0,  63635}, {0,  42000}, {0,  31818}, {0,  21000}, {0,  10500}},
> +{{0,  42000}, {0,  31817}, {0,  21000}, {0,  15909}, {0,  10500}, {0,   5250}},
I'd prefer
   { { 0,  42000 }, { 0,   31817 }, etc for this formatting.
Don't worry about going a little over 80 chars to do so - I think the readability
makes it worth while.


> +};

> +static int veml6046x00_get_gain_idx(struct veml6046x00_data *data)
> +{
> +	int ret, reg;
> +	int i;
> +	int reg_gain;
> +	int reg_pd;
> +

I'd combine a few more of these on one line.  Either all as one line
or i on the line with ret then the two reg* together.


> +static int veml6046x00_single_read(struct iio_dev *iio,
> +					enum iio_modifier modifier, int *val)
> +{
> +	struct veml6046x00_data *data = iio_priv(iio);
> +	int addr, it_usec, ret;
> +	__le16 reg;
> +
> +	switch (modifier) {
> +	case IIO_MOD_LIGHT_RED:
> +		addr = VEML6046X00_REG_R_L;
> +		break;
> +	case IIO_MOD_LIGHT_GREEN:
> +		addr = VEML6046X00_REG_G_L;
> +		break;
> +	case IIO_MOD_LIGHT_BLUE:
> +		addr = VEML6046X00_REG_B_L;
> +		break;
> +	case IIO_MOD_LIGHT_IR:
> +		addr = VEML6046X00_REG_IR_L;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	ret = pm_runtime_resume_and_get(data->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = veml6046x00_get_it_usec(data, &it_usec);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_field_write(data->rf.mode, 1);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_field_write(data->rf.trig, 1);
> +	if (ret)
> +		return ret;
> +
> +	/* integration time + 10 % to ensure completion */
> +	fsleep(it_usec + (it_usec / 10));
> +
> +	ret = veml6046x00_wait_data_available(iio, it_usec * 10);
> +	if (ret == 1) {
> +		dev_dbg(data->dev, "data ready\n");
> +	} else {
> +		dev_warn(data->dev, "no data ready ret: %d\n", ret);
> +		goto no_data;
> +	}
> +
> +	if (!iio_device_claim_direct(iio))
> +		return -EBUSY;
> +
> +	ret = regmap_bulk_read(data->regmap, addr, &reg, sizeof(reg));
> +	iio_device_release_direct(iio);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_mark_last_busy(data->dev);
> +	pm_runtime_put_autosuspend(data->dev);
> +
> +	*val = le16_to_cpu(reg);
> +
> +	return IIO_VAL_INT;
> +
> +no_data:
> +	pm_runtime_mark_last_busy(data->dev);
> +	pm_runtime_put_autosuspend(data->dev);
> +
> +	return -EINVAL;

Why -EINVAL for not yet?  EAGAIN maybe if expectation is it will succeed later.

> +}



> +static int veml6046x00_setup_device(struct iio_dev *iio)
> +{
> +	struct veml6046x00_data *data = iio_priv(iio);
> +	struct device *dev = data->dev;
> +	int ret, val;
> +	__le16 reg16;
> +	uint8_t reg[2];

kernel types preferred.  Doesn't really matter but they are more common in IIO.

> +
> +	reg[0] = VEML6046X00_CONF0_AF;
> +	reg[1] = 0x00;
Given you are respinning anyway, might as well do
	u8 reg[2] = { VEMDL6046X00_CONF0_AF, 0x00 };

and save a few lines.

> +	ret = regmap_bulk_write(data->regmap, VEML6046X00_REG_CONF0, reg, sizeof(reg));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set configuration\n");
> +
> +	reg16 = cpu_to_le16(0);
> +	ret = regmap_bulk_write(data->regmap, VEML6046X00_REG_THDL_L, &reg16, sizeof(reg16));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set low threshold\n");
> +
> +	reg16 = cpu_to_le16(U16_MAX);
> +	ret = regmap_bulk_write(data->regmap, VEML6046X00_REG_THDH_L, &reg16, sizeof(reg16));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set high threshold\n");
> +
> +	ret = regmap_read(data->regmap, VEML6046X00_REG_INT_H, &val);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to clear interrupts\n");
> +
> +	return 0;
> +}


