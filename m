Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66487D2ED4
	for <lists+linux-iio@lfdr.de>; Mon, 23 Oct 2023 11:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjJWJtp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 23 Oct 2023 05:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjJWJtm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Oct 2023 05:49:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962B5DF
        for <linux-iio@vger.kernel.org>; Mon, 23 Oct 2023 02:49:39 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SDVhf6s4yz6K6Lg;
        Mon, 23 Oct 2023 17:46:58 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 23 Oct
 2023 10:49:37 +0100
Date:   Mon, 23 Oct 2023 10:49:36 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     David Lechner <dlechner@baylibre.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 1/8] iio: locking: introduce __cleanup() based
 direct mode claiming infrastructure
Message-ID: <20231023104936.0000124d@Huawei.com>
In-Reply-To: <CAMknhBEEPC-JArFJvpHw0YAmdA+BrAQzkxU5vNvCwxf5OdHKrw@mail.gmail.com>
References: <20231022154710.402590-1-jic23@kernel.org>
        <20231022154710.402590-2-jic23@kernel.org>
        <CAMknhBEEPC-JArFJvpHw0YAmdA+BrAQzkxU5vNvCwxf5OdHKrw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Oct 2023 16:10:48 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Sun, Oct 22, 2023 at 10:47 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Allows use of:
> >
> >         CLASS(iio_claim_direct, claimed_dev)(indio_dev);
> >         if (IS_ERR(claimed_dev))
> >                 return PTR_ERR(claimed_dev);
> >
> >         st = iio_priv(claimed_dev);
> >
> > to automatically call iio_device_release_direct_mode() based on scope.
> > Typically seen in combination with local device specific locks which
> > are already have automated cleanup options via guard(mutex)(&st->lock)
> > and scoped_guard().  Using both together allows most error handling to
> > be automated.
> >
> > Note that whilst this pattern results in a struct iio_dev *claimed_dev
> > that can be used, it is not necessary to do so as long as that pointer
> > has been checked for errors as in the example.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/industrialio-core.c |  4 ++++
> >  include/linux/iio/iio.h         | 25 +++++++++++++++++++++++++
> >  2 files changed, 29 insertions(+)
> >
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index c77745b594bd..93bfad105eb5 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -2065,6 +2065,10 @@ EXPORT_SYMBOL_GPL(iio_device_claim_direct_mode);
> >   */
> >  void iio_device_release_direct_mode(struct iio_dev *indio_dev)
> >  {
> > +       /* Auto cleanup can result in this being called with an ERR_PTR */
> > +       if (IS_ERR(indio_dev))
> > +               return;
> > +
> >         mutex_unlock(&to_iio_dev_opaque(indio_dev)->mlock);
> >  }
> >  EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index d0ce3b71106a..11c42170fda1 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -9,6 +9,7 @@
> >
> >  #include <linux/device.h>
> >  #include <linux/cdev.h>
> > +#include <linux/cleanup.h>
> >  #include <linux/slab.h>
> >  #include <linux/iio/types.h>
> >  /* IIO TODO LIST */
> > @@ -644,6 +645,30 @@ int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
> >  int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
> >  int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
> >  void iio_device_release_direct_mode(struct iio_dev *indio_dev);
> > +/*
> > + * Auto cleanup version of iio_device_claim_direct_mode,
> > + *
> > + *     CLASS(iio_claim_direct, claimed_dev)(indio_dev);
> > + *     if (IS_ERR(claimed_dev))
> > + *             return PTR_ERR(claimed_dev);
> > + *
> > + *     st = iio_priv(claimed_dev);
> > + *     ....
> > + */
> > +DEFINE_CLASS(iio_claim_direct, struct iio_dev *,
> > +            iio_device_release_direct_mode(_T),
> > +            ({
> > +                       struct iio_dev *dev;
> > +                       int d = iio_device_claim_direct_mode(_T);
> > +
> > +                       if (d < 0)
> > +                               dev = ERR_PTR(d);
> > +                       else
> > +                               dev = _T;
> > +                       dev;
> > +            }),
> > +            struct iio_dev *_T);
> > +
> >  int iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
> >  void iio_device_release_buffer_mode(struct iio_dev *indio_dev);
> >
> > --
> > 2.42.0
> >  
> 
> What is the benefit of exposing `claimed_dev` rather than just the int
> return value? It seems like it just makes more noise in the error
> check.
> 
> Also, this seems like this is a pattern that could be generalized and
> put in cleanup.h. For example, this pattern could be used with
> mutex_trylock as well.
> 
> Basically we could create a variation of the current `guard` like:
> 
> #define DEFINE_CHECKED_GUARD(_name, _type, _lock, _unlock) ...
> #define checked_guard(_name) ...
> 
> To be used like:
> 
> /* linux/mutex.h */
> #define DEFINE_CHECKED_GUARD(mutex, struct mutex *, \
>     mutex_trylock(_T), mutex_unlock(_T))

My head hurt whilst digging through what the macros did, but
I don't think this can work this simply because we need to instantiate
a local variable that is then used for the cleanup.

When you call
guard(mutex)(&lock);

Expanding to
CLASS(mutex, __UNIQUE_ID(guard))(&lock)
to
class_mutex_t var __cleanup(class_mutex_destuctor) = class_mutex_constructor(&lock);

where
DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
to
DEFINE_CLASS(mutex, struct mutex *, mutex_unlock, ({mutex_lock(_T), T;}), struct mutex *_T;
to 
typedef struct mutex * class_mutex_t;
...

Key being that it relies on the lock path returning the variable that you use as the
input for the cleanup.

If we return an int, we can't do that.

Unless I'm missing some magic that would make it work!

> 
> /* any/driver.c */
> if (!checked_guard(mutex)(&thing->lock))
>     return -EBUSY
> 
> /* linux/iio/iio.h */
> #define DEFINE_CHECKED_GUARD(iio_claim_direct, struct iio_dev *indio_dev *, \
>     iio_device_claim_direct_mode(_T), iio_device_release_direct_mode(_T))
> 
> /* iio/driver.c */
> if (!checked_guard(iio_claim_direct)(indio_dev))
>     return -EBUSY
> 

