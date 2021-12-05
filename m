Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46199468C14
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 17:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbhLEQYl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 11:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhLEQYl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 11:24:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62840C061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 08:21:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 643E06103E
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 16:21:13 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 398A2C00446;
        Sun,  5 Dec 2021 16:21:11 +0000 (UTC)
Date:   Sun, 5 Dec 2021 16:26:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 01/12] iio:dac:ad5755: Switch to generic firmware
 properties and drop pdata
Message-ID: <20211205162622.7e3d77a4@jic23-huawei>
In-Reply-To: <CAHp75VdB-rV-KxwpWtapG7jhJHcdH8az9FWt+WgKNWCpZpojQg@mail.gmail.com>
References: <20211204171237.2769210-1-jic23@kernel.org>
        <20211204171237.2769210-2-jic23@kernel.org>
        <CAHp75Vd7vPfNMMBwDYuFSNtSZryyeGEDp9P6wcWCuJrz5B2OqA@mail.gmail.com>
        <CAHp75VdB-rV-KxwpWtapG7jhJHcdH8az9FWt+WgKNWCpZpojQg@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 5 Dec 2021 17:36:03 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Dec 5, 2021 at 5:02 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, Dec 4, 2021 at 7:07 PM Jonathan Cameron <jic23@kernel.org> wrote:  
> 
> ...
> 
> > > +       const struct ad5755_platform_data *pdata = NULL;
> > >         struct iio_dev *indio_dev;
> > >         struct ad5755_state *st;
> > >         int ret;  
> >  
> > > -       if (spi->dev.of_node)
> > > -               pdata = ad5755_parse_dt(&spi->dev);
> > > -       else
> > > -               pdata = spi->dev.platform_data;
> > > +       if (dev_fwnode(&spi->dev))
> > > +               pdata = ad5755_parse_fw(&spi->dev);
> > >
> > >         if (!pdata) {
> > > -               dev_warn(&spi->dev, "no platform data? using default\n");
> > > +               dev_warn(&spi->dev,
> > > +                        "no firmware provided parameters? using default\n");  
> >
> > It's fine to have it on one line (and not related to the 80 vs 100
> > case, it's about string literal as the last argument).
> >  
> > >                 pdata = &ad5755_default_pdata;
> > >         }  
> >
> >
> > Perhaps
> >
> >     const struct ad5755_platform_data *pdata;
> >     ...
> >     if (dev_fwnode(...))
> >       pdata = ...
> >     else
> >       pdata = &_default;
> >     if (pdata == &_default)
> >       dev_warn(...);
> >
> > ?  
> 
> After reading it again, I realized that pdata may be NULL in fwnode
> case. So, original code is fine, but I would rather move NULL
> assignment closer to the conditional (up to you, I'm fine with either,
> i.o.w. you may ignore this comment).
> 
I think a nicer way to tidy this up given I agree it's no immediately obvious
what is going on is to push

if (!dev_fwnode())
	return NULL;

into ad5755_parse_fw() then the flow here will be more obvious as just

	pdata = ad5755_parse_fw();
	if (!pdata) {
		dev_warn();
		pdata = &_default;
	}

