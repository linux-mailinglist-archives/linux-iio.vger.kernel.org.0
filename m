Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15ACD23F74B
	for <lists+linux-iio@lfdr.de>; Sat,  8 Aug 2020 13:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgHHLDT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Aug 2020 07:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgHHLDP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2020 07:03:15 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A805CC061756
        for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2020 04:03:14 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id g14so4416423iom.0
        for <linux-iio@vger.kernel.org>; Sat, 08 Aug 2020 04:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/rMjSitKg11eWPrP47+bEiCSiGgxhZYLQp+NPvYTWSg=;
        b=AAQsFxUZzjPjP58Czuy0igxPeageuNQz9VKT+d7KEu84BQUloDHnUxHG5aSrIuv4tl
         L4NJfC5gfMA6GxqhpBxsDoPyh4cmuUh8l9j6/Ej/1pHH4/fYoJ5qr3ocSVHYpZnf4SQl
         rQQfDWoZf15coMoTh8sSIfNEG5/DFJ9Q0F95JnBZ4vuDu2VuU8j2K+tQDMG4HqLPNseo
         nCt6iM8xRe+9kLaXrLhdNu19DRUmlBDR09X0p2qfAjYzv3ewgm1qeqkpRRcefBCfLy8y
         jk/cT+ZTqigOvbaMXb3naebZvLVM01Cg/No256aHol+sTGuXkMRuUpONktFBQJJyu6TB
         JOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/rMjSitKg11eWPrP47+bEiCSiGgxhZYLQp+NPvYTWSg=;
        b=KpzhryBcohHtQvpiGMEdW5YSSUIohzLMLI8ZNy/7WG8FEPgG+DadzQAv2TsXZ5AdAK
         Hz8cQJ3h//BGzKUVDoXqY7m1DpjlCBHr6CA9+EhucA1fzN2gaGgo9xGQUVdTxj4WsFPM
         RqmXOuBjMrQZ7ZcuHTg3pyuiQ3f/t4Y2zyRpIz4lVYFwwPii/8sv0AMyWpifQp1HsAdh
         hYr8acehQe+EZrull0DZZIwrX7+NQzLeQsdAK0FhrO9QSyYhCDhW9rfkRH+W8TzIMPqx
         zRCW0LBOdiRaI1L4tqCq9bHIszT5Mmje/iijadvUHJ5R1PHbeovtWLKvHMrB6ps8t1xn
         azuQ==
X-Gm-Message-State: AOAM533MwePxniU9oi6ESR7PYKr4QTcYOPlQHfdlgiKOWkar2Ts6BnvO
        7y8OITsaGPwMDFC4stB8aV/zn9xmuyN8rmdgyaVHlA==
X-Google-Smtp-Source: ABdhPJw016ghdVx3H93Lg91jwmBjuZpsTWBPtK5Ylvr4itcW65kL6CAOEtz+n6hrSNbg7J8R9q6MYYntQcop+LqUCac=
X-Received: by 2002:a05:6638:1027:: with SMTP id n7mr9657134jan.86.1596884592900;
 Sat, 08 Aug 2020 04:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200807232104.1256119-1-cmo@melexis.com> <20200807232104.1256119-3-cmo@melexis.com>
 <CAHp75VemS+QJ+m05KVNobYyzbqB-hcBdbLK1YbiaZWbAFJ9xfw@mail.gmail.com>
In-Reply-To: <CAHp75VemS+QJ+m05KVNobYyzbqB-hcBdbLK1YbiaZWbAFJ9xfw@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Sat, 8 Aug 2020 13:02:37 +0200
Message-ID: <CAKv63ustKRyeas=Kt7pHi9=7ZND1wy8quS6LVTy7Ax7+=k-S1g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio:temperature:mlx90632: Adding extended
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

On Sat, 8 Aug 2020 at 12:44, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Sat, Aug 8, 2020 at 2:24 AM Crt Mori <cmo@melexis.com> wrote:
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
> Thank you for an update!
> My comments below.
>

Will provide next version with changelog as well.

