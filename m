Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51ECE3A028
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 16:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfFHOFi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 8 Jun 2019 10:05:38 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:33148 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFHOFi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Jun 2019 10:05:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id BF0A29E9182;
        Sat,  8 Jun 2019 15:05:36 +0100 (BST)
Date:   Sat, 8 Jun 2019 15:05:35 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 5/5] iio: amplifiers: ad8366: Add support for ADL5240
 VGA
Message-ID: <20190608150535.4b4f5bf2@archlinux>
In-Reply-To: <20190530131812.3476-5-alexandru.ardelean@analog.com>
References: <20190530131812.3476-1-alexandru.ardelean@analog.com>
        <20190530131812.3476-5-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 May 2019 16:18:12 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The ADL5240 is a high performance, digitally controlled variable gain
> amplifier (VGA) operating from 100 MHz to 4000 MHz. The VGA integrates a
> high performance, 20 dB gain, internally matched amplifier (AMP) with a
> 6-bit digital step attenuator (DSA) that has a gain control range of
> 31.5 dB in 0.5 dB steps with ±0.25 dB step accuracy.
> 
> Datasheet link:
>   https://www.analog.com/media/en/technical-documentation/data-sheets/adl5240.pdf
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/amplifiers/Kconfig  |  1 +
>  drivers/iio/amplifiers/ad8366.c | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
> index 259058da8811..871e8060d996 100644
> --- a/drivers/iio/amplifiers/Kconfig
> +++ b/drivers/iio/amplifiers/Kconfig
> @@ -16,6 +16,7 @@ config AD8366
>  	  from Analog Devices:
>  	    AD8366 Dual-Digital Variable Gain Amplifier (VGA)
>  	    ADA4961 BiCMOS RF Digital Gain Amplifier (DGA)
> +	    ADL5240 Digitally controlled variable gain amplifier (VGA)
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad8366.
> diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
> index 0a9883e8eb2e..0176d3d8cc9c 100644
> --- a/drivers/iio/amplifiers/ad8366.c
> +++ b/drivers/iio/amplifiers/ad8366.c
> @@ -4,6 +4,7 @@
>   * This driver supports the following gain amplifiers:
>   *   AD8366 Dual-Digital Variable Gain Amplifier (VGA)
>   *   ADA4961 BiCMOS RF Digital Gain Amplifier (DGA)
> + *   ADL5240 Digitally controlled variable gain amplifier (VGA)
>   *
>   * Copyright 2012-2019 Analog Devices Inc.
>   */
> @@ -25,6 +26,7 @@
>  enum ad8366_type {
>  	ID_AD8366,
>  	ID_ADA4961,
> +	ID_ADL5240,
>  };
>  
>  struct ad8366_info {
> @@ -56,6 +58,10 @@ static struct ad8366_info ad8366_infos[] = {
>  		.gain_min = -6000,
>  		.gain_max = 15000,
>  	},
> +	[ID_ADL5240] = {
> +		.gain_min = -11500,
> +		.gain_max = 20000,
> +	},
>  };
>  
>  static int ad8366_write(struct iio_dev *indio_dev,
> @@ -75,6 +81,9 @@ static int ad8366_write(struct iio_dev *indio_dev,
>  	case ID_ADA4961:
>  		st->data[0] = ch_a & 0x1F;
>  		break;
> +	case ID_ADL5240:
> +		st->data[0] = (ch_a & 0x3F);
> +		break;
>  	}
>  
>  	ret = spi_write(st->spi, st->data, indio_dev->num_channels);
> @@ -106,6 +115,9 @@ static int ad8366_read_raw(struct iio_dev *indio_dev,
>  		case ID_ADA4961:
>  			gain = 15000 - code * 1000;
>  			break;
> +		case ID_ADL5240:
> +			gain = 20000 - 31500 + code * 500;
> +			break;
>  		}
>  
>  		/* Values in dB */
> @@ -149,6 +161,9 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
>  	case ID_ADA4961:
>  		code = (15000 - gain) / 1000;
>  		break;
> +	case ID_ADL5240:
> +		code = ((gain - 500 - 20000) / 500) & 0x3F;
> +		break;
>  	}
>  
>  	mutex_lock(&st->lock);
> @@ -217,6 +232,7 @@ static int ad8366_probe(struct spi_device *spi)
>  		indio_dev->num_channels = ARRAY_SIZE(ad8366_channels);
>  		break;
>  	case ID_ADA4961:
> +	case ID_ADL5240:
>  		st->reset_gpio = devm_gpiod_get(&spi->dev, "reset",
>  			GPIOD_OUT_HIGH);
>  		indio_dev->channels = ada4961_channels;
> @@ -268,6 +284,7 @@ static int ad8366_remove(struct spi_device *spi)
>  static const struct spi_device_id ad8366_id[] = {
>  	{"ad8366",  ID_AD8366},
>  	{"ada4961", ID_ADA4961},
> +	{"adl5240", ID_ADL5240},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, ad8366_id);

