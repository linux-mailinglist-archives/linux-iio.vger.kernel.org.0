Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 536CB3A027
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 16:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfFHOEh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 10:04:37 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:33134 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFHOEh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Jun 2019 10:04:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 003F79E8FD6;
        Sat,  8 Jun 2019 15:04:34 +0100 (BST)
Date:   Sat, 8 Jun 2019 15:04:33 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        Paul Cercueil <paul.cercueil@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 4/5] iio: amplifiers: ad8366: Add support for the
 ADA4961 DGA
Message-ID: <20190608150433.49a356aa@archlinux>
In-Reply-To: <20190530131812.3476-4-alexandru.ardelean@analog.com>
References: <20190530131812.3476-1-alexandru.ardelean@analog.com>
        <20190530131812.3476-4-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 May 2019 16:18:11 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Paul Cercueil <paul.cercueil@analog.com>
> 
> This change adds support for the ADA4961 BiCMOS RF Digital Gain Amplifier,
> (DGA), which is optimized for driving heavy loads out 2.0 GHz and beyond.
> The device typically achieves -90 dBc IMD3 performance at 500 MHz and
> -85  dBc at 1.5 GHz.
> 
> Datasheet link:
>  http://www.analog.com/media/en/technical-documentation/data-sheets/ADA4961.pdf
> 
> This change re-uses the existing ad8366 driver, as most logic is similar.
> Also, this chip has a reset pin which is initialized during probe.
> 
> Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

I'm fairly sure you want a GPIOLIB kconfig dependency.
I've added it rather than going for a v2 for just that.
Give me a shout if it's not actually required!

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/amplifiers/Kconfig  |  9 ++++++---
>  drivers/iio/amplifiers/ad8366.c | 34 +++++++++++++++++++++++++++++++--
>  2 files changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
> index da5830da9bcf..259058da8811 100644
> --- a/drivers/iio/amplifiers/Kconfig
> +++ b/drivers/iio/amplifiers/Kconfig
> @@ -7,12 +7,15 @@
>  menu "Amplifiers"
>  
>  config AD8366
> -	tristate "Analog Devices AD8366 VGA"
> +	tristate "Analog Devices AD8366 and similar Gain Amplifiers"
>  	depends on SPI
>  	select BITREVERSE
>  	help
> -	  Say yes here to build support for Analog Devices AD8366
> -	  SPI Dual-Digital Variable Gain Amplifier (VGA).
> +	  Say yes here to build support for Analog Devices AD8366 and similar
> +	  gain amplifiers. This driver supports the following gain amplifiers
> +	  from Analog Devices:
> +	    AD8366 Dual-Digital Variable Gain Amplifier (VGA)
> +	    ADA4961 BiCMOS RF Digital Gain Amplifier (DGA)
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad8366.
> diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
> index 1beda6409301..0a9883e8eb2e 100644
> --- a/drivers/iio/amplifiers/ad8366.c
> +++ b/drivers/iio/amplifiers/ad8366.c
> @@ -1,6 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * AD8366 SPI Dual-Digital Variable Gain Amplifier (VGA)
> + * AD8366 and similar Gain Amplifiers
> + * This driver supports the following gain amplifiers:
> + *   AD8366 Dual-Digital Variable Gain Amplifier (VGA)
> + *   ADA4961 BiCMOS RF Digital Gain Amplifier (DGA)
>   *
>   * Copyright 2012-2019 Analog Devices Inc.
>   */
> @@ -11,6 +14,7 @@
>  #include <linux/sysfs.h>
>  #include <linux/spi/spi.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/gpio/consumer.h>
I'd be highly surprised if this didn't need a KCONFIG dependency
change...

>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/bitrev.h>
> @@ -20,6 +24,7 @@
>  
>  enum ad8366_type {
>  	ID_AD8366,
> +	ID_ADA4961,
>  };
>  
>  struct ad8366_info {
> @@ -31,6 +36,7 @@ struct ad8366_state {
>  	struct spi_device	*spi;
>  	struct regulator	*reg;
>  	struct mutex            lock; /* protect sensor state */
> +	struct gpio_desc	*reset_gpio;
>  	unsigned char		ch[2];
>  	enum ad8366_type	type;
>  	struct ad8366_info	*info;
> @@ -46,6 +52,10 @@ static struct ad8366_info ad8366_infos[] = {
>  		.gain_min = 4500,
>  		.gain_max = 20500,
>  	},
> +	[ID_ADA4961] = {
> +		.gain_min = -6000,
> +		.gain_max = 15000,
> +	},
>  };
>  
>  static int ad8366_write(struct iio_dev *indio_dev,
> @@ -62,6 +72,9 @@ static int ad8366_write(struct iio_dev *indio_dev,
>  		st->data[0] = ch_b >> 4;
>  		st->data[1] = (ch_b << 4) | (ch_a >> 2);
>  		break;
> +	case ID_ADA4961:
> +		st->data[0] = ch_a & 0x1F;
> +		break;
>  	}
>  
>  	ret = spi_write(st->spi, st->data, indio_dev->num_channels);
> @@ -90,6 +103,9 @@ static int ad8366_read_raw(struct iio_dev *indio_dev,
>  		case ID_AD8366:
>  			gain = code * 253 + 4500;
>  			break;
> +		case ID_ADA4961:
> +			gain = 15000 - code * 1000;
> +			break;
>  		}
>  
>  		/* Values in dB */
> @@ -130,6 +146,9 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
>  	case ID_AD8366:
>  		code = (gain - 4500) / 253;
>  		break;
> +	case ID_ADA4961:
> +		code = (15000 - gain) / 1000;
> +		break;
>  	}
>  
>  	mutex_lock(&st->lock);
> @@ -164,6 +183,10 @@ static const struct iio_chan_spec ad8366_channels[] = {
>  	AD8366_CHAN(1),
>  };
>  
> +static const struct iio_chan_spec ada4961_channels[] = {
> +	AD8366_CHAN(0),
> +};
> +
>  static int ad8366_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> @@ -193,6 +216,12 @@ static int ad8366_probe(struct spi_device *spi)
>  		indio_dev->channels = ad8366_channels;
>  		indio_dev->num_channels = ARRAY_SIZE(ad8366_channels);
>  		break;
> +	case ID_ADA4961:
> +		st->reset_gpio = devm_gpiod_get(&spi->dev, "reset",
> +			GPIOD_OUT_HIGH);
> +		indio_dev->channels = ada4961_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(ada4961_channels);
> +		break;
>  	default:
>  		dev_err(&spi->dev, "Invalid device ID\n");
>  		ret = -EINVAL;
> @@ -238,6 +267,7 @@ static int ad8366_remove(struct spi_device *spi)
>  
>  static const struct spi_device_id ad8366_id[] = {
>  	{"ad8366",  ID_AD8366},
> +	{"ada4961", ID_ADA4961},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, ad8366_id);
> @@ -254,5 +284,5 @@ static struct spi_driver ad8366_driver = {
>  module_spi_driver(ad8366_driver);
>  
>  MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> -MODULE_DESCRIPTION("Analog Devices AD8366 VGA");
> +MODULE_DESCRIPTION("Analog Devices AD8366 and similar Gain Amplifiers");
>  MODULE_LICENSE("GPL v2");

