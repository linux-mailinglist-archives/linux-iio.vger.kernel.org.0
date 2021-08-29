Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC353FAD5B
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 19:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhH2RDL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 29 Aug 2021 13:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhH2RDL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 13:03:11 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DB2260E76;
        Sun, 29 Aug 2021 17:02:16 +0000 (UTC)
Date:   Sun, 29 Aug 2021 18:05:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] iio: ad5770r: make devicetree property reading
 consistent
Message-ID: <20210829180533.24adfdb1@jic23-huawei>
In-Reply-To: <CAHp75VekRA=U0CUmZWj+3Q4t2CB-51EdtphT_Mt_kAvyPK_fFQ@mail.gmail.com>
References: <20210818080525.62790-1-nuno.sa@analog.com>
        <CAHp75VekRA=U0CUmZWj+3Q4t2CB-51EdtphT_Mt_kAvyPK_fFQ@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Aug 2021 12:54:09 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Aug 18, 2021 at 11:05 AM Nuno Sá <nuno.sa@analog.com> wrote:
> >
> > The bindings file for this driver is defining the property as 'reg' but
> > the driver was reading it with the 'num' name. The bindings actually had
> > the 'num' property when added in
> > commit ea52c21268e6 ("dt-bindings: iio: dac: Add docs for AD5770R DAC")
> > and then changed it to 'reg' in
> > commit 2cf3818f18b2 ("dt-bindings: iio: dac: AD5570R fix bindings errors").
> > However, both these commits landed in v5.7 so the assumption is
> > that either 'num' is not being used or if it is, the validations were not
> > done.
> >
> > Anyways, if someone comes back yelling about this, we might just support
> > both of the properties in the future. Not ideal, but that's life...  
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Given the potential issues on this I want it to sit in next for a while. As such
I'm applying it via the slow path rather than the quick one.  It'll sit in next
for most of a cycle before the merge window in 3 months time.

Hopefully anyone who has fallen in the gap is doing tests! (seems unlikely but
they can't claim we didn't give them time to notice ;)

Applied to the togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> 
> > Fixes: 2cf3818f18b2 ("dt-bindings: iio: dac: AD5570R fix bindings errors")
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > ---
> > v2:
> >  * Updated the commit description and added a fixes tag.
> >
> >  drivers/iio/dac/ad5770r.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
> > index 8107f7bbbe3c..7e2fd32e993a 100644
> > --- a/drivers/iio/dac/ad5770r.c
> > +++ b/drivers/iio/dac/ad5770r.c
> > @@ -522,7 +522,7 @@ static int ad5770r_channel_config(struct ad5770r_state *st)
> >                 return -EINVAL;
> >
> >         device_for_each_child_node(&st->spi->dev, child) {
> > -               ret = fwnode_property_read_u32(child, "num", &num);
> > +               ret = fwnode_property_read_u32(child, "reg", &num);
> >                 if (ret)
> >                         goto err_child_out;
> >                 if (num >= AD5770R_MAX_CHANNELS) {
> > --
> > 2.32.0
> >  
> 
> 

