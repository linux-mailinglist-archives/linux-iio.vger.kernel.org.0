Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD6C1A93C4
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 09:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404014AbgDOHAt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 03:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404012AbgDOHAr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 03:00:47 -0400
X-Greylist: delayed 435 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Apr 2020 00:00:47 PDT
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EE4C061A0E
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2020 00:00:47 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jOc27-0006DZ-RA; Wed, 15 Apr 2020 09:00:27 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jOc25-0007Ko-JT; Wed, 15 Apr 2020 09:00:25 +0200
Date:   Wed, 15 Apr 2020 09:00:25 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefan Popa <stefan.popa@analog.com>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: DAC extension for ltc2634-12/10/8
Message-ID: <20200415070025.6isvybjzpfhh3ts3@pengutronix.de>
References: <20200414235609.20125-1-chris.ruehl@gtsys.com.hk>
 <20200414235609.20125-3-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200414235609.20125-3-chris.ruehl@gtsys.com.hk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 15, 2020 at 07:56:03AM +0800, Chris Ruehl wrote:
> This patch add support for Analog Devices (Linear Technology)
> LTC2634 Quad 12-/10-/8-Bit Rail-to-Rail DAC.
> The SPI functionality based on them from LTC2632 therefor
> add the definitions only and update the Kconfig.
> 
> V2:
> Send the documentation fix in a extra patch
> Kconfig simplify the driver description, details to the help text
> ltc2632.txt add to this patch-set (prepare to convert to yaml)
> 
> V3:
> Consistens decimal separator in help text

The description about how the patch evolves usually goes below the ---
and S-o-b area. This way it doesn't make it into the commit history.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
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

The naming pattern seems to be:

	LTC263ab-cc

with:

	a = 2 -> 2 channels
	a = 4 -> 4 channels
	a = 6 -> 8 channels

	b = L -> Vref = 2.5V
	b = H -> Vref = 4.096V

	cc = 8 -> 8 bit precision
	cc = 10 -> 10 bit precision
	cc = 12 -> 12 bit precision

Would it make sense to document this somewhere?

But as this is (somewhat) orthogonal to this patch:

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
