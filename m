Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52517FECBD
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2019 15:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfKPOtj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Nov 2019 09:49:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbfKPOtj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Nov 2019 09:49:39 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BA8F206E1;
        Sat, 16 Nov 2019 14:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573915778;
        bh=oLD/aoWkdH7fAZwv6JTEeMRGSjEpbCiLAiDfL/bpp50=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sKZfQ3Nq109/LHrcAR6N1oGkoS4UCmypQpuMIuVUijWV//fezUycpqT71Ird1Ipkw
         uYBMoZnWgwg7HXRyCIOJWezxuJGboV9YFZoFNYaKTr8aTGuwGHB2INwmAGmlmviW3m
         cKw923uZzXixrXkXPPUlQcdGAXZaQ0BRBlnGdUUQ=
Date:   Sat, 16 Nov 2019 14:49:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Colin Ian King <colin.king@canonical.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Daniel Gomez <dagmcr@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [v2 7/9] iio: max31856: add support for runtime-configuring the
 thermocouple type
Message-ID: <20191116144932.2ee5336a@archlinux>
In-Reply-To: <20191111153517.13862-8-andrea.merello@gmail.com>
References: <20190923121714.13672-1-andrea.merello@gmail.com>
        <20191111153517.13862-1-andrea.merello@gmail.com>
        <20191111153517.13862-8-andrea.merello@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 Nov 2019 16:35:15 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

> The sensor support various thermocouple types (e.g. J, K, N, ...). The
> driver allows to configure this parameter using a DT property.
> 
> This is useful when i.e. the thermocouple is physically tied to the sensor
> and it is usually not removed, or when it is at least known in advance
> which sensor will be connected to the circuit.
> 
> However, if the user can randomly connect any kind of thermocouples (i.e.
> the device exposes a connector, and the user is free to connect its own
> sensors), it would be more appropriate to provide a mechanism to
> dynamically switch from one thermocouple type to another. This can be i.e.
> handled in userspace by a GUI, a configuration file or a program that
> detects the thermocouple type by reading a GPIO, or a eeprom on the probe,
> or whatever.
> 
> This patch adds a IIO attribute that can be used to override, at run-time,
> the DT-provided setting (which serves as default).
> 
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Colin Ian King <colin.king@canonical.com>
> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> Cc: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> Cc: Matt Weber <matthew.weber@rockwellcollins.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> Cc: Chuhong Yuan <hslester96@gmail.com>
> Cc: Daniel Gomez <dagmcr@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Trivial comment inline to tody up.  Otherwise looks good.
> ---
>  drivers/iio/temperature/max31856.c | 39 +++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
> index 9f0f4f65dccd..6689eab174df 100644
> --- a/drivers/iio/temperature/max31856.c
> +++ b/drivers/iio/temperature/max31856.c
> @@ -6,6 +6,7 @@
>   * Copyright (C) 2018-2019 Rockwell Collins
>   */
>  
> +#include <linux/ctype.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/err.h>
> @@ -76,6 +77,10 @@ struct max31856_data {
>  	int averaging;
>  };
>  
> +const char max31856_tc_types[] = {
> +	'B', 'E', 'J', 'K', 'N', 'R', 'S', 'T'
> +};
> +
>  static int max31856_read(struct max31856_data *data, u8 reg,
>  			 u8 val[], unsigned int read_size)
>  {
> @@ -233,6 +238,9 @@ static int max31856_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		*val = 1 << data->averaging;
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> +		*val = max31856_tc_types[data->thermocouple_type];
> +		return IIO_VAL_CHAR;
>  	default:
>  		ret = -EINVAL;
>  		break;
> @@ -241,6 +249,18 @@ static int max31856_read_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int max31856_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				      struct iio_chan_spec const *chan,
> +				      long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> +		return IIO_VAL_CHAR;
> +	default:
> +		return IIO_VAL_INT;
> +	}
> +}
> +
>  static int max31856_write_raw(struct iio_dev *indio_dev,
>  			      struct iio_chan_spec const *chan,
>  			      int val, int val2, long mask)
> @@ -260,7 +280,24 @@ static int max31856_write_raw(struct iio_dev *indio_dev,
>  		data->averaging = msb;
>  		max31856_init(data);
>  		break;
> +	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> +	{
> +		int tc_type = -1;
> +		int i;
> +
> +		for (i = 0; i < ARRAY_SIZE(max31856_tc_types); i++) {
> +			if (max31856_tc_types[i] == toupper(val)) {
> +				tc_type = i;
> +				break;
> +			}
> +		}
> +		if (tc_type < 0)
> +			return -EINVAL;
>  
> +		data->thermocouple_type = tc_type;
> +		max31856_init(data);
> +		break;
> +	}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -333,7 +370,6 @@ static ssize_t set_filter(struct device *dev,
>  	default:
>  		return -EINVAL;
>  	}
> -

Check your patches for unconnected little changes like this.
It adds noise and mess to the history so please clear them out.

>  	max31856_init(data);
>  	return len;
>  }
> @@ -357,6 +393,7 @@ static const struct attribute_group max31856_group = {
>  static const struct iio_info max31856_info = {
>  	.read_raw = max31856_read_raw,
>  	.write_raw = max31856_write_raw,
> +	.write_raw_get_fmt = max31856_write_raw_get_fmt,
>  	.attrs = &max31856_group,
>  };
>  

