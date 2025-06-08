Return-Path: <linux-iio+bounces-20317-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDF9AD1336
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jun 2025 18:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA0E1699CE
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jun 2025 16:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA63B194C96;
	Sun,  8 Jun 2025 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xj8w+fMy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A25E3B19A;
	Sun,  8 Jun 2025 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749398910; cv=none; b=cioKllml9T7UmNNN/jdHWAfT8hZVwhfM0Ns2+b55jLBaR07iXKjcbmi98vGiMAlzfPjg93/bs1uAPfyisKMITvyH89JsOTmPPTHibNGIbfP++oD8zF2cJiqSX/7gXOrQEh/b6izb6YUV5pZiKBNhvwZF99gPQYD87K90QvsYNhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749398910; c=relaxed/simple;
	bh=zT8pfwQggTwjmmpDXtomNlqsYnWtwB9hIB8F6T6RC+E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asAoavyqFhBglrE7HJcySulLCzO7t7YOptH0wTPdBpMcaogOxly2B8mbfCLnpnVGUrFzFT45UXvfyrhiTQuo0vKjgImIjr/GiqNbdaImc55tyThvLXu3Tsrd1x/Bsc+wwqOSZYAtkHF6D57GwxAo3CsK72p8IVxj1i2HUJMCGX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xj8w+fMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E69DC4CEEE;
	Sun,  8 Jun 2025 16:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749398910;
	bh=zT8pfwQggTwjmmpDXtomNlqsYnWtwB9hIB8F6T6RC+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xj8w+fMyKv7xpICegf/+7VHdDm9sO30btmf3HpDcyvX23r097EtVi4JXHIXgd7WND
	 U+JlaHDLEEhqB/Z4jQaFmJyA/NeBYFS++fd9vgbeQQgUTy5h8RK7XRqgrxIOeUvqsa
	 JYXOQQQRQoXMGe0C2X9S0kUwnSDaEwTXiOHOpRmZE4f8SoUCwhjDd5XYvTzx4FPvfr
	 9upcldIwK9Og8I5u9dxGRVPD75kp9NLDxAUs3aQUI95mveS+iLJ9IrQf7dY9+G7R8y
	 6FVGGNpgupbDp3smUgEDnTv3ECNaurCWBUdmkqH1R/GE6AUgWCMcN7Bq5DvSRje2Br
	 zH2OSedBg4nqw==
Date: Sun, 8 Jun 2025 17:08:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, bagasdotme@gmail.com,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/11] iio: accel: adxl313: add activity sensing
Message-ID: <20250608170819.3de87f4e@jic23-huawei>
In-Reply-To: <20250601172139.59156-8-l.rubusch@gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
	<20250601172139.59156-8-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Jun 2025 17:21:35 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add possibilities to set a threshold for activity sensing. Extend the
> interrupt handler to process activity interrupts. Provide functions to set
> the activity threshold and to enable/disable activity sensing. Further add
> a fake channel for having x, y and z axis anded on the iio channel.
> 
> This is a preparatory patch. Some of the definitions and functions are
> supposed to be extended for inactivity later on.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

Hi Lothar,

My main question from this read through is whether we need to be quite
so careful on disabling measurement when configuring events.  It is rather
unusual if that is necessary and I'm not sure that's what the datasheet
is implying with the vague bit of advice.

>  static const unsigned long adxl313_scan_masks[] = {
> @@ -297,6 +331,68 @@ static int adxl313_read_freq_avail(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int adxl313_is_act_inact_en(struct adxl313_data *data,
> +				   enum adxl313_activity_type type)
> +{
> +	unsigned int axis_ctrl;
> +	unsigned int regval;
> +	int axis_en, int_en, ret;
> +
> +	ret = regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &axis_ctrl);
> +	if (ret)
> +		return ret;
> +
> +	/* Check if axis for activity are enabled */
> +	if (type != ADXL313_ACTIVITY)

As below - only one value possible, so don't check it.

> +		return 0;
> +
> +	axis_en = FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
> +
> +	/* The axis are enabled, now check if specific interrupt is enabled */
> +	ret = regmap_read(data->regmap, ADXL313_REG_INT_ENABLE, &regval);
> +	if (ret)
> +		return ret;
> +
> +	int_en = adxl313_act_int_reg[type] & regval;
> +
> +	return axis_en && int_en;
> +}
> +
> +static int adxl313_set_act_inact_en(struct adxl313_data *data,
> +				    enum adxl313_activity_type type,
> +				    bool cmd_en)
> +{
> +	unsigned int axis_ctrl;
> +	unsigned int threshold;
> +	int ret;
> +
> +	if (type != ADXL313_ACTIVITY)

As the enum only has one value you can drop this check.
Obviously it's dropped in next patch anyway but better to never
introduce it.

> +		return 0;
> +
> +	axis_ctrl = ADXL313_ACT_XYZ_EN;
> +
> +	ret = adxl313_set_measure_en(data, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_assign_bits(data->regmap, ADXL313_REG_ACT_INACT_CTL,
> +				 axis_ctrl, cmd_en);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, adxl313_act_thresh_reg[type], &threshold);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_assign_bits(data->regmap, ADXL313_REG_INT_ENABLE,
> +				 adxl313_act_int_reg[type],
> +				 cmd_en && threshold);
> +	if (ret)
> +		return ret;
> +
> +	return adxl313_set_measure_en(data, true);
> +}
> +
>  static int adxl313_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val, int *val2, long mask)
> @@ -370,6 +466,113 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
>  	}
>  }