> ...
>
> >  struct mlx90632_data {
> >         struct i2c_client *client;
> >         struct mutex lock; /* Multiple reads for single measurement */
> >         struct regmap *regmap;
> >         u16 emissivity;
> > +       u8 mtyp; /* measurement type - to enable extended range calculations */
> > +       u32 object_ambient_temperature;
> >  };
>
> As a separate patch to have a kernel doc for this, there are plenty of
> examples in the kernel, but I will show below an example
>
> /**
>  * struct foo - private data for the MLX90632 device
>  * @client: I2C client of the device
>  * @bar: ...
>  ...
>  */
> struct foo {
>   struct i2c_client *client;
>   ... bar;
>   ...
> };
>
> ...
>
> > +       if ((type != MLX90632_MTYP_MEDICAL) && (type != MLX90632_MTYP_EXTENDED))
> > +               return -EINVAL;
>
> So, just to point out what the difference between & and &&  (even for
> boolean): the former one forces both sides of operand to be executed,
> while && checks for only first in case of false.
>

OK, I am OK with evaluating first only. I mostly thought it is boolean
vs bitwise, but I keep on learning.

> ...
>
> > +static int mlx90632_read_ambient_raw_extended(struct regmap *regmap,
> > +                                             s16 *ambient_new_raw, s16 *ambient_old_raw)
> > +{
> > +       unsigned int read_tmp;
> > +       int ret;
> > +
> > +       ret = regmap_read(regmap, MLX90632_RAM_3(17), &read_tmp);
> > +       if (ret < 0)
> > +               return ret;
> > +       *ambient_new_raw = (s16)read_tmp;
>
> Again the same question, do you need all these castings?
>

These castings are in fact needed. You read unsigned integer, but the
return value is signed integer. Without the cast it did not extend the
signed bit, but just wrote the value to signed. Also I find it more
obvious with casts, that I did not "accidentally" convert to signed.

> > +       ret = regmap_read(regmap, MLX90632_RAM_3(18), &read_tmp);
>
> These 17, 18 and 19 should be defined with descriptive names.
>

When we started 0 to 19 were all open for access, from userspace, then
only 1 and 2 were used with calculations, and now we use 17, 18 and
19. Matter of fact is, I can't provide a descriptive name as it
depends on DSP version and as you can see now within the same DSP
version, also on the ID part. While RAM3 vs RAM1 and RAM2 could be
named RAM_OBJECT1, RAM_OBJECT2, RAM_AMBIENT, knowing our development
that might not be true in the next configuration, so I rather keep the
naming as in the datasheet.

> > +       if (ret < 0)
> > +               return ret;
> > +       *ambient_old_raw = (s16)read_tmp;
> > +
> > +       return 0;
> > +}
>
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
> Again, please use
>
> unsigned int tries = 4; // or should be 5?
>
> do {
>   ...
> } while (ret != ..._ LAST_CHANNEL && --tries);
> if (!tries)
>   ...
>
> It will really make the code easier to read.
>

I thought of keeping it consistent with the existing implementation in
the perform_measurement function. If you still insist in the loop
change, then I think it is better if I provide a followup patch that
changes both these loops.

> ...
>
> > +static s64 mlx90632_preprocess_temp_obj_extended(s16 object_new_raw, s16 ambient_new_raw,
> > +                                                s16 ambient_old_raw, s16 Ka)
> > +{
> > +       s64 VR_IR, kKa, tmp;
> > +
> > +       kKa = ((s64)Ka * 1000LL) >> 10ULL;
> > +       VR_IR = (s64)ambient_old_raw * 1000000LL +
> > +               kKa * div64_s64((s64)ambient_new_raw * 1000LL,
> > +                               MLX90632_REF_3);
> > +       tmp = div64_s64(
> > +                       div64_s64((s64) object_new_raw * 1000000000000LL, MLX90632_REF_12),
> > +                       VR_IR);
> > +       return div64_s64(tmp << 19ULL, 1000LL);
> > +}
>
> It would be nice to have a comment on this voodoo arithmetics.
>

Honestly, the equation is in the datasheet[1] and this is just making
floating point to fixed point with proper intermediate scaling
(initially I had defines of TENTOX, but that was not desired). There
is no better explanation of this voodoo.

> --
> With Best Regards,
> Andy Shevchenko

[1] https://www.melexis.com/-/media/files/documents/datasheets/mlx90632-datasheet-melexis.pdf
