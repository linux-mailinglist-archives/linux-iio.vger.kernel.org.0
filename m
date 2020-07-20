Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D84F225D70
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jul 2020 13:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgGTL3v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 07:29:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbgGTL3v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Jul 2020 07:29:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2978722B4D;
        Mon, 20 Jul 2020 11:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595244590;
        bh=yFWdQeS2UjVpRt8SIG9rT+mebfOyARTCZy0XtkoKNxY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pyLG10R8Wan7J8ce/CoGhMZRJgN1bhDR021+IlsrHuXZbkomCk3QbobDcUi8fBAeI
         3ZhL2FXQBNyQv6N/YViAgcHmwp4hA0U6Jp7DoV128m5JMQYRtf8iJYkHcxHvfch/T3
         eNEJpwGlgK3nMvOfIgM6CFEIU59chBc9K7Y0TvCk=
Date:   Mon, 20 Jul 2020 12:29:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ad7124: move chip ID & name on the chip_info
 table
Message-ID: <20200720122947.7c3cfc6e@archlinux>
In-Reply-To: <20200714051111.17892-1-alexandru.ardelean@analog.com>
References: <20200714051111.17892-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Jul 2020 08:11:11 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change does the following:
> * removes the SPI device table in favor of the OF device table
> * adds 'name' && 'chip_id' fields to chip_info
> * implements chip ID & silicon revision checking; the device ID for
>   AD7124-4 is 0x0, so just checking that value can be useless;
>   but at least the silicon revision isn't 0, so a non-zero value can be
>   used to check that "a" device is on the SPI bus; it's probably the best
>   way to narrow it down to one of the 2 AD7124 chip IDs
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Nice patch.

Applied to the togreg branch of iio.git and pushed out as testing for
the auto builders to play with it.

