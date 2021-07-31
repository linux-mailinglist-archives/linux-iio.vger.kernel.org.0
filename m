Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7343DC64B
	for <lists+linux-iio@lfdr.de>; Sat, 31 Jul 2021 16:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhGaO0v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Jul 2021 10:26:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232752AbhGaO0v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Jul 2021 10:26:51 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A296F60F3A;
        Sat, 31 Jul 2021 14:26:41 +0000 (UTC)
Date:   Sat, 31 Jul 2021 15:29:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v4 2/5] iio: adc: ad7949: fix spi messages on non 14-bit
 controllers
Message-ID: <20210731152921.2fcb53ab@jic23-huawei>
In-Reply-To: <20210727232906.980769-3-liambeguin@gmail.com>
References: <20210727232906.980769-1-liambeguin@gmail.com>
        <20210727232906.980769-3-liambeguin@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Jul 2021 19:29:03 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> From: Liam Beguin <lvb@xiphos.com>
> 
> This driver supports devices with 14-bit and 16-bit sample sizes.
> This is not always handled properly by spi controllers and can fail. To
> work around this limitation, pad samples to 16-bit and split the sample
> into two 8-bit messages in the event that only 8-bit messages are
> supported by the controller.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/iio/adc/ad7949.c | 62 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 54 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> index 0b549b8bd7a9..f1702c54c8be 100644
> --- a/drivers/iio/adc/ad7949.c
> +++ b/drivers/iio/adc/ad7949.c
> @@ -67,6 +67,7 @@ static const struct ad7949_adc_spec ad7949_adc_spec[] = {
>   * @indio_dev: reference to iio structure
>   * @spi: reference to spi structure
>   * @resolution: resolution of the chip
> + * @bits_per_word: number of bits per SPI word
>   * @cfg: copy of the configuration register
>   * @current_channel: current channel in use
>   * @buffer: buffer to send / receive data to / from device
> @@ -77,6 +78,7 @@ struct ad7949_adc_chip {
>  	struct iio_dev *indio_dev;
>  	struct spi_device *spi;
>  	u8 resolution;
> +	u8 bits_per_word;
>  	u16 cfg;
>  	unsigned int current_channel;
>  	u16 buffer ____cacheline_aligned;
> @@ -86,19 +88,34 @@ static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
>  				u16 mask)
>  {
>  	int ret;
> -	int bits_per_word = ad7949_adc->resolution;
> -	int shift = bits_per_word - AD7949_CFG_REG_SIZE_BITS;

The define for this was removed in patch 1.  I'll fix that up whilst applying by
keeping it until this patch.  Please check build passes on intermediate points
during a patch series as otherwise we may break bisectability and that's really
annoying if you are bisecting!

Jonathan

>  	struct spi_message msg;
>  	struct spi_transfer tx[] = {
>  		{
>  			.tx_buf = &ad7949_adc->buffer,
>  			.len = 2,
> -			.bits_per_word = bits_per_word,
> +			.bits_per_word = ad7949_adc->bits_per_word,
>  		},
>  	};
>  
> +	ad7949_adc->buffer = 0;
>  	ad7949_adc->cfg = (val & mask) | (ad7949_adc->cfg & ~mask);
> -	ad7949_adc->buffer = ad7949_adc->cfg << shift;
> +
> +	switch (ad7949_adc->bits_per_word) {
> +	case 16:
> +		ad7949_adc->buffer = ad7949_adc->cfg << 2;
> +		break;
> +	case 14:
> +		ad7949_adc->buffer = ad7949_adc->cfg;
> +		break;
> +	case 8:
> +		/* Here, type is big endian as it must be sent in two transfers */
> +		ad7949_adc->buffer = (u16)cpu_to_be16(ad7949_adc->cfg << 2);
> +		break;
> +	default:
> +		dev_err(&ad7949_adc->indio_dev->dev, "unsupported BPW\n");
> +		return -EINVAL;
> +	}
> +
>  	spi_message_init_with_transfers(&msg, tx, 1);
>  	ret = spi_sync(ad7949_adc->spi, &msg);
>  
> @@ -115,14 +132,12 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
>  {
>  	int ret;
>  	int i;
> -	int bits_per_word = ad7949_adc->resolution;
> -	int mask = GENMASK(ad7949_adc->resolution - 1, 0);
>  	struct spi_message msg;
>  	struct spi_transfer tx[] = {
>  		{
>  			.rx_buf = &ad7949_adc->buffer,
>  			.len = 2,
> -			.bits_per_word = bits_per_word,
> +			.bits_per_word = ad7949_adc->bits_per_word,
>  		},
>  	};
>  
> @@ -157,7 +172,25 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
>  
>  	ad7949_adc->current_channel = channel;
>  
> -	*val = ad7949_adc->buffer & mask;
> +	switch (ad7949_adc->bits_per_word) {
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
> +		*val = be16_to_cpu(ad7949_adc->buffer);
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
> @@ -265,6 +298,7 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
>  
>  static int ad7949_spi_probe(struct spi_device *spi)
>  {
> +	u32 spi_ctrl_mask = spi->controller->bits_per_word_mask;
>  	struct device *dev = &spi->dev;
>  	const struct ad7949_adc_spec *spec;
>  	struct ad7949_adc_chip *ad7949_adc;
> @@ -291,6 +325,18 @@ static int ad7949_spi_probe(struct spi_device *spi)
>  	indio_dev->num_channels = spec->num_channels;
>  	ad7949_adc->resolution = spec->resolution;
>  
> +	/* Set SPI bits per word */
> +	if (spi_ctrl_mask & SPI_BPW_MASK(ad7949_adc->resolution)) {
> +		ad7949_adc->bits_per_word = ad7949_adc->resolution;
> +	} else if (spi_ctrl_mask == SPI_BPW_MASK(16)) {
> +		ad7949_adc->bits_per_word = 16;
> +	} else if (spi_ctrl_mask == SPI_BPW_MASK(8)) {
> +		ad7949_adc->bits_per_word = 8;
> +	} else {
> +		dev_err(dev, "unable to find common BPW with spi controller\n");
> +		return -EINVAL;
> +	}
> +
>  	ad7949_adc->vref = devm_regulator_get(dev, "vref");
>  	if (IS_ERR(ad7949_adc->vref)) {
>  		dev_err(dev, "fail to request regulator\n");

