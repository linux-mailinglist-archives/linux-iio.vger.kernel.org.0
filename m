Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6003844AD16
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 13:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbhKIMI0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 9 Nov 2021 07:08:26 -0500
Received: from aposti.net ([89.234.176.197]:53678 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236479AbhKIMI0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 9 Nov 2021 07:08:26 -0500
Date:   Tue, 09 Nov 2021 12:05:27 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] iio/adc: ingenic: fix (MIPS) ingenic-adc build errors
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        linux-mips@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Message-Id: <390B2R.ICFJKTTX7S392@crapouillou.net>
In-Reply-To: <20211106174932.15676-1-rdunlap@infradead.org>
References: <20211106174932.15676-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Randy,

Le sam., nov. 6 2021 at 10:49:32 -0700, Randy Dunlap 
<rdunlap@infradead.org> a écrit :
> MIPS does not always provide clk*() interfaces and there are no
> always-present stubs for them, so depending on "MIPS || COMPILE_TEST"
> is not strong enough to prevent build errors.
> 
> Likewise MACH_INGENIC_SOC || COMPILE_TEST is not strong enough
> since if only COMPILE_TEST=y (with some other MIPS MACH_ or CPU or
> BOARD setting), there are still the same build errors.
> 
> It looks like depending on MACH_INGENIC_SOC is the only thing that is
> sufficient here in order to prevent build errors.

Should be "depends on MACH_INGENIC". This symbol is selected when 
building a kernel tailored for Ingenic boards (CONFIG_MACH_INGENIC_SOC) 
and also selected when building a generic MIPS kernel that supports 
Ingenic SoCs (CONFIG_BOARD_INGENIC).

Cheers,
-Paul

> 
> mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function 
> `jz4770_adc_init_clk_div':
> ingenic-adc.c:(.text+0xe4): undefined reference to `clk_get_parent'
> mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function 
> `jz4725b_adc_init_clk_div':
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
> ---
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
> +	depends on MACH_INGENIC_SOC
>  	select IIO_BUFFER
>  	help
>  	  Say yes here to build support for the Ingenic JZ47xx SoCs ADC 
> unit.