At somepoint we could think about moving this driver over to generic
fw interfaces, but that is a bigger job and no particular reason to
do that now (if it's even possible!)

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7124.c | 73 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 59 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index bb53ab265b64..8dce06e9e69c 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -12,6 +12,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
>  
> @@ -47,6 +48,15 @@
>  #define AD7124_ADC_CTRL_MODE_MSK	GENMASK(5, 2)
>  #define AD7124_ADC_CTRL_MODE(x)	FIELD_PREP(AD7124_ADC_CTRL_MODE_MSK, x)
>  
> +/* AD7124 ID */
> +#define AD7124_DEVICE_ID_MSK		GENMASK(7, 4)
> +#define AD7124_DEVICE_ID_GET(x)		FIELD_GET(AD7124_DEVICE_ID_MSK, x)
> +#define AD7124_SILICON_REV_MSK		GENMASK(3, 0)
> +#define AD7124_SILICON_REV_GET(x)	FIELD_GET(AD7124_SILICON_REV_MSK, x)
> +
> +#define CHIPID_AD7124_4			0x0
> +#define CHIPID_AD7124_8			0x1
> +
>  /* AD7124_CHANNEL_X */
>  #define AD7124_CHANNEL_EN_MSK		BIT(15)
>  #define AD7124_CHANNEL_EN(x)		FIELD_PREP(AD7124_CHANNEL_EN_MSK, x)
> @@ -120,6 +130,8 @@ static const char * const ad7124_ref_names[] = {
>  };
>  
>  struct ad7124_chip_info {
> +	const char *name;
> +	unsigned int chip_id;
>  	unsigned int num_inputs;
>  };
>  
> @@ -165,9 +177,13 @@ static const struct iio_chan_spec ad7124_channel_template = {
>  
>  static struct ad7124_chip_info ad7124_chip_info_tbl[] = {
>  	[ID_AD7124_4] = {
> +		.name = "ad7127-4",
> +		.chip_id = CHIPID_AD7124_4,
>  		.num_inputs = 8,
>  	},
>  	[ID_AD7124_8] = {
> +		.name = "ad7127-8",
> +		.chip_id = CHIPID_AD7124_8,
>  		.num_inputs = 16,
>  	},
>  };
> @@ -503,6 +519,34 @@ static int ad7124_soft_reset(struct ad7124_state *st)
>  	return -EIO;
>  }
>  
> +static int ad7124_check_chip_id(struct ad7124_state *st)
> +{
> +	unsigned int readval, chip_id, silicon_rev;
> +	int ret;
> +
> +	ret = ad_sd_read_reg(&st->sd, AD7124_ID, 1, &readval);
> +	if (ret < 0)
> +		return ret;
> +
> +	chip_id = AD7124_DEVICE_ID_GET(readval);
> +	silicon_rev = AD7124_SILICON_REV_GET(readval);
> +
> +	if (chip_id != st->chip_info->chip_id) {
> +		dev_err(&st->sd.spi->dev,
> +			"Chip ID mismatch: expected %u, got %u\n",
> +			st->chip_info->chip_id, chip_id);
> +		return -ENODEV;
> +	}
> +
> +	if (silicon_rev == 0) {
> +		dev_err(&st->sd.spi->dev,
> +			"Silicon revision empty. Chip may not be present\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
>  static int ad7124_init_channel_vref(struct ad7124_state *st,
>  				    unsigned int channel_number)
>  {
> @@ -665,25 +709,28 @@ static int ad7124_setup(struct ad7124_state *st)
>  
>  static int ad7124_probe(struct spi_device *spi)
>  {
> -	const struct spi_device_id *id;
> +	const struct ad7124_chip_info *info;
>  	struct ad7124_state *st;
>  	struct iio_dev *indio_dev;
>  	int i, ret;
>  
> +	info = of_device_get_match_data(&spi->dev);
> +	if (!info)
> +		return -ENODEV;
> +
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
>  
> -	id = spi_get_device_id(spi);
> -	st->chip_info = &ad7124_chip_info_tbl[id->driver_data];
> +	st->chip_info = info;
>  
>  	ad_sd_init(&st->sd, indio_dev, spi, &ad7124_sigma_delta_info);
>  
>  	spi_set_drvdata(spi, indio_dev);
>  
> -	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->name = st->chip_info->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &ad7124_info;
>  
> @@ -721,6 +768,10 @@ static int ad7124_probe(struct spi_device *spi)
>  	if (ret < 0)
>  		goto error_clk_disable_unprepare;
>  
> +	ret = ad7124_check_chip_id(st);
> +	if (ret)
> +		goto error_clk_disable_unprepare;
> +
>  	ret = ad7124_setup(st);
>  	if (ret < 0)
>  		goto error_clk_disable_unprepare;
> @@ -768,16 +819,11 @@ static int ad7124_remove(struct spi_device *spi)
>  	return 0;
>  }
>  
> -static const struct spi_device_id ad7124_id_table[] = {
> -	{ "ad7124-4", ID_AD7124_4 },
> -	{ "ad7124-8", ID_AD7124_8 },
> -	{}
> -};
> -MODULE_DEVICE_TABLE(spi, ad7124_id_table);
> -
>  static const struct of_device_id ad7124_of_match[] = {
> -	{ .compatible = "adi,ad7124-4" },
> -	{ .compatible = "adi,ad7124-8" },
> +	{ .compatible = "adi,ad7124-4",
> +		.data = &ad7124_chip_info_tbl[ID_AD7124_4], },
> +	{ .compatible = "adi,ad7124-8",
> +		.data = &ad7124_chip_info_tbl[ID_AD7124_8], },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, ad7124_of_match);
> @@ -789,7 +835,6 @@ static struct spi_driver ad71124_driver = {
>  	},
>  	.probe = ad7124_probe,
>  	.remove	= ad7124_remove,
> -	.id_table = ad7124_id_table,
>  };
>  module_spi_driver(ad71124_driver);
>  

