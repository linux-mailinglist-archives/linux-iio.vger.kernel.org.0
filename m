Return-Path: <linux-iio+bounces-6747-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F88A913A54
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 14:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85071F219CF
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 12:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A124E181309;
	Sun, 23 Jun 2024 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFjOE7tY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580D9180A9B;
	Sun, 23 Jun 2024 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719144227; cv=none; b=NeLj+Ji8wPU89yX9lGhhNB9py792V22maSHyBPZ5l2FVfrZ97cKEUIdixC2vpBA6nCmgPUIzcCcUos4vjf5XiDnwrUi2O3okT5hjQIXf64i074nBki4VOx3pN5/KVpNoJ+4g/kTO17wAnmxBOZ0+z1keShMKY4J9ti3MPeAuuos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719144227; c=relaxed/simple;
	bh=Ldz1GN6+3Z7G8+L6Q7Yh9h7HRyzDV64bj3F+rO77G7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GmsV7V28PzW42zuJDg+V1gvOXw9FkTT1Rt7Qy4okN6P6QiVPlXbsbUCSOH0Jandi8nuDjqnpeSo7pl1Z1JwgnLkx5rsWkR12JdWRgjzF0pfby2DYxh9Z5/mdMUMEVJOFbb32kdkaY215A5gF3MGSxf12xVX+MukogVaSJi4w4IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFjOE7tY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D09DC2BD10;
	Sun, 23 Jun 2024 12:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719144226;
	bh=Ldz1GN6+3Z7G8+L6Q7Yh9h7HRyzDV64bj3F+rO77G7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SFjOE7tYSboRbmzbWgyT48Ah1/vEWsZ61y7RgQdabaMP/sUFH8lcpcfV6Ty1kg6G5
	 LuaNtJrdpZTVgmao2HDLK0zGz5fRoJjySoVbzQtoiUcutHfEyxLdz4Yb0GoE2B379Q
	 dN9GaKC+pcd/B6tRbe6VtlI89fXkmoGFYIUa6VgDN4xrSACazrSZ3Z34pn32VupmhD
	 InImK/T0qbo6C8QGNtNWVlTxgIGp91v80XrZxq/cpfuw0pYI+OPAmawMe4Zkqdkm+Q
	 s54W7zCF5mn15d1iovDv9t8JoIEbp7hhDcDT8Zaj/cw8OBViYm6AY7KSKQkPDle5Bj
	 cPOy5Rj9HO+YQ==
Date: Sun, 23 Jun 2024 13:03:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: Add iio_read_channel_label to inkern API
Message-ID: <20240623130339.535b96ba@jic23-huawei>
In-Reply-To: <20240620211310.820579-2-sean.anderson@linux.dev>
References: <20240620211310.820579-1-sean.anderson@linux.dev>
	<20240620211310.820579-2-sean.anderson@linux.dev>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 17:13:08 -0400
Sean Anderson <sean.anderson@linux.dev> wrote:

> It can be convenient for other in-kernel drivers to reuse IIO channel
> labels. Export the iio_read_channel_label function to allow this. The
> signature is different depending on where we are calling it from, so
> the meat is moved to do_iio_read_channel_label.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Seems like a useful addition to me. I'm not 100% what path this will
take so if it goes via HWMON.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

It may be messy and need an immutable branch however. I haven't
checked for churn in this code yet.


> ---
> 
>  drivers/iio/iio_core.h          |  4 ++++
>  drivers/iio/industrialio-core.c | 23 ++++++++++++++---------
>  drivers/iio/inkern.c            |  6 ++++++
>  include/linux/iio/consumer.h    | 10 ++++++++++
>  4 files changed, 34 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> index 1a38b1915e7a..b7d5f4f0fada 100644
> --- a/drivers/iio/iio_core.h
> +++ b/drivers/iio/iio_core.h
> @@ -34,6 +34,10 @@ void iio_device_ioctl_handler_register(struct iio_dev *indio_dev,
>  				       struct iio_ioctl_handler *h);
>  void iio_device_ioctl_handler_unregister(struct iio_ioctl_handler *h);
>  
> +ssize_t do_iio_read_channel_label(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *c,
> +				  char *buf);
> +
>  int __iio_add_chan_devattr(const char *postfix,
>  			   struct iio_chan_spec const *chan,
>  			   ssize_t (*func)(struct device *dev,
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 2f185b386949..0f6cda7ffe45 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -727,22 +727,27 @@ ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals)
>  }
>  EXPORT_SYMBOL_GPL(iio_format_value);
>  
> -static ssize_t iio_read_channel_label(struct device *dev,
> -				      struct device_attribute *attr,
> -				      char *buf)
> +ssize_t do_iio_read_channel_label(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *c,
> +				  char *buf)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -
>  	if (indio_dev->info->read_label)
> -		return indio_dev->info->read_label(indio_dev, this_attr->c, buf);
> +		return indio_dev->info->read_label(indio_dev, c, buf);
>  
> -	if (this_attr->c->extend_name)
> -		return sysfs_emit(buf, "%s\n", this_attr->c->extend_name);
> +	if (c->extend_name)
> +		return sysfs_emit(buf, "%s\n", c->extend_name);
>  
>  	return -EINVAL;
>  }
>  
> +static ssize_t iio_read_channel_label(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	return do_iio_read_channel_label(dev_to_iio_dev(dev),
> +					 to_iio_dev_attr(attr)->c, buf);
> +}
> +
>  static ssize_t iio_read_channel_info(struct device *dev,
>  				     struct device_attribute *attr,
>  				     char *buf)
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 39cf26d69d17..9f484c94bc6e 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -1010,3 +1010,9 @@ ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
>  			       chan->channel, buf, len);
>  }
>  EXPORT_SYMBOL_GPL(iio_write_channel_ext_info);
> +
> +ssize_t iio_read_channel_label(struct iio_channel *chan, char *buf)
> +{
> +	return do_iio_read_channel_label(chan->indio_dev, chan->channel, buf);
> +}
> +EXPORT_SYMBOL_GPL(iio_read_channel_label);
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index e9910b41d48e..333d1d8ccb37 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -441,4 +441,14 @@ ssize_t iio_read_channel_ext_info(struct iio_channel *chan,
>  ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
>  				   const char *buf, size_t len);
>  
> +/**
> + * iio_read_channel_label() - read label for a given channel
> + * @chan:		The channel being queried.
> + * @buf:		Where to store the attribute value. Assumed to hold
> + *			at least PAGE_SIZE bytes.
> + *
> + * Returns the number of bytes written to buf, or an error code.
> + */
> +ssize_t iio_read_channel_label(struct iio_channel *chan, char *buf);
> +
>  #endif


