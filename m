Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6D23635B0
	for <lists+linux-iio@lfdr.de>; Sun, 18 Apr 2021 15:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhDRNuA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Apr 2021 09:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhDRNt7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Apr 2021 09:49:59 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9807C06174A;
        Sun, 18 Apr 2021 06:49:26 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id h15so3753869pfv.2;
        Sun, 18 Apr 2021 06:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbKScacbPnCVDko0r+AsXA3VAj92Swv+RtqzbxHYEQQ=;
        b=rV6v1JzJHRqixRuUv6qmV6vMTuLaBxbL6yfdlCQfxpMvWLG2wDI8QRIRTi7AaVUm88
         fOfiHccxft89ZX8AHGUDlkVCEGjhCQnAIdExjuQ49WQN9e26mmowHthHCN/adqS1AvMm
         iWuHVAwLIF8LQrPM3/WGVuMr1H5M2xNPZERR/r5WfO8KxkNULJCQJWX+np5J+ZljFBme
         HgHaPSRrkindJW01PL4nsuDB+r8kgiuCzQuEhZHLI8/bFxOK3q9+NTMFBpyUsdTeeWCV
         h19Cif7iPDYdQaE+OuOITrwgJLABJiI5ezn5LWwa+VgZEStjcSsyCcH7Y6gPgm7Ux/Yp
         jooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbKScacbPnCVDko0r+AsXA3VAj92Swv+RtqzbxHYEQQ=;
        b=sjwo8IWsSDQ8pfpXuUmPhrgJn5UAsiCN+Bfk6/iOQeiPR4fp3WEKwWv9oIwELtXnO7
         jWl6lSB/uConBa4ojh02DVps7pmdlNntrkc6GzsFpjhmuEs9TP9l/w4rWfFfhZznBS/M
         Ggt3LMSOMdH1ZDWhyNfRNHJRjCLeHKfsq3YdPcTh0GZcLxACXYkH3kVmFvqrky5tyrEX
         hwcnEcxJvThQrvEHqPX3ktVJ2vsrFOvVKbV3aa2o6uiGrb870BnMYAmxapBexo+UNw67
         y0I+0uBlyF7N6OxAlatLQxkbeIpA1ieDsgAV7ZR0Xiw2lcf5YqN3O4Q2GF3QNhbWEiTf
         pA0A==
X-Gm-Message-State: AOAM532dblzdbybAo/805lpPa+HQhAI7HRJQhuvIQIsqgKme6+oXQj11
        75Tb1pqcZt9Kvr20n6mag9tGP5L4GdqzjCKwCj8=
X-Google-Smtp-Source: ABdhPJyFGJD1cXvIF3FDJ7M2UiPRrn4WTWmkgt3uTyegd+zkAfKnvTXlsHbI6QtcbwlXypXZYpK486VW2AIfSSSzYbo=
X-Received: by 2002:a62:5c6:0:b029:24d:e97f:1b1d with SMTP id
 189-20020a6205c60000b029024de97f1b1dmr15893645pff.40.1618753765614; Sun, 18
 Apr 2021 06:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210414195454.84183-1-andriy.shevchenko@linux.intel.com>
 <20210414195454.84183-6-andriy.shevchenko@linux.intel.com> <20210418120655.3b2501fc@jic23-huawei>
In-Reply-To: <20210418120655.3b2501fc@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 18 Apr 2021 16:49:09 +0300
Message-ID: <CAHp75Vcrf02cVaeDevN-cEFFTPoxq6kyO3gGQYTcs-U4yHOFaQ@mail.gmail.com>
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
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        mr.lahorde@laposte.net,
        Matija Podravec <matija_podravec@fastmail.fm>,
        Sergey Borishchenko <borischenko.sergey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 18, 2021 at 2:07 PM Jonathan Cameron <jic23@kernel.org> wrote:

Thanks for review, my answers below.

