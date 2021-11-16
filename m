Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36355452D44
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 09:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhKPI6C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 03:58:02 -0500
Received: from elvis.franken.de ([193.175.24.41]:52966 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232602AbhKPI6B (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Nov 2021 03:58:01 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mmuF0-0006gG-01; Tue, 16 Nov 2021 09:54:58 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 0775BC2D9C; Tue, 16 Nov 2021 09:46:21 +0100 (CET)
Date:   Tue, 16 Nov 2021 09:46:20 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Artur Rojek <contact@artur-rojek.eu>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        bcm-kernel-feedback-list@broadcom.com,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4] mips: bcm63xx: add support for clk_get_parent()
Message-ID: <20211116084620.GB21168@alpha.franken.de>
References: <20211115004218.13034-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115004218.13034-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 14, 2021 at 04:42:18PM -0800, Randy Dunlap wrote:
> BCM63XX selects HAVE_LEGACY_CLK but does not provide/support
> clk_get_parent(), so add a simple implementation of that
> function so that callers of it will build without errors.
> 
> Fixes these build errors:
> 
> mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4770_adc_init_clk_div':
> ingenic-adc.c:(.text+0xe4): undefined reference to `clk_get_parent'
> mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4725b_adc_init_clk_div':
> ingenic-adc.c:(.text+0x1b8): undefined reference to `clk_get_parent'
> 
> Fixes: e7300d04bd08 ("MIPS: BCM63xx: Add support for the Broadcom BCM63xx family of SOCs." )
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Cc: Artur Rojek <contact@artur-rojek.eu>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: linux-mips@vger.kernel.org
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: linux-iio@vger.kernel.org
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: Jonas Gorski <jonas.gorski@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> v1 and v2 were:
> [PATCH] iio/adc: ingenic: fix (MIPS) ingenic-adc build errors
>   (limiting this driver to MACH_INGENIC in Kconfig)
> v3: add clk_get_parent() to arch/mips/bcm63xx/clk.c
> v4:
>   add Fixes:, Suggested-by:, Reviewed-by: Acked-by:
>   drop blank line between function and EXPORT_SYMBOL(); (Andy)
> 
>  arch/mips/bcm63xx/clk.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> --- linux-next-20211112.orig/arch/mips/bcm63xx/clk.c
> +++ linux-next-20211112/arch/mips/bcm63xx/clk.c
> @@ -381,6 +381,12 @@ void clk_disable(struct clk *clk)
>  
>  EXPORT_SYMBOL(clk_disable);
>  
> +struct clk *clk_get_parent(struct clk *clk)
> +{
> +	return NULL;
> +}
> +EXPORT_SYMBOL(clk_get_parent);
> +
>  unsigned long clk_get_rate(struct clk *clk)
>  {
>  	if (!clk)

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