> +
> +static int adxl313_read_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int *val, int *val2)
> +{
> +	struct adxl313_data *data = iio_priv(indio_dev);
> +	unsigned int act_threshold;
> +	int ret;
> +
> +	/* Measurement stays enabled, reading from regmap cache */

If it isn't safe to read whilst measurements are in progress (as opposed
to maybe getting a small variation in timing) then this seems more
fragile than I'd like (to future code changes for example).

Might need an explicit check on it being cached regcache_reg_cached()
for example though that is very rarely used which makes me dubious
about using it here.


> +
> +	if (type != IIO_EV_TYPE_MAG)
> +		return -EINVAL;
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		ret = regmap_read(data->regmap,
> +				  adxl313_act_thresh_reg[ADXL313_ACTIVITY],
> +				  &act_threshold);
> +		if (ret)
> +			return ret;
> +		*val = act_threshold * 15625;
> +		*val2 = MICRO;
> +		return IIO_VAL_FRACTIONAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int adxl313_write_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info,
> +				     int val, int val2)
> +{
> +	struct adxl313_data *data = iio_priv(indio_dev);
> +	unsigned int regval;
> +	int ret;
> +
> +	ret = adxl313_set_measure_en(data, false);
> +	if (ret)
> +		return ret;
> +
> +	if (type != IIO_EV_TYPE_MAG)
> +		return -EINVAL;
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	/* Scale factor 15.625 mg/LSB */
> +	regval = DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		ret = regmap_write(data->regmap,
> +				   adxl313_act_thresh_reg[ADXL313_ACTIVITY],
> +				   regval);

I'm surprised this can only be set with measurement disabled.
Maybe a spec reference.   It's common to tweak event values as events
come in and we generally don't have to stop data flow whilst we do.

There are a few specific bits where the datasheet suggests updating
them has unwanted side effects in measurement mode.  + there is a general
suggestion to do configuration before enabling measurement mode.  
I don't see anything saying it is a problem for this register.

> +		if (ret)
> +			return ret;
> +		return adxl313_set_measure_en(data, true);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int adxl313_set_watermark(struct iio_dev *indio_dev, unsigned int value)
>  {
>  	struct adxl313_data *data = iio_priv(indio_dev);
> @@ -502,19 +705,32 @@ static int adxl313_fifo_push(struct iio_dev *indio_dev, int samples)
>  
>  static int adxl313_push_event(struct iio_dev *indio_dev, int int_stat)

Ah. This does not also have events.  Still it's a mix, so maybe
adxl313_handle_interrupts() or something like that.

>  {
> +	s64 ts = iio_get_time_ns(indio_dev);
>  	struct adxl313_data *data = iio_priv(indio_dev);
>  	int samples;
> +	int ret = -ENOENT;
> +
> +	if (FIELD_GET(ADXL313_INT_ACTIVITY, int_stat)) {
> +		ret = iio_push_event(indio_dev,
> +				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> +							IIO_MOD_X_OR_Y_OR_Z,
> +							IIO_EV_TYPE_MAG,
> +							IIO_EV_DIR_RISING),
> +				     ts);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	if (FIELD_GET(ADXL313_INT_WATERMARK, int_stat)) {
>  		samples = adxl313_get_samples(data);
>  		if (samples < 0)
>  			return samples;
>  
> -		return adxl313_fifo_push(indio_dev, samples);
> +		ret = adxl313_fifo_push(indio_dev, samples);
>  	}
>  
>  	/* Return error if no event data was pushed to the IIO channel. */
> -	return -ENOENT;
> +	return ret;
This handling works, but as Andy observed maybe the comment is now confusing
given ret is mostly not an error.  Perhaps put that where ret is declared
instead, or use a separate mask check at the start to quickly
error out if no bits that we handle are set.
>  }

