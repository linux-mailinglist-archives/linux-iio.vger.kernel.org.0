Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D98B2D8F2C
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 18:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbgLMRxO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 12:53:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:52008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgLMRxO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 12:53:14 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 917C92085B;
        Sun, 13 Dec 2020 17:52:32 +0000 (UTC)
Date:   Sun, 13 Dec 2020 17:52:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] iio: as3935: Remove code to set trigger parent
Message-ID: <20201213175229.7665c0c5@archlinux>
In-Reply-To: <CA+U=Dsrds=qWRwbqHKyeWA7Wpd=Xm+YSA+KQZXfjiJJX=eTVNQ@mail.gmail.com>
References: <20201210204211.967018-1-gwendal@chromium.org>
        <20201210204211.967018-8-gwendal@chromium.org>
        <CA+U=Dsrds=qWRwbqHKyeWA7Wpd=Xm+YSA+KQZXfjiJJX=eTVNQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Dec 2020 10:07:32 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Thu, Dec 10, 2020 at 10:42 PM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > Already done in boiler plate code  
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
All the ones I haven't otherwise commented on look good to me.

Thanks for tidying this up.

Jonathan

> 
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> >  drivers/iio/proximity/as3935.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> > index b79ada839e01..edc4a35ae66d 100644
> > --- a/drivers/iio/proximity/as3935.c
> > +++ b/drivers/iio/proximity/as3935.c
> > @@ -411,7 +411,6 @@ static int as3935_probe(struct spi_device *spi)
> >
> >         st->trig = trig;
> >         st->noise_tripped = jiffies - HZ;
> > -       trig->dev.parent = indio_dev->dev.parent;
> >         iio_trigger_set_drvdata(trig, indio_dev);
> >         trig->ops = &iio_interrupt_trigger_ops;
> >
> > --
> > 2.29.2.576.ga3fc446d84-goog
> >  

