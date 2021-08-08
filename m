Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8207F3E3C54
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 21:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhHHTBc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Aug 2021 15:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbhHHTBc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Aug 2021 15:01:32 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EA5C061760;
        Sun,  8 Aug 2021 12:01:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d1so14077924pll.1;
        Sun, 08 Aug 2021 12:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qBu5iUaSAxxZpgJfxNDAcC/Wp2BLXG1BK3fHE7DMi70=;
        b=tUpEbBFwt/yi6jWl+lS2T/oX8Km8JAD2DIZeIPuoQE+MF/+EOx8nBPFbudEB0WXd29
         JEZaNCk960Jpgqn6/b1alTqcbP/Cfx3WAdeksY4clk0CWQMgyFwrkhAAkIrP/QpVJ3hY
         VqyppylTuz1BsMOSUcvSeEoE6g5hgcMOsFT1d2nMtMmqV68DFBwNX+5UJEls1B7h2LB2
         eJhNoiw3WpqgrUTb2gk7k4/Qx9+fuVaUh/hLmSnzC2gkjREh83ugtKKBIPJJqP/ytFIN
         4t1/mGZn51/qpeqpFy7Kv9c78nazmY16RyKg22OTxUtC3Qz8gkpwOi98Ka5JwVe4uV/z
         TuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qBu5iUaSAxxZpgJfxNDAcC/Wp2BLXG1BK3fHE7DMi70=;
        b=EMlynxhvMrcii04RBgzrQbQ0J52GqmfscOEhRVo3voLJH1Zg0w5oIMfq4U7wJvF9nx
         toj5XNunx7hCl+mN5E2qpt5+FR2mb5FpH5/ZtoC48tEsIVlvo+i3q9bVq2B4CdgN9Fcs
         +45JJYTAZbI6J7k79NnX+XsP0EmMnK4NBFfoEervxtohgSzDT0kI12LrHPX/XUBPZ5kb
         vUSKrc8/kIsv8h8fvB9q7BvM82mOAsvCnd6/scdDkzG/+B4+PtSgF3ceueGvVF1IdpZn
         z1tsEYJDxkRyJoOjV995M7FUYmiSd+NwxjJ4cJ5Rc/tgj1BdcdlPrTuYfJXq6xcVX0AR
         pDYA==
X-Gm-Message-State: AOAM5319Dq+hi4zXVQqJGj+zS6jhs/YoBKJvOks4mnHNZVI93WMZ5Hjm
        c6vh+QSbg27PthF6ML0w08i/BqD8FQRfoG0pbUI=
X-Google-Smtp-Source: ABdhPJy3lvTMhfLmQ3Z7rH5Zo4CSzjyA+DTg6zkmpCfBaSEixGQ4U1+Ng6BfzOIGfyuiMgVCyRSwpLzOm5cqKOnkV8U=
X-Received: by 2002:a17:90a:b10b:: with SMTP id z11mr32121963pjq.181.1628449270967;
 Sun, 08 Aug 2021 12:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210807152225.9403-1-len.baker@gmx.com> <20210808172503.5187cd24@jic23-huawei>
In-Reply-To: <20210808172503.5187cd24@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 8 Aug 2021 22:00:34 +0300
Message-ID: <CAHp75VfSX-7UqH9Lbr_GxQRY3dGjGo7H8++kBdrrSds1p6nB1Q@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/iio: Remove all strcpy() uses in favor of strscpy()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Len Baker <len.baker@gmx.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 8, 2021 at 7:25 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat,  7 Aug 2021 17:22:25 +0200
> Len Baker <len.baker@gmx.com> wrote:
>
> > strcpy() performs no bounds checking on the destination buffer. This
> > could result in linear overflows beyond the end of the buffer, leading
> > to all kinds of misbehaviors. The safe replacement is strscpy().
> >
> > This patch is an effort to clean up the proliferation of str*()
> > functions in the kernel and a previous step in the path to remove
> > the strcpy function from the kernel entirely [1].
> >
> > [1] https://github.com/KSPP/linux/issues/88
> >
> > Signed-off-by: Len Baker <len.baker@gmx.com>
> Applied to the togreg branch of iio.git and pushed out as testing
> so 0-day can poke at it and see if we missed anything.

Isn't it too early? Or am I missing something (see below)?

...

> >                       /* use length + 2 for adding minus sign if needed */
> > -                     str = devm_kzalloc(regmap_get_device(st->map),
> > -                                        strlen(orient) + 2, GFP_KERNEL);
> > +                     n = strlen(orient) + 2;
> > +                     str = devm_kzalloc(regmap_get_device(st->map), n,
> > +                                        GFP_KERNEL);
> >                       if (str == NULL)
> >                               return -ENOMEM;
> >                       if (strcmp(orient, "0") == 0) {
> > -                             strcpy(str, orient);
> > +                             strscpy(str, orient, n);
> >                       } else if (orient[0] == '-') {
> > -                             strcpy(str, &orient[1]);
> > +                             strscpy(str, &orient[1], n);
> >                       } else {
> >                               str[0] = '-';
> > -                             strcpy(&str[1], orient);
> > +                             strscpy(&str[1], orient, n - 1);

Why n-1?

> >                       }

As far as I understood the logic, it  inverts the sign except the case
when it equals 0.

I have a question here, why can't we always use +/-?
Why can't 0 be prefixed with a sign?

If the above can be used, we may simplify this code.

Len, I think this task may be considered simple, but I recommend
thinking about each case and finding a way to simplify it more.

-- 
With Best Regards,
Andy Shevchenko
