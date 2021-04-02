Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCA93528C8
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 11:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbhDBJaK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Apr 2021 05:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235043AbhDBJaJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 2 Apr 2021 05:30:09 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A874661005;
        Fri,  2 Apr 2021 09:30:06 +0000 (UTC)
Date:   Fri, 2 Apr 2021 10:30:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] iio:adc: Drop false comment about lack of timestamp
 control
Message-ID: <20210402103019.75bf89d9@jic23-huawei>
In-Reply-To: <CA+U=DsoFoBXAht_1QmROOshXKe=Vh8PBo5HfXj6c2WSn-_Qgpw@mail.gmail.com>
References: <20210401145410.226917-1-jic23@kernel.org>
        <CA+U=DsoFoBXAht_1QmROOshXKe=Vh8PBo5HfXj6c2WSn-_Qgpw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2 Apr 2021 10:25:41 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Thu, Apr 1, 2021 at 5:56 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > The timestamp control has been a function implemented in the core of
> > IIO for a long time, so this comment is incorrect and has clearly been
> > cut and paste into all these drivers.
> >
> > The remainder of the comment added nothing and was confusing so dropped
> > that as well.
> >  
> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

Applied to the togreg branch of iio.git and push out testing for
all the normal reasons.

Thanks,

Jonathan

> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> >
> > ---
> >  drivers/iio/adc/ad7298.c | 6 ------
> >  drivers/iio/adc/ad7887.c | 6 ------
> >  drivers/iio/adc/ad7923.c | 6 ------
> >  drivers/iio/adc/ad799x.c | 6 ------
> >  4 files changed, 24 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
> > index 689ecd5dd563..d2163cb62f4f 100644
> > --- a/drivers/iio/adc/ad7298.c
> > +++ b/drivers/iio/adc/ad7298.c
> > @@ -142,12 +142,6 @@ static int ad7298_update_scan_mode(struct iio_dev *indio_dev,
> >         return 0;
> >  }
> >
> > -/*
> > - * ad7298_trigger_handler() bh of trigger launched polling to ring buffer
> > - *
> > - * Currently there is no option in this driver to disable the saving of
> > - * timestamps within the ring.
> > - */
> >  static irqreturn_t ad7298_trigger_handler(int irq, void *p)
> >  {
> >         struct iio_poll_func *pf = p;
> > diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
> > index 4f6f0e0e03ee..9b3cbe1ddc6f 100644
> > --- a/drivers/iio/adc/ad7887.c
> > +++ b/drivers/iio/adc/ad7887.c
> > @@ -109,12 +109,6 @@ static int ad7887_ring_postdisable(struct iio_dev *indio_dev)
> >         return spi_sync(st->spi, &st->msg[AD7887_CH0]);
> >  }
> >
> > -/*
> > - * ad7887_trigger_handler() bh of trigger launched polling to ring buffer
> > - *
> > - * Currently there is no option in this driver to disable the saving of
> > - * timestamps within the ring.
> > - **/
> >  static irqreturn_t ad7887_trigger_handler(int irq, void *p)
> >  {
> >         struct iio_poll_func *pf = p;
> > diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> > index 287f4c13194e..9a649745cd0a 100644
> > --- a/drivers/iio/adc/ad7923.c
> > +++ b/drivers/iio/adc/ad7923.c
> > @@ -192,12 +192,6 @@ static int ad7923_update_scan_mode(struct iio_dev *indio_dev,
> >         return 0;
> >  }
> >
> > -/*
> > - * ad7923_trigger_handler() bh of trigger launched polling to ring buffer
> > - *
> > - * Currently there is no option in this driver to disable the saving of
> > - * timestamps within the ring.
> > - */
> >  static irqreturn_t ad7923_trigger_handler(int irq, void *p)
> >  {
> >         struct iio_poll_func *pf = p;
> > diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> > index 1575b7670207..18bf8386d50a 100644
> > --- a/drivers/iio/adc/ad799x.c
> > +++ b/drivers/iio/adc/ad799x.c
> > @@ -182,12 +182,6 @@ static int ad799x_update_config(struct ad799x_state *st, u16 config)
> >         return 0;
> >  }
> >
> > -/*
> > - * ad799x_trigger_handler() bh of trigger launched polling to ring buffer
> > - *
> > - * Currently there is no option in this driver to disable the saving of
> > - * timestamps within the ring.
> > - **/
> >  static irqreturn_t ad799x_trigger_handler(int irq, void *p)
> >  {
> >         struct iio_poll_func *pf = p;
> > --
> > 2.31.1
> >  

