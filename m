Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F0D4D6095
	for <lists+linux-iio@lfdr.de>; Fri, 11 Mar 2022 12:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbiCKLbj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Mar 2022 06:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348241AbiCKLbg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Mar 2022 06:31:36 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32371BB71A
        for <linux-iio@vger.kernel.org>; Fri, 11 Mar 2022 03:30:33 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id t1so10333971edc.3
        for <linux-iio@vger.kernel.org>; Fri, 11 Mar 2022 03:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qDHObeMo7WVeg2dkZzBUHH5RM+6e7KKfFQMfQ7QXGx8=;
        b=BULxjx0QdLIC402Uo/hccpVyg6Sa+gAGtKdW7EcnFOBwHQ5FIFvoX86bkpyd4tuiSL
         LOS0c2SLX7k29FimOGHLh0G7aKgj8snNzOrMsTWGfd2S+lJaTTc7uUruzSNoaDq82R2S
         UkukWrJGMWh+Yq7pRs2PEmIHIn6fUuB4n+Vnb6sx/oz4am6NPLu1riiBcfmFHwWxLFzO
         Ffw/trXzdKy9PGoJdhlPRNaZsd2wzP+VzdSbof58WjAy+dTguUKQAEJWTxJrSORQQRr3
         tUPNEC43L8ZOLkeH3ScHTZDHDSZMwy2mhAowXq+1jE+vC69X9cWIYRZsJCE3Mg0GPcTO
         d77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qDHObeMo7WVeg2dkZzBUHH5RM+6e7KKfFQMfQ7QXGx8=;
        b=3tqJHLw8lRlKIdF3RnP/bwElsnWFDkiBol4aThJnpGfIDarQNyfC6mWyCIJJAUseEB
         8i2Ol6xoBPiqjB8rLarrDfGgKvG7/zjKt8aNYe59NKhcD5NOvtneLTys9/h1qaVHa3pt
         YOAUmRoopE72zLPNIZeqK34oPm7EM0AQVyzj1Exr5bgaNLiUrS/WTBmHUb8/2BxvGP/c
         hswvX41aPV8yuo+b+pzY/DOYNqnjRNd5qTDjfuWH/PcHmKvvuGJuH+kc59Ny2UBXYqdL
         5RDXaICd+iKzdILdwuV204AzjQF7N+BBWgjkDwNhIvMw8BqHPdfsIbTutFLKJIDo9To9
         p39w==
X-Gm-Message-State: AOAM532jJaeqgS7QDU2lE6aKsmgnrZk8baatp2jK+hEa+Y5X7vP4Eggq
        HeN5K4pbDb04+2lmmWKHKSZyo5vzVpP1+314HARN2A8lhF5iJQ==
X-Google-Smtp-Source: ABdhPJwns6z8ubLOZueJiR2QY69U9qKKK05bciOMXR4zIG2efWfgEVaxe+eG/Swf9Fbep+a1kWmKirsWxGLHJ9r9HMg=
X-Received: by 2002:a05:6402:3452:b0:415:9d25:3967 with SMTP id
 l18-20020a056402345200b004159d253967mr8374804edc.125.1646998232334; Fri, 11
 Mar 2022 03:30:32 -0800 (PST)
MIME-Version: 1.0
References: <20220310003402.490478-1-marex@denx.de> <20220310003402.490478-4-marex@denx.de>
 <YioKZ6EZvYHOOFMe@smile.fi.intel.com> <082e1654-74b7-aed2-4915-f8dd304540d6@denx.de>
In-Reply-To: <082e1654-74b7-aed2-4915-f8dd304540d6@denx.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 11 Mar 2022 13:29:56 +0200
Message-ID: <CAHp75VfDv5CE0cDSBDeMeWj4ub1JV9o-jPpqhLvwnmmN+=WJ0Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] iio: adc: ti-ads1015: Deduplicate channel macros
To:     Marek Vasut <marex@denx.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 11, 2022 at 1:55 AM Marek Vasut <marex@denx.de> wrote:
> On 3/10/22 15:25, Andy Shevchenko wrote:
> > On Thu, Mar 10, 2022 at 01:34:00AM +0100, Marek Vasut wrote:

...

> >> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> >> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> >> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > You may consider using --cc parameter in `git send-email` to avoid this noise
> > in the commit messages.
>
> This is deliberate so I can keep track of who to CC on which patch.

You may add the Link tag to lore (which `b4` tool can do
automatically), so you can always access the email from the archives
and track this down. No need to have this in each of the commit
messages.

...

> >> -            .realbits = 12,                                 \
> >> +            .realbits = (_realbits),                        \
> >>              .storagebits = 16,                              \
> >
> > This seems inconsistent a bit. What if the next chip wants to have more than
> > 16 bits in realbits?
>
> When such a chip exists, this can be parametrized as well.

Yes, My point is that it's error prone.

...

> > I see two options:
> > 1) add static assert to make sure realbits <= storagebits;
>
> Does static_assert work in array of structures (I don't think it does) ?

You can check, but IIRC some of the macros have it. Don't remember the
details, though.

> > 2) make it also configurable.
>
> That would be unnecessary duplication, this patch is trying to
> DEduplicate the driver code, not REduplicate it differently.

-- 
With Best Regards,
Andy Shevchenko
