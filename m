Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2E263A022
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 15:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfFHN5p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 09:57:45 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:33008 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfFHN5p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Jun 2019 09:57:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 356859E8FD6;
        Sat,  8 Jun 2019 14:57:43 +0100 (BST)
Date:   Sat, 8 Jun 2019 14:57:41 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/5] iio: amplifiers: ad8366: rework driver to allow
 other chips
Message-ID: <20190608145741.5c90baf3@archlinux>
In-Reply-To: <20190530131812.3476-3-alexandru.ardelean@analog.com>
References: <20190530131812.3476-1-alexandru.ardelean@analog.com>
        <20190530131812.3476-3-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 May 2019 16:18:10 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The SPI gain amplifiers are simple devices, with 1 or 2 channels, to which
> are read-from/written-to.
> 
> The gain computation in ad8366_write_raw() has been updated to compute gain
> in dB for negative values.
> 
> This driver will be extended to support other chips as well.
> To do that, this rework handles the AD8366 device as a special-case (via
> switch-statements). This will make things easier when adding new chips.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Looks good to me.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

thanks,

Jonathan

> ---
>  drivers/iio/amplifiers/ad8366.c | 81 +++++++++++++++++++++++++--------
>  1 file changed, 62 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
> index 24ff5475d9f2..1beda6409301 100644
> --- a/drivers/iio/amplifiers/ad8366.c
> +++ b/drivers/iio/amplifiers/ad8366.c
> @@ -18,11 +18,22 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> +enum ad8366_type {
> +	ID_AD8366,
> +};
> +
> +struct ad8366_info {
> +	int gain_min;
> +	int gain_max;
> +};
> +
>  struct ad8366_state {
>  	struct spi_device	*spi;
>  	struct regulator	*reg;
>  	struct mutex            lock; /* protect sensor state */
>  	unsigned char		ch[2];
> +	enum ad8366_type	type;
> +	struct ad8366_info	*info;
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
> @@ -30,19 +41,30 @@ struct ad8366_state {
>  	unsigned char		data[2] ____cacheline_aligned;
>  };
>  
> +static struct ad8366_info ad8366_infos[] = {
> +	[ID_AD8366] = {
> +		.gain_min = 4500,
> +		.gain_max = 20500,
> +	},
> +};
> +
>  static int ad8366_write(struct iio_dev *indio_dev,
>  			unsigned char ch_a, unsigned char ch_b)
>  {
>  	struct ad8366_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	ch_a = bitrev8(ch_a & 0x3F);
> -	ch_b = bitrev8(ch_b & 0x3F);
> +	switch (st->type) {
> +	case ID_AD8366:
> +		ch_a = bitrev8(ch_a & 0x3F);
> +		ch_b = bitrev8(ch_b & 0x3F);
>  
> -	st->data[0] = ch_b >> 4;
> -	st->data[1] = (ch_b << 4) | (ch_a >> 2);
> +		st->data[0] = ch_b >> 4;
> +		st->data[1] = (ch_b << 4) | (ch_a >> 2);
> +		break;
> +	}
>  
> -	ret = spi_write(st->spi, st->data, ARRAY_SIZE(st->data));
> +	ret = spi_write(st->spi, st->data, indio_dev->num_channels);
>  	if (ret < 0)
>  		dev_err(&indio_dev->dev, "write failed (%d)", ret);
>  
> @@ -57,17 +79,22 @@ static int ad8366_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct ad8366_state *st = iio_priv(indio_dev);
>  	int ret;
> -	unsigned code;
> +	int code, gain = 0;
>  
>  	mutex_lock(&st->lock);
>  	switch (m) {
>  	case IIO_CHAN_INFO_HARDWAREGAIN:
>  		code = st->ch[chan->channel];
>  
> +		switch (st->type) {
> +		case ID_AD8366:
> +			gain = code * 253 + 4500;
> +			break;
> +		}
> +
>  		/* Values in dB */
> -		code = code * 253 + 4500;
> -		*val = code / 1000;
> -		*val2 = (code % 1000) * 1000;
> +		*val = gain / 1000;
> +		*val2 = (gain % 1000) * 1000;
>  
>  		ret = IIO_VAL_INT_PLUS_MICRO_DB;
>  		break;
> @@ -86,19 +113,24 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
>  			    long mask)
>  {
>  	struct ad8366_state *st = iio_priv(indio_dev);
> -	unsigned code;
> +	struct ad8366_info *inf = st->info;
> +	int code = 0, gain;
>  	int ret;
>  
> -	if (val < 0 || val2 < 0)
> -		return -EINVAL;
> -
>  	/* Values in dB */
> -	code = (((u8)val * 1000) + ((u32)val2 / 1000));
> +	if (val < 0)
> +		gain = (val * 1000) - (val2 / 1000);
> +	else
> +		gain = (val * 1000) + (val2 / 1000);
>  
> -	if (code > 20500 || code < 4500)
> +	if (gain > inf->gain_max || gain < inf->gain_min)
>  		return -EINVAL;
>  
> -	code = (code - 4500) / 253;
> +	switch (st->type) {
> +	case ID_AD8366:
> +		code = (gain - 4500) / 253;
> +		break;
> +	}
>  
>  	mutex_lock(&st->lock);
>  	switch (mask) {
> @@ -154,13 +186,24 @@ static int ad8366_probe(struct spi_device *spi)
>  	spi_set_drvdata(spi, indio_dev);
>  	mutex_init(&st->lock);
>  	st->spi = spi;
> +	st->type = spi_get_device_id(spi)->driver_data;
> +
> +	switch (st->type) {
> +	case ID_AD8366:
> +		indio_dev->channels = ad8366_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(ad8366_channels);
> +		break;
> +	default:
> +		dev_err(&spi->dev, "Invalid device ID\n");
> +		ret = -EINVAL;
> +		goto error_disable_reg;
> +	}
>  
> +	st->info = &ad8366_infos[st->type];
>  	indio_dev->dev.parent = &spi->dev;
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->info = &ad8366_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = ad8366_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(ad8366_channels);
>  
>  	ret = ad8366_write(indio_dev, 0 , 0);
>  	if (ret < 0)
> @@ -194,7 +237,7 @@ static int ad8366_remove(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id ad8366_id[] = {
> -	{"ad8366", 0},
> +	{"ad8366",  ID_AD8366},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, ad8366_id);

