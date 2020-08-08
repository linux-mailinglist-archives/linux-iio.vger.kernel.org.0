Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A281623F93C
	for <lists+linux-iio@lfdr.de>; Sat,  8 Aug 2020 23:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgHHV6k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Aug 2020 17:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgHHV6j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2020 17:58:39 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAED8C061A27
        for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2020 14:58:38 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id w12so5348274iom.4
        for <linux-iio@vger.kernel.org>; Sat, 08 Aug 2020 14:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s1t2lfaQk0rkTR+UCCj+M+q5gcbres1wVwog9hP9D1M=;
        b=io+N8reaIoOxRW0E9XgigMLCSPG90DOUMnVEkr4qEYcOHkVbfCLU/09SEL9hVgNsEc
         u8Fj5HgWdhKp9hR6eOUiKu4B/icHXrHZsUx+Z54yp3VkpCG3B18Kt+3MLB4nBUYgw8Or
         ajJxsa2k0+N+ec0oiM+NaNAdWcTHvSQmRfZu+2LS2tsdSy1C79gViKV6QutT8uMAe8gF
         U7ktob30rtXgH7XHhDTlk9sW5/rWkhSJtfMdharAw8gX9nSZMWRzENV0bgvSCRSkQGgE
         l5vltjjSpMVBgi7+ibQ96zQbjqJiUaCoavLAgUPVhpwA5u7qLrAimx3ymAkIofcB3efx
         0GDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s1t2lfaQk0rkTR+UCCj+M+q5gcbres1wVwog9hP9D1M=;
        b=MtHJyeG+FVXIthpw14PQE3UcC1rP2v8S8g8+uc7wI7gCww53ngxtEUq4SFMVC55Jez
         ayIVUssEzQoC9JKWjnM5Kn4TGTU2C/db0YhOvjZqtokPW3poHhw647UNxlfaMzowOTqX
         G9xLOzqVVTlg0cDtNWDo6+nVjvT5PqZrIerXa/k3+ZDoTHRmtb3DZtF1Vq0MAp1Wetdt
         Ntuf/Kx5Xo5dub8pOnJcinrtRVlN2r2Wrzy/iEkhHfp984vwTLS2lyy80L8jux9tIIko
         TtJuum2MVXdU88/eemb55Kq34t9mVQurdW0R3AQCxj4jjxmS/YdIpwdAWK8chnvQQOWL
         bAuw==
X-Gm-Message-State: AOAM533lnXmsjPIDlbnihZ8txOMWIwf3YDrNlakLT7jJheZhLvt7y5dN
        7HmsoJ4XZy21Au/58TMDOcudWGe4pFDSr6xCAcX4RQ==
X-Google-Smtp-Source: ABdhPJztroBCCsCQrE+r6q62a+gZPZLv+gHslDbOpPdBBALSdvQzgkrF2CpsUBb0HRGN5kd3RKsMlIvmqIqkIzy/Do4=
X-Received: by 2002:a02:8792:: with SMTP id t18mr11928881jai.117.1596923916194;
 Sat, 08 Aug 2020 14:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200808121026.1300375-1-cmo@melexis.com> <20200808121026.1300375-3-cmo@melexis.com>
 <CAHp75VfWk7pCy4Osv0uY0UH4yFS=PRGbE1CNCakuRFTE33SDJg@mail.gmail.com>
In-Reply-To: <CAHp75VfWk7pCy4Osv0uY0UH4yFS=PRGbE1CNCakuRFTE33SDJg@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Sat, 8 Aug 2020 23:57:59 +0200
Message-ID: <CAKv63uv-+r6M=G2rviSedgdCUd_0nzHKWXK363bJNERTQHRYXA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] iio:temperature:mlx90632: Adding extended
 calibration option
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,
I am very sorry you missed them, I thought you saw it (reply on v3 of
the patch). Maybe something happened to that mail, as it contained
link to datasheet, so I will omit it now.

Except for the order, only the remarks below are still open (did you
get the polling trail I did?)

On Sat, 8 Aug 2020 at 22:04, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Sat, Aug 8, 2020 at 3:11 PM Crt Mori <cmo@melexis.com> wrote:
> >
> > For some time the market wants medical grade accuracy in medical range,
> > while still retaining the declared accuracy outside of the medical range
> > within the same sensor. That is why we created extended calibration
> > which is automatically switched to when object temperature is too high.
> >
> > This patch also introduces the object_ambient_temperature variable which
> > is needed for more accurate calculation of the object infra-red
> > footprint as sensor's ambient temperature might be totally different
> > than what the ambient temperature is at object and that is why we can
> > have some more errors which can be eliminated. Currently this temperature
> > is fixed at 25, but the interface to adjust it by user (with external
> > sensor or just IR measurement of the other object which acts as ambient),
> > will be introduced in another commit.
>
> The kernel doc patch should go before this patch.
>
> ...
>
> > +       *ambient_new_raw = (s16)read_tmp;
>
> > +       *ambient_old_raw = (s16)read_tmp;
>
> Sorry, did I miss your answer about these castings all over the patch?
>

These castings are in fact needed. You read unsigned integer, but the
return value is signed integer. Without the cast it did not extend the
signed bit, but just wrote the value to signed. Also I find it more
obvious with casts, that I did not "accidentally" convert to signed.

> ...
>
> > +       ret = regmap_read(regmap, MLX90632_RAM_1(17), &read_tmp);
> > +       ret = regmap_read(regmap, MLX90632_RAM_2(17), &read_tmp);
> > +       ret = regmap_read(regmap, MLX90632_RAM_1(18), &read_tmp);
> > +       ret = regmap_read(regmap, MLX90632_RAM_2(18), &read_tmp);
> > +       ret = regmap_read(regmap, MLX90632_RAM_1(19), &read_tmp);
> > +       ret = regmap_read(regmap, MLX90632_RAM_2(19), &read_tmp);
>
> What so special about these magic 17, 18, 19? Can you provide definitions?
>
When we started 0 to 19 were all open for access, from userspace, then
only 1 and 2 were used with calculations, and now we use 17, 18 and
19. Matter of fact is, I can't provide a descriptive name as it
depends on DSP version and as you can see now within the same DSP
version, also on the ID part. While RAM3 vs RAM1 and RAM2 could be
named RAM_OBJECT1, RAM_OBJECT2, RAM_AMBIENT, knowing our development
that might not be true in the next configuration, so I rather keep the
naming as in the datasheet.

> ...
>
> > +       int tries = 4;
>
> > +       while (tries-- > 0) {
> > +               ret = mlx90632_perform_measurement(data);
> > +               if (ret < 0)
> > +                       goto read_unlock;
> > +
> > +               if (ret == 19)
> > +                       break;
> > +       }
> > +       if (tries < 0) {
> > +               ret = -ETIMEDOUT;
> > +               goto read_unlock;
> > +       }
>
> Please avoid ping-pong type of changes in the same series (similar way
> as for kernel doc), which means don't introduce something you are
> going to change later on. Patch to move to do {} while () should go
> before this one.

OK, will fix that ordering in v5, but will wait till we solve also
above discussions to avoid adding new versions.

>
> --
> With Best Regards,
> Andy Shevchenko

And about that voodoo stuff with numbers:

Honestly, the equation is in the datasheet[1] and this is just making
floating point to fixed point with proper intermediate scaling
(initially I had defines of TENTOX, but that was not desired). There
is no better explanation of this voodoo.
