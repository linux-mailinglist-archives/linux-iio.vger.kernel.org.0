Return-Path: <linux-iio+bounces-25790-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1909AC28D66
	for <lists+linux-iio@lfdr.de>; Sun, 02 Nov 2025 11:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F4BB4E3B15
	for <lists+linux-iio@lfdr.de>; Sun,  2 Nov 2025 10:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CA22264CD;
	Sun,  2 Nov 2025 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjjTEi+i"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8D1202F9C;
	Sun,  2 Nov 2025 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762079894; cv=none; b=oz3XC8swVVzkGevyIfbldx6XaSxpRBYb99H+rhvCgvnwb92ax0HtVXgXStr1lFQNx073rLnDdlWlVHJ0pU10PA/KHGoQckk8vJipkPx9rOz8W8gjoE1IX0okbG9Z1SC60OnZ0879QHrasdUZfKSbDdtzUWJAu/Uen3+9I2RbCSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762079894; c=relaxed/simple;
	bh=czP7YbvSnWl+QBZ/OpftcMTzFtBFis7UJczjWGygrcM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5nisl6u96NAxYfuHLZM19bzmtpGdHjOIvKXDQLFZ4a/p08h9yigJdgF8M8lYt3NPk4zRbTD1FeAjEjb/nf4n7kHIKR2xU3qeFJmpBuF95Xfbpnc2OaFyxssh/Sag2CJ2U0zzGbZCUiSaSBBz4zOxSwT+CIhLem437nw7VokdlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjjTEi+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20456C4CEF7;
	Sun,  2 Nov 2025 10:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762079893;
	bh=czP7YbvSnWl+QBZ/OpftcMTzFtBFis7UJczjWGygrcM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RjjTEi+in/b8qUlEHCg7pOsOqHggr4ahzQ7JA/tvckfZWyx67hZ9NydT6jawUBoPs
	 D/Che19cmK8iFqazo7DPrKgB8VbgenGJXu2Du6vjzBCdTku51SsxnJj3U3HZDEfkWL
	 T0I7Io0YCFrcgn5/hl64zEkY8vNZdOM2ix9YwUYts3XORYBMDB4YD5yiN3mR5QzjeU
	 grxbGE5n3SvOYIIfcKmQxC/Q+r0ZyWK9omeJpIehQjNBjHfG2XjsSEjIG6RAUpm5IP
	 s5yVXWIkXHBrL2d6XLPGiiP+iUt15QUhJTT9K2yoPI9H5Kp+tMmZPSu0pT8eznuYrM
	 kuFLR1Uq/PVHA==
Date: Sun, 2 Nov 2025 10:38:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: mpl3115: add threshold events support
Message-ID: <20251102103808.73cac929@jic23-huawei>
In-Reply-To: <20251031201821.88374-2-apokusinski01@gmail.com>
References: <20251031201821.88374-1-apokusinski01@gmail.com>
	<20251031201821.88374-2-apokusinski01@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 21:18:22 +0100
Antoni Pokusinski <apokusinski01@gmail.com> wrote:

> Add support for pressure and temperature rising threshold events. For
> both channels *_en and *_value (in raw units) attributes are exposed.
> 
> Since in write_event_config() the ctrl_reg1.active and ctrl_reg4
> are modified, accessing the data->ctrl_reg{1,4} in set_trigger_state()
> and write_event_config() needs to be now guarded by data->lock.
> Otherwise, it would be possible that 2 concurrent threads executing
> these functions would access the data->ctrl_reg{1,4} at the same time
> and then one would overwrite the other's result.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

Generally looks good to me, but some comments on the 24 bit value reading.

You got a lot of review quickly for this patch so I want to give some time
for follow up on v2 anyway. 

Thanks,

Jonathan


