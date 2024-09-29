Return-Path: <linux-iio+bounces-9887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E33C989672
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 19:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323621C20FD7
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 17:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1759517E010;
	Sun, 29 Sep 2024 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcYTIr+P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BA417E004;
	Sun, 29 Sep 2024 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727629811; cv=none; b=rwwKBzqafgNbNCPwd9yWppTfJsKndzJH6aAJ0JcDWErDU8CBYe7AqLEREEtnZ3uIRWYvT4duWVFfqc2fwIkYi8aRdHQ7BuKzI/kVRH3E96d7OrZnUts1qUFqbh6LTjAyFfoD4c05vtEPFaDy805vkUlInFGtHAbUvvsmMV1UFsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727629811; c=relaxed/simple;
	bh=vLELgkLkDGsWVr4f3ZDGKmIbHmczdwX3LvXWEjP6ja0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWkv2U99Wx9+JP8jqA/qu3AsOl81vW53CsTd6Ve7BulIi+rP22Bh26Lz23bU+FiPKactiz7NiMwLdwvIkHeg4NNtyK4Jzjj2ay5dGh31oXQ+aFJ72/f9ovaADtM/EIPqHUwe8oqmjJJCwV5Cfrw+2mUmaptRKROdpHxeKVRSUrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcYTIr+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E917C4CEC5;
	Sun, 29 Sep 2024 17:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727629811;
	bh=vLELgkLkDGsWVr4f3ZDGKmIbHmczdwX3LvXWEjP6ja0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FcYTIr+PaUFb5rJuYhUyyuK3bKU/VGOJw0Y4woU5inM+D0BltAOMIj1NQvGHG39ce
	 ffj5tFSDvSZdqeuLrt9+f6WSlDvsQEx/lwWMm8M9n8SaTTeH3v70HJjeGs61KqQXUv
	 3cFnGm5/Pf4fVbm0m60X6nf7h781wu+WR0/KMOi8vbeU9eOdglWQyZ5GE/sfYkml2m
	 Kz/o1Cy94LHERoHfeMDGcbLmw4OKvlJcU9Wsv9bWpQr55WrrwDTeg9y5GUIP3+jtl+
	 Po2b/gTW0Qh9OSGkspbNk89gI9Mo1vj/jqEUmEQDj9L/iU4aciYqxg7926zjWP7AGL
	 I5pxE6pB3Xv1A==
Date: Sun, 29 Sep 2024 18:10:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: dan.carpenter@linaro.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: pressure: bmp280: Use char instead of s32
 for data buffer
Message-ID: <20240929181003.26abf543@jic23-huawei>
In-Reply-To: <20240929112511.100292-3-vassilisamir@gmail.com>
References: <20240929112511.100292-1-vassilisamir@gmail.com>
	<20240929112511.100292-3-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Sep 2024 13:25:11 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> As it was reported and discussed here [1], storing the sensor data in an
> endian aware s32 buffer is not optimal. Advertising the timestamp as an
> addition of 2 s32 variables which is also implied is again not the best
> practice. For that reason, change the s32 sensor_data buffer to a char
> buffer with an extra value for the timestamp (as it is common practice).
> 
> [1]: https://lore.kernel.org/linux-iio/73d13cc0-afb9-4306-b498-5d821728c3ba@stanley.mountain/
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Hi Vasileois.

I missed a purely semantic issue in previous versions :( 

A few other places where you can achieve the same effect with less code
and clear casting to correct types.

Jonathan


> ---
>  drivers/iio/pressure/bmp280-core.c | 78 ++++++++++++++++++------------
>  drivers/iio/pressure/bmp280.h      |  5 +-
>  2 files changed, 51 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 472a6696303b..2c62490a40c6 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c


> @@ -2523,23 +2538,24 @@ static irqreturn_t bmp180_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct bmp280_data *data = iio_priv(indio_dev);
> -	int ret, chan_value;
> +	int ret, comp_temp, comp_press, offset;
>  
>  	guard(mutex)(&data->lock);
>  
> -	ret = bmp180_read_temp(data, &chan_value);
> +	ret = bmp180_read_temp(data, &comp_temp);
>  	if (ret)
>  		goto out;
>  
> -	data->sensor_data[1] = chan_value;
>  
> -	ret = bmp180_read_press(data, &chan_value);
> +	ret = bmp180_read_press(data, &comp_press);
>  	if (ret)
>  		goto out;
>  
> -	data->sensor_data[0] = chan_value;
> +	memcpy(&data->buffer.buf[offset], &comp_press, sizeof(s32));
> +	offset += sizeof(s32);
> +	memcpy(&data->buffer.buf[offset], &comp_temp, sizeof(s32));
I suppose there is a consistency argument for using memcpy even for the s32
cases but you 'could' if you like do
	s32 *chans = (s32 *)data->buffer.buf;
at top
and 
	chans[0] = comp_press;
	chans[1] = comp_temp;
here, which is functionally equivalent, particularly as we are forcing the
buffer alignment to be larger than this s32.

Similar for the other simple native endian s32 cases.

The memcpy is needed for the le24 one.


>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
>  					   iio_get_time_ns(indio_dev));
>  
>  out:
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index a9f220c1f77a..b0c26f55c6af 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -419,7 +419,10 @@ struct bmp280_data {
>  	 * Data to push to userspace triggered buffer. Up to 3 channels and
>  	 * s64 timestamp, aligned.
>  	 */
> -	s32 sensor_data[6] __aligned(8);
> +	struct {
> +		u8 buf[12];
> +		aligned_s64 ts;

I'd missed that this depends on the number of channels.  It makes no functional
difference because the core code will happily write over the end of buf, but
from a representation point of view this might be

		u8 buf[8];
		aligned_s64 ts;
or
		u8 buf[12];
		aligned_s64 ts;

So given we can't actually fix on one or the other normal convention is
to just use something that forces a large enough aligned u8 buffer like
		u8 buf[ALIGN(sizeof(s32) * BMP280_MAX_CHANNELS, 8) + sizeof(s64)]
			__aligned(sizeof(s64));

Sorry for leading you astray on this!

Jonathan


> +	} buffer;
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) may require the


