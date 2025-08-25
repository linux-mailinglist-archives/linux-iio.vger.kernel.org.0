Return-Path: <linux-iio+bounces-23245-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CF5B34480
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 16:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F016B161690
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7786D2F6162;
	Mon, 25 Aug 2025 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPeWoDqF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297282F2918;
	Mon, 25 Aug 2025 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133102; cv=none; b=VRUpdiAuHHoS4q6UNuBvQvibg/zaelnMv71fMaxRx0Y5kcvty6tHgGB3h5meEpyfmJIlPRoidmotnPqeyM+TyItjJtiVuJ2zXK8srtYYD+7TphiRguwzGF9jf1vb0uG2/EzmXbbTzELi4X1d4+9sj89JHstaJqDq2aNmEINgA4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133102; c=relaxed/simple;
	bh=CXtcxglAA+98wJhlfNUc3ZX0sJCWhslYoGCOjtc+ktI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=niSiXf6TbLkZVshZfCgd1CKR1FvjqM2olWu5ovZhLdyH2u8ASqQ7zLkP64/DTDU1bBX9zmmLqixjNrq1oLxn0Q+GWOKhE9dFGY6+Kzr3/zXdCH5nHRkd4hNSrc/eaoMDiQIDdAkXxrhWerY11xXMz99XwDpPLXl8kSfdzutZGUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPeWoDqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBC7C4CEED;
	Mon, 25 Aug 2025 14:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756133100;
	bh=CXtcxglAA+98wJhlfNUc3ZX0sJCWhslYoGCOjtc+ktI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gPeWoDqF7vJffRzi0Y3yt9IKt+LVXxczKGy80MxtSIholo8VrISuoJHb4x06yJi2q
	 HJylDHsXhnnv4IT2HVEq54riS28MeDHVdCrjw6abj70ChMRe2EtRkgoZKXsUm34CvE
	 oKjmdaQfVXKpF3F9q3K1Nv0lVRuYZJ9Ae4+xfU7JQeBLjpO+65UHPredvN1+hm37iM
	 lRgKCanirRDENXvfSGBqBf+Z6X1YC9yDkxXQunAodN+v1Nre5/Q6xwNnBG32qB6Qsr
	 saRwl+00bzontYffyDgLafrFMddyR+AXAFHJ81VK7E/TvsocYoyJUeEtdatn4hJAvo
	 TQzVPwt4Xkvcg==
Date: Mon, 25 Aug 2025 15:44:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <Michael.Hennerich@analog.com>,
 <lars@metafoo.de>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v2 4/4] iio: adc: ad7768-1: add support for ADAQ776x-1
 ADC Family
Message-ID: <20250825154450.75eedc9b@jic23-huawei>
In-Reply-To: <20250824041013.9872-1-Jonathan.Santos@analog.com>
References: <20250824041013.9872-1-Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Aug 2025 01:10:13 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> Add support for ADAQ7767/68/69-1 series, which includes PGIA and
> Anti-aliasing filter (AAF) gains. Unlike the AD7768-1, they do not
> provide a VCM regulator interface.
> 
> The PGA gain is configured in run-time through the scale attribute,
> if supported by the device. PGA is enabled and controlled by the GPIO
> controller (GPIOs 0, 1 and 2) provided by the device with the SPI
> interface.
> 
> The AAF gain is defined by hardware connections and should be specified
> in device tree.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
Hi Jonathan

Various minor comments inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 51562367a9d4..61d93dbfc4c6 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c

