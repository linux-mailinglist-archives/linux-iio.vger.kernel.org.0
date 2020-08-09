Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F4023FE0A
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 13:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgHILwb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 07:52:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbgHILwa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 07:52:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64B98206B5;
        Sun,  9 Aug 2020 11:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596973949;
        bh=Orp0fxs1DrPJape5YivoeaV7eJLcIaDwJa56sHn41RM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=khJaIjxDMH3AILlW0BtYz3iAQtTLYQpLos7DGDKcBX11bta/X0RHOPAJkJz9/Tljm
         9Lg3carUGQejS2StMUZrbu3xyfdNv+rxej0XFoh8v4xKI6Bqg33exQJEH7J31Y7OnL
         CRR3CSN6wCrJwm9tQemCYfdVrPHFkd0RKDkpJ7FI=
Date:   Sun, 9 Aug 2020 12:52:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Cc:     Michael Walle <michael@walle.cc>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Simon Xue <xxm@rock-chips.com>
Subject: Re: [PATCH] iio: adc: rockchip_saradc: select IIO_TRIGGERED_BUFFER
Message-ID: <20200809125225.5cddd324@archlinux>
In-Reply-To: <2468442.jk0zRepj8P@diego>
References: <20200803083001.6689-1-michael@walle.cc>
        <2468442.jk0zRepj8P@diego>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 03 Aug 2020 13:59:12 +0200
Heiko Stuebner <heiko.stuebner@theobroma-systems.com> wrote:

> Am Montag, 3. August 2020, 10:30:01 CEST schrieb Michael Walle:
> > The kernel fails to compile due to undefined reference to
> > devm_iio_triggered_buffer_setup() if IIO_TRIGGERED_BUFFER is not
> > enabled. The original patch [1] had this dependency. But somehow it
> > didn't make it into the kernel tree. Re-add it.
> > 
> > [1] https://lore.kernel.org/lkml/20200623233011.2319035-3-heiko@sntech.de/
> > 
> > Fixes: 4e130dc7b413 ("iio: adc: rockchip_saradc: Add support iio buffers")
> > Signed-off-by: Michael Walle <michael@walle.cc>  
> 
> Reviewed-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> 
> > ---
> >  drivers/iio/adc/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 66d9cc073157..d94dc800b842 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -865,6 +865,8 @@ config ROCKCHIP_SARADC
> >  	tristate "Rockchip SARADC driver"
> >  	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
> >  	depends on RESET_CONTROLLER
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> >  	help
> >  	  Say yes here to build support for the SARADC found in SoCs from
> >  	  Rockchip.
> >   
> 
> 
> 
> 

