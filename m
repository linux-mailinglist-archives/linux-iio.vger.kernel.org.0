Return-Path: <linux-iio+bounces-14843-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF587A24AF9
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 18:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5806E163516
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 17:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EF21C5F34;
	Sat,  1 Feb 2025 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxYKYMet"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5889208A9;
	Sat,  1 Feb 2025 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738430161; cv=none; b=dPXOUZlShr7NFrir8KfyX8UZS7XN/TaNg2FLosXBsjQvt4AaCqf1hFYdjzWzvXl8eCRWuEY9ewGZbUNobk3tt8KnHAu7Ll6AY93UVQBAdj0umWRzoacFKlSlWDPVqstZnlJhOqhuA3D28gY126iIgmp7VUtkjcHrivETrzI8xPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738430161; c=relaxed/simple;
	bh=bgrXXXcGjP/WRJpUP2Ix1RjH9C2C4mzFNjDc81oneAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BeXkTEr8TQlLBk3XXTAZPgg9RY2jfMzDe6YjGz3+wtN9ADP2BTJkqHys3t9R3U9upxolqCIIOMB4TvJ81kdNTw62NS7MKE89596yHPXXz6R/tLoniKYTy7xYQFjUvWPSl/8th1Gxb6lJHT44DS47FAz7RFQkFclsVB+TF1Kde+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxYKYMet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7064C4CED3;
	Sat,  1 Feb 2025 17:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738430161;
	bh=bgrXXXcGjP/WRJpUP2Ix1RjH9C2C4mzFNjDc81oneAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MxYKYMethFy2xKIfJMOOUWJzcjf/FpvNxzWkfdVQJM6vboC9uqiT/atkujiBtO3ps
	 /mbSu4TpRZOcFmjjv7lboY2wlYfsDq8rPdQkaWYa/dXf4HuEeMACtBqAJuR1Roy9NS
	 5aC/oGB4clttJiodJtvoXkuPCT2+dQWGvycKaSsyevKS5yzJNF6YBcB82xl46clSan
	 3kLtrwJMok0OAkxKsTAEKwH/AsLjJWGDUgliqGaKaQO/MxInnuMwS6dUnzQ1q3e1n7
	 dOLWvgt6EmHhcCOBN+2WA/fB31EvnfuQXR4D/1LEk72XmqgTZL2kQhIeSCAQo61j/V
	 1pkSyiEJ/B+jQ==
Date: Sat, 1 Feb 2025 17:15:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v1 08/12] iio: accel: adxl345: add double tap feature
Message-ID: <20250201171555.186136c1@jic23-huawei>
In-Reply-To: <20250128120100.205523-9-l.rubusch@gmail.com>
References: <20250128120100.205523-1-l.rubusch@gmail.com>
	<20250128120100.205523-9-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 12:00:56 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the double tap feature of the sensor. The interrupt handler needs
> to catch and forwared the event to the IIO channel. The single tap
> implementation now is extended to deal with double tap as well.
As with earlier patch, new ABI must be documented.  Also we need
a strong argument why the existing ABI is not suitable.

Tap detection algorithms are annoyingly specific to manufacturers
but we did make an effort to come up with a general description a
while back so I'd hope perhaps we can map to that.

> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 139 ++++++++++++++++++++++++++++---
>  1 file changed, 127 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 7831ec511941..f9e5f47ba303 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -129,6 +129,29 @@ enum adxl345_axis {
>  	ADXL345_TAP_SUPPRESS = BIT(3),
>  };
>  
> +/* single/double tap */
> +enum adxl345_tap_type {
> +	ADXL345_SINGLE_TAP,
> +	ADXL345_DOUBLE_TAP
trailing comma. Maybe there will be a triple tap sometime.
Anyhow, other than 'terminating' entries we should always have trailing commas.

> +};
> +
> +static const unsigned int adxl345_tap_int_reg[2] = {
> +	[ADXL345_SINGLE_TAP] = ADXL345_INT_SINGLE_TAP,
> +	[ADXL345_DOUBLE_TAP] = ADXL345_INT_DOUBLE_TAP,
> +};
> +
> +enum adxl345_tap_time_type {
> +	ADXL345_TAP_TIME_LATENT,
> +	ADXL345_TAP_TIME_WINDOW,
> +	ADXL345_TAP_TIME_DUR
Comma.

> +};
> +
> +static const unsigned int adxl345_tap_time_reg[3] = {
> +	[ADXL345_TAP_TIME_LATENT] = ADXL345_REG_LATENT,
> +	[ADXL345_TAP_TIME_WINDOW] = ADXL345_REG_WINDOW,
> +	[ADXL345_TAP_TIME_DUR] = ADXL345_REG_DUR,
> +};
> +
>  struct adxl345_state {
>  	const struct adxl345_chip_info *info;
>  	struct regmap *regmap;
> @@ -142,6 +165,8 @@ struct adxl345_state {
>  	u32 tap_axis_ctrl;
>  	u8 tap_threshold;
>  	u32 tap_duration_us;
> +	u32 tap_latent_us;
> +	u32 tap_window_us;
>  
>  	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
>  };
> @@ -154,6 +179,12 @@ static struct iio_event_spec adxl345_events[] = {
>  		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
>  		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
>  	},
> +	{
> +		/* double tap */
> +		.type = IIO_EV_TYPE_GESTURE,
> +		.dir = IIO_EV_DIR_DOUBLETAP,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),
> +	},
>  };
>  
>  #define ADXL345_CHANNEL(index, reg, axis) {					\
> @@ -250,10 +281,12 @@ static int adxl345_write_tap_axis(struct adxl345_state *st,
>  					     st->tap_axis_ctrl));
>  }
>  

