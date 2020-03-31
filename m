Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62DB319946C
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 12:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgCaK4l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 06:56:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36680 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730410AbgCaK4l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 06:56:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id c23so1797919pgj.3;
        Tue, 31 Mar 2020 03:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UTtHrNU5LzWuuToKx4rO2ORYgVK3pfVrzoDsMYbSSFk=;
        b=t6w3POTN/j3iSn5Qw6KJGzuBljRD/rguLo5r2495D3BfxURl+HxCLhInI88NWTIwCd
         jkrbsfXef3vzpZgmIXHHPYheHwHPSmkpLxApYEaVW5wRSV4BWIl+Xvxx4+cowVVlF/hK
         whbiMArrCv8m0RW0u5udo0K91mcljCO9N+/a9FdW+EhyO50bEJHhluN5N9GiqRi9+oAd
         ri/XJji7OiFNKUItD53WTsju6rIUm929C8q/ZgarddZ/lg+ZFkssBgkngtw4+ujDBzl6
         WxluL7t/yRGTHd8/Tc71L6sSJ6nEi2YLtszzWlGJEOS/Vuyk9qZRkKzNPm4m0lgsuYKL
         7vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UTtHrNU5LzWuuToKx4rO2ORYgVK3pfVrzoDsMYbSSFk=;
        b=rl9DmwNS5LKdOWwJmRF4smVWWQuCVDNw7ORqUP1AXlLOsSGYsui7C7YfYZ3ObPyxsB
         uGIYbD+OEPGrEuEuD12+LKhPjVQ5PB/4cZ9DOTdxN5GsO9E1lfO6mtRqsD9bjDD3Ucii
         6xz9CbIw+6x1CiXuEqxRtKS03kIkC6JOkLzT6ztdCqjVSBO0VRJcbIAfpGPDuEoQTUqY
         rgP4jEx+Ah1BZqCu1xNLomGaS5juaB07nsrbWJTwS/WTLuIcfs0q2xlWhoFvU0ybs4ui
         PsuF2vPh9MgkyPQaoECWqfpVbYZ/JAQyLu1C65DNy0A8Tj9j5UlkOVUIpCoFaH7R2sW0
         dHbA==
X-Gm-Message-State: AGi0PuZgx7Ly3qwSC3eWBsMlKdPVDmct+O9aGIErBuOPigRt+0BDdrxq
        1iQTEc5pdfjvuJj0YMqqWmLBNdJ8UKZ3ZE57RB4=
X-Google-Smtp-Source: APiQypK4967Yz3wvCe1oAOumRP/nk49TIrQmH1L64tCyCNI5Hwunx0suz5YhTj1EwTTQSNkwAm4ZE99/Vn3wVK6FZJ8=
X-Received: by 2002:a63:7b1d:: with SMTP id w29mr3546845pgc.4.1585652199992;
 Tue, 31 Mar 2020 03:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200317135649.8876-1-michael.auchter@ni.com> <20200317145113.12413-1-michael.auchter@ni.com>
 <CAHp75Veh3QRfqVFOpYbuuxcPqirc1_YrF-iZfRjNsYk7DWqYpQ@mail.gmail.com> <20200330201243.GA22106@xaphan>
In-Reply-To: <20200330201243.GA22106@xaphan>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 31 Mar 2020 13:56:32 +0300
Message-ID: <CAHp75VcEAgrRREjT867xDAXVqr6q9CR-pB5keCj2+-AdqjFYVA@mail.gmail.com>
Subject: Re: Re: [PATCH v2 1/2] iio: adc: ad7291: convert to device tree
To:     Michael Auchter <michael.auchter@ni.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 30, 2020 at 11:12 PM Michael Auchter <michael.auchter@ni.com> wrote:
> On Sun, Mar 22, 2020 at 01:46:21AM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 17, 2020 at 4:53 PM Michael Auchter <michael.auchter@ni.com> wrote:

...

> > > +       chip->reg = devm_regulator_get_optional(&client->dev, "vref");
> > > +       if (!IS_ERR(chip->reg)) {
> >
> > Why not to go with usual positive conditional?
>
> I took this pattern from ad7266.c which Lars pointed me to. I agree that
> a positive conditional here would probably be more natural. I'll change
> that if you'd prefer.

Yes, please do.

...

> > > +               .of_match_table = of_match_ptr(ad7291_of_match),
> >
> > No need to use of_match_ptr(). Haven't you got a compiler warning in !OF case?
>
> Hm, no warning as far as I can see with !OF...

Have you used `make W=1 ...`? With it you should get a warning that
table defined but not used.

> but agreed that this
> doesn't make much sense as-is.
>
> Is dropping of_match_ptr() the preferred route here? The driver doesn't
> depend on OF, so it seems like keeping of_match_ptr and instead guarding
> the ad7291_of_match table with #ifdef CONFIG_OF would be preferred. Of
> course, maybe that's not worth it for saving some bytes from the final
> image.

You need either both (of_match_ptr() _and_ ugly ifdeffery, and note
you will need of.h for that) or none (mod_devicetable.h maybe needed,
though).

> Let me know which route would be preferred.

If we would like to use this in non-DT environment, then drop all that
OF-specific stuff.

-- 
With Best Regards,
Andy Shevchenko
