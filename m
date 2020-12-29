Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0412E7301
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 19:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgL2S32 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Dec 2020 13:29:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgL2S32 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Dec 2020 13:29:28 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACA0020867;
        Tue, 29 Dec 2020 18:28:46 +0000 (UTC)
Date:   Tue, 29 Dec 2020 18:28:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: ad5504: Fix setting power-down state
Message-ID: <20201229182843.0086fc88@archlinux>
In-Reply-To: <CA+U=DspaoNjJGei+kyV4L+MzvYqJy08LdsGnf0y6uHr85PbD5g@mail.gmail.com>
References: <20201209104649.5794-1-lars@metafoo.de>
        <20201213165530.18dce485@archlinux>
        <CA+U=DspaoNjJGei+kyV4L+MzvYqJy08LdsGnf0y6uHr85PbD5g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 14 Dec 2020 09:23:20 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Sun, Dec 13, 2020 at 8:59 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Wed,  9 Dec 2020 11:46:49 +0100
> > Lars-Peter Clausen <lars@metafoo.de> wrote:
> >  
> > > The power-down mask of the ad5504 is actually a power-up mask. Meaning if
> > > a bit is set the corresponding channel is powered up and if it is not set
> > > the channel is powered down.
> > >
> > > The driver currently has this the wrong way around, resulting in the
> > > channel being powered up when requested to be powered down and vice versa.
> > >
> > > Fixes: 3bbbf150ffde ("staging:iio:dac:ad5504: Use strtobool for boolean values")
> > > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > > ---
> > > Stumbled upon this while looking at something else. It is untested, but I
> > > think it should be right. Alex can you double check?  
> >
> > I read the datasheet as saying this fix is right but will wait for
> > a confirmation from Alex.  
> 
> Oh.
> I see why the initial confusion existed.
> Was confused a bit myself.
> The thermal shutdown follows the initial/unchanged logic.
> While the actual powerdown channel bits are inverted.
> 
> Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for
stable.

Thanks,

Jonathan

> 
> 
> >
> > Thanks,
> >
> > Jonathan
> >  
> > > ---
> > >  drivers/iio/dac/ad5504.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
> > > index 28921b62e642..e9297c25d4ef 100644
> > > --- a/drivers/iio/dac/ad5504.c
> > > +++ b/drivers/iio/dac/ad5504.c
> > > @@ -187,9 +187,9 @@ static ssize_t ad5504_write_dac_powerdown(struct iio_dev *indio_dev,
> > >               return ret;
> > >
> > >       if (pwr_down)
> > > -             st->pwr_down_mask |= (1 << chan->channel);
> > > -     else
> > >               st->pwr_down_mask &= ~(1 << chan->channel);
> > > +     else
> > > +             st->pwr_down_mask |= (1 << chan->channel);
> > >
> > >       ret = ad5504_spi_write(st, AD5504_ADDR_CTRL,
> > >                               AD5504_DAC_PWRDWN_MODE(st->pwr_down_mode) |  
> >  

