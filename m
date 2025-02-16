Return-Path: <linux-iio+bounces-15598-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74143A3763D
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 18:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1A41699A0
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C901917E7;
	Sun, 16 Feb 2025 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HV1cJUkR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33282D299;
	Sun, 16 Feb 2025 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739726465; cv=none; b=ldzXia+v7ZbZ0dPPapJWKGM4qgNIZfQeGKv0AD1ly/dP8/27M10gCPRRypW4P9oZ52HhfQVtvvw55Htl01YMyGhUnWAUNkoROfdvS+k2tOsa6dblRfBOFnd7kpUsJZGc1s0R/SBd9YC87WLHR5ywbYQ4f6EbE4ZUAnsoE7hc1As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739726465; c=relaxed/simple;
	bh=MHq3kMKa00oyKeoaHt+9nyh3DovVEdbm0uCyx2ZDbxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SX1QRZo7uONaeMHTlREYzwbcOO8AyyA595uxW/Rza0JqU/5Lsc/dAwBN74OP+H+c7KXcTqub9/HPe5lMYofyX1k5zv5S5Lve4hyxa3sN1EjvZpKhyClwy4hn2aHcNJ+349NQl2QRv9FFw2GwNeGSaU3Uq1fQBvA/fHKd+gpOHQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HV1cJUkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6708C4CEDD;
	Sun, 16 Feb 2025 17:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739726464;
	bh=MHq3kMKa00oyKeoaHt+9nyh3DovVEdbm0uCyx2ZDbxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HV1cJUkRIbVHUAHkdWTDHW9jM5LutR2OddM4FyP2PmqDGWw+t9fk6HMfOU+SV9jwr
	 hiKtHVmQZPoJBOkambzZ65SJ8Seg3mKKfC5ndlO5s+DcSzd6nAXg8AVxluY25O7DxZ
	 JGR8H9o2Z38gwuIt/ruEeIEZfyluDSmvhmB8S1oO5HtB84B6mYWrTQCwoUkq/oeL8f
	 GSU92lKHq5tJoeUkPh77G3T38QOQ4bYj3rllgqz5kqDD+9f5gTWu+wlMsxxV94FPQw
	 d1uRCNEYEjU6kraaWKNd9wKa67HT/zWWnpkGcznvYzE4Eu5CwQk37M6DgQT25hRfwJ
	 9TFccfILO13qQ==
Date: Sun, 16 Feb 2025 17:20:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 05/14] iio: accel: adxl345: add single tap feature
Message-ID: <20250216172056.37762336@jic23-huawei>
In-Reply-To: <20250210110119.260858-6-l.rubusch@gmail.com>
References: <20250210110119.260858-1-l.rubusch@gmail.com>
	<20250210110119.260858-6-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 11:01:10 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the single tap feature with a threshold in 62.5mg/LSB points and a
> scaled duration in us. Keep singletap threshold and duration using means
> of IIO ABI. Extend the channels for single enable x/y/z axis of the
> feature but also initialize threshold and duration with reasonable
> content. When an interrupt is caught it will be pushed to the according
> IIO channel.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Hi Lothar,

Various comments inline,

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adxl345_core.c | 369 ++++++++++++++++++++++++++++++-
>  1 file changed, 367 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 910ad21279ed..304147a4ca60 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -8,6 +8,7 @@
>   */

> +};
> +
> +static const unsigned int adxl345_tap_int_reg[2] = {

Why force 2?  Just use []

> +	[ADXL345_SINGLE_TAP] = ADXL345_INT_SINGLE_TAP,
> +};
> +
> +enum adxl345_tap_time_type {
> +	ADXL345_TAP_TIME_DUR,
> +};
> +
> +static const unsigned int adxl345_tap_time_reg[3] = {
Why force 3?
> +	[ADXL345_TAP_TIME_DUR] = ADXL345_REG_DUR,
> +};

