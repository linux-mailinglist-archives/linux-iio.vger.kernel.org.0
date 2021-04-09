Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AEA359A22
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 11:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbhDIJ4U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 05:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbhDIJzw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 05:55:52 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A990FC0613DA
        for <linux-iio@vger.kernel.org>; Fri,  9 Apr 2021 02:55:38 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id q5so3877898pfh.10
        for <linux-iio@vger.kernel.org>; Fri, 09 Apr 2021 02:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7eD+elrYRDLpQrW74rbdw9/C9GZrRnF7A8PFe13iiCU=;
        b=mFaW6qyQOJn/r3hkRUQIuE5Wax8yjbgo+WU3lqTiuzqQFf0oFAXj+YSiJRTurdbrQG
         FulYMNTAVhZZVywuO6caQIizr9rVzKRuiZ5MifFmFJC4mPaqHHR4z4AFLZqWbYrWWpvT
         fC1jf7bq+/abnwxL3x7yFtsKGg/1dkL0hLNgmPxXQuIb9viY535kWUAnzefka3EEB7hk
         cZvXkiBGlrU2t9KRy6cDbnMUS3w4jN0QCtdFoy5kc6dTgFUak4N7TW6N9wzjnLbeCJ7n
         TmZduxoaVhnJctlcao/Qb0kxIxur/PRJCaWJTQO/leDJTZhG1m6J3LYR/aXpsrBmxNdf
         ROlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7eD+elrYRDLpQrW74rbdw9/C9GZrRnF7A8PFe13iiCU=;
        b=JPUtM/Shl+VsQe+x4N+g8VgBwJRO4vcy7u2SzylzHuZXn6rQvZCgy4c+DddcNkedHh
         ezBOUHoeaF8kooLLwGuuCFQb1HADkjLYFkzAHyWPJ3DGRJL3KlKql/xlQ/tUwHiNy7bC
         GEczXjy1TECWNxHcW3xB6+Xb3lJT9HCfy9Aj5QxvjRL7R+iAQpM2Xz6YBhsAhuICzDTv
         DkQoKGlYrzDBGUhK9e1ggIpRhy8Ih4ZoP1cGs7Sa/w5cHqUol2n3k9px+RmW5WRFFV3I
         LZC88rG7+LM2N94+r0mzAwHW1Uuze6ErfwiPHUPKoza9XQZr7T5CkZCJPwsve8Xc+ZhJ
         4Sfg==
X-Gm-Message-State: AOAM533aYg5emiy9DAVEP3nJ+h03o0oeFA01iA7MAZgQf2x/+IZU0YjV
        Yz02L8Ev1Nxv+u5Dj8mp56ZIkasMWTaqP7gqm3TGOKnaIwudtMkG
X-Google-Smtp-Source: ABdhPJwPzsUS+G2Csjx/TijELdgvd5XRhPacwlZ+7wJG3pcaxxXhOv2IsuUL4zi+pdZDA8Sj4o1saD3/Zkta3F3LKck=
X-Received: by 2002:a63:c48:: with SMTP id 8mr12287783pgm.74.1617962138214;
 Fri, 09 Apr 2021 02:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
 <1617881896-3164-6-git-send-email-yangyicong@hisilicon.com>
 <CA+U=DspZCGVjFxB0YH7OAPBKhFAKz=a9Q=O7xW-Xu4BPZKC=pA@mail.gmail.com>
 <9f1257a2-a69e-acbc-8c0a-2d2157274225@hisilicon.com> <CAHp75Ve_JwGeruZeZnVk3pXXmETVERQTdR2+MSPX=Y75+nQLcw@mail.gmail.com>
 <94bbe851-1f09-7099-38ac-2b6fcb056349@hisilicon.com>
In-Reply-To: <94bbe851-1f09-7099-38ac-2b6fcb056349@hisilicon.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 9 Apr 2021 12:55:22 +0300
Message-ID: <CAHp75Ve7+-_=nsUjn5e3tR-37Fg622_PSPyR5CrgUWGxk6zPKA@mail.gmail.com>
Subject: Re: [PATCH 5/7] iio: core: simplify some devm functions
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        prime.zeng@huawei.com, Tian Tao <tiantao6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 9, 2021 at 12:42 PM Yicong Yang <yangyicong@hisilicon.com> wrote:
> On 2021/4/9 17:19, Andy Shevchenko wrote:
> > On Fri, Apr 9, 2021 at 10:22 AM Yicong Yang <yangyicong@hisilicon.com> wrote:
> >> On 2021/4/8 21:09, Alexandru Ardelean wrote:
> >>> On Thu, Apr 8, 2021 at 2:41 PM Yicong Yang <yangyicong@hisilicon.com> wrote:

...

> > Actually Alexandru has a good point. Compare the pieces I left above.
> >
>
> a little different from my perspective when I did this.
>
> previously:
>
> -       ptr = devres_alloc(devm_iio_device_release, sizeof(*ptr),
> -                          GFP_KERNEL);
> -       if (!ptr)
> -               return NULL;
>
> if devres_alloc() failure we return NULL.
>
>
>         iio_dev = iio_device_alloc(parent, sizeof_priv);
> -       if (iio_dev) {
> -               *ptr = iio_dev;
> -               devres_add(parent, ptr);
> -       } else {
> -               devres_free(ptr);
> -       }
>
>         return iio_dev;
>
> if iio_device_alloc() failed, we return what it returns.
>
> now we remove devres_alloc() and stay iio_device_alloc(), so I just
> keep to return iio_dev.
>
> but actually iio_device_alloc() will return NULL at failure. :)
> so return NULL here is definitely correct. i'll change to that if
> it's recommended.

Confusing here (in your case) is that:

if (!FOO)
 return BAR;

...

return BAR;

I.e. twice returning BAR for different occasions. This makes
additional cognitive work and decrease readability / maintainability
of the code.

I.o.w., yes, it's preferred.

-- 
With Best Regards,
Andy Shevchenko
