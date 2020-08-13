Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558D924394D
	for <lists+linux-iio@lfdr.de>; Thu, 13 Aug 2020 13:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgHMLYk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Aug 2020 07:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgHMLYj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Aug 2020 07:24:39 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51F5C061757;
        Thu, 13 Aug 2020 04:24:39 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u20so2673939pfn.0;
        Thu, 13 Aug 2020 04:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/zriuZjSj9xj6/8fSPTT22Tss8liWtUy8xFTyXoU7yc=;
        b=RACy3nGsdFg0Fh3cY1pec6ZHDW/idUPIscW7C7rGAtfhfrk2GlEu8kdWw8GDTL/G/Y
         rVdyGUPjUVFmoEhwXIr9z8/k38tx4oN6Ut4CFvLnGAh3rUh002GwkI19Nhc1qYZ+uzQy
         kJn89akKBKKHXmtgHaW8l8/ExET1IIekAdK9+IE/abe+2LLEpIFKX8/MpUTbz0k8B60S
         NrMBsmzNjXEYhtnK7YKITD4cptUUgXOnx70nPvxWy5yias6o2/3Al8HeoRAGD52fYVei
         rw70CEvdwLEzp9I4hnM0ydJ+mFUgCeAZaF3AcQYspu+XRMPRbiHqfOR7pI5gX77lW5EI
         ZBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zriuZjSj9xj6/8fSPTT22Tss8liWtUy8xFTyXoU7yc=;
        b=PpKiva4s5uaHttXjXMcXZTSWLxkeW8Ju4Tsvl+YLQG7mPys/Gs2hj7U576IqD1NHYF
         kkujU8dzADy2h9sj9+kJI+rZMxVs4NodOwtP0dF4LGL4fjsm+akt95BPbW1LlvToxz9s
         XiN+S5pq7egbsz4pgwNmhmLdEFwSCUQXPWLJBV8ElhNYrvCgMFh06PCXMLZiWiX7MNcq
         R9IeCtsvYadId82zwC6BWyzvSHTchJ0J8K4Bb+TAaMxZEWkmZ/6lzL+AEzj8T9NJlk7t
         a4ZnEyyvY0pMpeUw/0x1KDNiGh7ZYkS42TxMfJPPDycz0rqkMpi1nFQnW7x8b3o4qD4d
         W26g==
X-Gm-Message-State: AOAM532kDnqswv3IybmSNFlWv+NOl1p2S2TfPPCIb1Rb2q8h7M1MhiZ2
        st5Jg24YTbwPMA2n0SUg4sGdaL+V42MTTrBd9bNHQWT9zts=
X-Google-Smtp-Source: ABdhPJzIkZApoDQ5oXbvk6Qqc/hVXxYMbJMPBQWt6vVX9AgOrIwlDctn2NxT7KNHfIDV7wXWA8f3BSG/ZvRAcfZP3j4=
X-Received: by 2002:a63:f24a:: with SMTP id d10mr3188515pgk.4.1597317879199;
 Thu, 13 Aug 2020 04:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200813075125.4949-1-cmo@melexis.com> <20200813075125.4949-4-cmo@melexis.com>
 <CAHp75VfNwb5uBp=H0295LEJjXy1+=V5yvSN1PHbtMYzgg=_EAA@mail.gmail.com> <CAKv63uv=b60B9RXBJF4HEhMOowu-qbGrv7LsmJVvkkERSida-A@mail.gmail.com>
In-Reply-To: <CAKv63uv=b60B9RXBJF4HEhMOowu-qbGrv7LsmJVvkkERSida-A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 13 Aug 2020 14:24:23 +0300
Message-ID: <CAHp75Vd+3SopKog6uhSKoOLn+tECsQfs7kRbJsrMZEbNRpk8bQ@mail.gmail.com>
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

On Thu, Aug 13, 2020 at 2:14 PM Crt Mori <cmo@melexis.com> wrote:
>
> On Thu, 13 Aug 2020 at 13:03, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >
> > On Thu, Aug 13, 2020 at 10:53 AM Crt Mori <cmo@melexis.com> wrote:
> > >
> > > Reduce number of lines and improve readability to convert polling while
> > > loops to do-while. The iopoll.h interface was not used, because we
> > > require more than 20ms timeout, because time for sensor to perform a
> > > measurement is around 10ms and it needs to perform measurements for each
> > > channel (which currently is 3).
> >
> > I don't see how it prevents using iopoll.h. It uses usleep_range()
> > under the hood in the same way you did here, but open coded.
> >
>
> One loop is indeed 10ms and that is not the problem, the problem is
> that timeout is at least 3 calls of this data ready (3 channels), so
> that is at minimum 30ms of timeout, or it could even be 4 in worse
> case scenario and that is outside of the range for usleep to measure.
> So in case of the other loop, where we wait 200ms for channel refresh
> it is also out of scope. Timeout should be in number of tries or in
> msleep range if you ask me.

I still didn't buy it. You have in both cases usleep_range(). Why in
your case it's okay and in regmap_read_poll_timeout() is not?

> > ...
> >
> > > -       while (tries-- > 0) {
> > > +       do {
> > >                 ret = regmap_read(data->regmap, MLX90632_REG_STATUS,
> > >                                   &reg_status);
> > >                 if (ret < 0)
> > >                         return ret;
> > > -               if (reg_status & MLX90632_STAT_DATA_RDY)
> > > -                       break;
> > >                 usleep_range(10000, 11000);
> > > -       }
> > > +       } while (!(reg_status & MLX90632_STAT_DATA_RDY) && tries--);
> > >
> > >         if (tries < 0) {
> > >                 dev_err(&data->client->dev, "data not ready");

-- 
With Best Regards,
Andy Shevchenko
