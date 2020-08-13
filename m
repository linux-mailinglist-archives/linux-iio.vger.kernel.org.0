Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1E6243F64
	for <lists+linux-iio@lfdr.de>; Thu, 13 Aug 2020 21:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgHMTlE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Aug 2020 15:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgHMTlE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Aug 2020 15:41:04 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DB5C061757;
        Thu, 13 Aug 2020 12:41:03 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ha11so3240353pjb.1;
        Thu, 13 Aug 2020 12:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ItWqBHS3w4jy5wn4p04F1o5bOPDbMS03wqOneXGD2w=;
        b=pAvjxfRpO04XR0yxwLloK2cUKe3FTLgE9OBjc/0k39x1lb1VE0hjqlv+bvc9IkffKw
         ohcZ3HcTN/J8jKsJH9UMIWVs7yDAxfq4TtxmlItOeQALNzNb4cADGB1vllk2emMv8g3t
         /9+YiQOL+Nz0jnrED0b5TpDp1E7u0A23uI6+oDawQzCGa2KcpTS/MT1pNJBZL6UT1gCK
         uosSAPCvfaxgsNJSdVNtnhUtiZv9wIe2dPOBMe9ogrU7jbmCzgFQtmzUdCChbvG2VefL
         coajWmbmOZRNc7x4+5l4hEWmOsI8QjEA+7+uCwh+Hg/PFsojVsjnXfYSb8QxwfDwrlzk
         LYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ItWqBHS3w4jy5wn4p04F1o5bOPDbMS03wqOneXGD2w=;
        b=TGKNCoD+QrLXvPMLXKRobEpcZCvxZRL3puEgZ7lhnIlnP1U2gsuP5pGCReZRJ15dzw
         jszu31eBuKRqz/eOSDq0qKJBW2FnUC/NVZdylACjgZvWHGhDzG9E8BI0Fyoz5Hm/3iJY
         NU75TAqskhCVwt6QoAF/tYyicgcAESPDDme4fIQ7Q38rX/VcmhPTiftJH5NIsAJlxnxH
         C3PKnivu+sB/vGgPgwh1+fv0KG0hbHssIBUk3iXSu4vwvFDqctw7mOca8STmO8VBCU/0
         HT7mYRXEo6bHP1LgdyGeKQDC+mzH39XxGmYj4c44/lhZp9l2ND3K5v53In+yfrGeRiok
         u7Rg==
X-Gm-Message-State: AOAM5308Ao5jQ/C2DAij7JkYGKgaf9uhPLRI054uz56eiDjmOsYOb/pA
        tBHsKoW6IDhIWlGI8WeiTzCudz4aScSxLH1UYRP8foVUbfc=
X-Google-Smtp-Source: ABdhPJy2rnCAGpf1YLxMoHo84kHU8QJ01pqvdjAcecx4qOd6Y0/r5k9Cv9x3aJSz/r4b2d9pfVtmJUAeffc+M2z0AYw=
X-Received: by 2002:a17:90b:509:: with SMTP id r9mr4074225pjz.228.1597347663347;
 Thu, 13 Aug 2020 12:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200813075125.4949-1-cmo@melexis.com> <20200813075125.4949-4-cmo@melexis.com>
 <CAHp75VfNwb5uBp=H0295LEJjXy1+=V5yvSN1PHbtMYzgg=_EAA@mail.gmail.com>
 <CAKv63uv=b60B9RXBJF4HEhMOowu-qbGrv7LsmJVvkkERSida-A@mail.gmail.com>
 <CAHp75Vd+3SopKog6uhSKoOLn+tECsQfs7kRbJsrMZEbNRpk8bQ@mail.gmail.com> <CAKv63usrjEHTmYtahedqULnqu-fM3TFC8HJ=S4h+w=UTv5sd-Q@mail.gmail.com>
In-Reply-To: <CAKv63usrjEHTmYtahedqULnqu-fM3TFC8HJ=S4h+w=UTv5sd-Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 13 Aug 2020 22:40:47 +0300
Message-ID: <CAHp75VeH5SA2KeiTSN__8ndj1v_SEb7mEWPG1p2Lz-tATDWi8A@mail.gmail.com>
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

On Thu, Aug 13, 2020 at 4:04 PM Crt Mori <cmo@melexis.com> wrote:
> On Thu, 13 Aug 2020 at 13:24, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Thu, Aug 13, 2020 at 2:14 PM Crt Mori <cmo@melexis.com> wrote:
> > > On Thu, 13 Aug 2020 at 13:03, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > On Thu, Aug 13, 2020 at 10:53 AM Crt Mori <cmo@melexis.com> wrote:

...

> > > > I don't see how it prevents using iopoll.h. It uses usleep_range()
> > > > under the hood in the same way you did here, but open coded.
> > > >
> > >
> > > One loop is indeed 10ms and that is not the problem, the problem is
> > > that timeout is at least 3 calls of this data ready (3 channels), so
> > > that is at minimum 30ms of timeout, or it could even be 4 in worse
> > > case scenario and that is outside of the range for usleep to measure.
> > > So in case of the other loop, where we wait 200ms for channel refresh
> > > it is also out of scope. Timeout should be in number of tries or in
> > > msleep range if you ask me.
> >
> > I still didn't buy it. You have in both cases usleep_range(). Why in
> > your case it's okay and in regmap_read_poll_timeout() is not?
> >
>
> I tried and it did not work, so then I read the manual. Looking into
>
> * regmap_read_poll_timeout_atomic - Poll until a condition is met or a
> timeout occurs

Why _atomic?!

> ...
>  * @delay_us: Time to udelay between reads in us (0 tight-loops).
>  *            Should be less than ~10us since udelay is used
>  *            (see Documentation/timers/timers-howto.rst).
>  * @timeout_us: Timeout in us, 0 means never timeout
>
>
> So I went to read Documentation/timers/timers-howto.rst
>
> SLEEPING FOR ~USECS OR SMALL MSECS ( 10us - 20ms):
> * Use usleep_range
>
> - Why not msleep for (1ms - 20ms)?
> Explained originally here:
> http://lkml.org/lkml/2007/8/3/250
>
> msleep(1~20) may not do what the caller intends, and
> will often sleep longer (~20 ms actual sleep for any
> value given in the 1~20ms range). In many cases this
> is not the desired behavior.
>
> Since I am above the 20ms range, it is too much for usleep_range and
> that proved to be a case as I got -ETIMEOUT and the desired channels
> were not read.
> > > > ...
> > > >
> > > > > -       while (tries-- > 0) {
> > > > > +       do {
> > > > >                 ret = regmap_read(data->regmap, MLX90632_REG_STATUS,
> > > > >                                   &reg_status);
> > > > >                 if (ret < 0)
> > > > >                         return ret;
> > > > > -               if (reg_status & MLX90632_STAT_DATA_RDY)
> > > > > -                       break;
> > > > >                 usleep_range(10000, 11000);

You use here usleep_range(). The same is used for
regmap_read_poll_timeout(). What's the difference?

Since it uses 1/4 of the range you probably need to update tries and
timeout_us to make it work.

> > > > > -       }
> > > > > +       } while (!(reg_status & MLX90632_STAT_DATA_RDY) && tries--);
> > > > >
> > > > >         if (tries < 0) {
> > > > >                 dev_err(&data->client->dev, "data not ready");

-- 
With Best Regards,
Andy Shevchenko
