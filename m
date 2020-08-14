Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD1224470B
	for <lists+linux-iio@lfdr.de>; Fri, 14 Aug 2020 11:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgHNJcD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Aug 2020 05:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHNJcD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Aug 2020 05:32:03 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0ED2C061383;
        Fri, 14 Aug 2020 02:32:02 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id e4so4151889pjd.0;
        Fri, 14 Aug 2020 02:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c8WGCCyt5Nm84cGuy3CE7BJ5TpGDOMgackC8NG3DTSU=;
        b=JJDdYGX+qYWom1+glsIFm36aA+kq05sY4IHY19GWFo+PrPtxaUl35YPoR0IJY/5Ogd
         ZFILUD2en5qve9Ofuic2q48oR+QRvlJ+IlACLTFByvGEw7aVUMkVBQKMLB7uEKGX2p/4
         vWnrNhJ1JVT+wZ6osS2ym6Bg+XH3m2sxY3hLKiJq2ZqnD4ltGJV0xL8D/bZfxqrIjp7N
         hZTCUCuAjkErf2jD4WXLl5TwnKF3PgmNMC+kBpnz/SVfbWhO7478X3srdWobHCmQLQv0
         jk4pajJTDcww3t59abFNjK+WArkTvBuYPLQsQg8YcTmBN2MtUfgHxDjvRGEwOr84tt6i
         nT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c8WGCCyt5Nm84cGuy3CE7BJ5TpGDOMgackC8NG3DTSU=;
        b=HHFQwGRn7qP87yGxF+/OA8sq5UyRRbmTVcNHslRtGM9GO5pBCYLq+3hBZ5XWPoMLSw
         zEiPS4Y6Ko7a9Zjb9ClcT3Zr/12i7wqdxEM6g78HM362RIdWEZIFa8i/7UkIcNPgEx1j
         kmh4D1CjEg0O9KLTUkr9o1eiykvWESBXz+anOkA7pUV7AKFQbihGfqeNsBDEKKZKpTzS
         xlIP0WlHoyuizb6qxTpiisR772r4cSvBqH0TurGhGYbeqSXhdX6SO+sstyGj5EmY5ACJ
         egsnebTdm/thuTZkBQVSa71zs58hGIudrPbFpojZFMErtmtlI915Y0pWQvfkfZICiGJF
         6x0Q==
X-Gm-Message-State: AOAM530/mhhOF/gcw1XH1kjItGS1R2T9GbzZoLuL9paSsPVFEkzsPIaT
        TsfSJ6OKmK3b8aKYqR+XDQQ1HXYy1S4SJrLM7viUyzhIccpCNA==
X-Google-Smtp-Source: ABdhPJx6uFRSOQ3rT9bgL2A99Me+ZV3uK5yhchrCJk0lDm2umwqxrGruDGfbhtHqO6DMgZiJWrbvLR0PHRJlo4UIs/g=
X-Received: by 2002:a17:90a:bc41:: with SMTP id t1mr1471976pjv.181.1597397522294;
 Fri, 14 Aug 2020 02:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200813075125.4949-1-cmo@melexis.com> <20200813075125.4949-4-cmo@melexis.com>
 <CAHp75VfNwb5uBp=H0295LEJjXy1+=V5yvSN1PHbtMYzgg=_EAA@mail.gmail.com>
 <CAKv63uv=b60B9RXBJF4HEhMOowu-qbGrv7LsmJVvkkERSida-A@mail.gmail.com>
 <CAHp75Vd+3SopKog6uhSKoOLn+tECsQfs7kRbJsrMZEbNRpk8bQ@mail.gmail.com>
 <CAKv63usrjEHTmYtahedqULnqu-fM3TFC8HJ=S4h+w=UTv5sd-Q@mail.gmail.com>
 <CAHp75VeH5SA2KeiTSN__8ndj1v_SEb7mEWPG1p2Lz-tATDWi8A@mail.gmail.com> <CAKv63uvQBoD=a2ADG7XBoQd2JRt6ggK0UB-g6cSuWLE7EV+qww@mail.gmail.com>
In-Reply-To: <CAKv63uvQBoD=a2ADG7XBoQd2JRt6ggK0UB-g6cSuWLE7EV+qww@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 14 Aug 2020 12:31:46 +0300
Message-ID: <CAHp75VfAbufX+jYcxnp8AyAzZ0M42jRCkP5X1sRqXm0jpoyvrQ@mail.gmail.com>
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

On Fri, Aug 14, 2020 at 10:33 AM Crt Mori <cmo@melexis.com> wrote:
> On Thu, 13 Aug 2020 at 21:41, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Thu, Aug 13, 2020 at 4:04 PM Crt Mori <cmo@melexis.com> wrote:
> > > On Thu, 13 Aug 2020 at 13:24, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > On Thu, Aug 13, 2020 at 2:14 PM Crt Mori <cmo@melexis.com> wrote:
> > > > > On Thu, 13 Aug 2020 at 13:03, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > > > On Thu, Aug 13, 2020 at 10:53 AM Crt Mori <cmo@melexis.com> wrote:
> >
> > ...
> >
> > > > > > I don't see how it prevents using iopoll.h. It uses usleep_range()
> > > > > > under the hood in the same way you did here, but open coded.
> > > > > >
> > > > >
> > > > > One loop is indeed 10ms and that is not the problem, the problem is
> > > > > that timeout is at least 3 calls of this data ready (3 channels), so
> > > > > that is at minimum 30ms of timeout, or it could even be 4 in worse
> > > > > case scenario and that is outside of the range for usleep to measure.
> > > > > So in case of the other loop, where we wait 200ms for channel refresh
> > > > > it is also out of scope. Timeout should be in number of tries or in
> > > > > msleep range if you ask me.
> > > >
> > > > I still didn't buy it. You have in both cases usleep_range(). Why in
> > > > your case it's okay and in regmap_read_poll_timeout() is not?
> > > >
> > >
> > > I tried and it did not work, so then I read the manual. Looking into
> > >
> > > * regmap_read_poll_timeout_atomic - Poll until a condition is met or a
> > > timeout occurs
> >
> > Why _atomic?!
>
> I just pasted something, it is the same as for non _atomic

OK.

...

> > >  * @delay_us: Time to udelay between reads in us (0 tight-loops).
> > >  *            Should be less than ~10us since udelay is used
> > >  *            (see Documentation/timers/timers-howto.rst).
> > >  * @timeout_us: Timeout in us, 0 means never timeout

...

> > > > > > >                 usleep_range(10000, 11000);
> >
> > You use here usleep_range(). The same is used for
> > regmap_read_poll_timeout(). What's the difference?
> >
> > Since it uses 1/4 of the range you probably need to update tries and
> > timeout_us to make it work.
> >
>
> Timeout_us here needs to be in one case 100 * 10ms (maybe not
> realistic as we could live with number of around 40 * 10ms), but this
> is a lot more than proposed range of usleep which Is up to 20ms. Even
> in best case this timeout should be 40 ms to give enough time to
> measure 2 channels for sure. So with the current timeout_us
> requirement we are outside of the range of the udelay timer and that
> is why I would need a macro with number of tries, not with the timeout
> value (or timeout value of ms).

I do not understand. The regmap_read_poll_timeout() is a macro which
unrolls in the very similar loop you have now in the code.
What prevents it from using it?

I think there is a big misunderstanding about the parameters of that macro.
delay_us (must be small enough), timeout_us can be any long.

-- 
With Best Regards,
Andy Shevchenko
