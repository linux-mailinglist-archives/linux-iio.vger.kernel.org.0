Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA4321C808
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jul 2020 10:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgGLITX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jul 2020 04:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgGLITW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Jul 2020 04:19:22 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755D2C061794
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2020 01:19:22 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id h17so4519196qvr.0
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2020 01:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MGwINlQgCbK7cpwpxpZe+If/M4ESfvkJJhKVPhatAlU=;
        b=jZXCOE48SXImaeZdlJiq4vPp0Rp3n7iSLnYs+sdbkaNBou3U17dn5vlwZ8cvUHR0/s
         fLI8lSGZrhVZK3dsCRSbv3oXaP7hBuws+Kj9p9D7RIWdxPSUlq//EPxVL3ZX1QjrLNuu
         q4CYd7YKR3uWPPIO4Jb/tIbAhOx1Kog1KQpF+Z/ETHW93Cz58nDZTHT41AoSh+GC8RiR
         wE+7pp9e/FP+dguSLrnmQgox2i8nVaRFWRn7ZF3G8B3QsHyIA5grkVOM38SmfIewJEjI
         ++md5hYIkU2X/Yi9dE76+q97eM8lj11obz63zYW/HhAgEvo5MatZsyfZdClmcRu8V1I3
         bVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MGwINlQgCbK7cpwpxpZe+If/M4ESfvkJJhKVPhatAlU=;
        b=eERp0NN1yjG0bBqMenaxazD+7SpxZlsDsUTymYq6eskScvvFotiM0ZKa8a+Zm9GdQ3
         ZS7gEkgbZjq4YVNWw5QQfVuF75jxhzNtyWZJKgcLl9eSeUj8FZwH8rIqGw3IUvyL2mup
         v2NUtqjkKCZNDOBgWTYjeix7mJrFlMU2Klg/ZHBok05fiYZ+8WclXxdF9C/sOBU5Adj1
         zDt708tXfejiXKnprDZwz0vEJjus0X5yeZ721hW/b5SFSQ4zLY2wzBcNLyh/eO88soUL
         KSZZNbVfwTVnvJZcI7Oy7nwvnELzhQlOWDqybLqPsN8npFPy3qcbVM0X14vY3Md61tBD
         GrBw==
X-Gm-Message-State: AOAM530wMFuqys0WmYlb//2t+O+sDuGiirG6nTBxuRSzWk05hX9K+UKv
        zAqDuZrFw+DbQtn77NnOaITwRFMfnkReYwHjErvumQ==
X-Google-Smtp-Source: ABdhPJxM7LrCDPZHbZbYu7ZdLOZATVDRxxTkWJh3awmIgacDx3Z/aXaXBBOIzRdcK0OahzmkNa2s8fQkmm7zDgeD4B4=
X-Received: by 2002:ad4:4e07:: with SMTP id dl7mr73637317qvb.134.1594541960625;
 Sun, 12 Jul 2020 01:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200710161516.11625-1-brgl@bgdev.pl> <20200710161516.11625-2-brgl@bgdev.pl>
 <CAHp75VfTDmyWWxAAky-CmuvO2ge0T1q+woJ8MxjdRQqNJwHS4w@mail.gmail.com>
In-Reply-To: <CAHp75VfTDmyWWxAAky-CmuvO2ge0T1q+woJ8MxjdRQqNJwHS4w@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Sun, 12 Jul 2020 10:19:09 +0200
Message-ID: <CAMpxmJXjhzYr5djfn5K9yxCOohtB76bbgY+Sh1ZLNzF7c0Gzmg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] devres: provide devm_krealloc()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jul 11, 2020 at 5:08 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Jul 10, 2020 at 7:17 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Implement the managed variant of krealloc(). This function works with
> > all memory allocated by devm_kmalloc() (or devres functions using it
> > implicitly like devm_kmemdup(), devm_kstrdup() etc.).
> >
> > Managed realloc'ed chunks can be manually released with devm_kfree().
>
> ...
>
> >    devm_kfree()
> >    devm_kmalloc()
> >    devm_kmalloc_array()
> > +  devm_krealloc()
> >    devm_kmemdup()
> >    devm_kstrdup()
> >    devm_kvasprintf()
>
> Order?
>

I didn't notice these were ordered alphabetically, I thought it was by
functionality.

> ...
>
> > +void *devm_krealloc(struct device *dev, void *ptr, size_t new_size, gfp_t gfp)
>
> Do we really need the 'new_' prefix in the parameter?
>

Yes, I think this is a good name for a function that's meant to modify
the size of a memory chunk.

> > +{
> > +       struct devres *old_dr, *new_dr;
> > +       struct list_head old_head;
> > +       unsigned long flags;
> > +       void *ret = NULL;
> > +       size_t tot_size;
>
> tot -> total.
>

Meh, ok.

> > +
> > +       if (unlikely(!new_size)) {
> > +               devm_kfree(dev, ptr);
> > +               return ZERO_SIZE_PTR;
> > +       }
>
> I guess here we need a comment of the possibilities below to have
> ZERO_SIZE_PTR as input.
>

Better yet: I'll just add a kernel doc for this function.

> > +       if (unlikely(ZERO_OR_NULL_PTR(ptr)))
> > +               return devm_kmalloc(dev, new_size, gfp);
> > +
> > +       if (WARN_ON(is_kernel_rodata((unsigned long)ptr)))
> > +               /*
> > +                * We cannot reliably realloc a const string returned by
> > +                * devm_kstrdup_const().
> > +                */
> > +               return NULL;
> > +
> > +       if (!check_dr_size(new_size, &tot_size))
> > +               return NULL;
> > +
> > +       spin_lock_irqsave(&dev->devres_lock, flags);
> > +
> > +       old_dr = find_dr(dev, devm_kmalloc_release, devm_kmalloc_match, ptr);
>
> > +       if (WARN_ON(!old_dr))
>
> Under spin lock? I would rather see spin unlock followed by WARN.
>

Yeah, can be done.

> > +               /* Memory chunk not managed or managed by a different device. */
> > +               goto out;
> > +
> > +       old_head = old_dr->node.entry;
> > +
> > +       new_dr = krealloc(old_dr, tot_size, gfp);
> > +       if (!new_dr)
> > +               goto out;
> > +
> > +       if (new_dr != old_dr)
> > +               list_replace(&old_head, &new_dr->node.entry);
> > +
> > +       ret = new_dr->data;
> > +
> > +out:
> > +       spin_unlock_irqrestore(&dev->devres_lock, flags);
> > +       return ret;
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko

Bartosz
