Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90060127832
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2019 10:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfLTJc4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Dec 2019 04:32:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34283 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfLTJc4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Dec 2019 04:32:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id l127so4896139pfl.1;
        Fri, 20 Dec 2019 01:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hXPvfKvwAwee7RsrZpIamZ8UANcZvc4/7hzUJ9vWG30=;
        b=ufnVJ3iPxZcZtJ92hsB9jBbHS38GFsw9MyCcx9SHRHdXmWo1pI6ZDU4ZFgZ9JeU7ZS
         j2irv1vy1DCI/tEIMvh7yIDPtZ4T2IudbrsSUY7w2xI/3TNYdhDJNK4F0fqI2AjK4S1B
         DZnLX8Uk0BHcXbzLOK9slVuYcpDEF75U/nEREA0vm3SQj7PKE3i2dUru17xsbs7PGUa+
         uHOr1Rs58B+A9FuO5Dp9W3nhFJ2wYxY31YasiyNKs/k1RteF/C5jxwRfvHem7LcAOi9t
         +DDteb1doMFCbUdUvGAAcbhL1yk50HwuVaCqH7+UjW7Kjt6F/GNcQIPX9MVEwJgoIE42
         UdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXPvfKvwAwee7RsrZpIamZ8UANcZvc4/7hzUJ9vWG30=;
        b=HPtTG0JCTxOaBNgAIsfMmf+tNOeaRwFQ7NhINxvzxBhxfSSSuc8V2q5315PjkjKH2E
         aiKGEWFlL5gaJ4hpBo22WUXTS93EW9ODw+xyWBu/Y2fT1gbtaxlkpCGgp3Jp2O5JwukQ
         1dUgYwR31j78hLrdSMAVveGCZQSD6iCqK6JIpixrcxCQ6S/psee2yA9sMZzUE/6Zecmk
         BXfXig3Tx2il9wo2kW4xaB8eYW+bA2Ku/4VjMVKjJKFWKxr0zBaJ4ZMBS+l909oNGHMd
         TEqCWnUgUhzGX1/qnOdQJkG5np2HkscRP+oab9xZL/PfRFLuBt0VZI198XqV5WarmnKQ
         uzYg==
X-Gm-Message-State: APjAAAWwpY9dpUzpGVRoG7MhYV++Eq9GUzOuMobX9ujt2jHMyj6Qqqrk
        7TNZlSkdmnElOIg4Vgz1rMTmnZc1X5ETp+7G9OA=
X-Google-Smtp-Source: APXvYqy89KLn49Y7AOaiBDwvJUbGIwKrXpVrAXbM6ogcz28z1+7I0//57vSQh5E6i+knbxU9bqCwYbEzCfkP8R4ECrQ=
X-Received: by 2002:a62:1944:: with SMTP id 65mr15366030pfz.151.1576834375318;
 Fri, 20 Dec 2019 01:32:55 -0800 (PST)
MIME-Version: 1.0
References: <20191219041039.23396-1-dan@dlrobertson.com> <20191219041039.23396-3-dan@dlrobertson.com>
 <CAHp75VdVmfAi5hSp23Gn8nm6LmX-Mr5Tnxcbus90DrRL+gVFRA@mail.gmail.com>
 <20191220043220.GA16415@nessie> <CAHp75Vec5ADoFH9KoTnU5+uEZvGqS2+NUN+MLTiwzofDtGG0+A@mail.gmail.com>
In-Reply-To: <CAHp75Vec5ADoFH9KoTnU5+uEZvGqS2+NUN+MLTiwzofDtGG0+A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 20 Dec 2019 11:32:42 +0200
Message-ID: <CAHp75VdzE4uKKJ_5g8eMZR+GSX9W+7Lc+kh2OYt5o7_8_NHTpw@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] iio: (bma400) add driver for the BMA400
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Dec 20, 2019 at 11:27 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Dec 20, 2019 at 6:48 AM Dan Robertson <dan@dlrobertson.com> wrote:
> > On Thu, Dec 19, 2019 at 01:02:28PM +0200, Andy Shevchenko wrote:
> > > On Thu, Dec 19, 2019 at 6:27 AM Dan Robertson <dan@dlrobertson.com> wrote:
>
> > > > +static int bma400_set_accel_output_data_rate(struct bma400_data *data,
> > > > +                                            int hz, int uhz)
> > > > +{
> > > > +       unsigned int idx;
> > > > +       unsigned int odr;
> > > > +       unsigned int val;
> > > > +       int ret;
> > > > +
> > > > +       if (hz >= BMA400_ACC_ODR_MIN_WHOLE_HZ) {
> > > > +               if (uhz || hz % BMA400_ACC_ODR_MIN_WHOLE_HZ)
> > > > +                       return -EINVAL;
> > > > +
> > > > +               val = hz / BMA400_ACC_ODR_MIN_WHOLE_HZ;
> > >
> > > Again, AFAICS division may be avoided in both cases (% and / above)
> > > because of is_power_of_2() check below.
> > > Can you revisit this?
> >
> > Yeah I can update this in the next patchset, but I don't know if it is much more
> > readable this way.
>
> You may describe the algo in the comment.
>
> Let's see how it might look like
>
>   if (uhz)
>     return -EINVAL;
>   idx = __ffs(val);
>   /* We're expecting value to be 2^n * ODR_MIN_WHOLE_HZ */
>   if ((val >> idx) != BMA400_ACC_ODR_MIN_WHOLE_HZ)

Okay, this would require trickier conditional for the cases when
MIN_WHOLE_HZ can be divided by 2^k...
Still from performance point of view it might be much faster than division.

>     retutn -EINVAL;
>   idx += BMA400_ACC_ODR_MIN_RAW + 1;
>
> Would it work?
>
> > > > +               if (!is_power_of_2(val))
> > > > +                       return -EINVAL;
> > > > +
> > > > +               idx = __ffs(val) + BMA400_ACC_ODR_MIN_RAW + 1;

-- 
With Best Regards,
Andy Shevchenko
