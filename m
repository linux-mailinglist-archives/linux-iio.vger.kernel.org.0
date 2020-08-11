Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B9A24179E
	for <lists+linux-iio@lfdr.de>; Tue, 11 Aug 2020 09:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgHKHyc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Aug 2020 03:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgHKHyc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Aug 2020 03:54:32 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8DAC06174A
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2020 00:54:31 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t4so9826619iln.1
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2020 00:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z5wWPMoezqlPQW+XdXx9xDErG0vZ5Ug+GxrnTbtmQ7M=;
        b=AWg5Or5YERYKPYus/eM6Psz/6DB+ozbeyIgm5BdkcNrz+qaXydnw5C9h2yoNvdDN5L
         BVwNYvfnGupyhB3fNudXRx17vToJsrp/WuFz7OccXouv5EOMlCDhKyQf7arOLvEgKskr
         CHcdKTyQDaZXTITMAdPG1+EqwrysS4FjRXFq250kG9RyuPLfOcHhaxHzbop867temC91
         HgjqFt4KcdcPJmq7FOCUhWbGmRQXhBFFXtn4eYrvOXDDrYHUFDdiCo79izc/XOb+Nm1G
         ZvIkJlOL1BHQdPwPAOneQ41ySPYmks5pmre/t7gxMA0veF6Q25TcnXlzhJ/O5GfmhkfZ
         IhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z5wWPMoezqlPQW+XdXx9xDErG0vZ5Ug+GxrnTbtmQ7M=;
        b=KU21GDPF45oPGeG0S2hkz5T3jxxpaz9GW/tPSDZzZpqCZP0pQfgBEnUvja7xjlXTgr
         zgUrN3jxGB4bmvVEYRJR7d4iKwuu3U1pIIDymy5xVCEWv2x4mF+DCtrxIoYH57HlBoKu
         m/XHcIVkDDZZ/c16jnTDfl/3G6L4m7SSYyfxWZQjE6JFN6dgb0fRFO9g1+1jr9LL9+EH
         kgWoHMqq6431qxFgpwlEjn7Zc7GHWpJKZhI/m0eat3rBjSs4LaFlwqg/WMTyKEBUtne0
         riivPu5NtkDPSD2ScEFLkAl03ybJ0nlnP8QznX2AQTiEyiS7rw4KPGdYAPniJVSQSrZU
         OOYw==
X-Gm-Message-State: AOAM532SUH4vv69gA9mmNpMunzppSJNT++EEZUvmjBr+dyXUvgChTkbL
        vcieaPl7jkRBUpiV3nU6IJWpWDpnYVdKUnULCoK4Og==
X-Google-Smtp-Source: ABdhPJxwBM5O2lPH+oGFjeL1pKcmpnayR8cPQmg3NDuJvttcswQ8j93D3BnivaApSCPbShY8CtutkgmYHtHlOc5nIKM=
X-Received: by 2002:a92:cb12:: with SMTP id s18mr5277285ilo.13.1597132470806;
 Tue, 11 Aug 2020 00:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200808121026.1300375-1-cmo@melexis.com> <20200808121026.1300375-3-cmo@melexis.com>
 <CAHp75VfWk7pCy4Osv0uY0UH4yFS=PRGbE1CNCakuRFTE33SDJg@mail.gmail.com>
 <CAKv63uv-+r6M=G2rviSedgdCUd_0nzHKWXK363bJNERTQHRYXA@mail.gmail.com>
 <20200809143222.4e19ea38@archlinux> <CAKv63uu1cRVCujM0nR5BstDYLZnCuGQTeFxhyUF0QK0mr0hvkQ@mail.gmail.com>
In-Reply-To: <CAKv63uu1cRVCujM0nR5BstDYLZnCuGQTeFxhyUF0QK0mr0hvkQ@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Tue, 11 Aug 2020 09:53:55 +0200
Message-ID: <CAKv63uuVYS5isAnhBzcqOJEJWhD5muSDBJzvYoJk1KkucrRnDA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] iio:temperature:mlx90632: Adding extended
 calibration option
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 9 Aug 2020 at 23:05, Crt Mori <cmo@melexis.com> wrote:
>
> On Sun, 9 Aug 2020 at 15:32, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Sat, 8 Aug 2020 23:57:59 +0200
> > Crt Mori <cmo@melexis.com> wrote:
> >
> > > Hi,
> > > I am very sorry you missed them, I thought you saw it (reply on v3 of
> > > the patch). Maybe something happened to that mail, as it contained
> > > link to datasheet, so I will omit it now.
> > >
> > > Except for the order, only the remarks below are still open (did you
> > > get the polling trail I did?)
> > >
> > > On Sat, 8 Aug 2020 at 22:04, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > >
> > > > On Sat, Aug 8, 2020 at 3:11 PM Crt Mori <cmo@melexis.com> wrote:
> > > > >
> > > > > For some time the market wants medical grade accuracy in medical range,
> > > > > while still retaining the declared accuracy outside of the medical range
> > > > > within the same sensor. That is why we created extended calibration
> > > > > which is automatically switched to when object temperature is too high.
> > > > >
> > > > > This patch also introduces the object_ambient_temperature variable which
> > > > > is needed for more accurate calculation of the object infra-red
> > > > > footprint as sensor's ambient temperature might be totally different
> > > > > than what the ambient temperature is at object and that is why we can
> > > > > have some more errors which can be eliminated. Currently this temperature
> > > > > is fixed at 25, but the interface to adjust it by user (with external
> > > > > sensor or just IR measurement of the other object which acts as ambient),
> > > > > will be introduced in another commit.
> > > >
> > > > The kernel doc patch should go before this patch.
> > > >
> > > > ...
> > > >
> > > > > +       *ambient_new_raw = (s16)read_tmp;
> > > >
> > > > > +       *ambient_old_raw = (s16)read_tmp;
> > > >
> > > > Sorry, did I miss your answer about these castings all over the patch?
> > > >
> > >
> > > These castings are in fact needed. You read unsigned integer, but the
> > > return value is signed integer. Without the cast it did not extend the
> > > signed bit, but just wrote the value to signed. Also I find it more
> > > obvious with casts, that I did not "accidentally" convert to signed.
> >
> > Should we perhaps be making this explicit for the cases where we
> > are sign extending?  That doesn't include these two as the lvalue
> > is s16, but does include some of the others.
> >
> > sign_extend32(read_tmp, 15)
> >
>
> So for you lines like
> s32 read;
> read = (read + (s16)read_tmp) / 2;
>
> would actually be better as:
> read = (read + sign_extend32(read_tmp, 15)) / 2;
>
> Hm, strange. I would read that more align the read_tmp to 32 bit than
> the value you have in read_tmp is actually a signed 16 bit integer...
>

