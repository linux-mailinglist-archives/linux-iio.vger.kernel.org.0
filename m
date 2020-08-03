Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7047123AD13
	for <lists+linux-iio@lfdr.de>; Mon,  3 Aug 2020 21:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgHCTb7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 15:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbgHCTbz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 15:31:55 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB59CC061756
        for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2020 12:31:54 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id 6so29169362qtt.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2020 12:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RvzegeXfDF+FVdvZWpUY2C/JYcGtzK0e5Km4cAoPNN8=;
        b=jSmTnJX12hJqDm4wSS6o7mGjoyl/+MvIhk0XVP7uEzSk09YcYc0nfbe7zl7aGuS6wC
         SZGNqDDIANha72buny9X6caEYisJ0XYhId0is+ZwGaTqeHILDvgTJPVKJvBN+9ZYXvZP
         0/nufiyHW+XAHqa5hL6CByacEB0uNBoHAuc4Kis0WamHtXH5CUsWqOiezhW9OIyk69+N
         oPiQemIU1078XmA59msE3KdOqcmq1SdKyAOJGFHHKvknx5m21uk7o6pQX+nWrZAsH1Oj
         YYTBVnF2EOEmJM9paMatW2pjQOsHClWl2IDuqTaFsRERReRg3AsBTwZj2m1vAcJQ5fLE
         ctSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RvzegeXfDF+FVdvZWpUY2C/JYcGtzK0e5Km4cAoPNN8=;
        b=DyyurwCpVV18chq9R9/0QMocdTyEdZEJ61+XYtDmrIdUi0MCTMPCWxM3lmoAeIjrRP
         ppt6K57zsE4AAfo/dSAv6c0ktso1rJkY2Y/qe9NBGfewrLdW/s2n6tAuxiQ3iSmkXom5
         2KF66Cfmaz0D96e02s18UbxU8B6CpfQ9rA+H5wPuuhHVJUi8ghBq1EUr4bXN2iMdrjJD
         UUlJ+6gf19ul67i5ay1aLGnn+es97Ht2NRZZcDLL4IkWrZBprtgHNjGSHzH4qAdK7D7R
         tF/65fgXWYiHbFIvjMm7PPsWcG1brHyi4rYPFS4KW2HXthYP97twWRSvK6mOVq3hJmqC
         wNJA==
X-Gm-Message-State: AOAM533Lt3ZUqeOX2rHlGNPfbkiuCF9fAXFsx9XC5ollIKaw6azqaJho
        viWmnq3SxUDQJS+yvGWEgX8Gtw3kN2Uj6N+z5cgvWA==
X-Google-Smtp-Source: ABdhPJyAJVak0FjVUTJi1mcLTSkaBZWjBpWRxzk7IIBX2OckQU/gStJWBE/N9Odcq/m1cUmnKTfpgZfhgTWyUcthDaU=
X-Received: by 2002:ac8:72cc:: with SMTP id o12mr17678716qtp.27.1596483113936;
 Mon, 03 Aug 2020 12:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200802083458.24323-1-brgl@bgdev.pl> <20200802083458.24323-2-brgl@bgdev.pl>
 <CAHp75Vfm_vUKZOGkNp+0uTe0b=vk8yDyjs7XPdw_1GRauTBx4g@mail.gmail.com>
In-Reply-To: <CAHp75Vfm_vUKZOGkNp+0uTe0b=vk8yDyjs7XPdw_1GRauTBx4g@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 3 Aug 2020 21:31:42 +0200
Message-ID: <CAMpxmJXvJRekVAbSAi7XTjmM33dN1bSDWPLjfufhwTk7KQMMDA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] devres: provide devm_krealloc()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 2, 2020 at 12:42 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>

[snip]

>
> I was thinking about this bit... Shouldn't we rather issue a simple
> dev_warn() and return the existing pointer?
> For example in some cases we might want to have resources coming
> either from heap or from constant. Then, if at some circumstances we
> would like to extend that memory (only for non-constant cases) we
> would need to manage this ourselves. Otherwise we may simply call
> krealloc().
> It seems that devm_kstrdup_const returns an initial pointer. Getting
> NULL is kinda inconvenient (and actually dev_warn() might also be
> quite a noise, however I would give a message to the user, because
> it's something worth checking).
>

But this is inconsistent behavior: if you pass a pointer to ro memory
to devm_krealloc() it will not resize it but by returning a valid
pointer it will make you think it did -> you end up writing to ro
memory in good faith.

> ...
>
> > +       spin_lock_irqsave(&dev->devres_lock, flags);
> > +       old_dr = find_dr(dev, devm_kmalloc_release, devm_kmalloc_match, ptr);
> > +       spin_unlock_irqrestore(&dev->devres_lock, flags);
>
> > +       if (!old_dr) {
>
> I would have this under spin lock b/c of below.
>
> > +               WARN(1, "Memory chunk not managed or managed by a different device.");
> > +               return NULL;
> > +       }
>
> > +       old_head = old_dr->node.entry;
>
> This would be still better to be under spin lock.
>
> > +       new_dr = krealloc(old_dr, total_size, gfp);
> > +       if (!new_dr)
> > +               return NULL;
>
> And perhaps spin lock taken already here.
>
> > +       if (new_dr != old_dr) {
> > +               spin_lock_irqsave(&dev->devres_lock, flags);
> > +               list_replace(&old_head, &new_dr->node.entry);
> > +               spin_unlock_irqrestore(&dev->devres_lock, flags);
> > +       }
>
> Yes, I understand that covering more code under spin lock does not fix
> any potential race, but at least it minimizes scope of the code that
> is not under it to see exactly what is problematic.
>
> I probably will think more about a better approach to avoid potential races.

My thinking behind this was this: we already have users who call
devres_find() and do something with the retrieved resources without
holding the devres_lock - so it's assumed that users are sane enough
to not be getting in each other's way. Now I see that the difference
is that here we're accessing the list node and it can change if
another thread is adding a different devres to the same device. So
this should definitely be protected somehow.

I think that we may have to give up using real krealloc() and instead
just reimplement its behavior in the following way:

Still outside of spinlock check if the new total size is smaller or
equal to the previous one. If so: return the same pointer. If not:
allocate a new devres as if it were for devm_kmalloc() but don't add
it to the list yet. Take the spinlock - check if we can find the
devres - if not: kfree() the new and old chunk and return NULL. If
yes: copy the contents of the devres node into the new chunk as well
as the memory contents. Replace the old one on the list and free it.
Release spinlock and return.

Does that work?

Bart
