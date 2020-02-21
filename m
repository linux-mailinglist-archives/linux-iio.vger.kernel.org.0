Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12A4D168358
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 17:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgBUQ3e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 11:29:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgBUQ3d (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 11:29:33 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 159D620578;
        Fri, 21 Feb 2020 16:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582302572;
        bh=bIv/Gy0try/2Ck0ORPZ1Orj2uFYFNPfi1/q/uWGc46A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N2Du/4sVBYICOmQahOIcWd9WCDUm9IKZNq0F02nT12xlRyNQwSePXONEfPjiFUTKe
         m1HT6tp4wnwNyvsqtCUYAFxZR09bI/iNpmBlHC3/tHt1IPTq+Ia0ZtEzqh8uK4b1AJ
         7NdowZNOaVC3vJaNm031XQTWnVhM1gbJTNO9SY7s=
Date:   Fri, 21 Feb 2020 16:29:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: Re: [PATCH v2] iio: amplifiers: ad8366: add support for HMC1119
 Attenuator
Message-ID: <20200221162929.41870ce9@archlinux>
In-Reply-To: <20200221161826.21291-1-alexandru.ardelean@analog.com>
References: <20200220092821.11050-1-sergiu.cuciurean@analog.com>
        <20200221161826.21291-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 21 Feb 2020 18:18:26 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> This change adds support for the HMC1119 Silicon Digial Attenuator. The
> HMC1119 is a broadband, highly accurate, 7-bit digital attenuator,
> operating from 0.1 GHz to 6.0 GHz with 31.5 dB attenuation control range
> in 0.25 dB steps.
> 
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/hmc1119.pdf
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

Applied, thanks.

Jonathan

> ---
>  drivers/iio/amplifiers/ad8366.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
> index 95972ab60f42..62167b87caea 100644
> --- a/drivers/iio/amplifiers/ad8366.c
> +++ b/drivers/iio/amplifiers/ad8366.c
> @@ -5,6 +5,7 @@
>   *   AD8366 Dual-Digital Variable Gain Amplifier (VGA)
>   *   ADA4961 BiCMOS RF Digital Gain Amplifier (DGA)
>   *   ADL5240 Digitally controlled variable gain amplifier (VGA)
> + *   HMC1119 0.25 dB LSB, 7-Bit, Silicon Digital Attenuator
>   *
>   * Copyright 2012-2019 Analog Devices Inc.
>   */
> @@ -27,6 +28,7 @@ enum ad8366_type {
>  	ID_AD8366,
>  	ID_ADA4961,
>  	ID_ADL5240,
> +	ID_HMC1119,
>  };
>  
>  struct ad8366_info {
> @@ -62,6 +64,10 @@ static struct ad8366_info ad8366_infos[] = {
>  		.gain_min = -11500,
>  		.gain_max = 20000,
>  	},
> +	[ID_HMC1119] = {
> +		.gain_min = -31750,
> +		.gain_max = 0,
> +	},
>  };
>  
>  static int ad8366_write(struct iio_dev *indio_dev,
> @@ -84,6 +90,9 @@ static int ad8366_write(struct iio_dev *indio_dev,
>  	case ID_ADL5240:
>  		st->data[0] = (ch_a & 0x3F);
>  		break;
> +	case ID_HMC1119:
> +		st->data[0] = ch_a;
> +		break;
>  	}
>  
>  	ret = spi_write(st->spi, st->data, indio_dev->num_channels);
> @@ -118,6 +127,9 @@ static int ad8366_read_raw(struct iio_dev *indio_dev,
>  		case ID_ADL5240:
>  			gain = 20000 - 31500 + code * 500;
>  			break;
> +		case ID_HMC1119:
> +			gain = -1 * code * 250;
> +			break;
>  		}
>  
>  		/* Values in dB */
> @@ -164,6 +176,9 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
>  	case ID_ADL5240:
>  		code = ((gain - 500 - 20000) / 500) & 0x3F;
>  		break;
> +	case ID_HMC1119:
> +		code = (abs(gain) / 250) & 0x7F;
> +		break;
>  	}
>  
>  	mutex_lock(&st->lock);
> @@ -246,6 +261,7 @@ static int ad8366_probe(struct spi_device *spi)
>  		break;
>  	case ID_ADA4961:
>  	case ID_ADL5240:
> +	case ID_HMC1119:
>  		st->reset_gpio = devm_gpiod_get(&spi->dev, "reset",
>  			GPIOD_OUT_HIGH);
>  		indio_dev->channels = ada4961_channels;
> @@ -298,6 +314,7 @@ static const struct spi_device_id ad8366_id[] = {
>  	{"ad8366",  ID_AD8366},
>  	{"ada4961", ID_ADA4961},
>  	{"adl5240", ID_ADL5240},
> +	{"hmc1119", ID_HMC1119},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, ad8366_id);

