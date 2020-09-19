Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9C5270DD3
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 14:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgISMIG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 08:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgISMIG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 08:08:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6E4C2100A;
        Sat, 19 Sep 2020 12:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600517285;
        bh=EgKiU9/VVvNA7hE19FG0m+n+1/5T5kdxqWxMZ2cnTyQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FlEmfZjjpllqVY2aPcahZymEtgA368FF9g4NI3k/hxse1PPPeDUM4U9TYMQ3kQ9Lb
         swAXjGKnn6gXVzR06GhbRrfFyo/Nirld/oNOkneBIHQNoQmxNLT1OsNruUKU84J8Is
         usEPWtzeq6FhD4ndNDWROzNq0SVXL+gnQ8g4NMsQ=
Date:   Sat, 19 Sep 2020 13:08:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 2/3] iio: Add __printf() attributes to various
 allocation functions
Message-ID: <20200919130801.1085e8c0@archlinux>
In-Reply-To: <CA+U=DspU3pyM54KgTweoQWAqO0zbJno4pTxaBdzhg0Pz-Bda4g@mail.gmail.com>
References: <20200913132115.800131-1-jic23@kernel.org>
        <20200913132115.800131-3-jic23@kernel.org>
        <CA+U=DspU3pyM54KgTweoQWAqO0zbJno4pTxaBdzhg0Pz-Bda4g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Sep 2020 16:25:05 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Sun, Sep 13, 2020 at 4:24 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > A partial set of these was added to IIO a long time back.
> > This fills in some gaps in coverage highlighted by building
> > with W=1
> >  
> 
> Stylistically, it looks like plenty of these attributes are specified
> on a separate line before the function definition.
> Example:
> 
> __printf(1, 0)
> static struct iio_trigger *viio_trigger_alloc(const char *fmt, va_list vargs)
> 
> It doesn't make much difference to me how it's placed.
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Thanks. I've tweaked it wrt to both the feedback you gave and that
which Andy gave in the request to review thread.

So on this example we end up with
static printf(..)
struct

Thanks!

Jonathan

> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/industrialio-trigger.c   | 2 +-
> >  include/linux/iio/iio.h              | 4 ++--
> >  include/linux/iio/trigger_consumer.h | 2 +-
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> > index 6f16357fd732..adfe023cad48 100644
> > --- a/drivers/iio/industrialio-trigger.c
> > +++ b/drivers/iio/industrialio-trigger.c
> > @@ -516,7 +516,7 @@ static void iio_trig_subirqunmask(struct irq_data *d)
> >         trig->subirqs[d->irq - trig->subirq_base].enabled = true;
> >  }
> >
> > -static struct iio_trigger *viio_trigger_alloc(const char *fmt, va_list vargs)
> > +__printf(1, 0) static struct iio_trigger *viio_trigger_alloc(const char *fmt, va_list vargs)
> >  {
> >         struct iio_trigger *trig;
> >         int i;
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index e2df67a3b9ab..a02a3efad794 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -691,8 +691,8 @@ static inline void *iio_priv(const struct iio_dev *indio_dev)
> >
> >  void iio_device_free(struct iio_dev *indio_dev);
> >  struct iio_dev *devm_iio_device_alloc(struct device *parent, int sizeof_priv);
> > -struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
> > -                                               const char *fmt, ...);
> > +__printf(2, 3) struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
> > +                                                         const char *fmt, ...);
> >  /**
> >   * iio_buffer_enabled() - helper function to test if the buffer is enabled
> >   * @indio_dev:         IIO device structure for device
> > diff --git a/include/linux/iio/trigger_consumer.h b/include/linux/iio/trigger_consumer.h
> > index 3aa2f132dd67..2c05dfad88d7 100644
> > --- a/include/linux/iio/trigger_consumer.h
> > +++ b/include/linux/iio/trigger_consumer.h
> > @@ -38,7 +38,7 @@ struct iio_poll_func {
> >  };
> >
> >
> > -struct iio_poll_func
> > +__printf(5, 6) struct iio_poll_func
> >  *iio_alloc_pollfunc(irqreturn_t (*h)(int irq, void *p),
> >                     irqreturn_t (*thread)(int irq, void *p),
> >                     int type,
> > --
> > 2.28.0
> >  

