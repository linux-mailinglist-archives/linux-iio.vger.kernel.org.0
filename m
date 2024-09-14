Return-Path: <linux-iio+bounces-9540-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EFF979089
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 13:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE4F282F4B
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 11:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDA51CEEB6;
	Sat, 14 Sep 2024 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5uFXxFX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B6D43177;
	Sat, 14 Sep 2024 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726313778; cv=none; b=QxQ7PNcAG9O7YL7oQnZOmqD6VOzYDQ+2ARTTSpxS0hbRSTkBxMwHljbha+QjOhFfg/3YZXnzzbDoXvFFZjhG9ia3/7vwUqh5dW75rmjTnlNTIQefQuEYZt5PZBe2AxNiPasfIKLVIaLYc6oG6wtydsbD531ZSHHKnPGm1B4biMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726313778; c=relaxed/simple;
	bh=KniP7/7T0/7iq4KLpY88z5uNWVBS7tQwjtKjGv1gMCg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1zSGZ9wm65bSFCl8HPdtRSY+wxxKtnUEz3MeOEDqkmBy/oNI5eixxNrdgbbVkdHXBS7V+ot71VLaD+wtgTqfQf1BD6yEWUchRaN/NDcZ80umzNviDwZy85x1kPbPXR80mWko+cZx62QtNlGeBN35UhY+y0vBQIyC/DHSdr+lBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5uFXxFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DDAC4CEC0;
	Sat, 14 Sep 2024 11:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726313778;
	bh=KniP7/7T0/7iq4KLpY88z5uNWVBS7tQwjtKjGv1gMCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q5uFXxFX6f0qi61Vy6Ogq0wSnXoQHzxorxn+UpnNbG7Gnl+MB8YrmSyU1W6bZb/26
	 Gsd0Cim2Ns8Ae44hWDK5ILje1O576B43CDBdFgwn17D6nWxQip6gIsmr2YMz/CO70c
	 XPQfsWI6jufespqsrIEoS8HVSu4OVCGMHBy+OgwAbL6QtNMzE5P8P0UwVsU/PZ1Uob
	 Cr7JiUiUS7/P6Siw8bQNfn68UOAugJaf1N6AOYoF/Zghq6O+78GEGGg2MKMD2jI4pU
	 K+P1yKUJAEa23595Ec03QW4q8lCVFzAiX4mJ3iVPyp1zmZ/VtEBu4I+06KzO3ZveO8
	 5woyIK4PWnPqQ==
Date: Sat, 14 Sep 2024 12:36:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: dan.carpenter@linaro.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: iio: pressure: bmp280: Use char instead of s32 for data buffer
Message-ID: <20240914123611.3fdb1fbf@jic23-huawei>
In-Reply-To: <20240823172017.9028-1-vassilisamir@gmail.com>
References: <20240823172017.9028-1-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 19:20:17 +0200
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
Hi.
Thanks for poking. Looks like I'd accidentally marked this one handled
without actually doing so :(

> ---
>  drivers/iio/pressure/bmp280-core.c | 43 +++++++++++++++++-------------
>  drivers/iio/pressure/bmp280.h      |  5 +++-
>  2 files changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 3deaa57bb3f5..71e481c2f30d 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -1035,7 +1035,8 @@ static irqreturn_t bmp280_trigger_handler(int irq, void *p)
>  		goto out;
>  	}
>  
> -	data->sensor_data[1] = bmp280_compensate_temp(data, adc_temp);
> +	ret = bmp280_compensate_temp(data, adc_temp);
> +	memcpy(&data->buffer.buf[4], &ret, 4);

The 4's in here are magic indexes.  Probably use sizeof(s32) in both cases.
Maybe for the first one make the fact it's after an s32 explicit with
&data->buffer.buf[1 * sizeof(s32)]

Of carry an offset through the code that you update when you fill in part of
the buffer.  That is probably cleaner.

	int offset = 0;
	stuff
	offset += sizeof(s32);
	mempcy(&data->bufer.buf[offset], &ret, 4);

if offset is used for a later entry then add the new element.


