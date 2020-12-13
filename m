Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CB72D8F26
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 18:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgLMRqL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 12:46:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:49438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgLMRqL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 12:46:11 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC6C522BF5;
        Sun, 13 Dec 2020 17:45:29 +0000 (UTC)
Date:   Sun, 13 Dec 2020 17:45:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] iio: fix devm_iio_trigger_alloc with
 parent.cocci
Message-ID: <20201213174526.5d81c7bb@archlinux>
In-Reply-To: <CA+U=DsrGAUP_T4rd_L0ctp6Drm35DcGEzTaJv=uVxO5JufVabQ@mail.gmail.com>
References: <20201210204211.967018-1-gwendal@chromium.org>
        <20201210204211.967018-3-gwendal@chromium.org>
        <CA+U=DsrGAUP_T4rd_L0ctp6Drm35DcGEzTaJv=uVxO5JufVabQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Dec 2020 09:47:58 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Thu, Dec 10, 2020 at 10:42 PM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > Use cocci semantic patch:
> > @@
> > expression trigger, P, name;
> > @@
> >    trigger = devm_iio_trigger_alloc(P, ...);
> >    ...
> > -  trigger->dev.parent = P;
> >
> > To remove trigger->dev.parent, since it is set by default.
> >  
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

There's a bonus one in here :)

Otherwise looks good.

Jonathan




> > diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> > index 765c44adac57..e732d308ac4e 100644
> > --- a/drivers/iio/light/vcnl4035.c
> > +++ b/drivers/iio/light/vcnl4035.c
> > @@ -511,7 +511,6 @@ static int vcnl4035_probe_trigger(struct iio_dev *indio_dev)
> >         if (!data->drdy_trigger0)
> >                 return -ENOMEM;
> >
> > -       data->drdy_trigger0->dev.parent = indio_dev->dev.parent;
> >         data->drdy_trigger0->ops = &vcnl4035_trigger_ops;
> >         iio_trigger_set_drvdata(data->drdy_trigger0, indio_dev);
> >         ret = devm_iio_trigger_register(indio_dev->dev.parent,

This one is a bit obscured by the code.  I wonder it it would be sensible to
just pass the client->dev directly into vcnl4035_probe_trigger rather than
somewhat making us guess where it goes. Unrelated to your patch though.

> > diff --git a/drivers/iio/proximity/sx932x.c b/drivers/iio/proximity/sx932x.c
> > index 26503348ce85..95ad49e627c6 100644
> > --- a/drivers/iio/proximity/sx932x.c
> > +++ b/drivers/iio/proximity/sx932x.c
> > @@ -1336,7 +1336,6 @@ static int sx932x_probe(struct i2c_client *client,
> >                 if (!data->trig)
> >                         return -ENOMEM;
> >
> > -               data->trig->dev.parent = &client->dev;
> >                 data->trig->ops = &sx932x_trigger_ops;
> >                 iio_trigger_set_drvdata(data->trig, indio_dev);

There is no such driver in mainline yet.

I had the sudden horror that I'd let another wild card name in without
noticing and checked :)  We had a v1 of the patch, but currently
waiting for v2.

Jonathan

> >
> > --
> > 2.29.2.576.ga3fc446d84-goog
> >  

