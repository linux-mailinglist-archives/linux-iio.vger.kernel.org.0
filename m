Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACFA3EB23C
	for <lists+linux-iio@lfdr.de>; Fri, 13 Aug 2021 10:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbhHMIG0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Aug 2021 04:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239720AbhHMIGS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Aug 2021 04:06:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863E2C0617AE
        for <linux-iio@vger.kernel.org>; Fri, 13 Aug 2021 01:05:19 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gz13-20020a17090b0ecdb0290178c0e0ce8bso11385158pjb.1
        for <linux-iio@vger.kernel.org>; Fri, 13 Aug 2021 01:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFLYs7lg2xaFGygIQ/aLe23uHXNweOH6e0hbjMTVNSA=;
        b=ChIGG4bWE5VbiejujTTlwcgah84tBGuFvE4IJbnoGhuLup0gc6XykoOqVyGCIsjUFC
         u2SAVeDWVnATYpOEqmX5iRtFZ3+jkAsOf85WDLjOEIBH/a2eSULiffaVtBSL3YTB+CYW
         weBtyZqnbTdAbyaz1qsGOUrSDm9XABhWOaS0yg/TQ9WC7HuYS9eJhRej9hcOaDON1Y3l
         BPw3As4Z+DOe/1COeNjTv/Wh1nRPQTM5P39CMphL+SCAUCSG+Xk2J+6AfcFLWR359SVb
         eSWTIw6riqjcVz8cFL3BgmbGFvgw7LR9ODKgw0MUNd2VeXrXeFoyfUMe4qwRgyU1teBS
         TrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFLYs7lg2xaFGygIQ/aLe23uHXNweOH6e0hbjMTVNSA=;
        b=O36PDnp+CaR/GuE3BHGiMYyXndrnKDsP/8nNhv/PSZF7G8sq05OiPnxJTNhwJpnM8t
         dVLsguMHYhmMl8TwhU6Su2MDi9H83xL8McobYA9z2ylhD/8MYl/Zuy7AvSYEmMaaBBI/
         ejV1bCoAWNIvvZnlj3d9ME6Veo5Tgv3Bl2I/o3R/dtHymZ5njJIqDqqnFwejhVXS1cTU
         bNL1CVG78x1kMtpRhq58luJLw4AdrJk13OrK54ZuZu7YB+7ggXNEe3rpqmXnuSsXdirU
         aq79phzehmWv5vP9rgnDJ6nL+orajFWmJVUieiXmyk1NGICmw3H194hH3a80vNqHdZnM
         2CsQ==
X-Gm-Message-State: AOAM533wJYuhd+ZTcINm55PfzZrJCYIvhRnEha0Xl7AjN8c+6cNn0Odv
        FXlPfGvdHAlX4SBnWgcCuzdgEh3ax2/qeHLm/tY=
X-Google-Smtp-Source: ABdhPJyKjpbwdSLgxqF/yhpgxFD4S9FbzMSNIrdhiobNTYwTbUv3h+Ms/nW4NFCmWT7M0SnMZTyuC4p4ZCK+oFiFXYo=
X-Received: by 2002:aa7:800b:0:b029:330:455f:57a8 with SMTP id
 j11-20020aa7800b0000b0290330455f57a8mr1343634pfi.7.1628841919072; Fri, 13 Aug
 2021 01:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210811074827.21889-1-nuno.sa@analog.com> <CAHp75VeLfxyLG-zTdVVnwB+PR2v=LW-PcvM4ZkEoLq+Ht0-iCg@mail.gmail.com>
 <PH0PR03MB6366283246B9D4925BFA444C99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
 <CAHp75VeZLKN0C_+PopKfYtPMqEzGLd4paSKYnrHr1B2Y1Nk9=w@mail.gmail.com>
 <PH0PR03MB636647F75955CF0C5E6D5A3D99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
 <CAL_Jsq+V0++aO8cTcd3A-nBiG_X4wzJ+ZXWnXeRMPb=2QYOUhw@mail.gmail.com> <PH0PR03MB63662507607DD7E06995B7EE99FA9@PH0PR03MB6366.namprd03.prod.outlook.com>
In-Reply-To: <PH0PR03MB63662507607DD7E06995B7EE99FA9@PH0PR03MB6366.namprd03.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 13 Aug 2021 11:04:42 +0300
Message-ID: <CAHp75Ve=C62FmC20qkLsMVFkc-rbhHqmY2StDtrYqG0=mjtcTw@mail.gmail.com>
Subject: Re: [PATCH] iio: ad5770r: make devicetree property reading consistent
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 13, 2021 at 10:47 AM Sa, Nuno <Nuno.Sa@analog.com> wrote:
> > From: Rob Herring <robh+dt@kernel.org>
> > Sent: Thursday, August 12, 2021 5:11 PM
> > On Thu, Aug 12, 2021 at 3:14 AM Sa, Nuno <Nuno.Sa@analog.com>
> > wrote:

...

> > > Could you give your input on this one?
> >
> > There's no context, but I'm assuming this is in channel nodes. Keep
>
> Sorry about that. Your assumption is correct, the binding is for a channel
> node [1]. The driver just get's it as 'num' [2] which is not consistent.
> Naively, I just though changing the driver to use reg would be enough
> but Andy nicely raised the question of someone being already relying
> on 'num'...
>
> > the binding 'reg' and make the driver support both if needed.
> > Considering the author of the binding also changed the binding from
> > num to reg shortly after adding the binding, I don't think 'num'
> > support is needed. If someone used 'num' and didn't run validation,
> > well, that's their problem.
> >
>
> So I guess the solution here is just to change the driver to support both
> reg and num.

As far as I got Rob's answer, if the binding never had the 'num',
dropping it from the driver is what we want now (actually your
original patch) and users, who are 'too much clever' :-) should have
had run validation for their DTs before production.

Taking this into account, I'm fine with the patch (but update a commit
message to summarize this discussion)
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