>  
>  	/* Pressure calculations */
>  	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[0]));
> @@ -1045,10 +1046,10 @@ static irqreturn_t bmp280_trigger_handler(int irq, void *p)
>  	}
>  
>  	t_fine = bmp280_calc_t_fine(data, adc_temp);
> +	ret = bmp280_compensate_press(data, adc_press, t_fine);
> +	memcpy(&data->buffer.buf[0], &ret, 4);
>  
> -	data->sensor_data[0] = bmp280_compensate_press(data, adc_press, t_fine);
> -
> -	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
>  					   iio_get_time_ns(indio_dev));
>  
>  out:
> @@ -1148,7 +1149,8 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
>  		goto out;
>  	}
>  
> -	data->sensor_data[1] = bmp280_compensate_temp(data, adc_temp);
> +	ret = bmp280_compensate_temp(data, adc_temp);
> +	memcpy(&data->buffer.buf[4], &ret, 4);
>  
>  	/* Pressure calculations */
>  	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[0]));
> @@ -1158,8 +1160,8 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
>  	}
>  
>  	t_fine = bmp280_calc_t_fine(data, adc_temp);
> -
> -	data->sensor_data[0] = bmp280_compensate_press(data, adc_press, t_fine);
> +	ret = bmp280_compensate_press(data, adc_press, t_fine);
> +	memcpy(&data->buffer.buf[0], &ret, 4);
>  
>  	/* Humidity calculations */
>  	adc_humidity = get_unaligned_be16(&data->buf[6]);
> @@ -1168,9 +1170,11 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
>  		dev_err(data->dev, "reading humidity skipped\n");
>  		goto out;
>  	}
> -	data->sensor_data[2] = bme280_compensate_humidity(data, adc_humidity, t_fine);
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
> +	ret = bme280_compensate_humidity(data, adc_humidity, t_fine);
> +	memcpy(&data->buffer.buf[8], &ret, 4);
as above, but here it is I guess after 2 other elements, so

2 * sizeof(s32)

> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
>  					   iio_get_time_ns(indio_dev));
>  
>  out:
> @@ -1628,7 +1632,8 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
>  		goto out;
>  	}
>  
> -	data->sensor_data[1] = bmp380_compensate_temp(data, adc_temp);
> +	ret = bmp380_compensate_temp(data, adc_temp);
> +	memcpy(&data->buffer.buf[4], &ret, 4);
>  
>  	/* Pressure calculations */
>  	adc_press = get_unaligned_le24(&data->buf[0]);
> @@ -1638,10 +1643,10 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
>  	}
>  
>  	t_fine = bmp380_calc_t_fine(data, adc_temp);
> +	ret = bmp380_compensate_press(data, adc_press, t_fine);
> +	memcpy(&data->buffer.buf[0], &ret, 4);
>  
> -	data->sensor_data[0] = bmp380_compensate_press(data, adc_press, t_fine);
> -
> -	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
>  					   iio_get_time_ns(indio_dev));
>  
>  out:
> @@ -2203,12 +2208,12 @@ static irqreturn_t bmp580_trigger_handler(int irq, void *p)
>  	}
>  
>  	/* Temperature calculations */
> -	memcpy(&data->sensor_data[1], &data->buf[0], 3);
> +	memcpy(&data->buffer.buf[4], &data->buf[0], 3);
>  
>  	/* Pressure calculations */
> -	memcpy(&data->sensor_data[0], &data->buf[3], 3);
> +	memcpy(&data->buffer.buf[0], &data->buf[3], 3);

> -	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
>  					   iio_get_time_ns(indio_dev));
>  
>  out:
> @@ -2522,15 +2527,15 @@ static irqreturn_t bmp180_trigger_handler(int irq, void *p)
>  	if (ret)
>  		goto out;
>  
> -	data->sensor_data[1] = chan_value;
> +	memcpy(&data->buffer.buf[4], &chan_value, 4);
>  
>  	ret = bmp180_read_press(data, &chan_value);
>  	if (ret)
>  		goto out;
>  
> -	data->sensor_data[0] = chan_value;
> +	memcpy(&data->buffer.buf[0], &chan_value, 4);
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
>  					   iio_get_time_ns(indio_dev));
>  
>  out:
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index ccacc67c1473..a853b6d5bdfa 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -411,7 +411,10 @@ struct bmp280_data {
>  	 * Data to push to userspace triggered buffer. Up to 3 channels and
>  	 * s64 timestamp, aligned.
>  	 */
> -	s32 sensor_data[6] __aligned(8);
> +	struct {
> +		u8 buf[12];
> +		s64 ts __aligned(8);

We have a new aligned_s64 that is cleaner for these cases.  It's only
in my togreg branch currently though so you'll need to base on that
to use it.

Jonathan


> +	} buffer;
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) may require the


