Return-Path: <linux-iio+bounces-26913-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C703CAB944
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 19:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 069723004CA0
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 18:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D612F2D94AC;
	Sun,  7 Dec 2025 18:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukALtdYH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D735272805;
	Sun,  7 Dec 2025 18:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765133546; cv=none; b=L8j+ruScu3oEfuWtUpeTO3EWsdzCctSfQtJCu0FSIqIfPLtvZSvcXrvcqKG39IWFQJGF0oI9wSqLgvxyfrXdR7JnrnisSVeuwZOVP/++c+7Fzc+niPEmZ9mEczpSuGAW8M75wwD7kc9fswzDDmHfQC4pbNsU8M3V1vSqH4OAkHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765133546; c=relaxed/simple;
	bh=Jl9xgbfPEfUyJdr1AfOMTKTT1iWVo8UXst339ZG/qjA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R8gged/+CA1V9/mW9jXhY2lRLKg/tPAx/lKfg5y7xbEjQMeuSjGBwSCJX+5SbWBhIZ9rGBDcWmI6mxkZGFQvafmdIw0Cq4vycUcDqyLl3QSx2GK/4jJVqu2mVp1HNG5LzLWLXFncQpSfiN2GSQ2PeqshKQu0egHnXfIzrFxbP38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukALtdYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B812C4CEFB;
	Sun,  7 Dec 2025 18:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765133546;
	bh=Jl9xgbfPEfUyJdr1AfOMTKTT1iWVo8UXst339ZG/qjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ukALtdYHQWoWQDNR3BInpMpcDtjO7cvS+YHwR8Ix/c5vgRDrnhGXCVREVn0rp9DWT
	 6dKkhEbHpIk0B6dZQ9pSHfMd+w9y/qL9eAlO/neoYFOOQG2OWIdMwRfWBCxophVmQa
	 C6WhRly425F8XGGmrRU6TDcJkKiQMqRognioh8b0rUNmX14e7gSK0o1GJDHXOjXmFx
	 Ff5z+WZWPMjJOpN0lCzLXWDE7jybWwh2yt+7zqUfTd8op7a8t/W2Ycs6cgbZN/Etis
	 ZUm7ldr3wvRkR9OR1NqsSzD+pUiFKgrXZKKeQAMuBRfhbXizSPp1zqlYrUiZ1Ktx6R
	 e8GXH8mjQCb6w==
Date: Sun, 7 Dec 2025 18:52:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 3/6] iio: add processed write API
Message-ID: <20251207185216.7498ab0f@jic23-huawei>
In-Reply-To: <20251124-ltm8054-driver-v4-3-107a8a814abe@bootlin.com>
References: <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
	<20251124-ltm8054-driver-v4-3-107a8a814abe@bootlin.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Nov 2025 15:48:07 +0100
Romain Gantois <romain.gantois@bootlin.com> wrote:

> Add a function to allow IIO consumers to write a processed value to a
> channel.
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
I'm lazy so I'll just ask the question rather than try to find an answer.
Is there any existing consumer of DAC channels that can use this?
It might be easier to land as a refactor than with the new driver and
reduce what is in the more controversial patch for the regulator.

Jonathan

