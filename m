Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767C23EC1E8
	for <lists+linux-iio@lfdr.de>; Sat, 14 Aug 2021 12:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbhHNKJx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Aug 2021 06:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhHNKJw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Aug 2021 06:09:52 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9DFC061764;
        Sat, 14 Aug 2021 03:09:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id b7so15173690plh.7;
        Sat, 14 Aug 2021 03:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XAHgbwonCeesahvHLBdcLZ4Rxo0MiUJAmQUW5HriCGk=;
        b=iM/nlNUE04IUh6TJwkTihJgEWvT70Qfz0Zj6+y3vSn3TjMHV0SxElc+kLPxwYlXQMe
         q834O/qcJ0GFjXTn5JGOieBLJ4XBtvwsrmkrLHaITHamHO0e327IViMav2T7pGKIaAbc
         VHWx5hvtB2AY5QF/2O/azTnyAec7VvDt0SPcQV61POh7oV1hwkwEx4ADwjHxIzaSKYbh
         ij6+kO27GoOHVaukMz/T+h/0f6iKGcG8U71zRtP9LdoCCSjz/9jfyyqCFnH747Uj0GiX
         yEouH5D2cXVLrTueLLHN+jxLK1C5YjhDH31djUDwFm6wPcQt7ex88NKKLmxPbxBPr/AH
         rprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XAHgbwonCeesahvHLBdcLZ4Rxo0MiUJAmQUW5HriCGk=;
        b=uUpmg7REgHXJPNMrq3cfpsQCSuoU3RZh+HxgL2nVaeVqVoUNYxdO0LHVJWwYyKYP8L
         atDBvMiv9THoAg4oM5OTH7ADDW4NH0JpTfOf87pH6XNHdhGq9lqZl3tFiNhn9m0dI7wt
         a8CVnns07wbCMAFkfHrpLPNgj7qx1VKE7fmt0Xj/oJ8c8jXrSpJrAHMc5bxFbZqYwNNU
         G3fme3O28/CFMl8PF9vHoDqf9se86LKEjXrfgHDh7vVTGWSWTII8IHybZtUuKlo2NPRJ
         7OqPHBXukQ8C2Vtlx+9azWED6/5XchP31vLmtZ69Ugrl6dH0MTCM4YKGHaGwHw79OOMQ
         oYOQ==
X-Gm-Message-State: AOAM533ZFTQLwW7BUAXSx6bXarNJfZNZsJ/Cr0T/nuqZCMF3hdleQ/ol
        I5iG78OC/o8qkJPBojPjdTvjF11+S8w8GuivJd0=
X-Google-Smtp-Source: ABdhPJyN6UP54Y0+Pb8P9xpTbWW0GLRBfwUf9GkVs11BPvR1SXXP1r4s/cxRhBdhWCFNnhyIiyYlX9K9enJ2k7m3iWk=
X-Received: by 2002:a17:902:e786:b029:12d:2a7:365f with SMTP id
 cp6-20020a170902e786b029012d02a7365fmr5492149plb.21.1628935764456; Sat, 14
 Aug 2021 03:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210814090618.8920-1-len.baker@gmx.com>
In-Reply-To: <20210814090618.8920-1-len.baker@gmx.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 14 Aug 2021 13:08:48 +0300
Message-ID: <CAHp75VfxYd0pS-WmE62F5w4SFWchDS=7iedaG1rY0Nc9+092RQ@mail.gmail.com>
Subject: Re: [PATCH v3] drivers/iio: Remove all strcpy() uses
To:     Len Baker <len.baker@gmx.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 14, 2021 at 12:06 PM Len Baker <len.baker@gmx.com> wrote:
>
> strcpy() performs no bounds checking on the destination buffer. This
> could result in linear overflows beyond the end of the buffer, leading
> to all kinds of misbehaviors. So, remove all the uses and add
> devm_kstrdup() or devm_kasprintf() instead.
>
> This patch is an effort to clean up the proliferation of str*()
> functions in the kernel and a previous step in the path to remove
> the strcpy function from the kernel entirely [1].
>
> [1] https://github.com/KSPP/linux/issues/88

Thanks for an update, my comments below.

...

> This patch doesn't change the logic. I think it is better to use the
> current logic and not use always the plus and minus signs as suggested
> in the previous version. I don't like the idea that 0 has sign.

Agree on that, the safest way to go with.

...

>         const char *orient;
>         char *str;
>         int i;
> +       struct device *dev;

Please, keep this in reversed xmas tree order (longer lines first).

...

> +               dev = regmap_get_device(st->map);

I haven't checked the code in between, but maybe it's possible to move
an assignment directly to the definition block above.

...

> +                       /*
> +                        * The value is inverted according to the following

"to one of the"
And technically speaking "inversion" is not the same as negation
(which is "sign inversion").

> +                        * rules:
> +                        *
> +                        * 1) Drop leading minus.
> +                        * 2) Add leading minus.
> +                        * 3) Leave 0 as is.
> +                        */
> +                       if (orient[0] == '-')
> +                               str = devm_kstrdup(dev, orient + 1, GFP_KERNEL);

> +                       else if (orient[0] != '0' || orient[1] != '\0')
> +                               str = devm_kasprintf(dev, GFP_KERNEL, "-%s", orient);

I would go with the logic I suggested later on, i.e.

                       else if (orient[0] == '0' && orient[1] == '\0')
                               str = devm_kstrdup(dev, orient, GFP_KERNEL);

and below changed accordingly. It will clarify the "0" check.

> +                       else
> +                               str = devm_kstrdup(dev, orient, GFP_KERNEL);

> +

Redundant blank line.

> +                       if (!str)
>                                 return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko
