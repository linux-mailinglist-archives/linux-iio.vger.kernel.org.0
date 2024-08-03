Return-Path: <linux-iio+bounces-8198-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 749669469EF
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 15:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF84281ABD
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 13:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A1F14F9D0;
	Sat,  3 Aug 2024 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYcrXcWw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC09F49659;
	Sat,  3 Aug 2024 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722693522; cv=none; b=M3+0vIoPwMnAT19Dk9wXfWSerQ/KoBBb4oZdc5q/tJZ5cTMohqmmCk4+6OLx97mkNKnId3FD3lq0UZa9prYj92EONXWhwwXCXiBhCJwqvfW9SHtGxfPbg6jG8fwIyV8hhViR3I248wwc84z08lkF8C7bNrj6WSniBRDO2K4zT1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722693522; c=relaxed/simple;
	bh=AIeZbb0qUxCQ1LM+7ww/qViytruP6dlDAjaHpz/D+BI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQbnKcHwl7665Al8nQ3C7/AvMdlD/SZW/AgWJlNoA4Bdy9hVmjmUO8p3xE50V8IKabfnCSUvr4xkUWQsm4h0OIJtkD/ymiWSpPELm0KHJ8czHyhLh75zN91dNIhhb8052XS33fSWfgEpj6LiEuvWpIqfOypSk4rtO7hVVEZB5hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYcrXcWw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7B4C116B1;
	Sat,  3 Aug 2024 13:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722693522;
	bh=AIeZbb0qUxCQ1LM+7ww/qViytruP6dlDAjaHpz/D+BI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dYcrXcWws9dmrvoqXds0UjflzCZDu85f457RZA4wND5EMJP7UgvxNn5lhOEPQhAcM
	 eTxXVQ7dlLGzvfMfzviLEjzv6nG1tqOb8pfBMGgdQ6HbDgg1kmXlImoiH8OHQ3oN5w
	 Dd+ban79c86ENC2hhY94JPv0oWkGfoY+oQAZs3UzWAI0rMNRlcfAWZBX1iDRITFmyi
	 ig98dhOFfk8By5iDuiKWqKKVmFxrI7obbdSUopJJhe2LKRQbDUIrgIZh6Ha9SVgMCV
	 xt4q39nsrHM+9XfKmffAxR2EKtfgk5OUuY/LrlJM12xE0qXvpP+slAgMzdWTIY1RMX
	 ZZGQMHUCEa1Ew==
Date: Sat, 3 Aug 2024 14:58:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iio: light: apds9960: Add proximity and gesture
 offset calibration
Message-ID: <20240803145836.4e372899@jic23-huawei>
In-Reply-To: <20240801143857.16438-2-abhashkumarjha123@gmail.com>
References: <20240801143857.16438-1-abhashkumarjha123@gmail.com>
	<20240801143857.16438-2-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Aug 2024 20:08:57 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> Proximity and gesture offset registers perform offset correction to
> improve cross-talk performance. Added `calibbias` to the proximity
> and gesture channels.
> Provided facility to set calibbias based on the channel number.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>

I nearly applied this with tweaks, but I think there are enough improvements
that can be made to make it worth bouncing back to you one more time

Thanks,

