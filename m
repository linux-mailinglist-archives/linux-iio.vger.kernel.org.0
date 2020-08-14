Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B9024498C
	for <lists+linux-iio@lfdr.de>; Fri, 14 Aug 2020 14:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgHNMLW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Aug 2020 08:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgHNMLU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Aug 2020 08:11:20 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF65C061384;
        Fri, 14 Aug 2020 05:11:19 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g33so4447130pgb.4;
        Fri, 14 Aug 2020 05:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1NtQ9LmUKH6JjqwT9wrIjgDDKCd1tp2A+ZqG50gHTxc=;
        b=TLJJt+PAvbLe/+adQI+UNb9lc9K0xmOvZskp3cpjyWRTTWItu6QIqqdAOKPsQByL1s
         4zKmvi4d00Xbw3OgJ1asC2638a9rmYlzWLKF10XDsCt3peEOqf+Au5162DiMlOXCowm3
         868SQmZe5GKjddeKgOy59vDdajoLfP4YHJSX2z+4ptj/NgfTATGNwOayPo2hveaaNNPV
         rKZJzEYCIsla+/zKeQx5fAEwVRazow3UyS8+3V97OAYCQFoqfzwIwnHR///AA9UjEZfE
         hvm4rODDBx8InjuFibHrL5PZVhrgSbU52uJbexbMkF1CrfFstpgOdbnStM0e1GSSyU74
         GmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1NtQ9LmUKH6JjqwT9wrIjgDDKCd1tp2A+ZqG50gHTxc=;
        b=eVzWmZlcAjiGvX5uZjTWAJwcHC01Y1ww8uBUJZko1FCKEHfriLfScavY0nyNF/hsqw
         q9J8P7YkNYXzCu2cYPOIW0S+XI8BpIyBAZqWY0tugtDhBQkj65weJ+T1JrVpkRmMWHYz
         bMvVtjuH03963DhgJkbyMr3Nx3UnWjMOcMKXRhqRpb5456552gSnH/Q6T3RmQ6sr29MJ
         ZNaOUPDDbdXJF3IrXSFMejOQVfEuHawJrCtwPs6dObIZboHodQxzw/Lms2TBDL3g/4RX
         GgqugX35WwjjgEESrydp9iVvawFpdm00l0jjlwEiFkDsolmWyvbK2xJ3VroTfqqRXJ1z
         Fmww==
X-Gm-Message-State: AOAM5332mWwwJKI1oYr/8sP+E1RSbOc7vOWbJjpyQpfJxJaqfFQh3GhA
        xwlkPzdpOZa1nxGlV740HxrFdK2Ei12oUxKeBz6WWvJ7O/giBQ==
X-Google-Smtp-Source: ABdhPJwcz5POI/numPYIz6Dr98uPukTGGD2OQi8eJSUtEV38WgE382KwDVvMguYRyOc5ud3bnnxBzR3g3s0oyMmHRKY=
X-Received: by 2002:a63:f24a:: with SMTP id d10mr1552682pgk.4.1597407077534;
 Fri, 14 Aug 2020 05:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200813075125.4949-1-cmo@melexis.com> <20200813075125.4949-4-cmo@melexis.com>
 <CAHp75VfNwb5uBp=H0295LEJjXy1+=V5yvSN1PHbtMYzgg=_EAA@mail.gmail.com>
 <CAKv63uv=b60B9RXBJF4HEhMOowu-qbGrv7LsmJVvkkERSida-A@mail.gmail.com>
 <CAHp75Vd+3SopKog6uhSKoOLn+tECsQfs7kRbJsrMZEbNRpk8bQ@mail.gmail.com>
 <CAKv63usrjEHTmYtahedqULnqu-fM3TFC8HJ=S4h+w=UTv5sd-Q@mail.gmail.com>
 <CAHp75VeH5SA2KeiTSN__8ndj1v_SEb7mEWPG1p2Lz-tATDWi8A@mail.gmail.com>
 <CAKv63uvQBoD=a2ADG7XBoQd2JRt6ggK0UB-g6cSuWLE7EV+qww@mail.gmail.com>
 <CAHp75VfAbufX+jYcxnp8AyAzZ0M42jRCkP5X1sRqXm0jpoyvrQ@mail.gmail.com> <CAKv63utpidP12iQXWU59=F+cVCq6oShSAitmKhoC4W4aaPtnRA@mail.gmail.com>
In-Reply-To: <CAKv63utpidP12iQXWU59=F+cVCq6oShSAitmKhoC4W4aaPtnRA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 14 Aug 2020 15:11:01 +0300
Message-ID: <CAHp75Vd+CZQCtDX8LUbQef7cQyG7brJT6S5rZeSZHTB1ZArSgQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] iio:temperature:mlx90632: Convert polling while
 loop to do-while
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 14, 2020 at 12:42 PM Crt Mori <cmo@melexis.com> wrote:
> On Fri, 14 Aug 2020 at 11:32, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Fri, Aug 14, 2020 at 10:33 AM Crt Mori <cmo@melexis.com> wrote:
> > > On Thu, 13 Aug 2020 at 21:41, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > On Thu, Aug 13, 2020 at 4:04 PM Crt Mori <cmo@melexis.com> wrote:
> > > > > On Thu, 13 Aug 2020 at 13:24, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...

> > > > >                 usleep_range(10000, 11000);

Above for 4 attempts is up to 44000us.

With iopoll.h case we may set
 delay_us = 18000 (the result range will be 4500, 18000)
 timeout_us = 72000 (this will give up to 16 attempts to read)

> I tested on Beaglebone with the 100 * 10000 as timeout_us and I always
> got the -ETIMEDOUT error. I also tested in the other case where
> delay_us is 250000 and then timeout_us would be 4*250000 and I have
> also received -ETIMEDOUT as a response.

I don't see how delay_us should be bigger than 20ms (20000).

> I can prepare a patch with the iopoll.h API and maybe you will spot
> the mistake, as after rechecking timeout_us is indeed 64bit and is
> only used in the time comparison operations and not with timers.

Perhaps above will clarify.

-- 
With Best Regards,
Andy Shevchenko
