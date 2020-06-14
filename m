Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC891F88FB
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jun 2020 15:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgFNNj2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jun 2020 09:39:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgFNNj2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jun 2020 09:39:28 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C367B20714;
        Sun, 14 Jun 2020 13:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592141967;
        bh=8W9q5XEQ9tbuhFfFDg1dTXt14GUP04D+6xKFyX8K14w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xflgNYVIVkQiLI/QyjVkjGGsyPnJnIP7lZvy/uNan99QrUIS13XvF9T6PkJtRW+LW
         TI/QnkNCdV7wS5W/2XT9qVi4dnC0u2wmlQ4Urgi4JREXVMN77GZQlTdci4ACAJUhog
         /3UDFKi71GtsIWXFBZjFb5u/PPES9wef9Akp7DKM=
Date:   Sun, 14 Jun 2020 14:39:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: chemical: atlas-ezo-sensor: add support for O2
 sensor
Message-ID: <20200614143921.24e1ce15@archlinux>
In-Reply-To: <20200609194117.5837-4-matt.ranostay@konsulko.com>
References: <20200609194117.5837-1-matt.ranostay@konsulko.com>
        <20200609194117.5837-4-matt.ranostay@konsulko.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  9 Jun 2020 12:41:17 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Add support for the Atlas EZO O2 chemical sensor which required
> some refactoring of the driver and parsing of i2c transfer.
> 
> Sensor data is converted by the scaling value from percent to
> IIO_CONCENTRATION.
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Hohum.  I could just apply this series today (looks good) but
given you just fixed that missing strings problem, that will make
for a messy merge for Greg when I send this via togreg and the
fix via fixes-togreg.

As such I'm going to sit on this one until that fix ends up in my
upstream then pick this up.

Do remind me if I seem to have lost it though once that's true!

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/atlas-ezo-sensor.c | 74 ++++++++++++++++++-------
>  1 file changed, 55 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
> index a94eb8a6bf32..94188c84e65f 100644
> --- a/drivers/iio/chemical/atlas-ezo-sensor.c
> +++ b/drivers/iio/chemical/atlas-ezo-sensor.c
> @@ -16,10 +16,11 @@
>  #include <linux/iio/iio.h>
>  
>  #define ATLAS_EZO_DRV_NAME		"atlas-ezo-sensor"
> -#define ATLAS_CO2_INT_TIME_IN_MS	950
> +#define ATLAS_INT_TIME_IN_MS		950
>  
>  enum {
>  	ATLAS_CO2_EZO,
> +	ATLAS_O2_EZO,
>  };
>  
>  struct atlas_ezo_device {
> @@ -38,31 +39,54 @@ struct atlas_ezo_data {
>  	u8 buffer[8];
>  };
>  
> +#define ATLAS_CONCENTRATION_CHANNEL(_modifier) \
> +	{ \
> +		.type = IIO_CONCENTRATION, \
> +		.modified = 1,\
> +		.channel2 = _modifier, \
> +		.info_mask_separate = \
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE), \
> +		.scan_index = 0, \
> +		.scan_type =  { \
> +			.sign = 'u', \
> +			.realbits = 32, \
> +			.storagebits = 32, \
> +			.endianness = IIO_CPU, \
> +		}, \
> +	}
> +
>  static const struct iio_chan_spec atlas_co2_ezo_channels[] = {
> -	{
> -		.type = IIO_CONCENTRATION,
> -		.modified = 1,
> -		.channel2 = IIO_MOD_CO2,
> -		.info_mask_separate =
> -			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> -		.scan_index = 0,
> -		.scan_type = {
> -			.sign = 'u',
> -			.realbits = 32,
> -			.storagebits = 32,
> -			.endianness = IIO_CPU,
> -		},
> -	},
> +	ATLAS_CONCENTRATION_CHANNEL(IIO_MOD_CO2),
> +};
> +
> +static const struct iio_chan_spec atlas_o2_ezo_channels[] = {
> +	ATLAS_CONCENTRATION_CHANNEL(IIO_MOD_O2),
>  };
>  
>  static struct atlas_ezo_device atlas_ezo_devices[] = {
>  	[ATLAS_CO2_EZO] = {
>  		.channels = atlas_co2_ezo_channels,
>  		.num_channels = 1,
> -		.delay = ATLAS_CO2_INT_TIME_IN_MS,
> +		.delay = ATLAS_INT_TIME_IN_MS,
>  	},
> +	[ATLAS_O2_EZO] = {
> +		.channels = atlas_o2_ezo_channels,
> +		.num_channels = 1,
> +		.delay = ATLAS_INT_TIME_IN_MS,
> +	}
>  };
>  
> +static void atlas_ezo_sanitize(char *buf)
> +{
> +	char *ptr = strchr(buf, '.');
> +
> +	if (!ptr)
> +		return;
> +
> +	for (; *ptr; ptr++)
> +		*ptr = *(ptr + 1);
> +}
> +
>  static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
>  			  struct iio_chan_spec const *chan,
>  			  int *val, int *val2, long mask)
> @@ -96,6 +120,9 @@ static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
>  			return -EBUSY;
>  		}
>  
> +		/* removing floating point for fixed number representation */
> +		atlas_ezo_sanitize(data->buffer + 2);
> +
>  		ret = kstrtol(data->buffer + 1, 10, &tmp);
>  
>  		*val = tmp;
> @@ -105,9 +132,16 @@ static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
>  		return ret ? ret : IIO_VAL_INT;
>  	}
>  	case IIO_CHAN_INFO_SCALE:
> -		*val = 0;
> -		*val2 = 100; /* 0.0001 */
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		switch (chan->channel2) {
> +		case IIO_MOD_CO2:
> +			*val = 0;
> +			*val2 = 100; /* 0.0001 */
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_MOD_O2:
> +			*val = 100;
> +			return IIO_VAL_INT;
> +		}
> +		return -EINVAL;
>  	}
>  
>  	return 0;
> @@ -119,12 +153,14 @@ static const struct iio_info atlas_info = {
>  
>  static const struct i2c_device_id atlas_ezo_id[] = {
>  	{ "atlas-co2-ezo", ATLAS_CO2_EZO },
> +	{ "atlas-o2-ezo", ATLAS_O2_EZO },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, atlas_ezo_id);
>  
>  static const struct of_device_id atlas_ezo_dt_ids[] = {
>  	{ .compatible = "atlas,co2-ezo", .data = (void *)ATLAS_CO2_EZO, },
> +	{ .compatible = "atlas,o2-ezo", .data = (void *)ATLAS_O2_EZO, },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, atlas_ezo_dt_ids);

