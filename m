Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444E121F820
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jul 2020 19:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgGNR00 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jul 2020 13:26:26 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2479 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbgGNR00 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Jul 2020 13:26:26 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 382E17DFB3F37659EEC1;
        Tue, 14 Jul 2020 18:26:24 +0100 (IST)
Received: from localhost (10.52.127.136) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Tue, 14 Jul
 2020 18:26:23 +0100
Date:   Tue, 14 Jul 2020 18:25:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH 1/3] iio: Move attach/detach of the poll func to the
 core
Message-ID: <20200714182514.00003e60@Huawei.com>
In-Reply-To: <51beb4f5cad1abdb8d832fed768cbcbe70d38882.camel@analog.com>
References: <20200522104632.517470-1-alexandru.ardelean@analog.com>
        <51beb4f5cad1abdb8d832fed768cbcbe70d38882.camel@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.127.136]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Jul 2020 14:57:36 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Fri, 2020-05-22 at 13:46 +0300, Alexandru Ardelean wrote:
> > From: Lars-Peter Clausen <lars@metafoo.de>
> > 
> > All devices using a triggered buffer need to attach and detach the
> > trigger
> > to the device in order to properly work. Instead of doing this in each
> > and
> > every driver by hand move this into the core.
> > 
> > At this point in time, all drivers should have been resolved to
> > attach/detach the poll-function in the same order.
> > 
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  .../buffer/industrialio-triggered-buffer.c    | 10 +--------
> >  drivers/iio/iio_core_trigger.h                | 17 ++++++++++++++
> >  drivers/iio/industrialio-buffer.c             | 13 +++++++++++
> >  drivers/iio/industrialio-trigger.c            | 22 ++++---------------
> >  include/linux/iio/trigger_consumer.h          |  7 ------
> >  5 files changed, 35 insertions(+), 34 deletions(-)
> > 
> > diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c
> > b/drivers/iio/buffer/industrialio-triggered-buffer.c
> > index e8046c1ecd6b..6c20a83f887e 100644
> > --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
> > +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
> > @@ -13,11 +13,6 @@
> >  #include <linux/iio/triggered_buffer.h>
> >  #include <linux/iio/trigger_consumer.h>
> >  
> > -static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops
> > = {
> > -	.postenable = &iio_triggered_buffer_postenable,
> > -	.predisable = &iio_triggered_buffer_predisable,
> > -};
> > -
> >  /**
> >   * iio_triggered_buffer_setup() - Setup triggered buffer and pollfunc
> >   * @indio_dev:		IIO device structure
> > @@ -67,10 +62,7 @@ int iio_triggered_buffer_setup(struct iio_dev
> > *indio_dev,
> >  	}
> >  
> >  	/* Ring buffer functions - here trigger setup related */
> > -	if (setup_ops)
> > -		indio_dev->setup_ops = setup_ops;
> > -	else
> > -		indio_dev->setup_ops = &iio_triggered_buffer_setup_ops;
> > +	indio_dev->setup_ops = setup_ops;
> >  
> >  	/* Flag that polled ring buffering is possible */
> >  	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
> > diff --git a/drivers/iio/iio_core_trigger.h
> > b/drivers/iio/iio_core_trigger.h
> > index e59fe2f36bbb..9d1a92cc6480 100644
> > --- a/drivers/iio/iio_core_trigger.h
> > +++ b/drivers/iio/iio_core_trigger.h
> > @@ -18,6 +18,12 @@ void iio_device_register_trigger_consumer(struct
> > iio_dev *indio_dev);
> >   **/
> >  void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev);
> >  
> > +
> > +int iio_trigger_attach_poll_func(struct iio_trigger *trig,
> > +				 struct iio_poll_func *pf);
> > +int iio_trigger_detach_poll_func(struct iio_trigger *trig,
> > +				 struct iio_poll_func *pf);
> > +
> >  #else
> >  
> >  /**
> > @@ -37,4 +43,15 @@ static void
> > iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
> >  {
> >  }
> >  
> > +static inline int iio_trigger_attach_poll_func(struct iio_trigger *trig,
> > +					       struct iio_poll_func *pf)
> > +{
> > +	return 0;
> > +}
> > +static inline int iio_trigger_detach_poll_func(struct iio_trigger *trig,
> > +					       struct iio_poll_func *pf)
> > +{
> > +	return 0;
> > +}
> > +
> >  #endif /* CONFIG_TRIGGER_CONSUMER */
> > diff --git a/drivers/iio/industrialio-buffer.c
> > b/drivers/iio/industrialio-buffer.c
> > index ec4f531994fa..88d756107fb2 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -20,6 +20,7 @@
> >  
> >  #include <linux/iio/iio.h>
> >  #include "iio_core.h"
> > +#include "iio_core_trigger.h"
> >  #include <linux/iio/sysfs.h>
> >  #include <linux/iio/buffer.h>
> >  #include <linux/iio/buffer_impl.h>
> > @@ -972,6 +973,13 @@ static int iio_enable_buffers(struct iio_dev
> > *indio_dev,
> >  		}
> >  	}
> >  
> > +	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> > +		ret = iio_trigger_attach_poll_func(indio_dev->trig,
> > +						   indio_dev->pollfunc);
> > +		if (ret)
> > +			goto err_disable_buffers;
> > +	}
> > +  
> 
> I'm wondering what happened here, or whether I was on some other planet, or
> some other universe where this was correct, but this part looks wrong.
> This should be called before the "indio_dev->setup_ops->postenable" call
> 
> And similarly iio_trigger_detach_poll_func() should be called after the
> "indio_dev->setup_ops->predisable" call.
> 
> This looks clearly like my fault.
> And it looks like I sent it like this from the start....
> 
> At this point, what's the way to fix this?
> Re-send or send a fix?

