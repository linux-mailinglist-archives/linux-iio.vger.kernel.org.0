Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD6F3E3AB0
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 15:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhHHNzk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Aug 2021 09:55:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229923AbhHHNzk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Aug 2021 09:55:40 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 216746101E;
        Sun,  8 Aug 2021 13:55:19 +0000 (UTC)
Date:   Sun, 8 Aug 2021 14:58:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] iio: ep93xx: Prepare clock before using it
Message-ID: <20210808145809.5797c590@jic23-huawei>
In-Reply-To: <24f29bc6-311c-4f96-2e1b-1a5df936bb3a@gmail.com>
References: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
        <20210613233041.128961-2-alexander.sverdlin@gmail.com>
        <20210614115043.07ea0ae1@jic23-huawei>
        <24f29bc6-311c-4f96-2e1b-1a5df936bb3a@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Aug 2021 09:30:23 +0200
Alexander Sverdlin <alexander.sverdlin@gmail.com> wrote:

> Hello Jonathan!
> 
> On 14/06/2021 12:50, Jonathan Cameron wrote:
> > On Mon, 14 Jun 2021 01:30:35 +0200
> > Alexander Sverdlin <alexander.sverdlin@gmail.com> wrote:
> >   
> >> Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
> >> to Common Clock Framework, otherwise the following is visible:
> >>
> >> WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:1011 clk_core_enable+0x9c/0xbc
> >> Enabling unprepared ep93xx-adc
> >> CPU: 0 PID: 1 Comm: swapper Not tainted 5.13.0-rc5-... #1
> >> Hardware name: Cirrus Logic EDB9302 Evaluation Board
> >> [<c000d5b0>] (unwind_backtrace) from [<c000c590>] (show_stack+0x10/0x18)
> >> [<c000c590>] (show_stack) from [<c03a5f38>] (dump_stack+0x20/0x2c)
> >> [<c03a5f38>] (dump_stack) from [<c03a2098>] (__warn+0x98/0xc0)
> >> [<c03a2098>] (__warn) from [<c03a2150>] (warn_slowpath_fmt+0x90/0xc0)
> >> [<c03a2150>] (warn_slowpath_fmt) from [<c01d8358>] (clk_core_enable+0x9c/0xbc)
> >> [<c01d8358>] (clk_core_enable) from [<c01d8698>] (clk_core_enable_lock+0x18/0x30)
> >> [<c01d8698>] (clk_core_enable_lock) from [<c0266560>] (ep93xx_adc_probe+0xe4/0x1a0)
> >> [<c0266560>] (ep93xx_adc_probe) from [<c02126e0>] (platform_probe+0x34/0x80)
> >> [<c02126e0>] (platform_probe) from [<c0210bf8>] (really_probe+0xe8/0x394)
> >> [<c0210bf8>] (really_probe) from [<c0211464>] (device_driver_attach+0x5c/0x64)
> >> [<c0211464>] (device_driver_attach) from [<c02114e8>] (__driver_attach+0x7c/0xec)
> >> [<c02114e8>] (__driver_attach) from [<c020f1b4>] (bus_for_each_dev+0x78/0xc4)
> >> [<c020f1b4>] (bus_for_each_dev) from [<c0211570>] (driver_attach+0x18/0x24)
> >> [<c0211570>] (driver_attach) from [<c020fab4>] (bus_add_driver+0x140/0x1cc)
> >> [<c020fab4>] (bus_add_driver) from [<c0211c44>] (driver_register+0x74/0x114)
> >> [<c0211c44>] (driver_register) from [<c02134f8>] (__platform_driver_register+0x18/0x24)
> >> [<c02134f8>] (__platform_driver_register) from [<c0470148>] (ep93xx_adc_driver_init+0x10/0x1c)
> >> [<c0470148>] (ep93xx_adc_driver_init) from [<c045ce88>] (do_one_initcall+0x7c/0x1a4)
> >> [<c045ce88>] (do_one_initcall) from [<c045d184>] (kernel_init_freeable+0x17c/0x1fc)
> >> [<c045d184>] (kernel_init_freeable) from [<c03a64d0>] (kernel_init+0x8/0xf8)
> >> [<c03a64d0>] (kernel_init) from [<c00082d8>] (ret_from_fork+0x14/0x3c)
> >> ...
> >> ep93xx-adc ep93xx-adc: Cannot enable clock
> >> ep93xx-adc: probe of ep93xx-adc failed with error -108
> >>
> >> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>  
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > From cover letter I'm assuming you want these to go through same route as
> > the common clock conversion?  If not shout and I can pick this one up.  
> 
> We didn't manage to consolidate the delivery path for this series, could
> you please take this patch alone, as you proposed initially?

Sure. Applied to the togreg branch of iio.git and pushed out as testing for
0-day to see if it can find anything we missed.

Thanks,

Jonathan
> 
> >> ---
> >>  drivers/iio/adc/ep93xx_adc.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/ep93xx_adc.c b/drivers/iio/adc/ep93xx_adc.c
> >> index c08ab3c6dfaf..5c85257b814c 100644
> >> --- a/drivers/iio/adc/ep93xx_adc.c
> >> +++ b/drivers/iio/adc/ep93xx_adc.c
> >> @@ -207,7 +207,7 @@ static int ep93xx_adc_probe(struct platform_device *pdev)
> >>  		 */
> >>  	}
> >>  
> >> -	ret = clk_enable(priv->clk);
> >> +	ret = clk_prepare_enable(priv->clk);
> >>  	if (ret) {
> >>  		dev_err(&pdev->dev, "Cannot enable clock\n");
> >>  		return ret;
> >> @@ -215,7 +215,7 @@ static int ep93xx_adc_probe(struct platform_device *pdev)
> >>  
> >>  	ret = iio_device_register(iiodev);
> >>  	if (ret)
> >> -		clk_disable(priv->clk);
> >> +		clk_disable_unprepare(priv->clk);
> >>  
> >>  	return ret;
> >>  }
> >> @@ -226,7 +226,7 @@ static int ep93xx_adc_remove(struct platform_device *pdev)
> >>  	struct ep93xx_adc_priv *priv = iio_priv(iiodev);
> >>  
> >>  	iio_device_unregister(iiodev);
> >> -	clk_disable(priv->clk);
> >> +	clk_disable_unprepare(priv->clk);
> >>  
> >>  	return 0;
> >>  }  
> >   

