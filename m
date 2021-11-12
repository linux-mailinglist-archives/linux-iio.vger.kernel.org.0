Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D7A44E9D3
	for <lists+linux-iio@lfdr.de>; Fri, 12 Nov 2021 16:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhKLPUn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 12 Nov 2021 10:20:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229509AbhKLPUm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Nov 2021 10:20:42 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0FD5601FF;
        Fri, 12 Nov 2021 15:17:50 +0000 (UTC)
Date:   Fri, 12 Nov 2021 15:22:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [RFC PATCH 1/1] iio: dac: add support for ltc2688
Message-ID: <20211112152235.12fdcc49@jic23-huawei>
In-Reply-To: <PH0PR03MB636630C2C0C98896409F352999949@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20211111110043.101891-1-nuno.sa@analog.com>
        <20211111110043.101891-2-nuno.sa@analog.com>
        <CAHp75Ve3ZfFz5g4qH6HhuqaLKgqd058Jj-xY4=-e3ciG67cfRg@mail.gmail.com>
        <PH0PR03MB6366576BD3950F5F5D2A403599949@PH0PR03MB6366.namprd03.prod.outlook.com>
        <CAHp75VfsMa7n8BVJvN36N02u+LKLO36tZNx4rdEzSGZ4HGGoMA@mail.gmail.com>
        <PH0PR03MB636630C2C0C98896409F352999949@PH0PR03MB6366.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> >   
> > > > > +               chan->overrange = fwnode_property_read_bool(child,
> > > > > +                                                           "adi,overrange");  
> > > >
> > > > One line?  
> > >
> > > It will pass the 80 col limit. AFAIR, Jonathan prefers to keep it when it
> > > does not hurt readability...  
> > 
> > I believe it will increase readability being located on one line.  
> 
> I mean, this is perfectly aligned with the open "(", so it's a pretty
> normal pattern. Anyways, I'm more than happy to move this into a one
> liner and just use the 100 limit. But let's see what Jonathan has to say
> because I do not want to move back and forward...

Here it happens to be particularly ugly because of the short first parameter,
so I'm fine with a longer line for this one.


> > > > > +       st->regmap = devm_regmap_init(&spi->dev, NULL, st,  
> > > > &ltc2688_regmap_config);
> > > >
> > > > I'm wondering why it's not a regmap SPI?  
> > >
> > > The problem is on the read side... In the first transfer we write the  
> > command/register  
> > > to read, then we need to release the CS pin so that the device  
> > executes the command,  
> > > and only then we read the data. AFAIK, the regmap spi  
> > implementation won't work like  
> > > this. I think CS is kept asserted the whole time...  
> > 
> > I believe it's configurable, no? Like the cs_change flag somewhere.
> > Can you double check?  
> 
> Don't think we can... The read part just calls:
> https://elixir.bootlin.com/linux/latest/source/drivers/base/regmap/regmap-spi.c#L98
> and has no control over the spi transfer bits...

Feature to add then or a custom regmap_bus if you want to keep it in the driver.

J
> 
> - Nuno Sá

