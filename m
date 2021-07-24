Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DFF3D48DD
	for <lists+linux-iio@lfdr.de>; Sat, 24 Jul 2021 19:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhGXQrG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Jul 2021 12:47:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229689AbhGXQrG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Jul 2021 12:47:06 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82F5F60E8E;
        Sat, 24 Jul 2021 17:27:32 +0000 (UTC)
Date:   Sat, 24 Jul 2021 18:30:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "hui.liu" <hui.liu@mediatek.com>
Cc:     <robh+dt@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <srv_heupstream@mediatek.com>,
        <zhiyong.tao@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <seiya.wang@mediatek.com>,
        <matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] iio: mtk-auxadc: add mutex_destroy
Message-ID: <20210724183003.6f3bc1d5@jic23-huawei>
In-Reply-To: <1627042875.27985.15.camel@mhfsdcap03>
References: <20210715093523.29844-1-hui.liu@mediatek.com>
        <20210715093523.29844-2-hui.liu@mediatek.com>
        <20210717174432.7e69e4e9@jic23-huawei>
        <1627042875.27985.15.camel@mhfsdcap03>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 23 Jul 2021 20:21:15 +0800
hui.liu <hui.liu@mediatek.com> wrote:

> On Sat, 2021-07-17 at 17:44 +0100, Jonathan Cameron wrote:
> > On Thu, 15 Jul 2021 17:35:23 +0800
> > Hui Liu <hui.liu@mediatek.com> wrote:
> >   
> > > Add mutex_destroy when probe fail and remove device.
> > > 
> > > Signed-off-by: Hui Liu <hui.liu@mediatek.com>  
> > Hi Hui Liu,
> > 
> > We very very rarely bother to call mutex_destroy().  The reason is
> > that it is only a non noop in when mutex debugging is enabled and
> > that is only useful if there is a plausible route in which it could
> > be used after the mutex_destroy.   Given these are both at the ends
> > of removal paths, I don't think this is useful.  That's why you will
> > rarely find mutex_destroy() being called.
> > 
> > Thanks,
> > 
> > Jonathan  
> 
> Hi Jonathon,
> 
> I think this patch could assurance the integrity of code.
> mutex_init will be called when driver probe. If driver probe fail or
> device removed, mutex_destroy could set lock->magic to NULL.

I'm not seeing the use case here given the location doesn't leave
a huge amount of code that could have such a bug.  There might have been
something if we had any route to increment the reference count of the
structure this mutex is ultimately embedded in and so have it outlast
the remove function or error path. In this driver it looks like there is
no such path.  Hence you are protecting against a automated
cleanup of core code (nothing in the driver itself) which is obviously
not going to try taking a driver specific mutex.

A few side notes:

You are calling it wrong place in remove. The ordering in remove
should be the opposite of that in probe so the mutex_destroy should either
be a few lines earlier, or you should have a comment there to say why you
are doing it where you have chosen to do so.

The style of this probe is to do error handling in a block at the end.
So this handling should be there, not in the if statement.

Jonathan



> 
> Thanks.
> Hui
> 
> >   
> > > ---
> > >  drivers/iio/adc/mt6577_auxadc.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> > > index 79c1dd68b909..d57243037ad6 100644
> > > --- a/drivers/iio/adc/mt6577_auxadc.c
> > > +++ b/drivers/iio/adc/mt6577_auxadc.c
> > > @@ -289,6 +289,7 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
> > >  	ret = iio_device_register(indio_dev);
> > >  	if (ret < 0) {
> > >  		dev_err(&pdev->dev, "failed to register iio device\n");
> > > +		mutex_destroy(&adc_dev->lock);
> > >  		goto err_power_off;
> > >  	}
> > >  
> > > @@ -313,6 +314,7 @@ static int mt6577_auxadc_remove(struct platform_device *pdev)
> > >  			      0, MT6577_AUXADC_PDN_EN);
> > >  
> > >  	clk_disable_unprepare(adc_dev->adc_clk);
> > > +	mutex_destroy(&adc_dev->lock);
> > >  
> > >  	return 0;
> > >  }  
> >   
> 

