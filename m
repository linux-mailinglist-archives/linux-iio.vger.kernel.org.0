Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C8A44FC5D
	for <lists+linux-iio@lfdr.de>; Sun, 14 Nov 2021 23:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbhKNW6Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 17:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbhKNW6M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Nov 2021 17:58:12 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DF3C061746;
        Sun, 14 Nov 2021 14:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=522taJi6xoI1oSlErZXqjEanXSw8p1Evt8R0PTr7T9Q=; b=AXlcil1N6dkH3p2EcMwi3ksaUD
        iqo9pXx7QfUvGusYd3mJray/7fluS9trZfB+eeLIkcnZ46aKP7IF2AsrMwVuCunysGr36XmgP9DRG
        p22p05hQgjd84r+vub1DsQdTShZkODb3sJsuzVNQgWgYN5jGLAEjz/tIi81C6ekizBtOadm7EXp8A
        Qc4okktAUw9SiZjGrehgjkpw8p4F5+5C7wTDlWnRScTviWDj+X+H+3WkZyRUDdx9WeyKgBobRv+zP
        nUaZcJ88IyVME5RnQ0WXqaoTXH5HYcUK6ztJSeQvakncjCoZEv5wcBdTuxVewiwld6486WAiPwFNX
        gDRShPig==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55624)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mmOOw-0006wd-Mi; Sun, 14 Nov 2021 22:55:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mmOOr-0000RX-SN; Sun, 14 Nov 2021 22:55:01 +0000
Date:   Sun, 14 Nov 2021 22:55:01 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jonas Gorski <jonas.gorski@gmail.com>
Subject: Re: [PATCH v3] mips: bcm63xx: add support for clk_get_parent()
Message-ID: <YZGTxTHn3HuIhuSH@shell.armlinux.org.uk>
References: <20211114163444.21669-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211114163444.21669-1-rdunlap@infradead.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 14, 2021 at 08:34:44AM -0800, Randy Dunlap wrote:
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

Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
