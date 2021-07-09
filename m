Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFBC3C260B
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 16:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhGIOh5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 10:37:57 -0400
Received: from first.geanix.com ([116.203.34.67]:36992 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231921AbhGIOhz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Jul 2021 10:37:55 -0400
Received: from skn-laptop (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id 3D2B04C63D7;
        Fri,  9 Jul 2021 14:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1625841307; bh=bh6RWvk3gmI+BmTSxLuJ9NcI8N1I3Z2smqLftpZU+y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ApIdNMxurywsYvIo8oZfSSHfK/bjc6l5eWGbDvuLDGF7aHc5lVIsktOl6Qvsbokwh
         axeNpl9sOmQd71eFz71Y+uUXOMrTegznugOToWaHfy0YLXTo603yeXXXI2XTvDBfcV
         Lt8OuHb4+3SSD7JZXYQnET6ADMm1pZpo3LMmnZhbIW0Kq04k5Am08yJURWgTuBtmLk
         i0DKZ/CN/XDeGQl4P5XaT6fMw8yd3yPKgZRQxwtQYENdg6lF/HxAg2aGvZFZj2c2HQ
         Z2oTGaBg26YpNkEkxVyK3diNPB3rUb7nAATgFyaEHqScVkUUjoHnp3tVJwlJ8EjoVo
         rZmSdvyAlvOmA==
Date:   Fri, 9 Jul 2021 16:35:05 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] iio: accel: fxls8962af: Initialize return value
Message-ID: <20210709143505.4xzpols32j7rotpc@skn-laptop>
References: <20210709031526.30746-1-jrdr.linux@gmail.com>
 <CAOMZO5BHDBR5y5q559UexTmYbhPwSp1MV3TJ3k+z4W8ehE-5_Q@mail.gmail.com>
 <CAFqt6zZ3WOv6sv5iVgkbYBhnxvv=t1pE8ZxEiC7=j5qugvy=NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFqt6zZ3WOv6sv5iVgkbYBhnxvv=t1pE8ZxEiC7=j5qugvy=NA@mail.gmail.com>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 09, 2021 at 07:50:48PM +0530, Souptick Joarder wrote:
> On Fri, 9 Jul, 2021, 9:06 am Fabio Estevam, <festevam@gmail.com> wrote:
> 
> > Hi Souptick,
> >
> > On Fri, Jul 9, 2021 at 12:17 AM Souptick Joarder <jrdr.linux@gmail.com>
> > wrote:
> > >
> > > kernel test robot throws below warning ->
> > >
> > > smatch warnings:
> > > drivers/iio/accel/fxls8962af-core.c:640
> > > fxls8962af_i2c_raw_read_errata3() error: uninitialized symbol 'ret'.
> > >
> > > Initialize it.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > ---
> > >  drivers/iio/accel/fxls8962af-core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/accel/fxls8962af-core.c
> > b/drivers/iio/accel/fxls8962af-core.c
> > > index 078d87865fde..8af1c8f58e83 100644
> > > --- a/drivers/iio/accel/fxls8962af-core.c
> > > +++ b/drivers/iio/accel/fxls8962af-core.c
> > > @@ -628,7 +628,7 @@ static int fxls8962af_i2c_raw_read_errata3(struct
> > fxls8962af_data *data,
> > >                                            u16 *buffer, int samples,
> > >                                            int sample_length)
> > >  {
> > > -       int i, ret;
> > > +       int i, ret = -EINVAL;
> > >
> > >         for (i = 0; i < samples; i++) {
> > >                 ret = regmap_raw_read(data->regmap, FXLS8962AF_BUF_X_LSB,
> >
> > Would the change below work?
> >
> 
> This function returns -ERRNO when failed. If it is not entering loop,
> ideally it should return -ERRNO, not 0. No ?

samples can't be 0, as fxls8962af_fifo_transfer() is never called if
samples are 0 :)

> 
> >
> > --- a/drivers/iio/accel/fxls8962af-core.c
> > +++ b/drivers/iio/accel/fxls8962af-core.c
> > @@ -637,7 +637,7 @@ static int fxls8962af_i2c_raw_read_errata3(struct
> > fxls8962af_data *data,
> >                         return ret;
> >         }
> >
> > -       return ret;
> > +       return 0;
> >  }
> >

