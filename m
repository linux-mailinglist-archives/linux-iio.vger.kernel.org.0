Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 650A917CF30
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 16:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgCGP4C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 10:56:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:35870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgCGP4C (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 10:56:02 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AE522073D;
        Sat,  7 Mar 2020 15:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583596561;
        bh=5dhC0zIY7ABeh1ZvdL4xEBbZTq+SCYzCjEOG8hZQi4c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FLqufPNPwIEq5pc7DIfo0Bg/ioRmXQALHkmLsX0VzjDTnfsqSbMP6ZCVgTVMOQ3in
         Tz+3yrlmGWNbPGWPHShyyKqT0SVNpkrnLBHHKmHaQlEkYzOM6aGh9a7l2j++PEFT0k
         0+WzCcogyCRtYP3i+8I4vrt7x9qIeLbWAv2q0CQg=
Date:   Sat, 7 Mar 2020 15:55:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: dac: Kconfig: sort symbols alphabetically
Message-ID: <20200307155558.7e80ed41@archlinux>
In-Reply-To: <20200304135544.2538-1-alexandru.ardelean@analog.com>
References: <20200304135544.2538-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 4 Mar 2020 15:55:44 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> While adding a new device, I noticed these aren't sorted alphabetically [as
> in the Makefile], which messed my head-up.
> This change sorts the devices alphabetically in the drivers/iio/dac/Kconfig
> file as well.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
oops. That clearly snuck past when I wasn't paying attention.

Good to clean it up.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to hopefully not notice!

Thanks,

Jonathan

> ---
>  drivers/iio/dac/Kconfig | 62 ++++++++++++++++++++---------------------
>  1 file changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 63916a6142ec..93744011b63f 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -121,27 +121,6 @@ config AD5624R_SPI
>  	  Say yes here to build support for Analog Devices AD5624R, AD5644R and
>  	  AD5664R converters (DAC). This driver uses the common SPI interface.
>  
> -config LTC1660
> -	tristate "Linear Technology LTC1660/LTC1665 DAC SPI driver"
> -	depends on SPI
> -	help
> -	  Say yes here to build support for Linear Technology
> -	  LTC1660 and LTC1665 Digital to Analog Converters.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called ltc1660.
> -
> -config LTC2632
> -	tristate "Linear Technology LTC2632-12/10/8 and LTC2636-12/10/8 DAC spi driver"
> -	depends on SPI
> -	help
> -	  Say yes here to build support for Linear Technology
> -	  LTC2632-12, LTC2632-10, LTC2632-8, LTC2636-12, LTC2636-10 and
> -	  LTC2636-8 converters (DAC).
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called ltc2632.
> -
>  config AD5686
>  	tristate
>  
> @@ -240,16 +219,6 @@ config AD7303
>  	  To compile this driver as module choose M here: the module will be called
>  	  ad7303.
>  
> -config CIO_DAC
> -	tristate "Measurement Computing CIO-DAC IIO driver"
> -	depends on X86 && (ISA_BUS || PC104)
> -	select ISA_BUS_API
> -	help
> -	  Say yes here to build support for the Measurement Computing CIO-DAC
> -	  analog output device family (CIO-DAC16, CIO-DAC08, PC104-DAC06). The
> -	  base port addresses for the devices may be configured via the base
> -	  array module parameter.
> -
>  config AD8801
>  	tristate "Analog Devices AD8801/AD8803 DAC driver"
>  	depends on SPI_MASTER
> @@ -260,6 +229,16 @@ config AD8801
>  	  To compile this driver as a module choose M here: the module will be called
>  	  ad8801.
>  
> +config CIO_DAC
> +	tristate "Measurement Computing CIO-DAC IIO driver"
> +	depends on X86 && (ISA_BUS || PC104)
> +	select ISA_BUS_API
> +	help
> +	  Say yes here to build support for the Measurement Computing CIO-DAC
> +	  analog output device family (CIO-DAC16, CIO-DAC08, PC104-DAC06). The
> +	  base port addresses for the devices may be configured via the base
> +	  array module parameter.
> +
>  config DPOT_DAC
>  	tristate "DAC emulation using a DPOT"
>  	depends on OF
> @@ -289,6 +268,27 @@ config LPC18XX_DAC
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called lpc18xx_dac.
>  
> +config LTC1660
> +	tristate "Linear Technology LTC1660/LTC1665 DAC SPI driver"
> +	depends on SPI
> +	help
> +	  Say yes here to build support for Linear Technology
> +	  LTC1660 and LTC1665 Digital to Analog Converters.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ltc1660.
> +
> +config LTC2632
> +	tristate "Linear Technology LTC2632-12/10/8 and LTC2636-12/10/8 DAC spi driver"
> +	depends on SPI
> +	help
> +	  Say yes here to build support for Linear Technology
> +	  LTC2632-12, LTC2632-10, LTC2632-8, LTC2636-12, LTC2636-10 and
> +	  LTC2636-8 converters (DAC).
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ltc2632.
> +
>  config M62332
>  	tristate "Mitsubishi M62332 DAC driver"
>  	depends on I2C

