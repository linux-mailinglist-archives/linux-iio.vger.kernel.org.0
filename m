Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9F044F92D
	for <lists+linux-iio@lfdr.de>; Sun, 14 Nov 2021 17:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbhKNQ5Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 11:57:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:51624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231831AbhKNQ5Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Nov 2021 11:57:25 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A11C60C4D;
        Sun, 14 Nov 2021 16:54:26 +0000 (UTC)
Date:   Sun, 14 Nov 2021 16:59:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        bcm-kernel-feedback-list@broadcom.com,
        Jonas Gorski <jonas.gorski@gmail.com>
Subject: Re: [PATCH v3] mips: bcm63xx: add support for clk_get_parent()
Message-ID: <20211114165913.55a90249@jic23-huawei>
In-Reply-To: <20211114163444.21669-1-rdunlap@infradead.org>
References: <20211114163444.21669-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 14 Nov 2021 08:34:44 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

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
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I wonder a bit if it makes sense to fix only the ones we hit given there
look to be other missing definitions in this subarch.
clk_has_parent() for example appears to also be missing.

Do we have the same issue with mips/lantiq?

Jonathan


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
> ---
> v1 and v2 were:
> [PATCH] iio/adc: ingenic: fix (MIPS) ingenic-adc build errors
> Fixes: 1a78daea107d ("IIO: add Ingenic JZ47xx ADC driver.")
> 
>  arch/mips/bcm63xx/clk.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> --- linux-next-20211112.orig/arch/mips/bcm63xx/clk.c
> +++ linux-next-20211112/arch/mips/bcm63xx/clk.c
> @@ -381,6 +381,13 @@ void clk_disable(struct clk *clk)
>  
>  EXPORT_SYMBOL(clk_disable);
>  
> +struct clk *clk_get_parent(struct clk *clk)
> +{
> +	return NULL;
> +}
> +
> +EXPORT_SYMBOL(clk_get_parent);
> +
>  unsigned long clk_get_rate(struct clk *clk)
>  {
>  	if (!clk)

