Return-Path: <linux-iio+bounces-20092-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA62AC9C36
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 20:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B73317D4EB
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 18:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600B9190664;
	Sat, 31 May 2025 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhK0tD7g"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15217645;
	Sat, 31 May 2025 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748715295; cv=none; b=PB22o3kgOEmhXDLWKOZIB4EhR0D6Cs/sDCzTTR23KY9Mz9cc5xeOKj0eZ7F5aMIgkUTqX4J/lOpjBgzHSWxXLXjd/RlK7WGGZ3ztPbwh7Rsh4WrVgmX1uq3Uwso44I6ZOzAMD/EhJL0SR+w90q55peMEUvKNoK4UlUwVTQAVPDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748715295; c=relaxed/simple;
	bh=nqKuVp+2bREMRpt2LB+oUZKxwqEqRuXFgwB+aDcnJYA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEfrouPYLszg6x1l+1vimSzRB173b9VbdJcCM1F/mjiqIPH8dRaE623LNOpj1Thd1CpT0zlEqX9xlQChTLfOMMLIbw5ztpncN3oCwvN9SePvBHb+NFpr61iNwLHa7mgYvQwfxs4noIMyRoeZx6R2RgQ1XiJ/Rd8ohGYQlpCl4QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhK0tD7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C057BC4CEE3;
	Sat, 31 May 2025 18:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748715294;
	bh=nqKuVp+2bREMRpt2LB+oUZKxwqEqRuXFgwB+aDcnJYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GhK0tD7gg+5upDblc5GqYqs78Y1o1ZyqKYujT4T/CBShAU5KG4JxhLapy/OexLrkh
	 XfHqWi5wJPlua7sjlTQiD8YC/QWTUGnUMozLxQbDDwH3BR4zzLtkZbTiSwQpxRj7Do
	 5J+wAUDZCkA1SUlUhDFHVHNibofyW0I1v2dVkSEbLOpGmQiCUCVPK3OYk2nRUKzpfS
	 O1hK33T+tAhclTJH8/sBTHnAViZ97cePylVi2jdN7fHev7pST+G7KUzwOLyS8N7QJl
	 uKACpnyb6wYAVnp6Ztv5b2LuKKHi7lV2a8VZIR2msIjZMOEwUGtoEq4FxFtWEqPZGN
	 NIHN5ka2+EN5A==
Date: Sat, 31 May 2025 19:14:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 9/9] iio: rpr0521: Use new timestamp-related APIs
Message-ID: <20250531191446.1b1d2e2f@jic23-huawei>
In-Reply-To: <20250519-timestamp-v1-9-fcb4f6c2721c@gmail.com>
References: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
	<20250519-timestamp-v1-9-fcb4f6c2721c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 23:26:01 +0900
Gyeyoung Baek <gye976@gmail.com> wrote:

> This patch is an example that helps explain the previous series.
> Now there is no need to handle timestamps differently depending on whether
> the consumer is attached to its own trigger or to another trigger.
> And the own trigger of rpr0521 can simply pass a timestamp to consumer,
> using `iio_trigger_store_time()`
> 
> Not tested since I don't have the corresponding device.
> 
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>

Ah. So this is what the trigger grabbing timestamp thing is about.

I'd just ignore this case for now and solve the simpler one
of what to do the the pf->timestamp stuff.

That part of the patch set looks promising to me.

Jonathan


> ---
>  drivers/iio/light/rpr0521.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index 92e7552f3e39..32981db18428 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -186,7 +186,6 @@ struct rpr0521_data {
>  	bool pxs_dev_en;
>  
>  	struct iio_trigger *drdy_trigger0;
> -	s64 irq_timestamp;
>  
>  	/* optimize runtime pm ops - enable/disable device only if needed */
>  	bool als_ps_need_en;
> @@ -416,7 +415,7 @@ static irqreturn_t rpr0521_drdy_irq_handler(int irq, void *private)
>  	struct iio_dev *indio_dev = private;
>  	struct rpr0521_data *data = iio_priv(indio_dev);
>  
> -	data->irq_timestamp = iio_get_time_ns(indio_dev);
> +	iio_trigger_store_time(data->drdy_trigger0);
>  	/*
>  	 * We need to wake the thread to read the interrupt reg. It
>  	 * is not possible to do that here because regmap_read takes a
> @@ -446,15 +445,6 @@ static irqreturn_t rpr0521_trigger_consumer_handler(int irq, void *p)
>  	struct rpr0521_data *data = iio_priv(indio_dev);
>  	int err;
>  
> -	/* Use irq timestamp when reasonable. */
> -	if (iio_trigger_using_own(indio_dev) && data->irq_timestamp) {
> -		pf->timestamp = data->irq_timestamp;
> -		data->irq_timestamp = 0;
> -	}
> -	/* Other chained trigger polls get timestamp only here. */
> -	if (!pf->timestamp)
> -		pf->timestamp = iio_get_time_ns(indio_dev);
> -
>  	err = regmap_bulk_read(data->regmap, RPR0521_REG_PXS_DATA,
>  		data->scan.channels,
>  		(3 * 2) + 1);	/* 3 * 16-bit + (discarded) int clear reg. */
> @@ -464,7 +454,6 @@ static irqreturn_t rpr0521_trigger_consumer_handler(int irq, void *p)
>  	else
>  		dev_err(&data->client->dev,
>  			"Trigger consumer can't read from sensor.\n");
> -	pf->timestamp = 0;
>  
>  	iio_trigger_notify_done(indio_dev->trig);
>  
> @@ -867,8 +856,6 @@ static int rpr0521_init(struct rpr0521_data *data)
>  		return ret;
>  #endif
>  
> -	data->irq_timestamp = 0;
> -
>  	return 0;
>  }
>  
> @@ -984,6 +971,9 @@ static int rpr0521_probe(struct i2c_client *client)
>  			goto err_pm_disable;
>  		}
>  		data->drdy_trigger0->ops = &rpr0521_trigger_ops;
> +		data->drdy_trigger0->early_timestamp = true;
> +		data->drdy_trigger0->trig_type = IIO_TRIG_TYPE_POLL_NESTED;
> +
>  		indio_dev->available_scan_masks = rpr0521_available_scan_masks;
>  		iio_trigger_set_drvdata(data->drdy_trigger0, indio_dev);
>  
> @@ -1011,10 +1001,10 @@ static int rpr0521_probe(struct i2c_client *client)
>  		 */
>  
>  		/* Trigger consumer setup */
> -		ret = devm_iio_triggered_buffer_setup(indio_dev->dev.parent,
> +		ret = devm_iio_triggered_buffer_setup_new(indio_dev->dev.parent,
>  			indio_dev,
> -			iio_pollfunc_store_time,
>  			rpr0521_trigger_consumer_handler,
> +			true,
>  			&rpr0521_buffer_setup_ops);
>  		if (ret < 0) {
>  			dev_err(&client->dev, "iio triggered buffer setup failed\n");
> 