>  
>  struct ad7768_state {
> @@ -235,6 +298,9 @@ struct ad7768_state {
>  	unsigned int samp_freq;
>  	unsigned int samp_freq_avail[ARRAY_SIZE(ad7768_mclk_div_rates)];
>  	unsigned int samp_freq_avail_len;
> +	int pga_gain_mode;
> +	int aaf_gain;
> +	int scale_tbl[ADAQ776X_MAX_GAIN_MODES][2];
>  	struct completion completion;
>  	struct iio_trigger *trig;
>  	struct gpio_desc *gpio_sync_in;
> @@ -243,6 +309,7 @@ struct ad7768_state {
>  	struct gpio_chip gpiochip;
>  	const struct ad7768_chip_info *chip;
>  	bool en_spi_sync;
> +	struct mutex pga_lock; /* protect PGA value access */

why?  What is special about that value? Is it only state in device?
If so I'd go with 
/* protect device internal state (PGA) */


> +static int ad7768_calc_pga_gain(struct ad7768_state *st, int gain_int,
> +				int gain_fract, int precision)
> +{
> +	u64 gain_nano;
> +	int gain_idx;
> +	u32 tmp;
> +
> +	gain_nano = gain_int * NANO + gain_fract;
> +	gain_nano = clamp(gain_nano, 0, ADAQ776X_GAIN_MAX_NANO);
> +	tmp = DIV_ROUND_CLOSEST_ULL(gain_nano << precision, NANO);
> +	gain_nano = DIV_ROUND_CLOSEST(st->vref_uv, tmp);
> +	if (st->chip->has_variable_aaf)
> +		/* remove the AAF gain from the overall gain */
> +		gain_nano = DIV_ROUND_CLOSEST_ULL(gain_nano *  MILLI,
> +						  ad7768_aaf_gains[st->aaf_gain]);
> +	tmp = st->chip->num_pga_modes;
> +	gain_idx = find_closest(gain_nano, st->chip->pga_gains, tmp);
put tmp inline.  It's not adding anything by having it in the local variable
where it's not so obvious it is the number of the previous parameter.
> +
> +	return gain_idx;
> +}
> +
> +static int ad7768_set_pga_gain(struct ad7768_state *st,
> +			       int gain_mode)
> +{
> +	int pgia_pins_value = abs(gain_mode - st->chip->pgia_mode2pin_offset);
> +	int check_val;
> +	int ret;
> +
> +	guard(mutex)(&st->pga_lock);
> +	/* Check GPIO control register */

The code is pretty much saying what that comment does. Drop the comment.

> +	ret = regmap_read(st->regmap, AD7768_REG_GPIO_CONTROL, &check_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if ((check_val & AD7768_GPIO_PGIA_EN) != AD7768_GPIO_PGIA_EN) {
> +		/* Enable PGIA GPIOs and set them as output */
> +		ret = regmap_write(st->regmap, AD7768_REG_GPIO_CONTROL, AD7768_GPIO_PGIA_EN);

Why check it? Just write it and rely on regcache making that only happen once
if at all.  If you need to be careful about double writing - add a comment.

> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Write the respective gain values to GPIOs 0, 1, 2 */
> +	ret = regmap_write(st->regmap, AD7768_REG_GPIO_WRITE,
> +			   AD7768_GPIO_WRITE(pgia_pins_value));
> +	if (ret)
> +		return ret;
> +
> +	st->pga_gain_mode = gain_mode;
> +
> +	return 0;
> +}

>  static int __ad7768_write_raw(struct iio_dev *indio_dev,
>  			      struct iio_chan_spec const *chan,
>  			      int val, int val2, long info)
>  {
>  	struct ad7768_state *st = iio_priv(indio_dev);
> +	const struct iio_scan_type *scan_type;
> +	int gain_mode;
>  	int ret;

Might as well combine ret and gain_mode on one line.
or pus gain_mode down into a more local scope so it's not defined here
at all.


>  
> +	scan_type = iio_get_current_scan_type(indio_dev, chan);
> +	if (IS_ERR(scan_type))
> +		return PTR_ERR(scan_type);
> +
>  	switch (info) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		return ad7768_set_freq(st, val);
> @@ -887,6 +1083,18 @@ static int __ad7768_write_raw(struct iio_dev *indio_dev,
>  
>  		/* Update sampling frequency */
>  		return ad7768_set_freq(st, st->samp_freq);
> +	case IIO_CHAN_INFO_SCALE:
> +		if (!st->chip->has_pga)
> +			return -EOPNOTSUPP;
> +
> +		if (scan_type->sign == 's')
> +			gain_mode = ad7768_calc_pga_gain(st, val, val2,
> +							 scan_type->realbits - 1);
> +		else
> +			gain_mode = ad7768_calc_pga_gain(st, val, val2,
> +							 scan_type->realbits);
> +
> +		return ad7768_set_pga_gain(st, gain_mode);

>  static int ad7768_probe(struct spi_device *spi)
>  {
>  	struct ad7768_state *st;
>  	struct iio_dev *indio_dev;
> +	u32 val;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> @@ -1409,9 +1653,37 @@ static int ad7768_probe(struct spi_device *spi)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	/* Register VCM output regulator */
> -	ret = ad7768_register_regulators(&spi->dev, st, indio_dev);
> -	if (ret)
> -		return ret;
> +	if (st->chip->has_vcm_regulator) {
> +		ret = ad7768_register_regulators(&spi->dev, st, indio_dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	st->aaf_gain = AD7768_AAF_IN1;
> +	ret = device_property_read_u32(&spi->dev, "adi,gain-milli", &val);
> +	if (ret && st->chip->has_variable_aaf)
> +		dev_warn(&spi->dev, "AAF gain not specified, using default\n");
> +
> +	if (!ret && !st->chip->has_variable_aaf)
> +		dev_warn(&spi->dev, "AAF gain not supported for %s\n", st->chip->name);

I'm confused.  If you hit this warn, you then go ahead and set it anyway. How does that
work?

> +
> +	if (!ret) {
use a local bool for ret here with a suitable name. Carrying on using ret is
fragile against later code changes where someone doesn't realise it is still in use.

> +		/* If provided, validate and set the gain */
> +		switch (val) {
> +		case 1000:
> +			st->aaf_gain = AD7768_AAF_IN1;
> +			break;
> +		case 364:
> +			st->aaf_gain = AD7768_AAF_IN2;
> +			break;
> +		case 143:
> +			st->aaf_gain = AD7768_AAF_IN3;
> +			break;
> +		default:
> +			return dev_err_probe(&spi->dev, -EINVAL,
> +					     "Invalid firmware provided AAF gain\n");
> +		}
> +	}

