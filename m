Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8A22477D6
	for <lists+linux-iio@lfdr.de>; Mon, 17 Aug 2020 22:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgHQUCU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Aug 2020 16:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbgHQUCR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2020 16:02:17 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6802BC061389
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2020 13:02:17 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id j9so15597202ilc.11
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2020 13:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=42EHKaiZokDYEpY04AQEHHdjVaoqLPYqnG7cOPFCkVo=;
        b=UHRcBPsnuwQhn3lAwxUnaMePKdIl5grFxltDU8PhTR6WLHfWFDbi2EKC+nzAhXFKsk
         Kj26U6KLk9VROr9Zvg9QT+0ePSN5fZsV5DJBIov3SJk+OVUohgcEBBDoYt/AdOFb3VId
         ntKhlpjtfnSoZfherw1s1yh05Ozxy1lNa20PIXZN4EYEu7T8EEsf4PWtydabRxXHX8fx
         lqd/l6hGDUi/rFf9nKBX1AKe0Vo3ohnAoa2gM4PZ/3byBobTwWlN+6PmI9PFlph0wyDG
         BoG6ayyGj/c0QIyGXj91qlxT7SaGZrldW0BhTH39V4+UPxdEJMrqCbBFSFf0+VUc9MHf
         OTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=42EHKaiZokDYEpY04AQEHHdjVaoqLPYqnG7cOPFCkVo=;
        b=Qvydc/uH0tP6EgFnZ8+723Kd05opkPFGiEclsN/NcPQa85CBmtIY0kWCo6AgDzz4j8
         4tvY3RnoNHLMISuDreQsrvn1jJK8xjtHOTr2ND+T3UcYgGjKrZedGLIzIaem4Mvy5XpF
         CFgZsoGMYNa+skWHIF3DgVupd0Tca5pu0ByQs8fQIa7wAZaBh4HQGWXISYjvzap7qDoh
         TenaXFXGEdwYiyDdQjYrPJ9Jl+LRsY0HA5E0mVGWUB/5Gbvx5XGlmlNv5CiFAklkK2Vv
         rgFJ3mRAtwxTdS5YKHJb1xtK2MJIrww9Wk4d15iYr2XYEw8eoF2SRTiH0urWOetgitHk
         vRXw==
X-Gm-Message-State: AOAM532MOEVIZjUbSxJxO97AJElCcmscAUoUrAXgEZBkSK1AfaGGLTMV
        NhLRphUV0ieTGP6zCH/Eksv3NpJmpg6/WwgUf8n6uQ==
X-Google-Smtp-Source: ABdhPJz7+/cSad+TqEVktg+PR5xxDaQJGXqAXQEodbtGBY1kqiUkr3yUdwTHkmeHwjQMPc5WO3+3DORBrxf8XAicLVM=
X-Received: by 2002:a92:a157:: with SMTP id v84mr14515417ili.189.1597694536738;
 Mon, 17 Aug 2020 13:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200817170535.17041-1-brgl@bgdev.pl> <20200817170535.17041-2-brgl@bgdev.pl>
 <20200817173908.GS1891694@smile.fi.intel.com>
In-Reply-To: <20200817173908.GS1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 17 Aug 2020 22:02:05 +0200
Message-ID: <CAMRc=MdaaWhV_ZKHgWy_Gxkp=jMuZcwqpoE8Ya_84n9ZT5O31A@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] devres: provide devm_krealloc()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 17, 2020 at 7:43 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Aug 17, 2020 at 07:05:33PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Implement the managed variant of krealloc(). This function works with
> > all memory allocated by devm_kmalloc() (or devres functions using it
> > implicitly like devm_kmemdup(), devm_kstrdup() etc.).
> >
> > Managed realloc'ed chunks can be manually released with devm_kfree().
>
> Thanks for an update! My comments / questions below.
>
> ...
>
> > +static struct devres *to_devres(void *data)
> > +{
> > +     return (struct devres *)((u8 *)data - ALIGN(sizeof(struct devres),
> > +                                                 ARCH_KMALLOC_MINALIGN));
>
> Do you really need both explicit castings?
>

Yeah, we can probably drop the (struct devres *) here.

> > +}
>
> ...
>
> > +     total_old_size = ksize(to_devres(ptr));
>
> But how you can guarantee this pointer:
>  - belongs to devres,

We can only check if a chunk is dynamically allocated with ksize() -
it will return 0 if it isn't and I'll add a check for that in the next
iteration. We check whether it's a managed chunk later after taking
the lock.

>  - hasn't gone while you run a ksize()?
>

At some point you need to draw a line. In the end: how do you
guarantee a devres buffer hasn't been freed when you're using it? In
my comment to the previous version of this patch I clarified that we
need to protect all modifications of the devres linked list - we must
not realloc a chunk that contains the links without taking the
spinlock but also we must not call alloc() funcs with GFP_KERNEL with
spinlock taken. The issue we could run into is: someone modifies the
linked list by adding/removing other managed resources, not modifying
this one.

The way this function works now guarantees it but other than that:
it's up to the users to not free memory they're actively using.

> ...
>
> > +     new_dr = alloc_dr(devm_kmalloc_release,
> > +                       total_new_size, gfp, dev_to_node(dev));
>
> Can you move some parameters to the previous line?
>

Why though? It's fine this way.

> > +     if (!new_dr)
> > +             return NULL;
>
> ...
>
> > +     spin_lock_irqsave(&dev->devres_lock, flags);
> > +
> > +     old_dr = find_dr(dev, devm_kmalloc_release, devm_kmalloc_match, ptr);
> > +     if (!old_dr) {
> > +             spin_unlock_irqrestore(&dev->devres_lock, flags);
> > +             devres_free(new_dr);
> > +             WARN(1, "Memory chunk not managed or managed by a different device.");
> > +             return NULL;
> > +     }
> > +
> > +     replace_dr(dev, &old_dr->node, &new_dr->node);
> > +
> > +     spin_unlock_irqrestore(&dev->devres_lock, flags);
> > +
> > +     memcpy(new_dr->data, old_dr->data, devres_data_size(total_old_size));
>
> But new_dr may concurrently gone at this point, no? It means memcpy() should be
> under spin lock.
>

Just as I explained above: we're protecting the linked list, not the
resource itself.

Bartosz