> ---
>  drivers/iio/pressure/mpl3115.c | 219 +++++++++++++++++++++++++++++++--
>  1 file changed, 209 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
> index c212dfdf59ff..472e9fd65776 100644
...
> @@ -347,15 +370,45 @@ static irqreturn_t mpl3115_interrupt_handler(int irq, void *private)
>  	struct iio_dev *indio_dev = private;
>  	struct mpl3115_data *data = iio_priv(indio_dev);
>  	int ret;
> +	__be32 val_press;
> +	__be16 val_temp;
>  
>  	ret = i2c_smbus_read_byte_data(data->client, MPL3115_INT_SOURCE);
>  	if (ret < 0)
>  		return IRQ_HANDLED;
>  
> -	if (!(ret & MPL3115_INT_SRC_DRDY))
> +	if (!(ret & (MPL3115_INT_SRC_TTH | MPL3115_INT_SRC_PTH |
> +		     MPL3115_INT_SRC_DRDY)))
>  		return IRQ_NONE;
>  
> -	iio_trigger_poll_nested(data->drdy_trig);
> +	if (ret & MPL3115_INT_SRC_DRDY)
> +		iio_trigger_poll_nested(data->drdy_trig);
> +
> +	if (ret & MPL3115_INT_SRC_PTH) {
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_PRESSURE, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_RISING),
> +						    iio_get_time_ns(indio_dev));
> +
> +		/* Reset the SRC_PTH bit in INT_SOURCE */
> +		i2c_smbus_read_i2c_block_data(data->client,
> +					      MPL3115_OUT_PRESS,
> +					      3, (u8 *)&val_press);

This is an oddity.  Why read into a __be32 when it's a 24bit number?
I guess it doesn't really matter as you just need a big enough space
and throw the value away.  However, I'd read it into a u8 [3]; then size off that
as well.

There are two existing cases of this in the driver. One of them should use
get_unaligned_be24 on a u8[3] buffer.  The other one is more complex as it's
reading directly into the scan buffer that gets pushed to the kfifo and is
reading into a u8 buffer ultimately anyway so at least there is no
real suggestion of it being 32 bits (just a +4 shift to deal with natural
alignment as the storage has to be power of 2 in that case.).

hmm. I think either we should tidy up the easy case (_read_info_raw) +
use a u8[3] here or just stick to this being odd.
My preference would be to have another patch tidying up the other case
+ use a u8[3] here.



> +	}
> +
> +	if (ret & MPL3115_INT_SRC_TTH) {
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_RISING),
> +						    iio_get_time_ns(indio_dev));
> +
> +		/* Reset the SRC_TTH bit in INT_SOURCE */
> +		i2c_smbus_read_i2c_block_data(data->client,
> +					      MPL3115_OUT_TEMP,
> +					      2, (u8 *)&val_temp);
> +	}
>  
>  	return IRQ_HANDLED;
>  }

> +
> +static int mpl3115_read_thresh(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       enum iio_event_type type,
> +			       enum iio_event_direction dir,
> +			       enum iio_event_info info,
> +			       int *val, int *val2)
> +{
> +	struct mpl3115_data *data = iio_priv(indio_dev);
> +	int ret;
> +	__be16 tmp;
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	switch (chan->type) {
> +	case IIO_PRESSURE:
> +		ret = i2c_smbus_read_i2c_block_data(data->client,
> +						    MPL3115_PRESS_TGT,
> +						    sizeof(tmp), (u8 *)&tmp);
> +		if (ret < 0)
> +			return ret;
> +
> +		/*
> +		 * Target value for the pressure is
> +		 * 16-bit unsigned value in 2 Pa units

Trivial but wrap comments to 80 char limit. Obviously doesn't really matter;
just a question of consistency.


> +		 */
> +		*val = be16_to_cpu(tmp) << 1;
> +
> +		return IIO_VAL_INT;
> +	case IIO_TEMP:
> +		ret = i2c_smbus_read_byte_data(data->client, MPL3115_TEMP_TGT);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Target value for the temperature is 8-bit 2's complement */
> +		*val = sign_extend32(ret, 7);
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mpl3115_write_thresh(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info,
> +				int val, int val2)
> +{
> +	struct mpl3115_data *data = iio_priv(indio_dev);
> +	__be16 tmp;
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	switch (chan->type) {
> +	case IIO_PRESSURE:
> +		val >>= 1;
> +
> +		if (val < 0 || val > U16_MAX)
> +			return -EINVAL;
> +
> +		tmp = cpu_to_be16(val);
> +
> +		return i2c_smbus_write_i2c_block_data(data->client,
> +						      MPL3115_PRESS_TGT,
> +						      sizeof(tmp), (u8 *)&tmp);
> +	case IIO_TEMP:
> +		if (val < S8_MIN || val > S8_MAX)
> +			return -EINVAL;
> +
> +		return i2c_smbus_write_byte_data(data->client,
> +						 MPL3115_TEMP_TGT, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}

