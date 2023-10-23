Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1497D2EED
	for <lists+linux-iio@lfdr.de>; Mon, 23 Oct 2023 11:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjJWJxa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 23 Oct 2023 05:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjJWJx3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Oct 2023 05:53:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EF2C4
        for <linux-iio@vger.kernel.org>; Mon, 23 Oct 2023 02:53:27 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SDVlx4jJ2z6J9dh;
        Mon, 23 Oct 2023 17:49:49 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 23 Oct
 2023 10:53:24 +0100
Date:   Mon, 23 Oct 2023 10:53:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        "Jagath Jog J" <jagathjog1996@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        "Daniel Campello" <campello@chromium.org>,
        <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 1/8] iio: locking: introduce __cleanup() based
 direct mode claiming infrastructure
Message-ID: <20231023105323.00000370@Huawei.com>
In-Reply-To: <462c181eab1c0b70c0350099b7f70aaf736aabe1.camel@gmail.com>
References: <20231022154710.402590-1-jic23@kernel.org>
        <20231022154710.402590-2-jic23@kernel.org>
        <CAMknhBEEPC-JArFJvpHw0YAmdA+BrAQzkxU5vNvCwxf5OdHKrw@mail.gmail.com>
        <462c181eab1c0b70c0350099b7f70aaf736aabe1.camel@gmail.com>
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

On Mon, 23 Oct 2023 10:55:56 +0200
Nuno Sá <noname.nuno@gmail.com> wrote:

> On Sun, 2023-10-22 at 16:10 -0500, David Lechner wrote:
> > On Sun, Oct 22, 2023 at 10:47 AM Jonathan Cameron <jic23@kernel.org> wrote:  
> > > 
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > Allows use of:
> > > 
> > >         CLASS(iio_claim_direct, claimed_dev)(indio_dev);
> > >         if (IS_ERR(claimed_dev))
> > >                 return PTR_ERR(claimed_dev);
> > > 
> > >         st = iio_priv(claimed_dev);
> > > 
> > > to automatically call iio_device_release_direct_mode() based on scope.
> > > Typically seen in combination with local device specific locks which
> > > are already have automated cleanup options via guard(mutex)(&st->lock)
> > > and scoped_guard().  Using both together allows most error handling to
> > > be automated.
> > > 
> > > Note that whilst this pattern results in a struct iio_dev *claimed_dev
> > > that can be used, it is not necessary to do so as long as that pointer
> > > has been checked for errors as in the example.
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  drivers/iio/industrialio-core.c |  4 ++++
> > >  include/linux/iio/iio.h         | 25 +++++++++++++++++++++++++
> > >  2 files changed, 29 insertions(+)
> > > 
> > > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-
> > > core.c
> > > index c77745b594bd..93bfad105eb5 100644
> > > --- a/drivers/iio/industrialio-core.c
> > > +++ b/drivers/iio/industrialio-core.c
> > > @@ -2065,6 +2065,10 @@ EXPORT_SYMBOL_GPL(iio_device_claim_direct_mode);
> > >   */
> > >  void iio_device_release_direct_mode(struct iio_dev *indio_dev)
> > >  {
> > > +       /* Auto cleanup can result in this being called with an ERR_PTR */
> > > +       if (IS_ERR(indio_dev))
> > > +               return;
> > > +
> > >         mutex_unlock(&to_iio_dev_opaque(indio_dev)->mlock);
> > >  }
> > >  EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
> > > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > > index d0ce3b71106a..11c42170fda1 100644
> > > --- a/include/linux/iio/iio.h
> > > +++ b/include/linux/iio/iio.h
> > > @@ -9,6 +9,7 @@
> > > 
> > >  #include <linux/device.h>
> > >  #include <linux/cdev.h>
> > > +#include <linux/cleanup.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/iio/types.h>
> > >  /* IIO TODO LIST */
> > > @@ -644,6 +645,30 @@ int __devm_iio_device_register(struct device *dev,
> > > struct iio_dev *indio_dev,
> > >  int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
> > >  int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
> > >  void iio_device_release_direct_mode(struct iio_dev *indio_dev);
> > > +/*
> > > + * Auto cleanup version of iio_device_claim_direct_mode,
> > > + *
> > > + *     CLASS(iio_claim_direct, claimed_dev)(indio_dev);
> > > + *     if (IS_ERR(claimed_dev))
> > > + *             return PTR_ERR(claimed_dev);
> > > + *
> > > + *     st = iio_priv(claimed_dev);
> > > + *     ....
> > > + */
> > > +DEFINE_CLASS(iio_claim_direct, struct iio_dev *,
> > > +            iio_device_release_direct_mode(_T),
> > > +            ({
> > > +                       struct iio_dev *dev;
> > > +                       int d = iio_device_claim_direct_mode(_T);
> > > +
> > > +                       if (d < 0)
> > > +                               dev = ERR_PTR(d);
> > > +                       else
> > > +                               dev = _T;
> > > +                       dev;
> > > +            }),
> > > +            struct iio_dev *_T);
> > > +
> > >  int iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
> > >  void iio_device_release_buffer_mode(struct iio_dev *indio_dev);
> > > 
> > > --
> > > 2.42.0
> > >   
> > 
> > What is the benefit of exposing `claimed_dev` rather than just the int
> > return value? It seems like it just makes more noise in the error
> > check.
> >   
> 
> I don't really have a very strong opinion on this but what I really don't like
> much is the pattern:
> 
> CLASS(type, ret), where the return value is an argument of the macro... It would
> be nice if we could just make it like:
> 
> ret = guard(type)(...); //or any other variation of the guard() macro
> if (ret) 
> 	return ret;
> 
> the above could also be an error pointer or even have one variation of each. but
> yeah, that likely means changing the cleanup.h file and that might be out of
> scope for Jonathan's patch series. 
> 

I fully agree it's ugly and a little unintuitive but I don't see a way an "lvalue"
can work work cleanly (due to magic types under the hood) and I suspect we will
have to get used to this pattern.

There are lots of other examples in kernel that are similar DECLARE_BITMAP() etc
and we've kind of gotten used to those...

Jonathan


> - Nuno Sá
> 
> 