OK, I did some trails without the casts and had deja-vu from the first
series of patches I submitted.  I noticed that without a cast the
value that ends up in variable is not extended to signed, but it is
unsigned value truncated. This same finding leads to have these casts
already in current ambient and object raw read functions.

So now only debate is if sign_extend32 is useful in this case, as read
in the current case is 32 bit (before it was also 16 bit).

My preference is to leave unified across the driver.

> > >
> > > > ...
> > > >
> > > > > +       ret = regmap_read(regmap, MLX90632_RAM_1(17), &read_tmp);
> > > > > +       ret = regmap_read(regmap, MLX90632_RAM_2(17), &read_tmp);
> > > > > +       ret = regmap_read(regmap, MLX90632_RAM_1(18), &read_tmp);
> > > > > +       ret = regmap_read(regmap, MLX90632_RAM_2(18), &read_tmp);
> > > > > +       ret = regmap_read(regmap, MLX90632_RAM_1(19), &read_tmp);
> > > > > +       ret = regmap_read(regmap, MLX90632_RAM_2(19), &read_tmp);
> > > >
> > > > What so special about these magic 17, 18, 19? Can you provide definitions?
> > > >
> > > When we started 0 to 19 were all open for access, from userspace, then
> > > only 1 and 2 were used with calculations, and now we use 17, 18 and
> > > 19. Matter of fact is, I can't provide a descriptive name as it
> > > depends on DSP version and as you can see now within the same DSP
> > > version, also on the ID part. While RAM3 vs RAM1 and RAM2 could be
> > > named RAM_OBJECT1, RAM_OBJECT2, RAM_AMBIENT, knowing our development
> > > that might not be true in the next configuration, so I rather keep the
> > > naming as in the datasheet.
> > Normal solution for that is to version the defines as well.
> >
> > MLX90632_FW3_RAM_1_AMBIENT etc
> > When a new version changes this, then you introduced new defines to
> > support that firmware.
> >
>
> OK will add those, but it is ending up as:
> MLX90632_RAM_DSP5_AMBIENT
> MLX90632_RAM_DSP5_EXTENDED_AMBIENT
> MLX90632_RAM_DSP5_OBJECT_1
> MLX90632_RAM_DSP5_EXTENDED_OBJECT_1
> MLX90632_RAM_DSP5_OBJECT_2
> MLX90632_RAM_DSP5_EXTENDED_OBJECT_2
>
> ok?
> > >
> > > > ...
> > > >
> > > > > +       int tries = 4;
> > > >
> > > > > +       while (tries-- > 0) {
> > > > > +               ret = mlx90632_perform_measurement(data);
> > > > > +               if (ret < 0)
> > > > > +                       goto read_unlock;
> > > > > +
> > > > > +               if (ret == 19)
> > > > > +                       break;
> > > > > +       }
> > > > > +       if (tries < 0) {
> > > > > +               ret = -ETIMEDOUT;
> > > > > +               goto read_unlock;
> > > > > +       }
> > > >
> > > > Please avoid ping-pong type of changes in the same series (similar way
> > > > as for kernel doc), which means don't introduce something you are
> > > > going to change later on. Patch to move to do {} while () should go
> > > > before this one.
> > >
> > > OK, will fix that ordering in v5, but will wait till we solve also
> > > above discussions to avoid adding new versions.
> > >
> > > >
> > > > --
> > > > With Best Regards,
> > > > Andy Shevchenko
> > >
> > > And about that voodoo stuff with numbers:
> > >
> > > Honestly, the equation is in the datasheet[1] and this is just making
> > > floating point to fixed point with proper intermediate scaling
> > > (initially I had defines of TENTOX, but that was not desired). There
> > > is no better explanation of this voodoo.
> >
> > We all love fixed point arithmetic :)
> >
> > Jonathan
