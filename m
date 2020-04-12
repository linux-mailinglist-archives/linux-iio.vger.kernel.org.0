Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 088801A5E29
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 13:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgDLLC2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 07:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgDLLC2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 07:02:28 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9DE920708;
        Sun, 12 Apr 2020 11:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586689347;
        bh=e63R6ATC7Bih+yStHh9602zufF+CIHhxin3sKETWPzA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nUWGnC+orMbzXLejNLCfXxfvNiuKiPnEfQjEoghgcIr6znXY/1YxnzsvVZQVO2n7q
         1jnvpj5MWJC3P0q1aJ6HrtIXOgMRmnkhnT9RydWgm5Y2g+bvfFWGj2vhEKJxRC+0gv
         hzA1MNSrt6nPrAZyRyK7VjzYLmdJ15v7Qnn9AglU=
Date:   Sun, 12 Apr 2020 12:02:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefan Popa <stefan.popa@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: DAC extension for ltc2634-12/10/8
Message-ID: <20200412120149.73c32f28@archlinux>
In-Reply-To: <20200408080338.11080-1-chris.ruehl@gtsys.com.hk>
References: <20200408080338.11080-1-chris.ruehl@gtsys.com.hk>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  8 Apr 2020 16:03:29 +0800
Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:

> This patch add support for Analog Devices (Linear Technology)
> LTC26234 Quad 12-/10-/8-Bit Rail-to-Rail DAC.
> The SPI functionality based on them from LTC2632 therefor
> add the definitions only and update the Kconfig.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Hi Chris

Process wise, please make sure patches appear as a series, preferably
with a cover letter patch to give a quick overview.

Otherwise, it's far too easy for bad timing to mean a bunch of other
emails turn up in the middle in people's inboxes!

One minor thing inline.

Thanks,

Jonathan


> ---
>  drivers/iio/dac/Kconfig   |  6 ++--
>  drivers/iio/dac/ltc2632.c | 61 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 93744011b63f..e14c9b14c4de 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -279,12 +279,12 @@ config LTC1660
>  	  module will be called ltc1660.
>  
>  config LTC2632
> -	tristate "Linear Technology LTC2632-12/10/8 and LTC2636-12/10/8 DAC spi driver"
> +	tristate "Linear Technology LTC2632,LTC2634,LTC2636-12/10/8 DAC spi driver"

Hmm. That's marginal.  At somepoint we'll just have to give in and say
"LTC2632 and similar" and rely on people grepping part names to find them
in the help text.

>  	depends on SPI
>  	help
>  	  Say yes here to build support for Linear Technology
> -	  LTC2632-12, LTC2632-10, LTC2632-8, LTC2636-12, LTC2636-10 and
> -	  LTC2636-8 converters (DAC).
> +	  LTC2632, LTC2634 and LTC2636 DAC resolution 12/10/8 bit
> +	  low 0-2.5V and high 0-4,096V range converters.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ltc2632.
> diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
> index 7adc91056aa1..e939d7f81014 100644
> --- a/drivers/iio/dac/ltc2632.c
> +++ b/drivers/iio/dac/ltc2632.c
> @@ -24,6 +24,7 @@
>  /**
>   * struct ltc2632_chip_info - chip specific information
>   * @channels:		channel spec for the DAC
> + * @num_channels:	DAC channel count of the chip

Good to fix this but please pull it out as a precursor patch - ideally
with a fixes tag even though it's just documentation.

>   * @vref_mv:		internal reference voltage
>   */
>  struct ltc2632_chip_info {
> @@ -53,6 +54,12 @@ enum ltc2632_supported_device_ids {
>  	ID_LTC2632H12,
>  	ID_LTC2632H10,
>  	ID_LTC2632H8,
> +	ID_LTC2634L12,
> +	ID_LTC2634L10,
> +	ID_LTC2634L8,
> +	ID_LTC2634H12,
> +	ID_LTC2634H10,
> +	ID_LTC2634H8,
>  	ID_LTC2636L12,
>  	ID_LTC2636L10,
>  	ID_LTC2636L8,
> @@ -235,6 +242,36 @@ static const struct ltc2632_chip_info ltc2632_chip_info_tbl[] = {
>  		.num_channels	= 2,
>  		.vref_mv	= 4096,
>  	},
> +	[ID_LTC2634L12] = {
> +		.channels	= ltc2632x12_channels,
> +		.num_channels	= 4,
> +		.vref_mv	= 2500,
> +	},
> +	[ID_LTC2634L10] = {
> +		.channels	= ltc2632x10_channels,
> +		.num_channels	= 4,
> +		.vref_mv	= 2500,
> +	},
> +	[ID_LTC2634L8] =  {
> +		.channels	= ltc2632x8_channels,
> +		.num_channels	= 4,
> +		.vref_mv	= 2500,
> +	},
> +	[ID_LTC2634H12] = {
> +		.channels	= ltc2632x12_channels,
> +		.num_channels	= 4,
> +		.vref_mv	= 4096,
> +	},
> +	[ID_LTC2634H10] = {
> +		.channels	= ltc2632x10_channels,
> +		.num_channels	= 4,
> +		.vref_mv	= 4096,
> +	},
> +	[ID_LTC2634H8] =  {
> +		.channels	= ltc2632x8_channels,
> +		.num_channels	= 4,
> +		.vref_mv	= 4096,
> +	},
>  	[ID_LTC2636L12] = {
>  		.channels	= ltc2632x12_channels,
>  		.num_channels	= 8,
> @@ -356,6 +393,12 @@ static const struct spi_device_id ltc2632_id[] = {
>  	{ "ltc2632-h12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H12] },
>  	{ "ltc2632-h10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H10] },
>  	{ "ltc2632-h8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H8] },
> +	{ "ltc2634-l12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634L12] },
> +	{ "ltc2634-l10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634L10] },
> +	{ "ltc2634-l8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634L8] },
> +	{ "ltc2634-h12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634H12] },
> +	{ "ltc2634-h10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634H10] },
> +	{ "ltc2634-h8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634H8] },
>  	{ "ltc2636-l12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636L12] },
>  	{ "ltc2636-l10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636L10] },
>  	{ "ltc2636-l8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636L8] },
> @@ -385,6 +428,24 @@ static const struct of_device_id ltc2632_of_match[] = {
>  	}, {
>  		.compatible = "lltc,ltc2632-h8",
>  		.data = &ltc2632_chip_info_tbl[ID_LTC2632H8]
> +	}, {
> +		.compatible = "lltc,ltc2634-l12",
> +		.data = &ltc2632_chip_info_tbl[ID_LTC2634L12]
> +	}, {
> +		.compatible = "lltc,ltc2634-l10",
> +		.data = &ltc2632_chip_info_tbl[ID_LTC2634L10]
> +	}, {
> +		.compatible = "lltc,ltc2634-l8",
> +		.data = &ltc2632_chip_info_tbl[ID_LTC2634L8]
> +	}, {
> +		.compatible = "lltc,ltc2634-h12",
> +		.data = &ltc2632_chip_info_tbl[ID_LTC2634H12]
> +	}, {
> +		.compatible = "lltc,ltc2634-h10",
> +		.data = &ltc2632_chip_info_tbl[ID_LTC2634H10]
> +	}, {
> +		.compatible = "lltc,ltc2634-h8",
> +		.data = &ltc2632_chip_info_tbl[ID_LTC2634H8]
>  	}, {
>  		.compatible = "lltc,ltc2636-l12",
>  		.data = &ltc2632_chip_info_tbl[ID_LTC2636L12]

