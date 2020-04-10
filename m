Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9111A4890
	for <lists+linux-iio@lfdr.de>; Fri, 10 Apr 2020 18:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgDJQhj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Apr 2020 12:37:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38445 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJQhj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Apr 2020 12:37:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id c21so1247134pfo.5;
        Fri, 10 Apr 2020 09:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMGQicetD64osreTQ6vhdHosnrVVm4nm7kya26WOitg=;
        b=oRm6j05JIM7UtqWRYrfSaxrrD/Ym6w6VtNQlVuCeHZOGUlJq9iJJAh63qp1VuVWcnA
         6tUrvMc5w4jbFD/AEDrwfhn0pnO8VUMXS9o2V3U88KWSQjZyXn01Pr4uT8GZzHYHUUlj
         d45zmXh82TAbafnNSli99toZ75v+WESMrHLBti5hZNs09ZkSQMY6t37mDOPxI54VxfsQ
         NCSL++sfB7WZeeWQBhiT53A66H5yn/uKbxYxLAwjfHXGLl4KDmVP9gEYLWtPsNy6iie2
         F6ZjMej+3ND1Zh5h5E4dlvdeik9GhQCePrfp7d1nHUVJz4i6+6SUj+1g9ApCazQWm2Sl
         3HgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMGQicetD64osreTQ6vhdHosnrVVm4nm7kya26WOitg=;
        b=hxOTpmY3pLvFuW/qMJ6wbx8NEGe4lLq82rZz/ji2/2IkbD3fLkbj4FqT0mY76rV7md
         CNN3xlQKawZw/8qwZkOq5U3eCg/B3GAk9XIu+KSGxunzG+bxnFKqBTr18Q1Anj48ingG
         r/Qph+k9l0EGiiAuKeRg5QeYQlmG9xIdIwYXGwQ5kDuneJayZwBSVbssrDefprusrxRC
         rTxOJtj3S831ROzhVO+LLb5qHf4jgLYKBYBFspO7jv7EiXA33sY3g/Jyg0yK5uxz3Fa5
         4MFI8B/8VteovOgWkVPpmB2CE10gkQnBRm6Km9O59qq4L7b+/vUlREJ5XO0eThZeu5L+
         xs1w==
X-Gm-Message-State: AGi0Pua5z0tfK8DgVVsy/RiUEVlUo9PnKpwE3VE/kmetFxb2VLRXBKp0
        MenJVdlu9DkxHm/81E1GIvWbIoa4j8itCoGEsU0=
X-Google-Smtp-Source: APiQypJSQVwaIbthGggDlTt2w0s1ErVhplhyXFG6YjdOuX1gpc0tMcIF6YG/7QdSDKsX+jLRYmIsK3fng1xEOpqLE+M=
X-Received: by 2002:a63:1d4:: with SMTP id 203mr5113227pgb.74.1586536656920;
 Fri, 10 Apr 2020 09:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200409151125.32677-1-aishwaryarj100@gmail.com>
 <20200409155936.GV3628@piout.net> <CAHp75VcLLjjc5T+Qq8du4QgnQ-rtzFLh=5Jt-DPjigb+QUWOSg@mail.gmail.com>
 <20200410112236.GX3628@piout.net>
In-Reply-To: <20200410112236.GX3628@piout.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Apr 2020 19:37:25 +0300
Message-ID: <CAHp75VfJMsVB2rC-Qx6mQw+e8Vw9sVaWTu2Jvxj-nO1LzadHeA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: at91-adc: Use devm_platform_ioremap_resource
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Aishwarya R <aishwaryarj100@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 10, 2020 at 2:22 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 10/04/2020 13:55:26+0300, Andy Shevchenko wrote:
> > On Thu, Apr 9, 2020 at 7:00 PM Alexandre Belloni
> > <alexandre.belloni@bootlin.com> wrote:
> > > On 09/04/2020 20:41:23+0530, Aishwarya R wrote:
> > > > Use the helper function that wraps the calls to
> > > > platform_get_resource() and devm_ioremap_resource()
> > > > together.
> >
> > > Please elaborate the actual value of doing that.
> >
> > Please, elaborate actual value of not doing that.
> >
> > Yes, I know that you are p* off of these changes, but why you not
> > going further and forbid all clean ups we are doing in the code?
> >
> > To the point. Above change is reducing code base and showing the new
> > comers modern APIs to use.

> The value of doing it is to reduce the code size by 16 bytes. The same
> people doing that will actively ruin that by adding error string for
> error that will never ever happen.

I don't see it in the patch we are discussing, so, not an argument.

> Also, the commit message is definitively lacking. A good commit message
> would say that the patch has been generated using coccinelle, that no
> testing has been done and that no thought has been given.

That's I agree with.
But somebody need to teach people how to do it better.

> It would definitively make sense to send one patch per subsystem instead
> of having 475 different patches each changing only one location.

Depends on the maintainer and subsystem. This is arguable argument.
In my subsystems (let's forget about PDx86, where one per subsystem in
principle is not working by nature of the subsystem, but consider
others I'm maintaining) I prefer to have a possibility to track
changes independently on driver basis.

> The whole "let's let newcomers fix trivial bugs" thing is definitively
> not working and it is not leading to an increase of the number of useful
> reviewers and contributors

Semi-agree. That people can be self-organized into a reviewer gang and
try to learn together.
In any case, as for maintainers, the task has not only technical
aspects, but mentoring as well.

-- 
With Best Regards,
Andy Shevchenko