> On Wed, 14 Apr 2021 22:54:53 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > We can utilize separate drivers for accelerometer and magnetometer,
> > so here is the glue driver to enable LSM9DS0 IMU support.
> >
> > The idea was suggested by Crestez Dan Leonard in [1]. The proposed change
> > was sent as RFC due to race condition concerns, which are indeed possible.
>
> If you are going to mention races, good to give some flavour in here!

I meant that the initial idea is racy due to different devices
communicating to the same i2c address.
So, any sequence of transfers are not serialized and you may end up with

drv1 -> i2c
drv2 -> i2c
drv1 <- i2c # garbage

> This driver makes me very nervous indeed.

Why?! This one is race free as far as I can see. Or maybe I interpret
this wrongly and you are talking about initial RFC?

>  I haven't 'found' any places
> where the fact we'll write the same registers from each of the drivers
> causes problems (e.g. int pin setup etc) but perhaps I'm missing something.
>
> Shall we say that makes me rather keener to get eyes (and thought) on this
> patch than normal :)

How should I amend the commit message to state:
1. First idea (RFC by the link) *is* racy AFAIU
2. This one *is not* racy.

> > In order to amend the initial change,

You see, *in order to amend*, so here is the *amended* version.

> I went further by providing a specific
> > multi-instantiate probe driver that reuses existing accelerometer and
> > magnetometer.
> >
> > [1]: https://lore.kernel.org/patchwork/patch/670353/
> >
> > Suggested-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> > Cc: mr.lahorde@laposte.net
> > Cc: Matija Podravec <matija_podravec@fastmail.fm>
> > Cc: Sergey Borishchenko <borischenko.sergey@gmail.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> A few comments in here, though mostly about stuff related to the origin code
> you are copying so perhaps not tidying them up is preferable because it would
> complicate comparison of the two cases.

...

> > +     {
> > +             .wai = 0x49,
> > +             .wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
> > +             .sensors_supported = {
> > +                     [0] = LSM9DS0_IMU_DEV_NAME,
>
> What does the name attribute report for these?
>
> Previously we've had the _accel etc postfix to differentiate the devices. I don't
> suppose it matters to much though as easy enough to identify the accelerometer
> etc from what channels are present.
>
> Of course driver may get name from somewhere different anyway, I haven't checked,
> just noticed this was different and wondered what the affect might be.

Yes, it has a postfix, that's why I leave it like this.

...

> > +static int st_lsm9ds0_power_enable(struct device *dev, struct st_lsm9ds0 *lsm9ds0)
> > +{
> > +     int ret;
> > +
> > +     /* Regulators not mandatory, but if requested we should enable them. */
>
> That's a bit of a missleading comment though cut and paste from the other driver
> code.  Key is that they will be handled by stub regulators if we don't provide
> the which is not really what that comment implies.

I see. I will remove it.

> > +     lsm9ds0->vdd = devm_regulator_get(dev, "vdd");
> > +     if (IS_ERR(lsm9ds0->vdd)) {
> > +             dev_err(dev, "unable to get Vdd supply\n");
> > +             return PTR_ERR(lsm9ds0->vdd);
> > +     }
> > +     ret = regulator_enable(lsm9ds0->vdd);
> > +     if (ret) {
> > +             dev_warn(dev, "Failed to enable specified Vdd supply\n");
>
> Given we fail to probe if this is true, dev_warn seems a bit soft.

Right.  I'll move to dev_err().

> > +             return ret;
> > +     }
> > +
> > +     lsm9ds0->vdd_io = devm_regulator_get(dev, "vddio");
> > +     if (IS_ERR(lsm9ds0->vdd_io)) {
> > +             dev_err(dev, "unable to get Vdd_IO supply\n");
> > +             regulator_disable(lsm9ds0->vdd);
> > +             return PTR_ERR(lsm9ds0->vdd_io);
> > +     }
> > +     ret = regulator_enable(lsm9ds0->vdd_io);
> > +     if (ret) {
> > +             dev_warn(dev, "Failed to enable specified Vdd_IO supply\n");

Ditto.

> > +             regulator_disable(lsm9ds0->vdd);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}

-- 
With Best Regards,
Andy Shevchenko
