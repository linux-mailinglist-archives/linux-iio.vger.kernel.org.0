Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDFC1AB8D6
	for <lists+linux-iio@lfdr.de>; Thu, 16 Apr 2020 08:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437732AbgDPG5Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Apr 2020 02:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437714AbgDPG5K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Apr 2020 02:57:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856A7C061A10
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2020 23:57:10 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jOySH-00050M-F3; Thu, 16 Apr 2020 08:56:57 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jOySF-0002To-Ra; Thu, 16 Apr 2020 08:56:55 +0200
Date:   Thu, 16 Apr 2020 08:56:55 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Steve Winslow <swinslow@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: DAC extension for ltc2634-12/10/8
Message-ID: <20200416065655.cxy67hlj267dpjrw@pengutronix.de>
References: <20200416012016.21422-1-chris.ruehl@gtsys.com.hk>
 <20200416012016.21422-3-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200416012016.21422-3-chris.ruehl@gtsys.com.hk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

dropped stefan.popa@analog.com from recipents as the address bounces for
me.

On Thu, Apr 16, 2020 at 09:20:10AM +0800, Chris Ruehl wrote:
> This patch add support for Analog Devices (Linear Technology)
> LTC2634 Quad 12-/10-/8-Bit Rail-to-Rail DAC.
> The SPI functionality based on them from LTC2632 therefor
> add the definitions only and update the Kconfig.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
> v4:
> -hide version from commit text
> v3:
> -Consistens decimal separator in help text
> v2:
> -Send the documentation fix in a extra patch
> -Kconfig simplify the driver description, details to the help text
> -ltc2632.txt add to this patch-set (prepare to convert to yaml)
> 
>  .../devicetree/bindings/iio/dac/ltc2632.txt   |  8 ++-
>  drivers/iio/dac/Kconfig                       |  6 +-
>  drivers/iio/dac/ltc2632.c                     | 60 +++++++++++++++++++
>  3 files changed, 70 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> index 338c3220f01a..1ab9570cf219 100644
> --- a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> +++ b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> @@ -1,4 +1,4 @@
> -Linear Technology LTC2632/2636 DAC
> +Linear Technology LTC2632/2634/2636 DAC
>  
>  Required properties:
>   - compatible: Has to contain one of the following:
> @@ -8,6 +8,12 @@ Required properties:
>  	lltc,ltc2632-h12
>  	lltc,ltc2632-h10
>  	lltc,ltc2632-h8
> +	lltc,ltc2634-l12
> +	lltc,ltc2634-l10
> +	lltc,ltc2634-l8
> +	lltc,ltc2634-h12
> +	lltc,ltc2634-h10
> +	lltc,ltc2634-h8
>  	lltc,ltc2636-l12
>  	lltc,ltc2636-l10
>  	lltc,ltc2636-l8
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 93744011b63f..aee13ced6ddf 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -279,12 +279,12 @@ config LTC1660
>  	  module will be called ltc1660.
>  
>  config LTC2632
> -	tristate "Linear Technology LTC2632-12/10/8 and LTC2636-12/10/8 DAC spi driver"
> +	tristate "Linear Technology LTC2632-12/10/8 and similar DAC spi driver"
>  	depends on SPI
>  	help
>  	  Say yes here to build support for Linear Technology
> -	  LTC2632-12, LTC2632-10, LTC2632-8, LTC2636-12, LTC2636-10 and
> -	  LTC2636-8 converters (DAC).
> +	  LTC2632, LTC2634 and LTC2636 DAC resolution 12/10/8 bit
> +	  low 0-2.5V and high 0-4.096V range converters.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ltc2632.
> diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
> index 2a84ea654645..e939d7f81014 100644
> --- a/drivers/iio/dac/ltc2632.c
> +++ b/drivers/iio/dac/ltc2632.c
> @@ -54,6 +54,12 @@ enum ltc2632_supported_device_ids {
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
> @@ -236,6 +242,36 @@ static const struct ltc2632_chip_info ltc2632_chip_info_tbl[] = {
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
> @@ -357,6 +393,12 @@ static const struct spi_device_id ltc2632_id[] = {
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
> @@ -386,6 +428,24 @@ static const struct of_device_id ltc2632_of_match[] = {
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

Looks good to me:

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
