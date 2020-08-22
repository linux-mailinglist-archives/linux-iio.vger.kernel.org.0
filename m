Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834AD24E6FE
	for <lists+linux-iio@lfdr.de>; Sat, 22 Aug 2020 13:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgHVLBx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Aug 2020 07:01:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbgHVLBp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Aug 2020 07:01:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93C5D20714;
        Sat, 22 Aug 2020 11:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598094105;
        bh=IT50F+47ubbA8dTOvO0j0cgKHHtEc++MMpOAVHL76xg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W2F3b+dLLOYn9KlCoEHdfAk0tZUFT2eIG8UP3PeOTQpxC3fiPTMiZi/S3IGmZo2ji
         W1EkmF2e61V21x2bPE4DMHVjNkz6B9vRkCKPnEugAiV0m0zuV15OHJ1HzKVBUqbGSD
         5k7vQjrARQ8NGvnh2pXIKZGL5EIqnKNgY/q981EM=
Date:   Sat, 22 Aug 2020 12:01:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: chemical: atlas-ezo-sensor: add humidity
 sensor support
Message-ID: <20200822120140.0a2c6d0f@archlinux>
In-Reply-To: <20200817005052.11565-3-matt.ranostay@konsulko.com>
References: <20200817005052.11565-1-matt.ranostay@konsulko.com>
        <20200817005052.11565-3-matt.ranostay@konsulko.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Aug 2020 03:50:52 +0300
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Add support for atlas,hum-ezo / humidity sensor which with scaling
> provides respective data in millipercent
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
One comment inline.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/atlas-ezo-sensor.c | 37 ++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
> index 60a0c752fbc5..b1bacfe3c3ce 100644
> --- a/drivers/iio/chemical/atlas-ezo-sensor.c
> +++ b/drivers/iio/chemical/atlas-ezo-sensor.c
> @@ -17,10 +17,12 @@
>  
>  #define ATLAS_EZO_DRV_NAME		"atlas-ezo-sensor"
>  #define ATLAS_INT_TIME_IN_MS		950
> +#define ATLAS_INT_HUM_TIME_IN_MS	350
>  
>  enum {
>  	ATLAS_CO2_EZO,
>  	ATLAS_O2_EZO,
> +	ATLAS_HUM_EZO,
>  };
>  
>  struct atlas_ezo_device {
> @@ -63,6 +65,21 @@ static const struct iio_chan_spec atlas_o2_ezo_channels[] = {
>  	ATLAS_CONCENTRATION_CHANNEL(IIO_MOD_O2),
>  };
>  
> +static const struct iio_chan_spec atlas_hum_ezo_channels[] = {
> +	{
> +		.type = IIO_HUMIDITYRELATIVE,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 0,
> +		.scan_type =  {
> +			.sign = 'u',
> +			.realbits = 32,
> +			.storagebits = 32,
> +			.endianness = IIO_CPU,
> +		},
> +	},
> +};
> +
>  static struct atlas_ezo_device atlas_ezo_devices[] = {
>  	[ATLAS_CO2_EZO] = {
>  		.channels = atlas_co2_ezo_channels,
> @@ -73,7 +90,12 @@ static struct atlas_ezo_device atlas_ezo_devices[] = {
>  		.channels = atlas_o2_ezo_channels,
>  		.num_channels = 1,
>  		.delay = ATLAS_INT_TIME_IN_MS,
> -	}
> +	},
> +	[ATLAS_HUM_EZO] = {
> +		.channels = atlas_hum_ezo_channels,
> +		.num_channels = 1,
> +		.delay = ATLAS_INT_HUM_TIME_IN_MS,
> +	},
>  };
>  
>  static void atlas_ezo_sanitize(char *buf)
> @@ -131,6 +153,17 @@ static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
>  		return ret ? ret : IIO_VAL_INT;
>  	}
>  	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_HUMIDITYRELATIVE:
> +			*val = 10;
> +			return IIO_VAL_INT;
> +		case IIO_CONCENTRATION:
> +			break;
> +		default:
> +			return -EINVAL;
> +		}

This structure strikes me as something that might get rather ugly if it
gets much more complex.

I'll take this one, but keep in mind for any future additions to the driver!

Jonathan

> +
> +		/* IIO_CONCENTRATION modifiers */
>  		switch (chan->channel2) {
>  		case IIO_MOD_CO2:
>  			*val = 0;
> @@ -153,6 +186,7 @@ static const struct iio_info atlas_info = {
>  static const struct i2c_device_id atlas_ezo_id[] = {
>  	{ "atlas-co2-ezo", ATLAS_CO2_EZO },
>  	{ "atlas-o2-ezo", ATLAS_O2_EZO },
> +	{ "atlas-hum-ezo", ATLAS_HUM_EZO },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, atlas_ezo_id);
> @@ -160,6 +194,7 @@ MODULE_DEVICE_TABLE(i2c, atlas_ezo_id);
>  static const struct of_device_id atlas_ezo_dt_ids[] = {
>  	{ .compatible = "atlas,co2-ezo", .data = (void *)ATLAS_CO2_EZO, },
>  	{ .compatible = "atlas,o2-ezo", .data = (void *)ATLAS_O2_EZO, },
> +	{ .compatible = "atlas,hum-ezo", .data = (void *)ATLAS_HUM_EZO, },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, atlas_ezo_dt_ids);

