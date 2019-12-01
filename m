Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA68F10E1BD
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2019 12:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfLALoD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Dec 2019 06:44:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfLALoD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Dec 2019 06:44:03 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9316E20833;
        Sun,  1 Dec 2019 11:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575200642;
        bh=tByoUwTMgZ8HHaQuYNzA3ZRZfBCczIoU/BZrjsO8QpI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OmQSSthUUtjZTTWnVVYln12q7U1x6QAqW2igLruXI30M7xhPi3xWjSCzMD6EZFVtD
         PhpAZlREjnDAhi6NsU5vhB8c0tUZ2UoJAaFqii4NQkl1zg/OZYUIlZ8cxLav0XhFyq
         IXgvmOiODOPwNKDmsyqN3TpMWT+G+4nAJkD08jKM=
Date:   Sun, 1 Dec 2019 11:43:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>
Subject: Re: [PATCH v2] iio: adc: ad7887: Cleanup channel assignment
Message-ID: <20191201114357.3c027077@archlinux>
In-Reply-To: <20191125132137.4753-1-beniamin.bia@analog.com>
References: <20191125132137.4753-1-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 25 Nov 2019 15:21:37 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> The channels specification assignment in chip info was simplified.
> This patch makes supporting other devices by this driver easier.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v2:
> -separate iio_chan_spec for dual mode
> 
>  drivers/iio/adc/ad7887.c | 82 +++++++++++++++++++++-------------------
>  1 file changed, 43 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
> index 6223043e432b..c6a3428e950a 100644
> --- a/drivers/iio/adc/ad7887.c
> +++ b/drivers/iio/adc/ad7887.c
> @@ -43,11 +43,17 @@ enum ad7887_channels {
>  /**
>   * struct ad7887_chip_info - chip specifc information
>   * @int_vref_mv:	the internal reference voltage
> - * @channel:		channel specification
> + * @channels:		channels specification
> + * @num_channels:	number of channels
> + * @dual_channels:	channels specification in dual mode
> + * @num_dual_channels:	number of channels in dual mode
>   */
>  struct ad7887_chip_info {
>  	u16				int_vref_mv;
> -	struct iio_chan_spec		channel[3];
> +	const struct iio_chan_spec	*channels;
> +	unsigned int			num_channels;
> +	const struct iio_chan_spec	*dual_channels;
> +	unsigned int			num_dual_channels;
>  };
>  
>  struct ad7887_state {
> @@ -183,45 +189,43 @@ static int ad7887_read_raw(struct iio_dev *indio_dev,
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
> +	AD7887_CHANNEL(0),
> +	IIO_CHAN_SOFT_TIMESTAMP(1),
> +};
> +
> +static const struct iio_chan_spec ad7887_dual_channels[] = {
> +	AD7887_CHANNEL(0),
> +	AD7887_CHANNEL(1),
> +	IIO_CHAN_SOFT_TIMESTAMP(2),
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
> +		.dual_channels = ad7887_dual_channels,
> +		.num_dual_channels = ARRAY_SIZE(ad7887_dual_channels),
>  		.int_vref_mv = 2500,
>  	},
>  };
> @@ -306,11 +310,11 @@ static int ad7887_probe(struct spi_device *spi)
>  		spi_message_init(&st->msg[AD7887_CH1]);
>  		spi_message_add_tail(&st->xfer[3], &st->msg[AD7887_CH1]);
>  
> -		indio_dev->channels = st->chip_info->channel;
> -		indio_dev->num_channels = 3;
> +		indio_dev->channels = st->chip_info->dual_channels;
> +		indio_dev->num_channels = st->chip_info->num_dual_channels;
>  	} else {
> -		indio_dev->channels = &st->chip_info->channel[1];
> -		indio_dev->num_channels = 2;
> +		indio_dev->channels = st->chip_info->channels;
> +		indio_dev->num_channels = st->chip_info->num_channels;
>  	}
>  
>  	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,

