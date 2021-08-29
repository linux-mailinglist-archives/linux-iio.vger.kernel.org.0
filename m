Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF99C3FAC3E
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 16:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhH2ObT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 10:31:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229824AbhH2ObO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 10:31:14 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A6AD60F36;
        Sun, 29 Aug 2021 14:30:19 +0000 (UTC)
Date:   Sun, 29 Aug 2021 15:33:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v6 2/5] iio: adc: ad7949: fix spi messages on non 14-bit
 controllers
Message-ID: <20210829153334.07f5c64c@jic23-huawei>
In-Reply-To: <20210815213309.2847711-3-liambeguin@gmail.com>
References: <20210815213309.2847711-1-liambeguin@gmail.com>
        <20210815213309.2847711-3-liambeguin@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Aug 2021 17:33:06 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> From: Liam Beguin <lvb@xiphos.com>
> 
> This driver supports devices with 14-bit and 16-bit sample sizes.
> This implies different SPI transfer lengths which are not always handled
> properly by some SPI controllers.
> 
> To work around this limitation, define a big endian buffer used to split
> the buffer into two 8-bit messages in the event that the controller
> doesn't support 14-bit or 16-bit transfers.
> A separate buffer is introduced here to avoid performing operations on
> types of different endianness.
> 
> Since all transfers use the same bits_per_word value, move that logic to
> the probe function, and let transfers default to the value defined in
> the struct spi_device.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
Hi Liam, 

I changed the title of this one to avoid it being picked up for automated
backporting.  I don't mind if you want to request it is backported explicitly
but it isn't a regression fix (as it never worked on such controllers) and
is non trivial.  As a result I want a backport to be a deliberate decision.
Now titled "iio: adc: ad7949: enable use with non 14/16-bit controllers"

