Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53E7452D41
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 09:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhKPI6B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 03:58:01 -0500
Received: from elvis.franken.de ([193.175.24.41]:52944 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232502AbhKPI55 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Nov 2021 03:57:57 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mmuF0-0006gG-02; Tue, 16 Nov 2021 09:54:58 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 0657CC2D9C; Tue, 16 Nov 2021 09:46:33 +0100 (CET)
Date:   Tue, 16 Nov 2021 09:46:33 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-mips@vger.kernel.org, John Crispin <john@phrozen.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] mips: lantiq: add support for clk_get_parent()
Message-ID: <20211116084633.GC21168@alpha.franken.de>
References: <20211115012051.16302-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115012051.16302-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 14, 2021 at 05:20:51PM -0800, Randy Dunlap wrote:
> Provide a simple implementation of clk_get_parent() in the
> lantiq subarch so that callers of it will build without errors.
> 
> Fixes this build error:
> ERROR: modpost: "clk_get_parent" [drivers/iio/adc/ingenic-adc.ko] undefined!
> 
> Fixes: 171bb2f19ed6 ("MIPS: Lantiq: Add initial support for Lantiq SoCs")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Cc: linux-mips@vger.kernel.org
> Cc: John Crispin <john@phrozen.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  arch/mips/lantiq/clk.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> --- linux-next-20211112.orig/arch/mips/lantiq/clk.c
> +++ linux-next-20211112/arch/mips/lantiq/clk.c
> @@ -158,6 +158,12 @@ void clk_deactivate(struct clk *clk)
>  }
>  EXPORT_SYMBOL(clk_deactivate);
>  
> +struct clk *clk_get_parent(struct clk *clk)
> +{
> +	return NULL;
> +}
> +EXPORT_SYMBOL(clk_get_parent);
> +
>  static inline u32 get_counter_resolution(void)
>  {
>  	u32 res;

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
