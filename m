Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E316D107F64
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 17:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfKWQj6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 11:39:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:54610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfKWQj5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 11:39:57 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D8912070E;
        Sat, 23 Nov 2019 16:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574527196;
        bh=vnz+Jf99O/Ww0zYOkfsxikYGzP4iHYLJ6JSbM+xenaM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RCjuMk8jp8ljER3h05cd+zBv3ugxKjB4RTgL/J/EecqJ70vVSGeIm7DQECV6Vphvf
         MKZIuekQugmD3Ic6e07gBE9EZmpc6HGEUK/FIkolBeLfxnez+FptrY8WBcFK9U6tFX
         O3It0n3sqsbDMe1KVkwh//+OONx3Im4kQjd6YZAw=
Date:   Sat, 23 Nov 2019 16:39:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>
Subject: Re: [PATCH] iio: adc: ad7887: Cleanup channel assignment
Message-ID: <20191123163952.2667157b@archlinux>
In-Reply-To: <20191118150927.19411-1-beniamin.bia@analog.com>
References: <20191118150927.19411-1-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Nov 2019 17:09:27 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> The channels specification assignment in chip info was simplified.
> This patch makes supporting other devices by this driver easier.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>

I'm not entirely keen on the trick with channel ordering to support
the use of the second input as vref.

I would just pay the cost of having two different iio_chan_spec
arrays and pick the relevant one.

Jonathan


> ---
>  drivers/iio/adc/ad7887.c | 71 ++++++++++++++++++----------------------
>  1 file changed, 31 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
> index 6223043e432b..65d1338d9392 100644
> --- a/drivers/iio/adc/ad7887.c
> +++ b/drivers/iio/adc/ad7887.c
> @@ -43,11 +43,12 @@ enum ad7887_channels {
>  /**
>   * struct ad7887_chip_info - chip specifc information
>   * @int_vref_mv:	the internal reference voltage
> - * @channel:		channel specification
> + * @channels:		channels specification
>   */
>  struct ad7887_chip_info {
>  	u16				int_vref_mv;
> -	struct iio_chan_spec		channel[3];
> +	const struct iio_chan_spec	*channels;
> +	unsigned int			num_channels;
>  };
>  
>  struct ad7887_state {
> @@ -183,45 +184,36 @@ static int ad7887_read_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +#define AD7887_CHANNEL(x) { \
> +	.type = IIO_VOLTAGE, \
> +	.indexed = 1, \
> +	.channel = (x), \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> +	.address = (x), \
> +	.scan_index = (x), \
> +	.scan_type = { \
> +		.sign = 'u', \
> +		.realbits = 12, \
> +		.storagebits = 16, \
> +		.shift = 0, \
> +		.endianness = IIO_BE, \
> +	}, \
> +}
> +
> +static const struct iio_chan_spec ad7887_channels[] = {
> +	IIO_CHAN_SOFT_TIMESTAMP(8),
> +	AD7887_CHANNEL(0),
> +	AD7887_CHANNEL(1),
> +};
>  
>  static const struct ad7887_chip_info ad7887_chip_info_tbl[] = {
>  	/*
>  	 * More devices added in future
>  	 */
>  	[ID_AD7887] = {
> -		.channel[0] = {
> -			.type = IIO_VOLTAGE,
> -			.indexed = 1,
> -			.channel = 1,
> -			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> -			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> -			.address = 1,
> -			.scan_index = 1,
> -			.scan_type = {
> -				.sign = 'u',
> -				.realbits = 12,
> -				.storagebits = 16,
> -				.shift = 0,
> -				.endianness = IIO_BE,
> -			},
> -		},
> -		.channel[1] = {
> -			.type = IIO_VOLTAGE,
> -			.indexed = 1,
> -			.channel = 0,
> -			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> -			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> -			.address = 0,
> -			.scan_index = 0,
> -			.scan_type = {
> -				.sign = 'u',
> -				.realbits = 12,
> -				.storagebits = 16,
> -				.shift = 0,
> -				.endianness = IIO_BE,
> -			},
> -		},
> -		.channel[2] = IIO_CHAN_SOFT_TIMESTAMP(2),
> +		.channels = ad7887_channels,
> +		.num_channels = ARRAY_SIZE(ad7887_channels),
>  		.int_vref_mv = 2500,
>  	},
>  };
> @@ -284,6 +276,9 @@ static int ad7887_probe(struct spi_device *spi)
>  	spi_message_init(&st->msg[AD7887_CH0]);
>  	spi_message_add_tail(&st->xfer[0], &st->msg[AD7887_CH0]);
>  
> +	indio_dev->channels = st->chip_info->channels;
> +	indio_dev->num_channels = st->chip_info->num_channels;
> +
>  	if (pdata && pdata->en_dual) {
>  		st->tx_cmd_buf[2] = AD7887_CH_AIN1 | mode;
>  
> @@ -305,12 +300,8 @@ static int ad7887_probe(struct spi_device *spi)
>  
>  		spi_message_init(&st->msg[AD7887_CH1]);
>  		spi_message_add_tail(&st->xfer[3], &st->msg[AD7887_CH1]);
> -
> -		indio_dev->channels = st->chip_info->channel;
> -		indio_dev->num_channels = 3;
>  	} else {
> -		indio_dev->channels = &st->chip_info->channel[1];
> -		indio_dev->num_channels = 2;
> +		indio_dev->num_channels = st->chip_info->num_channels - 1;
>  	}
>  
>  	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,