This and previous applied to the togreg branch of iio.git and pushed out
as testing for 0-day to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7949.c | 86 +++++++++++++++++++++++++++-------------
>  1 file changed, 58 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> index adc4487a7d56..a263d0fcec75 100644
> --- a/drivers/iio/adc/ad7949.c
> +++ b/drivers/iio/adc/ad7949.c
> @@ -14,7 +14,6 @@
>  #include <linux/bitfield.h>
>  
>  #define AD7949_CFG_MASK_TOTAL		GENMASK(13, 0)
> -#define AD7949_CFG_REG_SIZE_BITS	14
>  
>  /* CFG: Configuration Update */
>  #define AD7949_CFG_MASK_OVERWRITE	BIT(13)
> @@ -71,6 +70,7 @@ static const struct ad7949_adc_spec ad7949_adc_spec[] = {
>   * @cfg: copy of the configuration register
>   * @current_channel: current channel in use
>   * @buffer: buffer to send / receive data to / from device
> + * @buf8b: be16 buffer to exchange data with the device in 8-bit transfers
>   */
>  struct ad7949_adc_chip {
>  	struct mutex lock;
> @@ -81,27 +81,34 @@ struct ad7949_adc_chip {
>  	u16 cfg;
>  	unsigned int current_channel;
>  	u16 buffer ____cacheline_aligned;
> +	__be16 buf8b;
>  };
>  
>  static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
>  				u16 mask)
>  {
>  	int ret;
> -	int bits_per_word = ad7949_adc->resolution;
> -	int shift = bits_per_word - AD7949_CFG_REG_SIZE_BITS;
> -	struct spi_message msg;
> -	struct spi_transfer tx[] = {
> -		{
> -			.tx_buf = &ad7949_adc->buffer,
> -			.len = 2,
> -			.bits_per_word = bits_per_word,
> -		},
> -	};
>  
>  	ad7949_adc->cfg = (val & mask) | (ad7949_adc->cfg & ~mask);
> -	ad7949_adc->buffer = ad7949_adc->cfg << shift;
> -	spi_message_init_with_transfers(&msg, tx, 1);
> -	ret = spi_sync(ad7949_adc->spi, &msg);
> +
> +	switch (ad7949_adc->spi->bits_per_word) {
> +	case 16:
> +		ad7949_adc->buffer = ad7949_adc->cfg << 2;
> +		ret = spi_write(ad7949_adc->spi, &ad7949_adc->buffer, 2);
> +		break;
> +	case 14:
> +		ad7949_adc->buffer = ad7949_adc->cfg;
> +		ret = spi_write(ad7949_adc->spi, &ad7949_adc->buffer, 2);
> +		break;
> +	case 8:
> +		/* Here, type is big endian as it must be sent in two transfers */
> +		ad7949_adc->buf8b = cpu_to_be16(ad7949_adc->cfg << 2);
> +		ret = spi_write(ad7949_adc->spi, &ad7949_adc->buf8b, 2);
> +		break;
> +	default:
> +		dev_err(&ad7949_adc->indio_dev->dev, "unsupported BPW\n");
> +		return -EINVAL;
> +	}
>  
>  	/*
>  	 * This delay is to avoid a new request before the required time to
> @@ -116,16 +123,6 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
>  {
>  	int ret;
>  	int i;
> -	int bits_per_word = ad7949_adc->resolution;
> -	int mask = GENMASK(ad7949_adc->resolution - 1, 0);
> -	struct spi_message msg;
> -	struct spi_transfer tx[] = {
> -		{
> -			.rx_buf = &ad7949_adc->buffer,
> -			.len = 2,
> -			.bits_per_word = bits_per_word,
> -		},
> -	};
>  
>  	/*
>  	 * 1: write CFG for sample N and read old data (sample N-2)
> @@ -144,9 +141,11 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
>  	}
>  
>  	/* 3: write something and read actual data */
> -	ad7949_adc->buffer = 0;
> -	spi_message_init_with_transfers(&msg, tx, 1);
> -	ret = spi_sync(ad7949_adc->spi, &msg);
> +	if (ad7949_adc->spi->bits_per_word == 8)
> +		ret = spi_read(ad7949_adc->spi, &ad7949_adc->buf8b, 2);
> +	else
> +		ret = spi_read(ad7949_adc->spi, &ad7949_adc->buffer, 2);
> +
>  	if (ret)
>  		return ret;
>  
> @@ -158,7 +157,25 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
>  
>  	ad7949_adc->current_channel = channel;
>  
> -	*val = ad7949_adc->buffer & mask;
> +	switch (ad7949_adc->spi->bits_per_word) {
> +	case 16:
> +		*val = ad7949_adc->buffer;
> +		/* Shift-out padding bits */
> +		*val >>= 16 - ad7949_adc->resolution;
> +		break;
> +	case 14:
> +		*val = ad7949_adc->buffer & GENMASK(13, 0);
> +		break;
> +	case 8:
> +		/* Here, type is big endian as data was sent in two transfers */
> +		*val = be16_to_cpu(ad7949_adc->buf8b);
> +		/* Shift-out padding bits */
> +		*val >>= 16 - ad7949_adc->resolution;
> +		break;
> +	default:
> +		dev_err(&ad7949_adc->indio_dev->dev, "unsupported BPW\n");
> +		return -EINVAL;
> +	}
>  
>  	return 0;
>  }
> @@ -266,6 +283,7 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
>  
>  static int ad7949_spi_probe(struct spi_device *spi)
>  {
> +	u32 spi_ctrl_mask = spi->controller->bits_per_word_mask;
>  	struct device *dev = &spi->dev;
>  	const struct ad7949_adc_spec *spec;
>  	struct ad7949_adc_chip *ad7949_adc;
> @@ -292,6 +310,18 @@ static int ad7949_spi_probe(struct spi_device *spi)
>  	indio_dev->num_channels = spec->num_channels;
>  	ad7949_adc->resolution = spec->resolution;
>  
> +	/* Set SPI bits per word */
> +	if (spi_ctrl_mask & SPI_BPW_MASK(ad7949_adc->resolution)) {
> +		spi->bits_per_word = ad7949_adc->resolution;
> +	} else if (spi_ctrl_mask == SPI_BPW_MASK(16)) {
> +		spi->bits_per_word = 16;
> +	} else if (spi_ctrl_mask == SPI_BPW_MASK(8)) {
> +		spi->bits_per_word = 8;
> +	} else {
> +		dev_err(dev, "unable to find common BPW with spi controller\n");
> +		return -EINVAL;
> +	}
> +
>  	ad7949_adc->vref = devm_regulator_get(dev, "vref");
>  	if (IS_ERR(ad7949_adc->vref)) {
>  		dev_err(dev, "fail to request regulator\n");

