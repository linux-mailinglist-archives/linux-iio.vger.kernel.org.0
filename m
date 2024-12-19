Return-Path: <linux-iio+bounces-13659-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D719F7FEB
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504CC163EFA
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 16:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B0B227B87;
	Thu, 19 Dec 2024 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwgiNL09"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22D386345;
	Thu, 19 Dec 2024 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626104; cv=none; b=Br+cLaBwR6rotUvG84tsbBQ9C9yaotvignoKyEGWlQrEu2tufI5jQJhmTMBrKzACVhcSmiw1ZfRI8wiHd01+W4YDElJpkC3UxZaH4SbuS8Hq3rX8gGtFamSINTgGL9c+LLgjAkOfyWlmf5t0TH5qGIBZ8/+S3083pjC6FpokeK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626104; c=relaxed/simple;
	bh=EHAtmBne+Vnl7JyuyPOPPh7k66uotckadRqC996xYEw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/Ll/BXebZFfQXv6NkXy1iArJx6qrlWU+Vm7/xxSjAASKcciqJnznTtP93KkVpokSSpisE6acXd02+wkf/VqqxMbtD2NhXQHPFUGAUvP9MICicXrV123C0VW32/haNcnRniEG28fKYm3NIlLIzL3vXBIdcTo3vmbsVSWjWbEnAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwgiNL09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCE3C4CED0;
	Thu, 19 Dec 2024 16:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734626104;
	bh=EHAtmBne+Vnl7JyuyPOPPh7k66uotckadRqC996xYEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hwgiNL09gadmTjmLNwOWuvjpj/khHkLW6A5B5iZs0iEpK/LsnybOwyCPPSxJorqUq
	 wzg8RnsVPXyC93fmXVZvMdk+8QAe2Vl0fSXgxK5Weunfu8uKJMHNOaTAUFdOzG90hd
	 CXASphY59bgnI9UJalnoiTJJPwzKpiqvjyIntsSBx7UJ7tKEiCFniPuDIxyAKr5dlP
	 Qufy/hB44kKDXuZBI7tk15CaOoaiGPhp6ltH/7piP3/9BN14xFxFeeRmAMjYln/3Ph
	 sCeWm2FREmpjCktFY6shZ0Zj7Zg1vWv4pNPMd4zHHVXbaAbWqyHSjgtuAKJzJM+usk
	 cx6L+XZcwzehQ==
Date: Thu, 19 Dec 2024 16:34:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mikael Gonella-Bolduc via B4 Relay
 <devnull+mgonellabolduc.dimonoff.com@kernel.org>
Cc: mgonellabolduc@dimonoff.com, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Mikael Gonella-Bolduc
 <m.gonella.bolduc@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Matti
 Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: light: Add APDS9160 ALS & Proximity sensor
 driver
Message-ID: <20241219163454.09daa116@jic23-huawei>
In-Reply-To: <20241216-apds9160-driver-v3-2-c29f6c670bdb@dimonoff.com>
References: <20241216-apds9160-driver-v3-0-c29f6c670bdb@dimonoff.com>
	<20241216-apds9160-driver-v3-2-c29f6c670bdb@dimonoff.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 17:55:41 -0500
Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org> wrote:

> From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> 
> APDS9160 is a combination of ALS and proximity sensors.
> 
> This patch add supports for:
>     - Intensity clear data and illuminance data
>     - Proximity data
>     - Gain control, rate control
>     - Event thresholds
> 
> Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>

Hi Mikael,

A couple of questions on the calib* parts. I hadn't looked closely those
before and the datasheet is not very helpful!

Jonathan


> diff --git a/drivers/iio/light/apds9160.c b/drivers/iio/light/apds9160.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..0c93ab847d9a36aac7aa6a1893bba0fe819d9e28
> --- /dev/null
> +++ b/drivers/iio/light/apds9160.c