Gah. I missed it as well.  At this stage, a fix definitely. It will all
be in the same pull request, but I'd really rather not rebase the tree
again.

I guess this happened because of that debate a long time back on which
order made sense.  We concluded the one that you morphed all the drivers
into, but I guess we forgot the final patch.

I'll hold that pull request a bit longer.

Jonathan



> 
> I noticed this while sync-ing the ADI tree with upstream and comparing and
> spent a bit looking at this.
> 
> 
> >  	return 0;
> >  
> >  err_disable_buffers:
> > @@ -998,6 +1006,11 @@ static int iio_disable_buffers(struct iio_dev
> > *indio_dev)
> >  	if (list_empty(&indio_dev->buffer_list))
> >  		return 0;
> >  
> > +	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> > +		iio_trigger_detach_poll_func(indio_dev->trig,
> > +					     indio_dev->pollfunc);
> > +	}
> > +
> >  	/*
> >  	 * If things go wrong at some step in disable we still need to
> > continue
> >  	 * to perform the other steps, otherwise we leave the device in a
> > diff --git a/drivers/iio/industrialio-trigger.c
> > b/drivers/iio/industrialio-trigger.c
> > index 53d1931f6be8..6f16357fd732 100644
> > --- a/drivers/iio/industrialio-trigger.c
> > +++ b/drivers/iio/industrialio-trigger.c
> > @@ -239,8 +239,8 @@ static void iio_trigger_put_irq(struct iio_trigger
> > *trig, int irq)
> >   * the relevant function is in there may be the best option.
> >   */
> >  /* Worth protecting against double additions? */
> > -static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
> > -					struct iio_poll_func *pf)
> > +int iio_trigger_attach_poll_func(struct iio_trigger *trig,
> > +				 struct iio_poll_func *pf)
> >  {
> >  	int ret = 0;
> >  	bool notinuse
> > @@ -290,8 +290,8 @@ static int iio_trigger_attach_poll_func(struct
> > iio_trigger *trig,
> >  	return ret;
> >  }
> >  
> > -static int iio_trigger_detach_poll_func(struct iio_trigger *trig,
> > -					 struct iio_poll_func *pf)
> > +int iio_trigger_detach_poll_func(struct iio_trigger *trig,
> > +				 struct iio_poll_func *pf)
> >  {
> >  	int ret = 0;
> >  	bool no_other_users
> > @@ -705,17 +705,3 @@ void iio_device_unregister_trigger_consumer(struct
> > iio_dev *indio_dev)
> >  	if (indio_dev->trig)
> >  		iio_trigger_put(indio_dev->trig);
> >  }
> > -
> > -int iio_triggered_buffer_postenable(struct iio_dev *indio_dev)
> > -{
> > -	return iio_trigger_attach_poll_func(indio_dev->trig,
> > -					    indio_dev->pollfunc);
> > -}
> > -EXPORT_SYMBOL(iio_triggered_buffer_postenable);
> > -
> > -int iio_triggered_buffer_predisable(struct iio_dev *indio_dev)
> > -{
> > -	return iio_trigger_detach_poll_func(indio_dev->trig,
> > -					     indio_dev->pollfunc);
> > -}
> > -EXPORT_SYMBOL(iio_triggered_buffer_predisable);
> > diff --git a/include/linux/iio/trigger_consumer.h
> > b/include/linux/iio/trigger_consumer.h
> > index c3c6ba5ec423..3aa2f132dd67 100644
> > --- a/include/linux/iio/trigger_consumer.h
> > +++ b/include/linux/iio/trigger_consumer.h
> > @@ -50,11 +50,4 @@ irqreturn_t iio_pollfunc_store_time(int irq, void *p);
> >  
> >  void iio_trigger_notify_done(struct iio_trigger *trig);
> >  
> > -/*
> > - * Two functions for common case where all that happens is a pollfunc
> > - * is attached and detached from a trigger
> > - */
> > -int iio_triggered_buffer_postenable(struct iio_dev *indio_dev);
> > -int iio_triggered_buffer_predisable(struct iio_dev *indio_dev);
> > -
> >  #endif  


