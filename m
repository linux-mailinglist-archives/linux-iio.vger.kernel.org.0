Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 074DC89916
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2019 10:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfHLI5n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 12 Aug 2019 04:57:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56574 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727167AbfHLI5n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Aug 2019 04:57:43 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9EE8799132131362ED60;
        Mon, 12 Aug 2019 16:57:33 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 12 Aug 2019
 16:57:30 +0800
Date:   Mon, 12 Aug 2019 09:57:17 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Rodrigo Ribeiro <rodrigorsdc@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <kernel-usp@googlegroups.com>
Subject: Re: [PATCH] staging: iio: accel: adis16240: Improve readability on
 write_raw function
Message-ID: <20190812095717.00002918@huawei.com>
In-Reply-To: <CAOeBkLqGe-5LwBq1yrX_F8kNn2UK-7+7H+AOZPAqKS5OKHuYkA@mail.gmail.com>
References: <20190810150058.3509-1-rodrigorsdc@gmail.com>
        <20190811094322.063ad682@archlinux>
        <CAOeBkLqGe-5LwBq1yrX_F8kNn2UK-7+7H+AOZPAqKS5OKHuYkA@mail.gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 11 Aug 2019 13:47:04 -0300
Rodrigo Ribeiro <rodrigorsdc@gmail.com> wrote:

> Em dom, 11 de ago de 2019 às 05:43, Jonathan Cameron
> <jic23@kernel.org> escreveu:
> >
> > On Sat, 10 Aug 2019 12:00:58 -0300
> > Rodrigo <rodrigorsdc@gmail.com> wrote:
> >  
> > > From: Rodrigo Carvalho <rodrigorsdc@gmail.com>
> > >
> > > Improve readability by using GENMASK macro, changing switch statement
> > > by if statement and removing unnecessary local variables.  
> >  
> 
> Hi Jonathan. Thanks for reviewing!
> 
> > From your description it sounds like multiple changes in one patch.
> > Always preferable to have one type of change in a patch and more
> > small patches.
> >
> > Based on comments below, I would leave the switch statement alone,
> > but put in your GENMASK change as that one is good and gets
> > rid of the odd local variable 'bits' as well :)
> >
> > Thanks,
> >
> > Jonathan
> >
> >  
> > >
> > > Signed-off-by: Rodrigo Ribeiro Carvalho <rodrigorsdc@gmail.com>
> > > ---
> > >  drivers/staging/iio/accel/adis16240.c | 16 +++++++---------
> > >  1 file changed, 7 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
> > > index 62f4b3b1b457..68f165501389 100644
> > > --- a/drivers/staging/iio/accel/adis16240.c
> > > +++ b/drivers/staging/iio/accel/adis16240.c
> > > @@ -309,17 +309,15 @@ static int adis16240_write_raw(struct iio_dev *indio_dev,
> > >                              long mask)
> > >  {
> > >       struct adis *st = iio_priv(indio_dev);
> > > -     int bits = 10;
> > > -     s16 val16;
> > > +     int m;
> > >       u8 addr;
> > >
> > > -     switch (mask) {
> > > -     case IIO_CHAN_INFO_CALIBBIAS:
> > > -             val16 = val & ((1 << bits) - 1);
> > > -             addr = adis16240_addresses[chan->scan_index][0];
> > > -             return adis_write_reg_16(st, addr, val16);
> > > -     }
> > > -     return -EINVAL;
> > > +     if (mask != IIO_CHAN_INFO_CALIBBIAS)
> > > +             return -EINVAL;  
> >
> > Hmm. We generally encourage the use of switch statements in these
> > cases because they reduce churn as new features are added.
> >
> > In this particular case, we don't have any control of sampling frequency
> > in the driver, but the hardware appears to support it (table 23 on the
> > datasheet).  
> 
> On drivers of same kind out of staging (adis16209 and adis16201), sampling
> frequency writing are not implemented, even though datasheets suggest a register
> writing for this. I can try to implement if it is a good one.

I would be a bit nervous about doing so if you don't have
hardware, and we can't find anyone who is setup to test the device.

Obviously if you can get it tested one way or the other, it would be good
to add support.


Thanks,

J

> 
> > > +
> > > +     m = GENMASK(9, 0);
> > > +     addr = adis16240_addresses[chan->scan_index][0];
> > > +     return adis_write_reg_16(st, addr, val & m);  
> > Why the local variable m?  Can we not just do
> >
> >         return adis_write_reg_16(st, addr, val & GENMASK(9, 0));
> >
> > If anything I think that is a little more readable than your
> > version.  There is a reasonable argument for just having
> > addr inline as well.
> >
> >         return adis_write_reg_16(st,
> >                                  adis16240_addresses[chan->scan_index][0],
> >                                  val & GENMASK(9, 0));
> >
> > However, given I'm suggesting you leave it as a switch statement, it
> > will be too long with addr inline.
> >  
> > >  }
> > >
> > >  static const struct iio_chan_spec adis16240_channels[] = {  
> >  
> 
> Regards,
> Rodrigo


