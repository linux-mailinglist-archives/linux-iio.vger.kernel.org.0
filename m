Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9485A234891
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jul 2020 17:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgGaPmG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jul 2020 11:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgGaPmF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jul 2020 11:42:05 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9A4C061574;
        Fri, 31 Jul 2020 08:42:05 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a9so7616166pjd.3;
        Fri, 31 Jul 2020 08:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xPAf+0yy2ZlHtMa5ZnoGgULR1tZaCKmjHqaKAapeiYE=;
        b=P9SusStEhBevVJFpyIwzCSJhXC0IF23IbxXJG5RUH3Lo0cOgXcfs9zNejxYvCaUJma
         1aSRYCOEw6xfCbaMKqEG1OMIairUU0As7lC29/kyNkmpknvKHQIFlMK01c0WjzANlvoS
         8v7ToKIeIsXO8O/KUeruKvlVecTG7Nvr/Ndz1yt9A+lpE9cpUAnOlckY3Wjm4fU3Owpg
         K0ZsEO3QjXyG2bQHV/oKcMcCWfjs/NoZmAD7SZzfY22ucXF9jJxSqZEwTUtrxhJ1k2Pt
         PF4BOVkyl9ZozstvXLWBGIXGlnHYXKXFAJs0YjpzA4j4pv55IyB+xOw3NpR9fOoFq6tk
         ox+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xPAf+0yy2ZlHtMa5ZnoGgULR1tZaCKmjHqaKAapeiYE=;
        b=HUirnGBVuz3nL9uFjSbQiIUTheGA1IJuN13h+JI5mlEEQAWog/mKpiPN5APm/p0ija
         w0Uy7d69/3SGhFfueumgGdoJNNr4hfl4lfDN5kuPv5c5jh5SF9JgR7tzcEf3ETP/BcQ3
         UVlF+Ey/eMEESTIQtl0s+W4++NfI26L7JrJfKTsQ5cSjUvt+BqIsxjuBYx0BC+VjYu/q
         dENBe93p8Xh+/ArFPdiWtsNtlp1fY7f7KKvD9KP6DT+TRJeKqxIPc+3Tw9n+BuPpJ8k6
         jUafNiwoLOD6ULNYTW5WipNEv9wtPpmeMVA+qTLIl7LnFaPubSdtK1uM1ROm4kAI9yd7
         7Y4A==
X-Gm-Message-State: AOAM530wToEGalKEPSsi5yy3WftyYIWTM/EJWl/m8fTfrJy9gBGyqDuD
        EiAYsfcW92de84TSUstc+KKN34WLjHmtkiHIf+Q=
X-Google-Smtp-Source: ABdhPJyHZj9w5k2g08BjdMUMMpsbhEHwX49fk3X0Xki1sKGrtmR4QaT30+m5S+NWdoWcgeyl4xy+Phnj/JBhu2Db2LM=
X-Received: by 2002:a17:902:9a4b:: with SMTP id x11mr4119309plv.255.1596210125122;
 Fri, 31 Jul 2020 08:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200731070114.40471-1-ceggers@arri.de> <20200731070114.40471-3-ceggers@arri.de>
 <CAHp75VdDCnQLh0Qts8hsgLBy5TqibOKAYSeFxuV69XLroRBOEg@mail.gmail.com> <2706267.JtmGt7LAV2@n95hx1g2>
In-Reply-To: <2706267.JtmGt7LAV2@n95hx1g2>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 31 Jul 2020 18:41:47 +0300
Message-ID: <CAHp75VdSNXWCVVgX+8BCC5iWjO14KMUCNrYvZyFfez-fFerQsA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: light: as73211: New driver
To:     Christian Eggers <ceggers@arri.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 31, 2020 at 1:52 PM Christian Eggers <ceggers@arri.de> wrote:

> > W=1 (not V=1) runs kernel doc validation script.
> without V=1, I get nothing. Neither excess nor missing members
> are reported on my system.

It's strange.

...

> > Perhaps add a definition above and comment here?
> >
> > #define AS73211_BASE_FREQ_1024KHZ   1024000
> added similar define in v5. The array looks like the following now
>
> static const int as73211_samp_freq_avail[] = {

>         AS73211_SAMPLE_FREQ_BASE,

' * 1'

>         AS73211_SAMPLE_FREQ_BASE * 2,
>         AS73211_SAMPLE_FREQ_BASE * 4,
>         AS73211_SAMPLE_FREQ_BASE * 8
> };

...

> > > +/* integration time in units of 1024 clock cycles */
> >
> > Unify this with below one. Or the other way around, i.o.w. join one of
> > them into the other.
> >
> > > +static unsigned int as73211_integration_time_1024cyc(struct as73211_data
> > > *data) +{
> > > +       /* integration time in CREG1 is in powers of 2 (x 1024 cycles) */
> > > +       return BIT(FIELD_GET(AS73211_CREG1_TIME_MASK, data->creg1));
> > > +}
> I'm not sure, whether this is possible. as73211_integration_time_1024cyc()
> returns the current setting from hardware. as73211_integration_time_us()
> calculates the resulting time. But as73211_integration_time_us() is also
> called in as73211_integration_time_calc_avail() inside the loop.

What I meant is solely comments to be joined, not the code.

...

> > > +       unsigned int time_us = as73211_integration_time_us(data,
> > > +                                                          as73211_integration_time_1024cyc(data));
> > One line?

> checkpatch complains... ignore?

Hmm... is it over 100? Or you are using some old tools to work with
the kernel...

...

> > > +               /* gain can be calculated from CREG1 as 2^(13 -
> > > CREG1_GAIN) */ +               reg_bits = 13 - ilog2(val);
> >
> > 13 is the second time in the code. Deserves a descriptive definition.

> I'm unsure how to solve this. Possible values for gain:
>
> CREG1[7:4]  | gain
> -----------------------------
> 0           | 2048x
> 1           | 1024x
> 2           |  512x
> ...         |  ...
> 13          |    1x
>
> #define AS73211_CREG1_GAIN_1_NON_SHIFTED 13  // this define is CREG1 related, but not shifted to the right position
>
> static unsigned int as73211_gain(struct as73211_data *data)
> {
>         /* gain can be calculated from CREG1 as 2^(13 - CREG1_GAIN) */
>         return BIT(AS73211_CREG1_GAIN_1_NON_SHIFTED - FIELD_GET(AS73211_CREG1_GAIN_MASK, data->creg1));
> }

This way (w/o _NON_SHIFTED suffix) if both 13:s in the code are of the
same meaning.

...

> > > +       indio_dev->dev.parent = dev;
> >
> > Doesn't IIO core do this for you?
> devm_iio_device_alloc() doesn't pass 'dev' to iio_device_alloc().
> I already looked around, but I didn't find. And after debugging
> v5.4, devm_iio_device_alloc() definitely doesn't do it.

Why are you talking about v5.4? We are in v5.8 cycle contributing to v5.9.

Recently IIO gained some features among which I think the one that
assigns parent devices.

-- 
With Best Regards,
Andy Shevchenko
