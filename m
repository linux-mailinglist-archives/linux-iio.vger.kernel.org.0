Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8216144F22C
	for <lists+linux-iio@lfdr.de>; Sat, 13 Nov 2021 09:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbhKMIhe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Nov 2021 03:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhKMIhd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Nov 2021 03:37:33 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63B1C061766;
        Sat, 13 Nov 2021 00:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6SpImCaqZgDHAurHopXNKY5UNWFLoorRukjyWRRIR0U=; b=A73noCoSjs3BIZQFdjCMi1OuXz
        52zbVClFhsvYKJv6m9ug+u27uLdYshoo86Qouq3JiK4sWlvDscyrWSvfy+3C0QEJOgofkR8Mynh7V
        jCLcRyWiR4tfK8ll1CEYF+IZ4C5fy54EsPggQ0Sb7Sb3jUrSrTukMyYpSOzKcML03vh6mZYxnkN1D
        YXkHElHu5mP2cvu8kZYFJxRWCxrJNbwEXiPmIG/iS79ejoElGIBiQRp24TRYiNz2EaeUFNDTVpv4D
        AAgmZ9aEwMxOjRy5lpg7GYVZpuvihcA++5wxb/wCl0/4I4jBgSkODUnKkyJ3e0CmrtxMTQXn0WjJ6
        V52jk+1w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55604)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mloUe-0005vU-MI; Sat, 13 Nov 2021 08:34:36 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mloUa-0007Qg-Sq; Sat, 13 Nov 2021 08:34:32 +0000
Date:   Sat, 13 Nov 2021 08:34:32 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2] iio/adc: ingenic: fix (MIPS) ingenic-adc build errors
Message-ID: <YY94mLIM311/XiXU@shell.armlinux.org.uk>
References: <20211110023755.27176-1-rdunlap@infradead.org>
 <20211112172942.04553027@jic23-huawei>
 <dfc38220-c79a-f990-d025-c7f5344e0b9a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfc38220-c79a-f990-d025-c7f5344e0b9a@infradead.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Nov 12, 2021 at 04:39:04PM -0800, Randy Dunlap wrote:
> On 11/12/21 9:29 AM, Jonathan Cameron wrote:
> > On Tue,  9 Nov 2021 18:37:55 -0800
> > Randy Dunlap <rdunlap@infradead.org> wrote:
> > 
> > > MIPS does not always provide clk*() interfaces and there are no
> > > always-present stubs for them, so depending on "MIPS || COMPILE_TEST"
> > > is not strong enough to prevent build errors.
> > > 
> > > Likewise MACH_INGENIC_SOC || COMPILE_TEST is not strong enough
> > > since if only COMPILE_TEST=y (with some other MIPS MACH_ or CPU or
> > > BOARD setting), there are still the same build errors.
> > > 
> > > It looks like depending on MACH_INGENIC is the only thing that is
> > > sufficient here in order to prevent build errors.
> > > 
> > > mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4770_adc_init_clk_div':
> > > ingenic-adc.c:(.text+0xe4): undefined reference to `clk_get_parent'
> > > mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4725b_adc_init_clk_div':
> > > ingenic-adc.c:(.text+0x1b8): undefined reference to `clk_get_parent'
> > > 
> > > Fixes: 1a78daea107d ("IIO: add Ingenic JZ47xx ADC driver.")
> > > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Cc: Artur Rojek <contact@artur-rojek.eu>
> > > Cc: Paul Cercueil <paul@crapouillou.net>
> > > Cc: linux-mips@vger.kernel.org
> > > Cc: Jonathan Cameron <jic23@kernel.org>
> > > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > > Cc: linux-iio@vger.kernel.org
> > > Cc: Florian Fainelli <f.fainelli@gmail.com>
> > > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > 
> > I'm a bit confused.  There are stubs in include/linux/clk.h for these.
> > Why do those not apply here? Are these platforms built with CONFIG_CLK but
> > don't provide all the functions?
> > 
> > That sounds highly error prone and rather defeats the object of the
> > stubs.  Could we either provide the missing stubs, or solve this some other
> > way.  I'm not keen to massively cut the build coverage this driver is getting
> > by dropping COMPILE_TEST if there is any route to avoid doing so.
> 
> I'm all for that (above), but it's a mess.
> 
> > Based on the guess than any platform with clks must be able to turn them on
> > I grepped for int clk_enable() and there seem to be only two possiblities
> > bcm63xx and lantiq as sources of the build breakage.
> 
> CONFIG_BCM63XX=y
> # CONFIG_MACH_INGENIC_SOC is not set
> CONFIG_INGENIC_ADC=y
> CONFIG_HAVE_CLK=y
> 
> 
> According to the build error messages (above), clk_get_parent()
> is missing. Looking at <linux/clk.h>, for CONFIG_HAVE_CLK=y,
> there is a prototype for clk_get_parent(), and if CONFIG_HAVE_CLK
> is not set, there is a stub for it.
> 
> Now look at drivers/clk/clk.c and drivers/clk/Makefile:
> 
> clk_get_parent() is defined in clk.c, which is built when
> CONFIG_COMMON_CLK=y, but that is not set in this .config file.
> 
> CONFIG_HAVE_CLK=y, but that doesn't get clk_get_parent()
> compiled.
> 
> So to me it is a disparity or incongruity between HAVE_CLK and COMMON_CLK.

HAVE_CLK means we have the clk API implemented. COMMON_CLK is one such
implementation, and HAVE_LEGACY_CLK is another group of implementations.

BCM63XX has its own implementation and uses HAVE_LEGACY_CLK, which can
be found in arch/mips/bcm63xx/clk.c.

If it doesn't support parent clocks, then it should provide a stub
clk_get_parent() that returns NULL at the very least.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
