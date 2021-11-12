Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB83644EBF0
	for <lists+linux-iio@lfdr.de>; Fri, 12 Nov 2021 18:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbhKLR1w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Nov 2021 12:27:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233404AbhKLR1v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Nov 2021 12:27:51 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08CA760F93;
        Fri, 12 Nov 2021 17:24:57 +0000 (UTC)
Date:   Fri, 12 Nov 2021 17:29:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] iio/adc: ingenic: fix (MIPS) ingenic-adc build
 errors
Message-ID: <20211112172942.04553027@jic23-huawei>
In-Reply-To: <20211110023755.27176-1-rdunlap@infradead.org>
References: <20211110023755.27176-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  9 Nov 2021 18:37:55 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> MIPS does not always provide clk*() interfaces and there are no
> always-present stubs for them, so depending on "MIPS || COMPILE_TEST"
> is not strong enough to prevent build errors.
> 
> Likewise MACH_INGENIC_SOC || COMPILE_TEST is not strong enough
> since if only COMPILE_TEST=y (with some other MIPS MACH_ or CPU or
> BOARD setting), there are still the same build errors.
> 
> It looks like depending on MACH_INGENIC is the only thing that is
> sufficient here in order to prevent build errors.
> 
> mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4770_adc_init_clk_div':
> ingenic-adc.c:(.text+0xe4): undefined reference to `clk_get_parent'
> mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4725b_adc_init_clk_div':
> ingenic-adc.c:(.text+0x1b8): undefined reference to `clk_get_parent'
> 
> Fixes: 1a78daea107d ("IIO: add Ingenic JZ47xx ADC driver.")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Artur Rojek <contact@artur-rojek.eu>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: linux-mips@vger.kernel.org
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: linux-iio@vger.kernel.org
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>

I'm a bit confused.  There are stubs in include/linux/clk.h for these.
Why do those not apply here? Are these platforms built with CONFIG_CLK but
don't provide all the functions?

That sounds highly error prone and rather defeats the object of the
stubs.  Could we either provide the missing stubs, or solve this some other
way.  I'm not keen to massively cut the build coverage this driver is getting
by dropping COMPILE_TEST if there is any route to avoid doing so.

Based on the guess than any platform with clks must be able to turn them on
I grepped for int clk_enable() and there seem to be only two possiblities
bcm63xx and lantiq as sources of the build breakage.

Jonathan

> ---
> v2: use MACH_INGENIC instead of MACH_INGENIC_SOC (thanks, Paul)
> 
>  drivers/iio/adc/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20211105.orig/drivers/iio/adc/Kconfig
> +++ linux-next-20211105/drivers/iio/adc/Kconfig
> @@ -501,7 +501,7 @@ config INA2XX_ADC
>  
>  config INGENIC_ADC
>  	tristate "Ingenic JZ47xx SoCs ADC driver"
> -	depends on MIPS || COMPILE_TEST
> +	depends on MACH_INGENIC
>  	select IIO_BUFFER
>  	help
>  	  Say yes here to build support for the Ingenic JZ47xx SoCs ADC unit.