> +
> +/*
> + * The PS intelligent cancellation level register allows
> + * for an on-chip substraction of the ADC count caused by
> + * unwanted reflected light from PS ADC output.
As it's subtraction, why calibscale? Sounds more suitable to make this to calibbias.
> + */
> +static int apds9160_set_ps_cancellation_level(struct apds9160_chip *data,
> +					      int val)
> +{
> +	int ret;
> +	__le16 buf;
> +
> +	if (val < 0 || val > 0xFFFF)
> +		return -EINVAL;
> +
> +	buf = cpu_to_le16(val);
> +	ret = regmap_bulk_write(data->regmap, APDS9160_REG_PS_CAN_LEVEL_DIG_LSB,
> +				&buf, 2);
> +	if (ret)
> +		return ret;
> +
> +	data->ps_cancellation_level = val;
> +
> +	return ret;
> +}
> +
> +/*
> + * This parameter determines the cancellation pulse duration
> + * in each of the PWM pulse. The cancellation is applied during the
> + * integration phase of the PS measurement.
> + * Duration is programmed in half clock cycles
> + * A duration value of 0 or 1 will not generate any cancellation pulse

Perhaps add some details on why this is a calibbias type control?

Whilst I can sort of grasp it might have a similar affect to a conventional
calibration bias by removing some offset, it's not totally obvious.

> + */
> +static int apds9160_set_ps_analog_cancellation(struct apds9160_chip *data,
> +					       int val)
> +{
> +	int ret;
> +
> +	if (val < 0 || val > 0x7F)
> +		return -EINVAL;
> +
> +	ret = regmap_write(data->regmap, APDS9160_REG_PS_CAN_LEVEL_ANA_DUR,
> +			   val);
> +	if (ret)
> +		return ret;
> +
> +	data->ps_cancellation_analog = val;
> +
> +	return ret;
> +}
> +
> +/*
> + * This parameter works in conjunction with the cancellation pulse duration
> + * The value determines the current used for crosstalk cancellation
> + * B4-B5: The coarse value defines cancellation current in steps of 60nA
> + * B0-B3: The fine value adjusts the cancellation current in steps of 2.4nA

Whilst I'm failing to actually understand what this is doing and maybe never will
we can make the interface more intuitive by not using the encoded value.
Just use a value in nA with both the val and val2 parts.

it is rather odd given 15 * 2.4 is only 36 so there are holes..  PRobably a case
for getting as close as you can to the requested value.

Calibration parameters aren't guaranteed to have a simple interpretation but
this current case is worse that it needs to be.

> + */
> +static int apds9160_set_ps_cancellation_current(struct apds9160_chip *data,
> +						int val)
> +{
> +	int ret;
> +
> +	if (val < 0 || val > 0x3F)
> +		return -EINVAL;
> +
> +	ret = regmap_write(data->regmap, APDS9160_REG_PS_CAN_LEVEL_ANA_CURRENT,
> +			   val);
> +	if (ret)
> +		return ret;
> +
> +	data->ps_cancellation_current = val;
> +
> +	return ret;
> +}

> +/*
> + *	Setting the integration time ajusts resolution, rate, scale and gain
> + */
Single line comment syntax is fine here.  Also drop the extra spaces before
Setting.

> +static int apds9160_set_als_int_time(struct apds9160_chip *data, int val)
> +{
> +	int ret;
> +	int idx;
> +
> +	ret = apds9160_set_als_rate(data, val);
> +	if (ret)
> +		return ret;
> +
> +	/* Match resolution register with rate */
> +	ret = apds9160_set_als_resolution(data, val);
> +	if (ret)
> +		return ret;
> +
> +	data->als_itime = val;
> +
> +	/* Set the scale minimum gain */
> +	for (idx = 0; idx < ARRAY_SIZE(apds9160_als_scale_map); idx++) {
> +		if (data->als_itime != apds9160_als_scale_map[idx].itime)
> +			continue;
> +
> +		return apds9160_set_als_scale(data,
> +				apds9160_als_scale_map[idx].scale1,
> +				apds9160_als_scale_map[idx].scale2);
> +	}
> +
> +	return -EINVAL;
> +}

>
> +
> +static int apds9160_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int val,
> +			      int val2, long mask)
> +{
> +	struct apds9160_chip *data = iio_priv(indio_dev);
> +
> +	guard(mutex)(&data->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		if (val2 != 0)
> +			return -EINVAL;
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			return apds9160_set_ps_rate(data, val);
> +		case IIO_LIGHT:
> +			return apds9160_set_als_int_time(data, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			return apds9160_set_ps_gain(data, val);
> +		case IIO_LIGHT:
> +			return apds9160_set_als_scale(data, val, val2);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		if (val2 != 0)
> +			return -EINVAL;
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			return apds9160_set_ps_cancellation_level(data, val);
> +		case IIO_CURRENT:
> +			return apds9160_set_ps_cancellation_current(data, val);

I can't figure out what this one actually is.

> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		if (val2 != 0)
> +			return -EINVAL;
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			return apds9160_set_ps_analog_cancellation(data, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_RAW:
> +		if (val2 != 0)
> +			return -EINVAL;
> +		switch (chan->type) {
> +		case IIO_CURRENT:
> +			return apds9160_set_ps_current(data, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}

