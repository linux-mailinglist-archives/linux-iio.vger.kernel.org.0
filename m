Return-Path: <linux-iio+bounces-10178-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E317D99185E
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 18:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216771C210CD
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 16:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215EF157492;
	Sat,  5 Oct 2024 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3UHgaNc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C995A1CF96;
	Sat,  5 Oct 2024 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728146538; cv=none; b=gHdFbNatMaASXgt5Fue7ea0mKGdyX7jNj5PHTR0lUEIkU78CNesXXNyLXHx4yKkzZd3kvetMumVvyDHkZcgZkIVA01lgGG4KWM22dfSHt8qXCP5xvl3QtQbjfZtBlMJzPTfR7PwcuAUlmiHeIM3nJsW6qh4a9sS2KumzEXAfKpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728146538; c=relaxed/simple;
	bh=0Na0lFgZP18CB/jmqpHLoKSLvsmnXq9BLBngfsBByL0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAyEMX3ngKHidnpxvHR2zhJHU6/u0EPp3uNjKby4wYLw595NGYh8Dl9vAZW6uW/36eYAKRkIrPwZDVWqIwEArUvnAvqjY+dU1WwEtEJPxZGlo828SAHCtBQWWjKJfkP1Kv/kJ9P+8uLZ58tu+lIqLbTHaAGBsErj5UxfqAhb+58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3UHgaNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44C2C4CEC2;
	Sat,  5 Oct 2024 16:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728146538;
	bh=0Na0lFgZP18CB/jmqpHLoKSLvsmnXq9BLBngfsBByL0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W3UHgaNcJMDm4+dM4wX+9QheXfKrycgze74VhmlZ1qhfbiqLgfaA5o3OvqUMsJ48b
	 akCSKXR/WNk39B8tAVzdGFKM6hfAUsvnQ2G3fSHjtbGrwh2ruq0B5hBGDGE481HJFw
	 xhLwXikz/U2T3j7nzPdv77qGn+phRGALzEMUEfJuJKsLjbiHL+8MbKyIqeoJnPNmf1
	 G4PMoaPQ8wZ2uk7dyhTwQSb539a1QvYtd5+UFl953XbKwDICAOT8WPauuVWqm2lvj9
	 ECq3eERedx3bJLyTxSDsKTUkWPxu6a7FJZhpfMYMgciXsMG+HeQ8y5Dqn1WYFxIZCM
	 JLvER/GQSf9eg==
Date: Sat, 5 Oct 2024 17:41:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: light: vl6180: Add configurable
 inter-measurement period support
Message-ID: <20241005174151.4bcd55f6@jic23-huawei>
In-Reply-To: <20241004150148.14033-2-abhashkumarjha123@gmail.com>
References: <20241004150148.14033-1-abhashkumarjha123@gmail.com>
	<20241004150148.14033-2-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Oct 2024 20:31:46 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> Expose the IIO_CHAN_INFO_SAMP_FREQ attribute as a way to configure the
> inter-measurement period for both the IIO_DISTANCE and IIO_LIGHT
> channels. The inter-measurement period must be given in miliseconds.

Hi Abhash,

Sampling frequency must be in Hz and reflect how often the channel
is sampled (not just the inter measurement period.  So this sounds wrong.
It is sometimes complex to compute but we have to stick to the documented
ABI.

Other comments inline.

Thanks

Jonathan

> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>


> @@ -412,11 +430,22 @@ static int vl6180_set_it(struct vl6180_data *data, int val, int val2)
>  	return ret;
>  }
>  
> +static int vl6180_meas_reg_val_from_ms(unsigned int period)
> +{
> +	unsigned int reg_val = 0;
> +
> +	if (period > 10)
> +		reg_val = period < 2550 ? (DIV_ROUND_CLOSEST(period, 10) - 1) : 254;
> +
> +	return reg_val;
> +}
> +
>  static int vl6180_write_raw(struct iio_dev *indio_dev,
>  			     struct iio_chan_spec const *chan,
>  			     int val, int val2, long mask)
>  {
>  	struct vl6180_data *data = iio_priv(indio_dev);
> +	unsigned int reg_val;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_INT_TIME:
> @@ -427,6 +456,24 @@ static int vl6180_write_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  
>  		return vl6180_set_als_gain(data, val, val2);
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
	{

needed to define scope for that guard as you probably intend.

> +		guard(mutex)(&data->lock);
> +		switch (chan->type) {
> +		case IIO_DISTANCE:
> +			data->range_meas_rate = val;
> +			reg_val = vl6180_meas_reg_val_from_ms(val);
> +			return vl6180_write_byte(data->client, VL6180_RANGE_INTER_MEAS_TIME, reg_val);

long lines. I don't mind going over 80 chars when readability is badly hurt, but
in this case it isn't so wrap the parameters.

> +
> +		case IIO_LIGHT:
> +			data->als_meas_rate = val;
> +			reg_val = vl6180_meas_reg_val_from_ms(val);
> +			return vl6180_write_byte(data->client, VL6180_ALS_INTER_MEAS_TIME, reg_val);
> +
> +		default:
> +			return -EINVAL;
> +		}
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -473,6 +520,22 @@ static int vl6180_init(struct vl6180_data *data)
>  	if (ret < 0)
>  		return ret;
>  
> +	/* Default Range inter-measurement time: 50ms

As below.

Even though you now it in advance, I'd rather you used the vl6180_meas_reg_val_from_ms()
subject to the whole thing about it needing to be in Hz

> +	 * reg_val = (50 / 10 - 1) = 4
> +	 */
> +	ret = vl6180_write_byte(client, VL6180_RANGE_INTER_MEAS_TIME, 4);
> +	if (ret < 0)
> +		return ret;
> +	data->range_meas_rate = 50;
> +
> +	/* Default ALS inter-measurement time: 10ms
Multiline comment syntax in IIO (and most of the rest of the kernel)
is 
	/*
	 * Default ...

> +	 * reg_val = (10 / 10 - 1) = 0
> +	 */
> +	ret = vl6180_write_byte(client, VL6180_ALS_INTER_MEAS_TIME, 0);
> +	if (ret < 0)
> +		return ret;
> +	data->als_meas_rate = 10;
> +
>  	/* ALS integration time: 100ms */
>  	data->als_it_ms = 100;
>  	ret = vl6180_write_word(client, VL6180_ALS_IT, VL6180_ALS_IT_100);


