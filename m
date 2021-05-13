Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109E437FC1C
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 19:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhEMRJ1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 13 May 2021 13:09:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229877AbhEMRJ0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 13:09:26 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A41561408;
        Thu, 13 May 2021 17:08:13 +0000 (UTC)
Date:   Thu, 13 May 2021 18:09:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: Re: [PATCH v1 1/1] iio: dac: ad5770r: Put fwnode in error case
 during ->probe()
Message-ID: <20210513180922.44e0a0ad@jic23-huawei>
In-Reply-To: <CAHp75VfFTnS6+6KwqixTXNsMvC_LWGnY0rv3n9g_-i7HK2eq0w@mail.gmail.com>
References: <20210510095649.3302835-1-andy.shevchenko@gmail.com>
        <CA+U=DsoX1kTy-NwNFPajWMZnJT+cY9MocSGpgTggmhgXrhXREg@mail.gmail.com>
        <CAHp75VfFTnS6+6KwqixTXNsMvC_LWGnY0rv3n9g_-i7HK2eq0w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 13 May 2021 01:00:22 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wednesday, May 12, 2021, Alexandru Ardelean <ardeleanalex@gmail.com>
> wrote:
> 
> > On Mon, May 10, 2021 at 12:59 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:  
> > >
> > > device_for_each_child_node() bumps a reference counting of a returned  
> > variable.  
> > > We have to balance it whenever we return to the caller.  
> >
> > This feels like the device_for_each_child_node() [and the of_node
> > variant] iterator[s] need[s] some re-design to account for how easy it
> > is to slip stuff by.  
> 
> 
> I don’t know how you can do it differently if you wish to give a guarantee
> that object doesn’t suddenly disappear while you are iterating over it.
> 
> Look at the bus_find_device() and similar APIs, they basically do the
> similar.
> 
> 
> 
> > But that's something quite out of this scope.
> >
> > Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> >
> >  
> Thanks.
> 
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Joathan

> 
> > >
> > > Fixes: cbbb819837f6 ("iio: dac: ad5770r: Add AD5770R support")
> > > Cc: Alexandru Tachici <alexandru.tachici@analog.com>
> > > Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > ---
> > >  drivers/iio/dac/ad5770r.c | 16 +++++++++++-----
> > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
> > > index 7ab2ccf90863..8107f7bbbe3c 100644
> > > --- a/drivers/iio/dac/ad5770r.c
> > > +++ b/drivers/iio/dac/ad5770r.c
> > > @@ -524,23 +524,29 @@ static int ad5770r_channel_config(struct  
> > ad5770r_state *st)  
> > >         device_for_each_child_node(&st->spi->dev, child) {
> > >                 ret = fwnode_property_read_u32(child, "num", &num);
> > >                 if (ret)
> > > -                       return ret;
> > > -               if (num >= AD5770R_MAX_CHANNELS)
> > > -                       return -EINVAL;
> > > +                       goto err_child_out;
> > > +               if (num >= AD5770R_MAX_CHANNELS) {
> > > +                       ret = -EINVAL;
> > > +                       goto err_child_out;
> > > +               }
> > >
> > >                 ret = fwnode_property_read_u32_array(child,
> > >  
> > "adi,range-microamp",  
> > >                                                      tmp, 2);
> > >                 if (ret)
> > > -                       return ret;
> > > +                       goto err_child_out;
> > >
> > >                 min = tmp[0] / 1000;
> > >                 max = tmp[1] / 1000;
> > >                 ret = ad5770r_store_output_range(st, min, max, num);
> > >                 if (ret)
> > > -                       return ret;
> > > +                       goto err_child_out;
> > >         }
> > >
> > > +       return 0;
> > > +
> > > +err_child_out:
> > > +       fwnode_handle_put(child);
> > >         return ret;
> > >  }
> > >
> > > --
> > > 2.31.1
> > >  
> >  
> 
> 

