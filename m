Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E56C370DA7
	for <lists+linux-iio@lfdr.de>; Sun,  2 May 2021 17:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhEBPh1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 May 2021 11:37:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230110AbhEBPh1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 May 2021 11:37:27 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C94661175;
        Sun,  2 May 2021 15:36:34 +0000 (UTC)
Date:   Sun, 2 May 2021 16:37:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH 1/4] iio: core: Introduce
 iio_push_to_buffers_with_ts_na() for non aligned case.
Message-ID: <20210502163724.0a943f6e@jic23-huawei>
In-Reply-To: <CAHp75VdNiEGLC44AycNTJ7_oaibtshJHaFFcq+UKBJ3XtAcp+w@mail.gmail.com>
References: <20210501172515.513486-1-jic23@kernel.org>
        <20210501172515.513486-2-jic23@kernel.org>
        <CAHp75VdRTh6Pzj8yy6sDQqfhfAJj1nGZ79UmzBckNR4b1h5sog@mail.gmail.com>
        <CAHp75VdNiEGLC44AycNTJ7_oaibtshJHaFFcq+UKBJ3XtAcp+w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 1 May 2021 22:27:22 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, May 1, 2021 at 10:25 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, May 1, 2021 at 8:28 PM Jonathan Cameron <jic23@kernel.org> wrote:  
> 
> ...
> 
> > > +               iio_dev_opaque->bounce_buffer =
> > > +                       devm_krealloc(&indio_dev->dev,
> > > +                                     iio_dev_opaque->bounce_buffer,  
> >
> > Oh la la, foo = realloc(foo, ...) is 101 type of mistakes.
> > Please, don't do this.
> >  
> > > +                                     indio_dev->scan_bytes, GFP_KERNEL);
> > > +               if (!iio_dev_opaque)  
> 
> And this check...
Yup. Thoroughly broken.  Hohum, but basic idea conveyed however bad the rfc was :(


> 
> > > +                       return -ENOMEM;
> > > +       }  
> 

