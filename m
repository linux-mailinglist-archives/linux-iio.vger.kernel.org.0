Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB23245702
	for <lists+linux-iio@lfdr.de>; Sun, 16 Aug 2020 11:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgHPJOt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Aug 2020 05:14:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgHPJOq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Aug 2020 05:14:46 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5FA620674;
        Sun, 16 Aug 2020 09:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597569286;
        bh=l63dUHbS6Bp3x5IMpHcacWIoxv2j+1YwIkwZ7tn0Xk0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TTn6s82bJUssrz954gHhzA5EUGmflcM3/F5f77QYh3pHOHAogClIsx4Fg4lJNAaa6
         fValdRVMOGU1x27g2wrB1UbgPjYCNll6nsp32KfrFrlgZW+cXGzv4o9GTlM6p90CJ9
         HebyIeoCusGySPbYH1v0LM4YfY8ZcBnq95625UIc=
Date:   Sun, 16 Aug 2020 10:14:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Angelo Compagnucci <angelo@amarulasolutions.com>
Subject: Re: [PATCH] iio: adc: mcp3422: fix locking scope
Message-ID: <20200816101442.70cbfda0@archlinux>
In-Reply-To: <CA+TH9VkXpHwuMv4EA+SF8GkR-8sZQ8DrCqqovURwcU48NP0+bA@mail.gmail.com>
References: <20200801135511.342869-1-angelo@amarulasolutions.com>
        <20200801174633.08cee9d1@archlinux>
        <CA+TH9VkXpHwuMv4EA+SF8GkR-8sZQ8DrCqqovURwcU48NP0+bA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 Aug 2020 08:24:46 +0200
Angelo Compagnucci <angelo.compagnucci@gmail.com> wrote:

> Il giorno sab 1 ago 2020 alle ore 18:46 Jonathan Cameron
> <jic23@jic23.retrosnub.co.uk> ha scritto:
> >
> > On Sat,  1 Aug 2020 15:55:11 +0200
> > Angelo Compagnucci <angelo.compagnucci@gmail.com> wrote:
> >  
> > > Locking should be held for the entire reading sequence involving setting
> > > the channel, waiting for the channel switch and reading from the
> > > channel.
> > > If not, reading from a channel can result mixing with the reading from
> > > another channel.
> > >
> > > Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>  
> >
> > Looks like we should be backporting this.  Fixes tag please.  
> 
> I don't know what it fixes, there is no signalled bug for this, I
> simply discovered it doing some testing.

In this case I'm just looking for which patch originally introduced the
bug.  It might be the original driver introduction of course in which
case give me a tag for that (look at SubmittingPatches.rst for info).

That info is needed to let us figure out which stable kernels we should
backport this to.

Thanks

Jonathan

> 
> >
> > Jonathan
> >  
> > > ---
> > >  drivers/iio/adc/mcp3422.c | 12 +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> > > index d86c0b5d80a3..02a60fb164cd 100644
> > > --- a/drivers/iio/adc/mcp3422.c
> > > +++ b/drivers/iio/adc/mcp3422.c
> > > @@ -96,16 +96,12 @@ static int mcp3422_update_config(struct mcp3422 *adc, u8 newconfig)
> > >  {
> > >       int ret;
> > >
> > > -     mutex_lock(&adc->lock);
> > > -
> > >       ret = i2c_master_send(adc->i2c, &newconfig, 1);
> > >       if (ret > 0) {
> > >               adc->config = newconfig;
> > >               ret = 0;
> > >       }
> > >
> > > -     mutex_unlock(&adc->lock);
> > > -
> > >       return ret;
> > >  }
> > >
> > > @@ -138,6 +134,8 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
> > >       u8 config;
> > >       u8 req_channel = channel->channel;
> > >
> > > +     mutex_lock(&adc->lock);
> > > +
> > >       if (req_channel != MCP3422_CHANNEL(adc->config)) {
> > >               config = adc->config;
> > >               config &= ~MCP3422_CHANNEL_MASK;
> > > @@ -150,7 +148,11 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
> > >               msleep(mcp3422_read_times[MCP3422_SAMPLE_RATE(adc->config)]);
> > >       }
> > >
> > > -     return mcp3422_read(adc, value, &config);
> > > +     ret = mcp3422_read(adc, value, &config);
> > > +
> > > +     mutex_unlock(&adc->lock);
> > > +
> > > +     return ret;
> > >  }
> > >
> > >  static int mcp3422_read_raw(struct iio_dev *iio,  
> >  
> 
> 

