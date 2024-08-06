Return-Path: <linux-iio+bounces-8296-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C52949603
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 18:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6FB1F22E03
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 16:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A974F46444;
	Tue,  6 Aug 2024 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Re7LeUep"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6415044C81;
	Tue,  6 Aug 2024 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963557; cv=none; b=LwkLdg5vwhyfvgfRFMwnF1xLfof0IO4xQrPrjTAAdJ63nvitdvDw+fL1F/xgY98yx0TpC4p7Jhl66Ewdp/pHhSONjMTKTe/RT8Gwu0+dB3gNGX5TJMlvhRbdCvPksCBDPl36gI8y5ibimbPQGxqlX9vuw6yW59NQBkCNSDfoW2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963557; c=relaxed/simple;
	bh=38J3+Jcs1Gxd5oy/NKLXe7MSNL7iDXRXE5dsHskGipk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVVHr9Sdyzs74XqVAfar7AN5p09nwW1sQGNNiffZIW7hinw5IsQo76tlvK7Kpdgr04mIaNrSvhsbobAueVUIWxlTXdpntLxk0954KX8inniTw0QmAo/x4xadqUNfU9ZEObM4FNX0/Mjg1a7EUsdb8mNZQY0XmgIKK8Zp01bvGJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Re7LeUep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D44C32786;
	Tue,  6 Aug 2024 16:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722963557;
	bh=38J3+Jcs1Gxd5oy/NKLXe7MSNL7iDXRXE5dsHskGipk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Re7LeUeplr1KvqRTcs5SV9nQfIjcSgNSSgs98uebgSybqNNN4bv5ys01Bfg20+vsr
	 V5/TXEaS6Xizqg91pWRUXv+xWnxBnI4cP7a4rI/iNgOHYcf5wZfFmJ37TMzwM2Geir
	 2wbWLoW3gkEf9BSf83Qt0MTrpc7o48K3ESQyDkyAxRE2YQjLWzrC4SpsZ4B86RmPeq
	 BEW1Bnf5jN+nG90e8oFFEDUSSPe6zmVYTSJdubTU0mjwSlcO0lUsHmDlRSNLMZm3XZ
	 Om7VVM+NBKpETD4tLruyB1Cpn6DsmrRsZlQYcX5Dx3eqjVt3wsNFqvvYENiIhCo50A
	 BO2FSny73sYBw==
Date: Tue, 6 Aug 2024 17:59:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] iio: light: apds9960: Add proximity and gesture
 offset calibration
Message-ID: <20240806175910.3e0b5ab9@jic23-huawei>
In-Reply-To: <20240804134212.51682-2-abhashkumarjha123@gmail.com>
References: <20240804134212.51682-1-abhashkumarjha123@gmail.com>
	<20240804134212.51682-2-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  4 Aug 2024 19:12:12 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> Proximity and gesture offset registers perform offset correction to
> improve cross-talk performance. Added `calibbias` to the proximity
> and gesture channels.
> Provided facility to set calibbias based on the channel number.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
Hi Abhash,

LGTM. Applied to the togreg branch of iio.git and pushed out as testing
for 0-day (build bot) to take a look at it and see if it can find anything
we missed.

Thanks,

Jonathan

> ---
>  drivers/iio/light/apds9960.c | 55 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index 1065a340b..bc966b096 100644
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
> +static const unsigned int apds9960_offset_regs[][2] = {
> +	[APDS9960_CHAN_PROXIMITY] = {APDS9960_REG_POFFSET_UR, APDS9960_REG_POFFSET_DL},
> +	[APDS9960_CHAN_GESTURE_UP] = {APDS9960_REG_GOFFSET_U, 0},
> +	[APDS9960_CHAN_GESTURE_DOWN] = {APDS9960_REG_GOFFSET_D, 0},
> +	[APDS9960_CHAN_GESTURE_LEFT] = {APDS9960_REG_GOFFSET_L, 0},
> +	[APDS9960_CHAN_GESTURE_RIGHT] = {APDS9960_REG_GOFFSET_R, 0},
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
> @@ -316,6 +337,28 @@ static const struct iio_chan_spec apds9960_channels[] = {
>  	APDS9960_INTENSITY_CHANNEL(BLUE),
>  };
>  
> +static int apds9960_set_calibbias(struct apds9960_data *data,
> +		struct iio_chan_spec const *chan, int calibbias)
> +{
> +	int ret, i;
> +
> +	if (calibbias < S8_MIN || calibbias > S8_MAX)
> +		return -EINVAL;
> +
> +	guard(mutex)(&data->lock);
> +	for (i = 0; i < 2; i++) {
> +		if (apds9960_offset_regs[chan->channel][i] == 0)
> +			break;
> +
> +		ret = regmap_write(data->regmap, apds9960_offset_regs[chan->channel][i], calibbias);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	data->calibbias[chan->channel] = calibbias;
> +
> +	return 0;
> +}
> +
>  /* integration time in us */
>  static const int apds9960_int_time[][2] = {
>  	{ 28000, 246},
> @@ -531,6 +574,12 @@ static int apds9960_read_raw(struct iio_dev *indio_dev,
>  		}
>  		mutex_unlock(&data->lock);
>  		break;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		mutex_lock(&data->lock);
> +		*val = data->calibbias[chan->channel];
> +		ret = IIO_VAL_INT;
> +		mutex_unlock(&data->lock);
> +		break;
>  	}
>  
>  	return ret;
> @@ -564,6 +613,10 @@ static int apds9960_write_raw(struct iio_dev *indio_dev,
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