> +static int _adxl345_set_tap_int(struct adxl345_state *st,
> +				enum adxl345_tap_type type, bool state)
> +{
> +	bool axis_valid;
> +	bool singletap_args_valid = false;
> +	bool en = false;
> +
> +	axis_valid = FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, st->tap_axis_ctrl) > 0;
> +
> +	/*
> +	 * Note: A value of 0 for threshold and/or dur may result in undesirable
> +	 *	 behavior if single tap/double tap interrupts are enabled.
> +	 */
> +	singletap_args_valid = st->tap_threshold > 0 && st->tap_duration_us > 0;
> +
> +	if (type == ADXL345_SINGLE_TAP)
> +		en = axis_valid && singletap_args_valid;
> +
> +	if (state && en)
> +		__set_bit(ilog2(adxl345_tap_int_reg[type]),
> +			  (unsigned long *)&st->int_map);

That's not a good idea (I think I probably mislead you here). Casting
across integer pointer types isn't a good way to go.

> +	else
> +		__clear_bit(ilog2(adxl345_tap_int_reg[type]),
> +			    (unsigned long *)&st->int_map);
> +
> +	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_map);

As in previous, if we rely on the regmap cache then can just use
the regmap_set_bit() regmap_clear_bit() type helpers here.

> +}
>
> +static int adxl345_read_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
> +{
> +	struct adxl345_state *st = iio_priv(indio_dev);
> +	bool int_en;
> +	bool axis_en;
> +	int ret = -EFAULT;
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_GESTURE:
> +		switch (chan->channel2) {
> +		case IIO_MOD_X:
> +			axis_en = FIELD_GET(ADXL345_X_EN, st->tap_axis_ctrl);
> +			break;
> +		case IIO_MOD_Y:
> +			axis_en = FIELD_GET(ADXL345_Y_EN, st->tap_axis_ctrl);
> +			break;
> +		case IIO_MOD_Z:
> +			axis_en = FIELD_GET(ADXL345_Z_EN, st->tap_axis_ctrl);
> +			break;
> +		default:
> +			axis_en = ADXL345_TAP_SUPPRESS;

Add a break here.  Not strictly necessary but hardens against odd code
changes in future.

> +		}
> +
> +		switch (dir) {
> +		case IIO_EV_DIR_SINGLETAP:
> +			ret = adxl345_is_tap_en(st, ADXL345_SINGLE_TAP, &int_en);
> +			if (ret)
> +				return ret;
> +			return int_en && axis_en;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int adxl345_read_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
> +				    enum iio_event_type type, enum iio_event_direction dir,
> +				    enum iio_event_info info, int *val, int *val2)

My general preference in IIO is to keep to older 80 char line wrap limit unless
longer lines help readability. Even then try to keep them only a little longer.
So I'd prefer these parameters wrapped a bit more!

> +{

> -static int adxl345_get_status(struct adxl345_state *st, unsigned int *int_stat)
> +static int adxl345_get_status(struct adxl345_state *st, unsigned int *int_stat,
> +			      enum iio_modifier *act_tap_dir)
>  {
> +	unsigned int regval;
> +	bool check_tap_stat;
> +	int ret;
> +
> +	*act_tap_dir = IIO_NO_MOD;
> +	check_tap_stat = FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, st->tap_axis_ctrl) > 0;
> +
> +	if (check_tap_stat) {
> +		/* ACT_TAP_STATUS should be read before clearing the interrupt */
> +		ret = regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATUS, &regval);
> +		if (ret)
> +			return ret;
> +

This double bit pattern is odd enough that I think it needs a comment or
separate defines for the ACT_X source and TAP_X source

> +		if ((FIELD_GET(ADXL345_Z_EN, regval >> 4)
> +				| FIELD_GET(ADXL345_Z_EN, regval)) > 0)
> +			*act_tap_dir = IIO_MOD_Z;
> +		else if ((FIELD_GET(ADXL345_Y_EN, regval >> 4)
> +				| FIELD_GET(ADXL345_Y_EN, regval)) > 0)
> +			*act_tap_dir = IIO_MOD_Y;
> +		else if ((FIELD_GET(ADXL345_X_EN, regval >> 4)
> +				| FIELD_GET(ADXL345_X_EN, regval)) > 0)
> +			*act_tap_dir = IIO_MOD_X;
> +	}
> +



