Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0E72B7B6F
	for <lists+linux-iio@lfdr.de>; Wed, 18 Nov 2020 11:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgKRKf3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Nov 2020 05:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgKRKf3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Nov 2020 05:35:29 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C76C0613D4;
        Wed, 18 Nov 2020 02:35:28 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id r1so1422626iob.13;
        Wed, 18 Nov 2020 02:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BKPcjYkPwfMAm2g01yTzqP145VWNrXoKprIgjiPB/wU=;
        b=Bsgb65YJLAqQkIQcjy9f8oww8vFi2C0iHtiF2JeOmvAvfWeqcFQlPc/R5rOjmxdU2a
         2q9F6Xzv0PaJFub3ztMSQCI1yG4444ZxF57mHczP4sB9bHkPE1CM2L2BE5U+Wm6gI1fD
         b7RbOMAkn21lPBeoHH4ZL0GFh4HM6JlMFnOB4i9z+cSm0ktRQNw/rkEhwG9cnk/y8f7L
         dK8CAm05BiNw4hTtpRLaz/pUanvB+Aaj3Vus9HfqBdesj58xNmrTYz3Er00QNSS0kBaw
         VPgTjGgJabMYP4mqaZ4tsWHXeLf4QkavPjPlu+SMpe2yXIKDrTPAJZ7ekqR/oYMOcz8v
         2D7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BKPcjYkPwfMAm2g01yTzqP145VWNrXoKprIgjiPB/wU=;
        b=piotgi3P3FcdOaov/vkB425dNpeb0nWJaNw4xN2/isOGHnC3TjL7w5FR8fDjmBN+Vr
         9vtbBxGkNGcdxGXupwZ/XOmkUUpaAogS9UE/kpKFx9hiAjl/FBVFr2APkHlxomV96kOS
         ZfQKnkospLRa0c/Oz6jQqTcIsBYDItD6VAlxUi73eSvKJS8ja+yxBq4g5kLDVUFf/f5i
         epT9C7If69nUeFhTSABDMX4vzMdR3c9pDrIpLEGgP0+SSd27qBmFwOSu17ph9t1Yqbm0
         XE+M+bYK7oo0IgaQqfPQkk5M2ntvUvwkunmXeJbGFe3yTDX10uBzIFXEnKL5D192RdUB
         vKCw==
X-Gm-Message-State: AOAM532dD0bnH/v6ha7dIBp2VDD/HuFLqyGBftFbUGZPP0uJdcW6BWtq
        gn+GEv85zNxIHdYT0S8VvavUxnrbqSpo8vtzbh8=
X-Google-Smtp-Source: ABdhPJwglA8LVvau9H/EDjtY+yCY2Fo63u6e8utn4aIKBCN7unhYnxCR/yIkpBI05JSKw11Mo1qe3TTlqINggtgFnXE=
X-Received: by 2002:a05:6602:20c7:: with SMTP id 7mr14611416ioz.170.1605695728359;
 Wed, 18 Nov 2020 02:35:28 -0800 (PST)
MIME-Version: 1.0
References: <20200929125949.69934-1-alexandru.ardelean@analog.com>
 <20200929125949.69934-8-alexandru.ardelean@analog.com> <CAHp75VerL3x7L=AeLfnT6D01a=FyY3JE4vbwNFMaJz-v=f2k9w@mail.gmail.com>
 <CA+U=DsoKM6S+1vrhE6txB-zQLhpJE1St19D_tmHa0=bbqj-g8w@mail.gmail.com> <20200929164010.75f191c3@archlinux>
In-Reply-To: <20200929164010.75f191c3@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 18 Nov 2020 12:35:16 +0200
Message-ID: <CA+U=Dsqsz37HD0rjQLemnkOjdLOSBXoyVbpL_8svKS732jA-Uw@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] iio: cros_ec: use devm_iio_triggered_buffer_setup_ext()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Tue, Sep 29, 2020 at 6:40 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 29 Sep 2020 17:31:55 +0300
> Alexandru Ardelean <ardeleanalex@gmail.com> wrote:
>
> > On Tue, Sep 29, 2020 at 4:09 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Tue, Sep 29, 2020 at 3:55 PM Alexandru Ardelean
> > > <alexandru.ardelean@analog.com> wrote:
> > >
> > > > This change switches to the new devm_iio_triggered_buffer_setup_ext()
> > > > function and removes the iio_buffer_set_attrs() call, for assigning the
> > > > HW FIFO attributes to the buffer.
> > >
> > > Sorry, you were too fast with the version, below one nit.
> > >
> > > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > > ---
> > > >  .../common/cros_ec_sensors/cros_ec_sensors_core.c | 15 +++++++++------
> > > >  1 file changed, 9 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > > index c62cacc04672..1eafcf04ad69 100644
> > > > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > > @@ -353,19 +353,22 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> > > >                         if (ret)
> > > >                                 return ret;
> > > >                 } else {
> > > > +                       const struct attribute **fifo_attrs;
> > > > +
> > > > +                       if (has_hw_fifo)
> > > > +                               fifo_attrs = cros_ec_sensor_fifo_attributes;
> > > > +                       else
> > > > +                               fifo_attrs = NULL;
> > > > +
> > > >                         /*
> > > >                          * The only way to get samples in buffer is to set a
> > > >                          * software trigger (systrig, hrtimer).
> > > >                          */
> > > > -                       ret = devm_iio_triggered_buffer_setup(
> > >
> > > > +                       ret = devm_iio_triggered_buffer_setup_ext(
> > > >                                         dev, indio_dev, NULL, trigger_capture,
> > > > -                                       NULL);
> > > > +                                       NULL, fifo_attrs);
> > >
> > > Perhaps it's time to reformat a bit, i.e. move dev to the first line
> > > and do the rest accordingly?
> >
> > this feels like a mix of preferences here;
> > for once, the patch here [as-is], is the minimal form for this change
> > [in terms of patch-noise];
> > so, some people would choose the least noisiest patch;
> >
> > also, this indentation was chosen [as-is here] from the start [for
> > this code block];
> > not sure if it was preferred; i'd suspect it was due to the old 80-col limit;
> >
> > i'd leave it as-is [for now], or defer the decision to a maintainer to
> > decide [either IIO or chromium];
>
> The indenting of this whole code block is a bit too deep.
>
> Looks to me like we should flip the sense of the outer if statement
>
> if (!physical_device)
>         return 0;
>
> That would lead to a whole bunch of reformatting around here including
> picking up this.
>
> For now I can just shuffle it a bit whilst applying.
>
> This set isn't likely to make the merge window anyway now as I'd like
> it to sit on list a little longer just because it touches several
> drivers with active maintainers and I'd like time for them to sanity
> check.
>

ping on this;
should i do a V4 for this?

this is related to the multiple IIO buffer support:
https://lore.kernel.org/linux-iio/20201117162340.43924-1-alexandru.ardelean@analog.com/T/#t

it's one of the patchsets i could split away on it's own;

> Jonathan
>
>
> >
> > >
> > > >                         if (ret)
> > > >                                 return ret;
> > > > -
> > > > -                       if (has_hw_fifo)
> > > > -                               iio_buffer_set_attrs(indio_dev->buffer,
> > > > -                                                    cros_ec_sensor_fifo_attributes);
> > > >                 }
> > > >         }
> > > >
> > > > --
> > > > 2.17.1
> > > >
> > >
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
>