> -static int adxl345_is_tap_en(struct adxl345_state *st, bool *en)
> +static int adxl345_is_tap_en(struct adxl345_state *st,
> +			     enum adxl345_tap_type type, bool *en)
>  {
>  	int ret;
>  	unsigned int regval;
> @@ -280,7 +323,8 @@ static int adxl345_is_tap_en(struct adxl345_state *st, bool *en)
>  	if (ret)
>  		return ret;
>  
> -	*en = FIELD_GET(ADXL345_INT_SINGLE_TAP, regval) > 0;
> +	// TODO FIELD_GET() seems not possible here due to construct 'not const', any ideas?

There is a new function to solve this proposed on list, but not upstream yet.
For now roll your own as you have done.


> +	*en = (adxl345_tap_int_reg[type] & regval) > 0;
>  
>  	return 0;
>  }
> @@ -294,7 +338,12 @@ static int adxl345_set_singletap_en(struct adxl345_state *st,
>  	if (ret)
>  		return ret;
>  
> -	return _adxl345_set_tap_int(st, en);
> +	return _adxl345_set_tap_int(st, ADXL345_SINGLE_TAP, en);
> +}
> +
> +static int adxl345_set_doubletap_en(struct adxl345_state *st, bool en)
> +{
> +	return _adxl345_set_tap_int(st, ADXL345_DOUBLE_TAP, en);
>  }
>  
>  static int adxl345_set_tap_value(struct adxl345_state *st, u8 val)
> @@ -304,19 +353,33 @@ static int adxl345_set_tap_value(struct adxl345_state *st, u8 val)
>  	return regmap_write(st->regmap, ADXL345_REG_THRESH_TAP, min(val, 0xFF));
>  }
>  
> -static int _adxl345_set_tap_time(struct adxl345_state *st, u32 val_us)
> +static int _adxl345_set_tap_time(struct adxl345_state *st,
> +				 enum adxl345_tap_time_type type, u32 val_us)
>  {
>  	unsigned int regval;
>  
> -	st->tap_duration_us = val_us;
> +	switch (type) {
> +	case ADXL345_TAP_TIME_WINDOW:
> +		st->tap_window_us = val_us;
> +		break;
> +	case ADXL345_TAP_TIME_LATENT:
> +		st->tap_latent_us = val_us;
> +		break;
> +	case ADXL345_TAP_TIME_DUR:
> +		st->tap_duration_us = val_us;
> +		break;
> +	}
>  
>  	/*
>  	 * The scale factor is 1250us / LSB for tap_window_us and tap_latent_us.
>  	 * For tap_duration_us the scale factor is 625us / LSB.
>  	 */
> -	regval = DIV_ROUND_CLOSEST(val_us, 625);
> +	if (type == ADXL345_TAP_TIME_DUR)
> +		regval = DIV_ROUND_CLOSEST(val_us, 625);
> +	else
> +		regval = DIV_ROUND_CLOSEST(val_us, 1250);
>  
> -	return regmap_write(st->regmap, ADXL345_REG_DUR, regval);
> +	return regmap_write(st->regmap, adxl345_tap_time_reg[type], regval);
Use this in the earlier patch, even though it would only have one entry at that point.
There is little point in introducing infrastructure that rewrites a patch
just after that patch.  Just put it in the first one with a note
saying it is useful shortly.

>  }
>  
>  static int adxl345_set_tap_duration(struct adxl345_state *st, u32 val_int,
> @@ -330,7 +393,35 @@ static int adxl345_set_tap_duration(struct adxl345_state *st, u32 val_int,
>  	if (val_int || val_fract_us > 159375)
>  		return -EINVAL;
>  
> -	return _adxl345_set_tap_time(st, val_fract_us);
> +	return _adxl345_set_tap_time(st, ADXL345_TAP_TIME_DUR, val_fract_us);
> +}

> @@ -637,9 +735,13 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
>  	static IIO_DEVICE_ATTR_RW(in_accel_##A##_##C##_##E, 0)
>  
>  ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_singletap, tap, duration, MICRO, us);
> +ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_doubletap, tap, window, MICRO, us);
> +ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_doubletap, tap, latent, MICRO, us);
>  
>  static struct attribute *adxl345_event_attrs[] = {
>  	&iio_dev_attr_in_accel_gesture_singletap_duration_us.dev_attr.attr,
> +	&iio_dev_attr_in_accel_gesture_doubletap_latent_us.dev_attr.attr,
> +	&iio_dev_attr_in_accel_gesture_doubletap_window_us.dev_attr.attr,

As above.  ABI docs missing and times in IIO are all seconds.  us to seconds is easy
given you just use the formatting functions and pass val == 0.

>  	NULL
>  };
>  
> @@ -861,6 +963,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
>  			return ret;
>  	}
>  
> +	if (FIELD_GET(ADXL345_INT_DOUBLE_TAP, int_stat)) {
> +		ret = iio_push_event(indio_dev,
> +				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> +							act_tap_dir,
> +							IIO_EV_TYPE_GESTURE,
> +							IIO_EV_DIR_DOUBLETAP),
> +				     ts);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return -ENOENT;
>  }
>  
> @@ -965,6 +1078,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	/* Init with reasonable values */
>  	st->tap_threshold = 35;			/*   35 [0x23]            */
>  	st->tap_duration_us = 3;		/*    3 [0x03] -> .001875 */
> +	st->tap_window_us = 20;			/*   20 [0x14] -> .025    */
> +	st->tap_latent_us = 20;			/*   20 [0x14] -> .025    */
>  
>  	indio_dev->name = st->info->name;
>  	indio_dev->info = &adxl345_info;


