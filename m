Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C0D267EEB
	for <lists+linux-iio@lfdr.de>; Sun, 13 Sep 2020 11:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgIMJWX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Sep 2020 05:22:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgIMJWW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Sep 2020 05:22:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D35DE207BB;
        Sun, 13 Sep 2020 09:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599988941;
        bh=XFv3Rz5cevjqEIPQ0ZkuWC/0xVlieUxCA/o653kUQL8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nD7qqVrpz5nGIIQwRLd6kTD5Y3vmD9SZBdFjeY3+LhdR7Auw/pdLqJzvFYHUPWM1X
         vk5kJ8R+xArA5Kuj74RKmPYr+3ngo176q0v7HvZKQz5w9JH5AwMTGkGRSztMViDTCH
         EET7rF7tL2bSgT7rGRvzV0eo6BrqfBlOwVQ/p7U0=
Date:   Sun, 13 Sep 2020 10:22:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Crt Mori <cmo@melexis.com>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3] iio: temperature: mlx90632: Interface to change
 object ambient temperature
Message-ID: <20200913102215.7c79a0f8@archlinux>
In-Reply-To: <20200906210231.383976-1-cmo@melexis.com>
References: <20200906210231.383976-1-cmo@melexis.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  6 Sep 2020 23:02:31 +0200
Crt Mori <cmo@melexis.com> wrote:

> Since object temperature might be different than the sensor temperature
> the infrared sensors should provide an interface to inject ambient
> temperature. This was in past done via write to ambient temperature
> interface (in_temp_ambient_raw), but I think most people did not know
> about it. This solution introduces a new iio type of the CALIBAMBIENT
> which is hopefully more descriptive and more explicit about the purpose
> and capabilities of the sensors.
> 
> Signed-off-by: Crt Mori <cmo@melexis.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Applied to the togreg branch of iio.git and pushed out as testing for
all the normal reasons involving autobuilders etc.

Thanks,

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 8 ++++++++
>  drivers/iio/industrialio-core.c         | 1 +
>  drivers/iio/temperature/mlx90632.c      | 9 +++++++--
>  include/linux/iio/types.h               | 1 +
>  4 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 5c62bfb0f3f5..084436a315e2 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1740,3 +1740,11 @@ KernelVersion:	5.5
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		One of the following thermocouple types: B, E, J, K, N, R, S, T.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_temp_object_calibambient
> +What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_object_calibambient
> +KernelVersion:	5.9
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Calibrated ambient temperature for object temperature
> +		calculation in milli degrees Celsius.
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 606d5e61c575..941011502f4d 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -165,6 +165,7 @@ static const char * const iio_chan_info_postfix[] = {
>  	[IIO_CHAN_INFO_CALIBEMISSIVITY] = "calibemissivity",
>  	[IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
>  	[IIO_CHAN_INFO_THERMOCOUPLE_TYPE] = "thermocouple_type",
> +	[IIO_CHAN_INFO_CALIBAMBIENT] = "calibambient",
>  };
>  
>  #if defined(CONFIG_DEBUG_FS)
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 94bca2b2866a..048cafa04455 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -761,7 +761,9 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
>  			*val2 = data->emissivity * 1000;
>  		}
>  		return IIO_VAL_INT_PLUS_MICRO;
> -
> +	case IIO_CHAN_INFO_CALIBAMBIENT:
> +		*val = data->object_ambient_temperature;
> +		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -781,6 +783,9 @@ static int mlx90632_write_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		data->emissivity = val * 1000 + val2 / 1000;
>  		return 0;
> +	case IIO_CHAN_INFO_CALIBAMBIENT:
> +		data->object_ambient_temperature = val;
> +		return 0;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -798,7 +803,7 @@ static const struct iio_chan_spec mlx90632_channels[] = {
>  		.modified = 1,
>  		.channel2 = IIO_MOD_TEMP_OBJECT,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> -			BIT(IIO_CHAN_INFO_CALIBEMISSIVITY),
> +			BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) | BIT(IIO_CHAN_INFO_CALIBAMBIENT),
>  	},
>  };
>  
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index e6fd3645963c..1e3ed6f55bca 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -59,6 +59,7 @@ enum iio_chan_info_enum {
>  	IIO_CHAN_INFO_CALIBEMISSIVITY,
>  	IIO_CHAN_INFO_OVERSAMPLING_RATIO,
>  	IIO_CHAN_INFO_THERMOCOUPLE_TYPE,
> +	IIO_CHAN_INFO_CALIBAMBIENT,
>  };
>  
>  #endif /* _IIO_TYPES_H_ */

