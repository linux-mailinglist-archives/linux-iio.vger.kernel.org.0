Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486CC31EB90
	for <lists+linux-iio@lfdr.de>; Thu, 18 Feb 2021 16:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhBRP1i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Feb 2021 10:27:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:57620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230182AbhBRNfW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 18 Feb 2021 08:35:22 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66ED864E6F;
        Thu, 18 Feb 2021 13:34:13 +0000 (UTC)
Date:   Thu, 18 Feb 2021 13:34:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <mircea.caprioru@analog.com>
Subject: Re: [PATCH][RESEND] iio: dac: ad5686: Add support for
 AD5673R/AD5677R
Message-ID: <20210218133351.32fcaead@archlinux>
In-Reply-To: <20210217074102.23148-1-alexandru.ardelean@analog.com>
References: <20210217074102.23148-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 17 Feb 2021 09:41:02 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Mircea Caprioru <mircea.caprioru@analog.com>
> 
> The AD5673R/AD5677R are low power, 16-channel, 12-/16-bit buffered voltage
> output digital-to-analog converters (DACs). They include a 2.5 V internal
> reference (enabled by default).
> 
> These devices are very similar to AD5674R/AD5679R, except that they
> have an i2c interface.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied, thanks

Jonathan

> ---
> 
> Forgot to include the linux-iio list in the first send.
> 
>  drivers/iio/dac/Kconfig      |  5 +++--
>  drivers/iio/dac/ad5686.c     | 12 ++++++++++++
>  drivers/iio/dac/ad5686.h     |  2 ++
>  drivers/iio/dac/ad5696-i2c.c |  6 ++++--
>  4 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index cea07b4cced1..75e1f2b48638 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -142,8 +142,9 @@ config AD5696_I2C
>  	select AD5686
>  	help
>  	  Say yes here to build support for Analog Devices AD5311R, AD5338R,
> -	  AD5671R, AD5675R, AD5691R, AD5692R, AD5693, AD5693R, AD5694, AD5694R,
> -	  AD5695R, AD5696, and AD5696R Digital to Analog converters.
> +	  AD5671R, AD5673R, AD5675R, AD5677R, AD5691R, AD5692R, AD5693, AD5693R,
> +	  AD5694, AD5694R, AD5695R, AD5696, and AD5696R Digital to Analog
> +	  converters.
>  
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad5696.
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 7d6792ac1020..99a95282ac57 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -301,6 +301,12 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
>  		.num_channels = 8,
>  		.regmap_type = AD5686_REGMAP,
>  	},
> +	[ID_AD5673R] = {
> +		.channels = ad5674r_channels,
> +		.int_vref_mv = 2500,
> +		.num_channels = 16,
> +		.regmap_type = AD5686_REGMAP,
> +	},
>  	[ID_AD5674R] = {
>  		.channels = ad5674r_channels,
>  		.int_vref_mv = 2500,
> @@ -324,6 +330,12 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
>  		.num_channels = 8,
>  		.regmap_type = AD5686_REGMAP,
>  	},
> +	[ID_AD5677R] = {
> +		.channels = ad5679r_channels,
> +		.int_vref_mv = 2500,
> +		.num_channels = 16,
> +		.regmap_type = AD5686_REGMAP,
> +	},
>  	[ID_AD5679R] = {
>  		.channels = ad5679r_channels,
>  		.int_vref_mv = 2500,
> diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
> index d9c8ba413fe9..f89a6f92b427 100644
> --- a/drivers/iio/dac/ad5686.h
> +++ b/drivers/iio/dac/ad5686.h
> @@ -55,10 +55,12 @@ enum ad5686_supported_device_ids {
>  	ID_AD5338R,
>  	ID_AD5671R,
>  	ID_AD5672R,
> +	ID_AD5673R,
>  	ID_AD5674R,
>  	ID_AD5675R,
>  	ID_AD5676,
>  	ID_AD5676R,
> +	ID_AD5677R,
>  	ID_AD5679R,
>  	ID_AD5681R,
>  	ID_AD5682R,
> diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
> index a39eda7c02d2..24a6a4a5a2e0 100644
> --- a/drivers/iio/dac/ad5696-i2c.c
> +++ b/drivers/iio/dac/ad5696-i2c.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * AD5671R, AD5675R, AD5691R, AD5692R, AD5693, AD5693R,
> - * AD5694, AD5694R, AD5695R, AD5696, AD5696R
> + * AD5338R, AD5671R, AD5673R, AD5675R, AD5677R, AD5691R, AD5692R, AD5693,
> + * AD5693R, AD5694, AD5694R, AD5695R, AD5696, AD5696R
>   * Digital to analog converters driver
>   *
>   * Copyright 2018 Analog Devices Inc.
> @@ -74,7 +74,9 @@ static const struct i2c_device_id ad5686_i2c_id[] = {
>  	{"ad5311r", ID_AD5311R},
>  	{"ad5338r", ID_AD5338R},
>  	{"ad5671r", ID_AD5671R},
> +	{"ad5673r", ID_AD5673R},
>  	{"ad5675r", ID_AD5675R},
> +	{"ad5677r", ID_AD5677R},
>  	{"ad5691r", ID_AD5691R},
>  	{"ad5692r", ID_AD5692R},
>  	{"ad5693", ID_AD5693},