Jonathan
> ---
>  drivers/iio/light/apds9960.c | 69 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index 1065a340b..e7f2e129c 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -146,6 +146,25 @@ struct apds9960_data {
>  
>  	/* gesture buffer */
>  	u8 buffer[4]; /* 4 8-bit channels */
> +
> +	/* calibration value buffer */
> +	int calibbias[5];
> +};
> +
> +enum {
> +	APDS9960_CHAN_PROXIMITY,
> +	APDS9960_CHAN_GESTURE_UP,
> +	APDS9960_CHAN_GESTURE_DOWN,
> +	APDS9960_CHAN_GESTURE_LEFT,
> +	APDS9960_CHAN_GESTURE_RIGHT,
> +};
> +
> +static const unsigned int apds9960_offset_regs[] = {
> +	[APDS9960_CHAN_PROXIMITY] = APDS9960_REG_POFFSET_UR,
As below - I don't think this needs to be looked up here as it's the only proximity
channel + we have two registers to over.

Either, make this a 2D array and include both registers + some code below
to only write a register if non zero, or drop the first entry. Fine to leave
it as 0 with a comment saying why.

Advantage of a 2D register with 1 or 2 addresses per channel is that you can
have just one code path below.

> +	[APDS9960_CHAN_GESTURE_UP] = APDS9960_REG_GOFFSET_U,
> +	[APDS9960_CHAN_GESTURE_DOWN] = APDS9960_REG_GOFFSET_D,
> +	[APDS9960_CHAN_GESTURE_LEFT] = APDS9960_REG_GOFFSET_L,
> +	[APDS9960_CHAN_GESTURE_RIGHT] = APDS9960_REG_GOFFSET_R,
>  };
>  
>  static const struct reg_default apds9960_reg_defaults[] = {
> @@ -255,6 +274,7 @@ static const struct iio_event_spec apds9960_als_event_spec[] = {
>  
>  #define APDS9960_GESTURE_CHANNEL(_dir, _si) { \
>  	.type = IIO_PROXIMITY, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBBIAS), \
>  	.channel = _si + 1, \
>  	.scan_index = _si, \
>  	.indexed = 1, \
> @@ -282,7 +302,8 @@ static const struct iio_chan_spec apds9960_channels[] = {
>  	{
>  		.type = IIO_PROXIMITY,
>  		.address = APDS9960_REG_PDATA,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_CALIBBIAS),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>  		.channel = 0,
>  		.indexed = 0,
> @@ -316,6 +337,42 @@ static const struct iio_chan_spec apds9960_channels[] = {
>  	APDS9960_INTENSITY_CHANNEL(BLUE),
>  };
>  
> +static int apds9960_set_calibbias(struct apds9960_data *data,
> +		struct iio_chan_spec const *chan, int calibbias)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	if (calibbias < S8_MIN || calibbias > S8_MAX)
> +		return -EINVAL;
> +
> +	guard(mutex)(&data->lock);
> +	switch (chan->channel) {
> +	case APDS9960_CHAN_PROXIMITY:
> +		/* We will be writing the calibbias value to both the */
> +		/* POFFSET_UR and POFFSET_DL registers */
Use multiline comment syntax.

		/*
		 * Write calibbias to both POFFSET_UR adn POFFSET_DL
		 * registers.
		 */

> +		reg = apds9960_offset_regs[chan->channel];
> +		ret = regmap_write(data->regmap, reg, calibbias);

I can't see an advantage in having the local variable reg.

Easier to just put the array inline.
		ret = regmap_write(data->regmap,
				   apds9960_offset_regs[chan->channel,
				   calibbias);

Mind you, this always hits the same register I think. So just
hardcode the value here.
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = regmap_write(data->regmap, APDS9960_REG_POFFSET_DL, calibbias);
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	default:
Use an explicit type here as will make it more readable.
Throw in a default with an error return just to make it clear there are
no other valid values.

As above, I'd suggest you can combine these two paths easily anyway 
by making the second write optional based on whether offset_regs[chan->channel][1] == 0
or not.

> +		/* For GOFFSET_x we will be writing to the */
> +		/* respective offset register */
Fix this comment as well.  Is it trying to say that unlike the above,
only only register is relevant?  I'm not sure that's worth saying
as it's pretty obvious from the code.

> +		reg = apds9960_offset_regs[chan->channel];
> +		ret = regmap_write(data->regmap, reg, calibbias);
Similar here.

> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	data->calibbias[chan->channel] = calibbias;
Blank line here.

> +	return 0;
> +}
> +
>  /* integration time in us */
>  static const int apds9960_int_time[][2] = {
>  	{ 28000, 246},
> @@ -531,6 +588,12 @@ static int apds9960_read_raw(struct iio_dev *indio_dev,
>  		}
>  		mutex_unlock(&data->lock);
>  		break;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		mutex_lock(&data->lock);
> +		*val = data->calibbias[chan->channel];
> +		ret = IIO_VAL_INT;

This driver would benefit a lot from use of guard() and scoped_guard()
but that isn't related to this patch beyond this function making
me take a look at read_raw.


> +		mutex_unlock(&data->lock);
> +		break;
>  	}
>  
>  	return ret;
> @@ -564,6 +627,10 @@ static int apds9960_write_raw(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		if (val2 != 0)
> +			return -EINVAL;
> +		return apds9960_set_calibbias(data, chan, val);
>  	default:
>  		return -EINVAL;
>  	}


