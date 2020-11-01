Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3542A2199
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 21:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgKAUrY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 15:47:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726848AbgKAUrY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Nov 2020 15:47:24 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC08121527;
        Sun,  1 Nov 2020 20:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604263643;
        bh=hvn7E+/+MvJxm01yk9nw+/BUv3sMoRLa5MXoCGX9xp4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jxEQobWqQ1QBLnzczITZja5kUvdyHrYnWLQ9YqdyP6a+tTO4mTLhdVKxlpevpqFAx
         lHziFJc07V5Ue8RHMUeP12rtdR9McMaYC01D1pvDGO5VOYZX9ZsDELGPUa6ACYuXfx
         AigZkpvd/DObI7VbAxtILP8tzLAtEnm9nhlzGkwU=
Date:   Sun, 1 Nov 2020 20:47:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: accel: bmc150-accel: Add support for BMA222
Message-ID: <20201101204718.2bafcb9e@archlinux>
In-Reply-To: <20201101122833.1111424-2-linus.walleij@linaro.org>
References: <20201101122833.1111424-1-linus.walleij@linaro.org>
        <20201101122833.1111424-2-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  1 Nov 2020 13:28:32 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> This adds support for the BMA222 version of this sensor,
> found in for example the Samsung GT-I9070 mobile phone.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Looks good to me.

Jonathan

> ---
>  drivers/iio/accel/bmc150-accel-core.c | 17 +++++++++++++++++
>  drivers/iio/accel/bmc150-accel-i2c.c  |  4 ++++
>  drivers/iio/accel/bmc150-accel-spi.c  |  2 ++
>  drivers/iio/accel/bmc150-accel.h      |  1 +
>  4 files changed, 24 insertions(+)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 48435865fdaf..0dafe4052856 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -5,6 +5,7 @@
>   *  - BMI055
>   *  - BMA255
>   *  - BMA250E
> + *  - BMA222
>   *  - BMA222E
>   *  - BMA280
>   *
> @@ -1013,6 +1014,8 @@ static const struct iio_event_spec bmc150_accel_event = {
>  	IIO_CHAN_SOFT_TIMESTAMP(3),					\
>  }
>  
> +static const struct iio_chan_spec bma222_accel_channels[] =
> +	BMC150_ACCEL_CHANNELS(8);
>  static const struct iio_chan_spec bma222e_accel_channels[] =
>  	BMC150_ACCEL_CHANNELS(8);
>  static const struct iio_chan_spec bma250e_accel_channels[] =
> @@ -1063,6 +1066,20 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
>  				 {153277, BMC150_ACCEL_DEF_RANGE_8G},
>  				 {306457, BMC150_ACCEL_DEF_RANGE_16G} },
>  	},
> +	[bma222] = {
> +		.name = "BMA222",
> +		.chip_id = 0x03,
> +		.channels = bma222_accel_channels,
> +		.num_channels = ARRAY_SIZE(bma222_accel_channels),
> +		/*
> +		 * The datasheet page 17 says:
> +		 * 15.6, 31.3, 62.5 and 125 mg per LSB.
> +		 */
> +		.scale_table = { {156000, BMC150_ACCEL_DEF_RANGE_2G},
> +				 {313000, BMC150_ACCEL_DEF_RANGE_4G},
> +				 {625000, BMC150_ACCEL_DEF_RANGE_8G},
> +				 {1250000, BMC150_ACCEL_DEF_RANGE_16G} },
> +	},
>  	[bma222e] = {
>  		.name = "BMA222E",
>  		.chip_id = 0xF8,
> diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
> index 06021c8685a7..bba92dd33179 100644
> --- a/drivers/iio/accel/bmc150-accel-i2c.c
> +++ b/drivers/iio/accel/bmc150-accel-i2c.c
> @@ -5,6 +5,7 @@
>   *  - BMI055
>   *  - BMA255
>   *  - BMA250E
> + *  - BMA222
>   *  - BMA222E
>   *  - BMA280
>   *
> @@ -54,6 +55,7 @@ static const struct acpi_device_id bmc150_accel_acpi_match[] = {
>  	{"BMI055A",	bmi055},
>  	{"BMA0255",	bma255},
>  	{"BMA250E",	bma250e},
> +	{"BMA222",	bma222},
>  	{"BMA222E",	bma222e},
>  	{"BMA0280",	bma280},
>  	{"BOSC0200"},
> @@ -66,6 +68,7 @@ static const struct i2c_device_id bmc150_accel_id[] = {
>  	{"bmi055_accel",	bmi055},
>  	{"bma255",		bma255},
>  	{"bma250e",		bma250e},
> +	{"bma222",		bma222},
>  	{"bma222e",		bma222e},
>  	{"bma280",		bma280},
>  	{}
> @@ -78,6 +81,7 @@ static const struct of_device_id bmc150_accel_of_match[] = {
>  	{ .compatible = "bosch,bmi055_accel" },
>  	{ .compatible = "bosch,bma255" },
>  	{ .compatible = "bosch,bma250e" },
> +	{ .compatible = "bosch,bma222" },
>  	{ .compatible = "bosch,bma222e" },
>  	{ .compatible = "bosch,bma280" },
>  	{ },
> diff --git a/drivers/iio/accel/bmc150-accel-spi.c b/drivers/iio/accel/bmc150-accel-spi.c
> index 2a8c311d6f5a..74a8aee4f612 100644
> --- a/drivers/iio/accel/bmc150-accel-spi.c
> +++ b/drivers/iio/accel/bmc150-accel-spi.c
> @@ -39,6 +39,7 @@ static const struct acpi_device_id bmc150_accel_acpi_match[] = {
>  	{"BMI055A",	bmi055},
>  	{"BMA0255",	bma255},
>  	{"BMA250E",	bma250e},
> +	{"BMA222",	bma222},
>  	{"BMA222E",	bma222e},
>  	{"BMA0280",	bma280},
>  	{ },
> @@ -50,6 +51,7 @@ static const struct spi_device_id bmc150_accel_id[] = {
>  	{"bmi055_accel",	bmi055},
>  	{"bma255",		bma255},
>  	{"bma250e",		bma250e},
> +	{"bma222",		bma222},
>  	{"bma222e",		bma222e},
>  	{"bma280",		bma280},
>  	{}
> diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
> index ae6118ae11b1..f5427103574d 100644
> --- a/drivers/iio/accel/bmc150-accel.h
> +++ b/drivers/iio/accel/bmc150-accel.h
> @@ -9,6 +9,7 @@ enum {
>  	bmi055,
>  	bma255,
>  	bma250e,
> +	bma222,
>  	bma222e,
>  	bma280,
>  };

