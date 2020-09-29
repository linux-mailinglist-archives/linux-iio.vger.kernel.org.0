Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256C427D128
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 16:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgI2OcH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 10:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgI2OcH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2020 10:32:07 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF7DC061755;
        Tue, 29 Sep 2020 07:32:06 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x69so5661514oia.8;
        Tue, 29 Sep 2020 07:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LAmz0O8V9vfqJ0LDWpSIs9Cx80ruJ/1ftMGPdSc3hh0=;
        b=MGyy9+FWipuOI8XAyEkbbhJlUPT5fHdjwnVoRNRlonlvcqxmCS7Nxx1GAjrVCN0Kyl
         2LetpBcxmabr6SKEa+4S2IQ5BAGPTuz+WH0Byw/g/prsv7LOL+E4mdavUSSTSKfv/Dh3
         QmRcs2gEfTHqbS/qV9Yzs9qQrpEMLo+MPxEu59v3Mv3JnXpxedKUKixBe278TcHdlayz
         X6l3P/huYZ6yfSI7NmUNu/6tnaMDoEJdGlmHdY5PRnx4ahgXKrYUb1xDfWfGS6hj4kS0
         MXQ1RoWvPj28JOuBUyVOyq2CI8O5O3YE9rh9tE28i1frbCvQwIIFDflWMFyuMPoSM+ZW
         JHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LAmz0O8V9vfqJ0LDWpSIs9Cx80ruJ/1ftMGPdSc3hh0=;
        b=XwSg9B6r4aCBkvTYRCNiPU+PFeauExZNI79WzYoleGtpSsFtyZ0jB44h6S+1Kti0Ah
         j8H+w82zXY7D0kgpB3yfodf9zIC44N8EzQUZWTUO0LyabXbyev/+5atWt/TeWpnkRQ1i
         DA9NhqApCL/0MrTTE9VVYz3XzICcwE9So45GpYsnrePsqxQ2UvGZDEQ2ME5CG3KQguse
         P8MHSVq76vvZvS1PdRSrgceWchWjqrDIMJ8rU+P8rc+TtBfTQixMmz43rICVzGxmd3Uz
         RtYASJJYuld0u71vr3ScMzNczp+714wYHKYelV6e7xImvVGe4d7JnaRZCroGYnXgN9pN
         cx5A==
X-Gm-Message-State: AOAM532ES1QB/ULGQYYIZbMKeodPAhIxwOJxZOvjCYS5/MCTczRYOkdk
        FUiOvHXUUDi0SmILnPEvJMEBD8eqd7TWZMBlXA0=
X-Google-Smtp-Source: ABdhPJxQzX8QW8Pkfd+eKYVvvrcNkYYuqFEupPBiFsvkpEc9j8ISAG9ebnlBMio3g2zVKD8MMoIXQQ6TiQeuvQUlVpw=
X-Received: by 2002:aca:ea44:: with SMTP id i65mr2646582oih.117.1601389926080;
 Tue, 29 Sep 2020 07:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200929125949.69934-1-alexandru.ardelean@analog.com>
 <20200929125949.69934-8-alexandru.ardelean@analog.com> <CAHp75VerL3x7L=AeLfnT6D01a=FyY3JE4vbwNFMaJz-v=f2k9w@mail.gmail.com>
In-Reply-To: <CAHp75VerL3x7L=AeLfnT6D01a=FyY3JE4vbwNFMaJz-v=f2k9w@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 29 Sep 2020 17:31:55 +0300
Message-ID: <CA+U=DsoKM6S+1vrhE6txB-zQLhpJE1St19D_tmHa0=bbqj-g8w@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] iio: cros_ec: use devm_iio_triggered_buffer_setup_ext()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        groeck@chromium.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 29, 2020 at 4:09 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Sep 29, 2020 at 3:55 PM Alexandru Ardelean
> <alexandru.ardelean@analog.com> wrote:
>
> > This change switches to the new devm_iio_triggered_buffer_setup_ext()
> > function and removes the iio_buffer_set_attrs() call, for assigning the
> > HW FIFO attributes to the buffer.
>
> Sorry, you were too fast with the version, below one nit.
>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  .../common/cros_ec_sensors/cros_ec_sensors_core.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index c62cacc04672..1eafcf04ad69 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -353,19 +353,22 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> >                         if (ret)
> >                                 return ret;
> >                 } else {
> > +                       const struct attribute **fifo_attrs;
> > +
> > +                       if (has_hw_fifo)
> > +                               fifo_attrs = cros_ec_sensor_fifo_attributes;
> > +                       else
> > +                               fifo_attrs = NULL;
> > +
> >                         /*
> >                          * The only way to get samples in buffer is to set a
> >                          * software trigger (systrig, hrtimer).
> >                          */
> > -                       ret = devm_iio_triggered_buffer_setup(
>
> > +                       ret = devm_iio_triggered_buffer_setup_ext(
> >                                         dev, indio_dev, NULL, trigger_capture,
> > -                                       NULL);
> > +                                       NULL, fifo_attrs);
>
> Perhaps it's time to reformat a bit, i.e. move dev to the first line
> and do the rest accordingly?

this feels like a mix of preferences here;
for once, the patch here [as-is], is the minimal form for this change
[in terms of patch-noise];
so, some people would choose the least noisiest patch;

also, this indentation was chosen [as-is here] from the start [for
this code block];
not sure if it was preferred; i'd suspect it was due to the old 80-col limit;

i'd leave it as-is [for now], or defer the decision to a maintainer to
decide [either IIO or chromium];

>
> >                         if (ret)
> >                                 return ret;
> > -
> > -                       if (has_hw_fifo)
> > -                               iio_buffer_set_attrs(indio_dev->buffer,
> > -                                                    cros_ec_sensor_fifo_attributes);
> >                 }
> >         }
> >
> > --
> > 2.17.1
> >
>
>
> --
> With Best Regards,
> Andy Shevchenko
