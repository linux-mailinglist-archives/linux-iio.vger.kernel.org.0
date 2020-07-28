Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E49231184
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 20:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbgG1SUg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 14:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgG1SUg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 14:20:36 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEB8C061794;
        Tue, 28 Jul 2020 11:20:35 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m16so10340987pls.5;
        Tue, 28 Jul 2020 11:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HizAv/2BbJe10LFWzWz6Hy6JujP+ulm6Iu50hkDF5uA=;
        b=CXgvPRR9dF6S2mwU1s3zTo8xCa85QANXJFI/32e4Ttueq7Hfb9O4N7CtRi6xdPptCE
         QFdFz0ui5RPS8L3WKqd1tXQQ/a4F6zNqcgJrkyaBnX5LTh0OEQICl8Y9wQBhKPkwEVSq
         f0X+RtNGqksWS7CwXsbyOdj0K1D+B0GziQnb5Hw+RCBJI7e7ep3ue9LWkOTffAC/U3RD
         PLzY2W8Poe14fl7hCgryfZsR2a1SvEH7Wd/XxWpFHYNcs0T41hVCmakSY71fjgY/Kxse
         M8RSFkNtI5BAU9ym7HHwTh/s2UUIAvsGC3aSQ8JczAgINRnQwJ/TbQEQ2BtHFGl+9etB
         HMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HizAv/2BbJe10LFWzWz6Hy6JujP+ulm6Iu50hkDF5uA=;
        b=eWbn1wiHm+b6lTSBRS+GrokH+FHgCc6hvLlKc/sgeVbSPTJ9l1tyXCsQofFX7s4Wjy
         gJOg8HomYx70TlJZLCN52OMWRgJ2uObAPgCielY29sjw/dbKZwFijFjo+dUY8jxtMZlw
         OjlS7/hXWghdikqcPRNqAMy7T5KlQEIwCNqMjC+hmZ8CTetNGbccSwXKY5/qPHUoQ6WD
         B1CWmT78Sdcnz8zJw2k3B+IgesIwVXH6UjsycnArSAEyLKnm9x4UCMS9JDNa4wDaTWsk
         RLI5jLEnUOQSEDR6wvOfiecuLA2KTgVFvmUfsxQsSOJwVghnBHHki6AxMNbakw/j3stX
         Y5fg==
X-Gm-Message-State: AOAM531nsls+DILNNWI62lapxHBHHKv+dZpi8dcnMHeB90hdz929Z7g8
        Ut9Q8Y0eTddIxquLIxte0LpFPXYuB+O945LWOns=
X-Google-Smtp-Source: ABdhPJx68GU3hCtlmBaN4KU9OZ1g4rsdPZjDZEDJ3kAei4EES8o23Q8Zo+Wlx/5KxsVwQBwVB7CDk9hmdJE793rNoms=
X-Received: by 2002:a17:902:8491:: with SMTP id c17mr23983042plo.262.1595960435466;
 Tue, 28 Jul 2020 11:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org> <20200728091057.14.I687e37031ecdd9e21078adf8d290c48b6d9d9a1e@changeid>
In-Reply-To: <20200728091057.14.I687e37031ecdd9e21078adf8d290c48b6d9d9a1e@changeid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jul 2020 21:20:19 +0300
Message-ID: <CAHp75VeHK_EwQnhpTMe6Q=cxf5bz9Qiuq7vM4h94eTfbAcgjtg@mail.gmail.com>
Subject: Re: [PATCH 14/15] iio: sx9310: Drop channel_users[]
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 28, 2020 at 6:14 PM Daniel Campello <campello@chromium.org> wrote:
>
> From: Stephen Boyd <swboyd@chromium.org>
>
> This struct member isn't used. Drop it.
>
> Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Daniel Campello <campello@chromium.org>
> Signed-off-by: Daniel Campello <campello@chromium.org>

Here is everything correct!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> ---
>
>  drivers/iio/proximity/sx9310.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 4553ee83a016a3..202018b726e32f 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -131,7 +131,6 @@ struct sx9310_data {
>         struct completion completion;
>         unsigned long chan_read;
>         unsigned long chan_event;
> -       int channel_users[SX9310_NUM_CHANNELS];
>         unsigned int whoami;
>  };
>
> --
> 2.28.0.rc0.142.g3c755180ce-goog
>


-- 
With Best Regards,
Andy Shevchenko