> ---
>  drivers/iio/inkern.c         | 127 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iio/consumer.h |  36 ++++++++++++
>  2 files changed, 163 insertions(+)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 70b6f589f37a..6667e8e7648b 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -635,6 +635,54 @@ int iio_multiply_value(int *result, s64 multiplier,
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_multiply_value, "IIO_UNIT_TEST");
>  
> +int iio_divide_by_value(int *result, s64 numerator,
> +			unsigned int type, int val, int val2)
> +{
> +	s64 tmp_num, tmp_den;
> +
> +	switch (type) {
> +	case IIO_VAL_INT:
> +		tmp_num = numerator;
> +		tmp_den = val;
> +		break;
> +	case IIO_VAL_INT_PLUS_MICRO:
> +		tmp_num = numerator * MICRO;
> +		/* Cast inside abs() to avoid undefined behavior if val* == -INT_MIN. */
> +		tmp_den = abs((s64)val) * MICRO + abs((s64)val2);
> +
> +		if (val < 0 || val2 < 0)
> +			tmp_num *= -1;
> +
> +		break;
> +	case IIO_VAL_INT_PLUS_NANO:
> +		tmp_num = numerator * NANO;
> +		tmp_den = abs((s64)val) * NANO + abs((s64)val2);
> +
> +		if (val < 0 || val2 < 0)
> +			tmp_num *= -1;
> +
> +		break;
> +	case IIO_VAL_FRACTIONAL:
> +		tmp_num = (s64)numerator * (s64)val2;
> +		tmp_den = val;
> +		break;
> +	case IIO_VAL_FRACTIONAL_LOG2:
> +		tmp_num = (s64)numerator << val2;
> +		tmp_den = val;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (!tmp_den)
> +		return -EDOM;
> +
> +	*result = div64_s64(tmp_num, tmp_den);
> +
> +	return IIO_VAL_INT;
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_divide_by_value, "IIO_UNIT_TEST");
> +
>  static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
>  						 int raw, int *processed,
>  						 unsigned int scale)
> @@ -703,6 +751,66 @@ int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_convert_raw_to_processed, "IIO_CONSUMER");
>  
> +static int iio_convert_processed_to_raw_unlocked(struct iio_channel *chan,
> +						 int processed, int *raw,
> +						 unsigned int scale)
> +{
> +	int scale_type, scale_val, scale_val2;
> +	int offset_type, offset_val, offset_val2;
> +	int ret, half_step = 0;
> +
> +	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
> +				      IIO_CHAN_INFO_SCALE);
> +	if (scale_type >= 0) {
> +		ret = iio_divide_by_value(raw, processed, scale_type, scale_val, scale_val2);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		*raw = processed;
> +	}
> +
> +	if (!scale)
> +		return -EDOM;
> +
> +	*raw = div_s64(*raw, scale);
> +
> +	offset_type = iio_channel_read(chan, &offset_val, &offset_val2,
> +				       IIO_CHAN_INFO_OFFSET);
> +
> +	switch (offset_type) {
> +	case IIO_VAL_INT:
> +	case IIO_VAL_INT_PLUS_MICRO:
> +		half_step = MICRO / 2;
> +		break;
> +	case IIO_VAL_INT_PLUS_NANO:
> +		half_step = NANO / 2;
> +		break;
> +	case IIO_VAL_FRACTIONAL:
> +		offset_val = DIV_ROUND_CLOSEST(offset_val, offset_val2);
> +		break;
> +	case IIO_VAL_FRACTIONAL_LOG2:
> +		offset_val >>= offset_val2;
> +		break;
> +	default:
> +		if (offset_type >= 0)
> +			return -EINVAL;
> +
> +		offset_val = 0;
> +	}
> +
> +	/* Round fractional part to closest to reduce rounding bias. */
> +	if (half_step) {
> +		if (offset_val2 >= half_step)
> +			*raw -= 1;
> +		else if (offset_val2 <= -half_step)
> +			*raw += 1;
> +	}
> +
> +	*raw -= offset_val;
> +
> +	return 0;
> +}
> +
>  int iio_read_channel_attribute(struct iio_channel *chan, int *val, int *val2,
>  			       enum iio_chan_info_enum attribute)
>  {
> @@ -1039,3 +1147,22 @@ ssize_t iio_read_channel_label(struct iio_channel *chan, char *buf)
>  	return do_iio_read_channel_label(chan->indio_dev, chan->channel, buf);
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_read_channel_label, "IIO_CONSUMER");
> +
> +int iio_write_channel_processed_scale(struct iio_channel *chan, int val,
> +				      unsigned int scale)
> +{
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
> +	int ret, processed;
> +
> +	guard(mutex)(&iio_dev_opaque->info_exist_lock);
> +
> +	if (!chan->indio_dev->info)
> +		return -ENODEV;
> +
> +	ret = iio_convert_processed_to_raw_unlocked(chan, val, &processed, scale);
> +	if (ret)
> +		return ret;
> +
> +	return iio_channel_write(chan, processed, 0, IIO_CHAN_INFO_RAW);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_write_channel_processed_scale, "IIO_CONSUMER");
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index a38b277c2c02..f80ab1b80234 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -399,6 +399,24 @@ int iio_read_channel_scale(struct iio_channel *chan, int *val,
>  int iio_multiply_value(int *result, s64 multiplier,
>  		       unsigned int type, int val, int val2);
>  
> +/**
> + * iio_divide_by_value() - Divide by an IIO value
> + * @result:	Destination pointer for the division result
> + * @numerator:	Numerator.
> + * @type:	One of the %IIO_VAL_* constants. This decides how the @val
> + *		and @val2 parameters are interpreted.
> + * @val:	Denominator.
> + * @val2:	Denominator. @val2 use depends on type.
> + *
> + * Divide @numerator by an IIO value, storing the result as
> + * %IIO_VAL_INT. This is typically used for scaling.
> + *
> + * Returns:
> + * %IIO_VAL_INT on success or a negative error-number on failure.
> + */
> +int iio_divide_by_value(int *result, s64 numerator,
> +			unsigned int type, int val, int val2);
> +
>  /**
>   * iio_convert_raw_to_processed() - Converts a raw value to a processed value
>   * @chan:		The channel being queried
> @@ -469,4 +487,22 @@ ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
>   */
>  ssize_t iio_read_channel_label(struct iio_channel *chan, char *buf);
>  
> +/**
> + * iio_write_channel_processed_scale() - scale and write processed value to a given channel
> + * @chan:		The channel being queried.
> + * @val:		Value to write.
> + * @scale:		Processed value is divided by this scale factor during the conversion.
> + *
> + * This function writes a processed value to a channel. A processed value means
> + * that this value will have the correct unit and not some device internal
> + * representation. If the device does not support writing a processed value, the
> + * function will query the channel's scale and offset and write an appropriately
> + * transformed raw value.
> + *
> + * Returns:
> + * 0 or a negative error-number on failure.
> + */
> +int iio_write_channel_processed_scale(struct iio_channel *chan, int val,
> +				      unsigned int scale);
> +
>  #endif
> 


