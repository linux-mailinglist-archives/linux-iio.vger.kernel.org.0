Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B303635CA
	for <lists+linux-iio@lfdr.de>; Sun, 18 Apr 2021 15:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhDRN7t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Apr 2021 09:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhDRN7s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Apr 2021 09:59:48 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5070C06174A;
        Sun, 18 Apr 2021 06:59:18 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f29so22410867pgm.8;
        Sun, 18 Apr 2021 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1aigIR0BvhKNpJH8HZM077zbfnE53M8nOpQFLBIhB7g=;
        b=po3mbtrmF99BkK13bJXnZv8TaplADbv3EClddd5JPVrfX8fgyUbQyzFpsu87psUfd5
         BVd8q8uq4lqo8azSA73rlyW7J0MfQWn1PxvUSYiGcnNRg7WXl4wednbFtVXLJ7i2cZFU
         PCsy4pbdz3PPl5jJFaz8Aclws6al+32fnBe7VWb9r8gUdJKpZ2A+fnx4/rQbTeOT088x
         gZRB4vfnH87Qs7eh0UbcvIBE0f20Q2vgYKQSp+mN8RRS0Muz05DsE5o06d82EH5LXGVg
         zi/ZkW3ewIiFpLwbsvBSWpXtNctAqwpN2n7bLcMcwuHZ0qEMfSfZwOojsElbX+sBXXGs
         RQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1aigIR0BvhKNpJH8HZM077zbfnE53M8nOpQFLBIhB7g=;
        b=EKPLG5BM9cby+lsUVeXh7Ubr2XHr8IGiCkOkM0zEAT8hrZ4LtZIyCnuTfZ/OnoXU2e
         lE59RqleprlXrS5OXijbb7NUJc4/bk5lGJmgZb9nRZlGGnNjpYwnfYY+432mU3XIryOZ
         slB08dpYNXGfjOH5glInAIHBeBovA59qGUhPrISZj2d28h3muWYA4FJNuXH4/yGE7wnn
         1Dfmm+acAwIbZoR1T5KxAwGYe43dB81imk5dZCq37oJcHXj/zoXQlJ4Pb4oq77gE/V4K
         PYhuZSkwhSS/B9S7TbmAhJ+6GJReO5qo+jahGigurz7Ap/XDWh1T7mImxlvfKVSQnBK2
         SSRg==
X-Gm-Message-State: AOAM531nRRTuJYHX0vx9APlBW+VfbXxvKIHUxCnh97z3YfyS0BSWgH8U
        u7vIp888S7z+I6mHllzvIgv6ju7unr1WyI3wFBQ=
X-Google-Smtp-Source: ABdhPJxNHtSkjTf/uc4V6OunEUsxnheX9vie/SzKpDvK2SiACBWp0QmBU2dNbFKwWpa5Y2sc7habDBL/EytZpNtfN/4=
X-Received: by 2002:a62:5c6:0:b029:24d:e97f:1b1d with SMTP id
 189-20020a6205c60000b029024de97f1b1dmr15917880pff.40.1618754358350; Sun, 18
 Apr 2021 06:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210414195454.84183-1-andriy.shevchenko@linux.intel.com>
 <20210414195454.84183-6-andriy.shevchenko@linux.intel.com>
 <20210418120655.3b2501fc@jic23-huawei> <CAHp75Vcrf02cVaeDevN-cEFFTPoxq6kyO3gGQYTcs-U4yHOFaQ@mail.gmail.com>
In-Reply-To: <CAHp75Vcrf02cVaeDevN-cEFFTPoxq6kyO3gGQYTcs-U4yHOFaQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 18 Apr 2021 16:59:02 +0300
Message-ID: <CAHp75VeRgGcat18p+dN+pbHEYqm+YLGB_06kFEjFsahB2EW9Fw@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] iio: st_sensors: Add lsm9ds0 IMU support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?B?R2HDq3RhbiBBbmRyw6k=?= <rvlander@gaetanandre.eu>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Matija Podravec <matija_podravec@fastmail.fm>,
        Sergey Borishchenko <borischenko.sergey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 18, 2021 at 4:49 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Apr 18, 2021 at 2:07 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> Thanks for review, my answers below.
>
> > On Wed, 14 Apr 2021 22:54:53 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > We can utilize separate drivers for accelerometer and magnetometer,
> > > so here is the glue driver to enable LSM9DS0 IMU support.
> > >
> > > The idea was suggested by Crestez Dan Leonard in [1]. The proposed change
> > > was sent as RFC due to race condition concerns, which are indeed possible.
> >
> > If you are going to mention races, good to give some flavour in here!
>
> I meant that the initial idea is racy due to different devices
> communicating to the same i2c address.
> So, any sequence of transfers are not serialized and you may end up with
>
> drv1 -> i2c
> drv2 -> i2c
> drv1 <- i2c # garbage
>
> > This driver makes me very nervous indeed.
>
> Why?! This one is race free as far as I can see. Or maybe I interpret
> this wrongly and you are talking about initial RFC?
>
> >  I haven't 'found' any places
> > where the fact we'll write the same registers from each of the drivers
> > causes problems (e.g. int pin setup etc) but perhaps I'm missing something.
> >
> > Shall we say that makes me rather keener to get eyes (and thought) on this
> > patch than normal :)
>
> How should I amend the commit message to state:
> 1. First idea (RFC by the link) *is* racy AFAIU
> 2. This one *is not* racy.

I re-read this and now understand better what you meant.
So, it may be that the initial proposal may work without any
amendment, but since I haven't investigated much, I should rather use
the phrase "potentially racy". In my variant it's using one regmap for
both drivers (not two), which makes the register state consistent. Am
I wrong?
Do we have some places where we may write to the same register concurrently?

-- 
With Best Regards,
Andy Shevchenko
