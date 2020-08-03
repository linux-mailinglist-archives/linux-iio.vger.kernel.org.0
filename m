Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDB323AA91
	for <lists+linux-iio@lfdr.de>; Mon,  3 Aug 2020 18:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgHCQfI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 12:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgHCQfI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 12:35:08 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B284C06174A;
        Mon,  3 Aug 2020 09:35:08 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id z5so20172503pgb.6;
        Mon, 03 Aug 2020 09:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aRy5XNlke5IVnZt6sTMSjwcVBGjttryTgAPuHqOx9j4=;
        b=kn6i3PXUFUQH/VqSaREbKFj2TJx+e0PLygDMv6IaDSVQfrXGBMhv6TUWQHxLltsG3B
         wDsOB9pM3Ap+XeBiV5JNbVFAbYOFZsgRMm7hiMxiBEu6Ni5r2bhbZhSjCWqSyGdIYdYF
         Q9XugV1ayVllr2VDlYiEqUlNqSFZQi2MSvBxf2ANCfQq36gF0LEm7oMKzv01arOnFSuX
         dTDdYUSA5X6s4l5v8trsyS9X8PGnjTAhzXB6OhsPalc6x7rCImzB56apFixz4UYpkexH
         /GUp3uQFriJRmfWZL9VzwXBTYTHQWn2qJhQzWPv1O0Ks4epx/gTLmlSjIrvHkUWIiY7t
         LVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aRy5XNlke5IVnZt6sTMSjwcVBGjttryTgAPuHqOx9j4=;
        b=Ig1haYh2eQRvqgiKwU4yBfZ/pFs3SlEnBuAHeWKE9ZeTcqOUCSxJ8H5VSjuBU1dzdp
         JHdtY0tvijywjWDz5bOLrQNH7oxR+Hut23Ml618pivVXykp0vjj95y0tD0EEHaYmsUTl
         m/JSas1q47Kwpi0X9JcU1W78na9zX1pANygroHHuYbcn/rStWsmlFUxC34oBMJhx198a
         zKUqs6LySHX0S+/BJ+KEIioD37pNquyMNpmUo+8segUNyb8jAa2rXEGIkzu9EmJJc2U5
         5Na+7D4CYD4lt9iGatjox4j01z3QW9GJM+2B2+dHih1nlW6Vv927dzh+HQy+F1hWLLIt
         FcCw==
X-Gm-Message-State: AOAM530Z8+mcCwHH1fEDwVgeZfuNQp3cEWsQRTIzO6fIv6nj5u9PMMyZ
        6GNa+zc3J/KDs6u9srdV3lNIBv8tQvENwcZTTZA=
X-Google-Smtp-Source: ABdhPJwc9GDQjb7z3XXCuqPV0Ya3NQgR6ya/khg6+JqrFseMeGZR5amQZ4DYFdMSFN7YS7kiQVlVnn75BsXQ7Y5XWiw=
X-Received: by 2002:a62:758f:: with SMTP id q137mr15998175pfc.170.1596472507773;
 Mon, 03 Aug 2020 09:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200803151656.332559-1-cmo@melexis.com>
In-Reply-To: <20200803151656.332559-1-cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Aug 2020 19:34:52 +0300
Message-ID: <CAHp75VfmSfmezqwwRfHZ797Y9rYDu3hgL5vGvPwbzGjCXsKWcQ@mail.gmail.com>
Subject: Re: [PATCH] iio:temperature:mlx90632: Reduce number of equal calulcations
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 3, 2020 at 6:17 PM Crt Mori <cmo@melexis.com> wrote:
>
> TAdut4 was calculated each iteration although it did not change. In light
> of near future additions of the Extended range DSP calculations, this
> function refactoring will help reduce unrelated changes in that series as
> well as reduce the number of new functions needed.

Okay!

> Also converted shifts in this function of signed integers to divisions as
> that is less implementation-defined behavior.

This is what I'm wondering about. Why?

...

> -       Ha_customer = ((s64)Ha * 1000000LL) >> 14ULL;
> -       Hb_customer = ((s64)Hb * 100) >> 10ULL;
> +       Ha_customer = div64_s64((s64)Ha * 1000000LL, 16384);
> +       Hb_customer = div64_s64((s64)Hb * 100, 1024);

Have you checked the code on 32-bit machines?
As far as I can see the div64_*64() do not have power of two divisor
optimizations. I bet it will generate a bulk of unneeded code.

...

> -       calcedKsTO = ((s64)((s64)Ga * (prev_object_temp - 25 * 1000LL)
> -                            * 1000LL)) >> 36LL;
> -       calcedKsTA = ((s64)(Fb * (TAdut - 25 * 1000000LL))) >> 36LL;
> -       Alpha_corr = div64_s64((((s64)(Fa * 10000000000LL) >> 46LL)
> -                               * Ha_customer), 1000LL);

> +       calcedKsTO = div64_s64((s64)((s64)Ga * (prev_object_temp - 25 * 1000LL)
> +                                    * 1000LL), 68719476736);
> +       calcedKsTA = div64_s64((s64)(Fb * (TAdut - 25 * 1000000LL)), 68719476736);
> +       Alpha_corr = div64_s64(div64_s64((s64)(Fa * 10000000000LL), 70368744177664)
> +                              * Ha_customer, 1000LL);

This is less readable and full of magic numbers in comparison to the
above (however, also full of magics, but at least gives better hint).

...

> +       TAdut4 = (div64_s64(TAdut, 10000LL) + 27315) *
> +               (div64_s64(TAdut, 10000LL) + 27315) *
> +               (div64_s64(TAdut, 10000LL)  + 27315) *
> +               (div64_s64(TAdut, 10000LL) + 27315);

Shouldn't you switch to definitions from units.h? (perhaps as a separate change)

-- 
With Best Regards,
Andy Shevchenko
