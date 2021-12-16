Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BF6476B1F
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 08:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhLPHly (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 02:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbhLPHlx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 02:41:53 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E49C061574
        for <linux-iio@vger.kernel.org>; Wed, 15 Dec 2021 23:41:53 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id l10so11366437pgm.7
        for <linux-iio@vger.kernel.org>; Wed, 15 Dec 2021 23:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NOY6FNnQPr6HXUT7OkqLrY9/Kdd/U+y5gi7GCLTCjPk=;
        b=hkQv0Uy/xynIW2PDCvGzNEWhKizwHgjUBCivk99soLPuBc4IQ+NMlK6qKVq4LP1qV4
         dX+3KlorYOLKqUogF4DbR0hL6ADRCxMe7a8M2N48xcHSVpL9Iq6UxaJ7+qA/tmJwNqSD
         yGgdqOWEESWXmGVq2DstXV+22dVRQlm/9GRDjq4+3P3qfA4n4l0Qp8rh1h3RWCXszO0B
         Vj6lrTt1Y96X+spSFXyzKNDdB5EK33sARRjv1DGZuKm44fzL7UobUae1RvIcUlCq7nOZ
         0Y+Oju0Ax4dZp8U+ng/WlLW+dgSPEco1Ld6ONPxOUev4oQDV+r4NihG+ebRtJN86AaY5
         LmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NOY6FNnQPr6HXUT7OkqLrY9/Kdd/U+y5gi7GCLTCjPk=;
        b=mLov5qjVPp78/nC/6a/voh4IbNWXfM9zxM2E9YMwWSCuu34Vk4/fBC/C0svZ6xqFem
         H0mvEhD2XiF/nwMAuoTF1kvgfv4Qvx3IaszVBe0ZcuJlj0/uSlUyek4nPmc3ENI/YOBA
         bs792wdwOIKNy2yvKDmbvELHW8ykcnuWvtHwcrWD+MxYZvVz4wrMV7NJnGCr8g/R/CVH
         sHSrj7DuMHpg7D3QSl54yOMkpqvFBSA8cSxIDTFO3oDz4xHGYos8dgluAnABoyCrCfbe
         52UuYLBsl3KJzpZgJbmyuSV4+1+3RIo8StyInGPMCVYTyOK81GrIG+TPSwpykUhm5OZh
         LEvg==
X-Gm-Message-State: AOAM531VOqvE9SHKFwzpD55CoNdeiTZ0RpOparuKz9UgoKmJkwMowBLe
        hQ/ugGpw1hihyhPajuZYPIurMqndOD+lIrCUepCYRYlYfcMOBg==
X-Google-Smtp-Source: ABdhPJzCP1z8alze5EvwRkVGyz63qRTRQNUvrg01JCwE3WxL7B6H1eV1lK3CZbC9cSbwbRFEZXGfFErOa7CGnE61gns=
X-Received: by 2002:a05:6a00:7cc:b0:49f:9cf1:2969 with SMTP id
 n12-20020a056a0007cc00b0049f9cf12969mr12954829pfu.12.1639640512119; Wed, 15
 Dec 2021 23:41:52 -0800 (PST)
MIME-Version: 1.0
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
 <20211215151344.163036-7-miquel.raynal@bootlin.com> <CA+U=DsrD6pqpYs=D_YtkwJntcUCjUJi8qS49Dg5nLTC9yqvWZA@mail.gmail.com>
In-Reply-To: <CA+U=DsrD6pqpYs=D_YtkwJntcUCjUJi8qS49Dg5nLTC9yqvWZA@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 16 Dec 2021 09:41:40 +0200
Message-ID: <CA+U=DspTbK7SHFNOfM64_fTcBUhAicQ4w6hJWd1Teo7z0neFdQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] iio: core: Hide read accesses to iio_dev->currentmode
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 16, 2021 at 9:38 AM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
>
> On Wed, Dec 15, 2021 at 10:04 PM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> >
> > In order to later move this variable within the opaque structure, let's
> > create a helper for accessing it in read-only mode. This helper will be
> > exposed and kept accessible for the few drivers that could need it. The
> > write access to this variable however should be fully reserved to the
> > core so in a second step we will add another helper, not exported to th=
e
> > device drivers.
>
> The naming needs a bit of discussion.
> I would have gone for iio_dev_get_current_mode() or something like that.
>
> And I would probably not use this helper inside the IIO core stuff
> (i.e. drivers/iio/industrialio-*.c files)
> Mostly because [if now used only in IIO core] it makes the
> "indio_dev->currentmode" assignment and access easier to trace.

Oh, I just saw the next patch with iio_set_internal_mode().
I guess having a set helper (like this) resolves the discussion about traci=
ng.
Still not sure whether it makes sense to use these helpers inside IIO
core, but =C2=AF\_(=E3=83=84)_/=C2=AF

>
> There's also the change that accessing "indio_dev->currentmode"
> becomes a function-symbol which has rules at link-time and may add
> some new jmp/ret instructions.
> But It doesn't look like this is used in any fast-paths, so it's not
> an issue as much.
>
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/iio/accel/bmc150-accel-core.c |  4 ++--
> >  drivers/iio/adc/at91-sama5d2_adc.c    |  4 ++--
> >  drivers/iio/industrialio-buffer.c     |  6 +++---
> >  drivers/iio/industrialio-core.c       | 11 +++++++++++
> >  drivers/iio/industrialio-trigger.c    |  2 +-
> >  include/linux/iio/iio.h               |  9 ++++++---
> >  6 files changed, 25 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/=
bmc150-accel-core.c
> > index b0678c351e82..0a191463d462 100644
> > --- a/drivers/iio/accel/bmc150-accel-core.c
> > +++ b/drivers/iio/accel/bmc150-accel-core.c
> > @@ -1525,7 +1525,7 @@ static int bmc150_accel_buffer_postenable(struct =
iio_dev *indio_dev)
> >         struct bmc150_accel_data *data =3D iio_priv(indio_dev);
> >         int ret =3D 0;
> >
> > -       if (indio_dev->currentmode =3D=3D INDIO_BUFFER_TRIGGERED)
> > +       if (iio_get_internal_mode(indio_dev) =3D=3D INDIO_BUFFER_TRIGGE=
RED)
> >                 return 0;
> >
> >         mutex_lock(&data->mutex);
> > @@ -1557,7 +1557,7 @@ static int bmc150_accel_buffer_predisable(struct =
iio_dev *indio_dev)
> >  {
> >         struct bmc150_accel_data *data =3D iio_priv(indio_dev);
> >
> > -       if (indio_dev->currentmode =3D=3D INDIO_BUFFER_TRIGGERED)
> > +       if (iio_get_internal_mode(indio_dev) =3D=3D INDIO_BUFFER_TRIGGE=
RED)
> >                 return 0;
> >
> >         mutex_lock(&data->mutex);
> > diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-=
sama5d2_adc.c
> > index 4c922ef634f8..2b7f6371950e 100644
> > --- a/drivers/iio/adc/at91-sama5d2_adc.c
> > +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> > @@ -1117,7 +1117,7 @@ static int at91_adc_buffer_prepare(struct iio_dev=
 *indio_dev)
> >                 return at91_adc_configure_touch(st, true);
> >
> >         /* if we are not in triggered mode, we cannot enable the buffer=
. */
> > -       if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
> > +       if (!(iio_get_internal_mode(indio_dev) & INDIO_ALL_TRIGGERED_MO=
DES))
> >                 return -EINVAL;
> >
> >         /* we continue with the triggered buffer */
> > @@ -1159,7 +1159,7 @@ static int at91_adc_buffer_postdisable(struct iio=
_dev *indio_dev)
> >                 return at91_adc_configure_touch(st, false);
> >
> >         /* if we are not in triggered mode, nothing to do here */
> > -       if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
> > +       if (!(iio_get_internal_mode(indio_dev) & INDIO_ALL_TRIGGERED_MO=
DES))
> >                 return -EINVAL;
> >
> >         /*
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrial=
io-buffer.c
> > index e180728914c0..f4dbab7c44fa 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -1101,7 +1101,7 @@ static int iio_enable_buffers(struct iio_dev *ind=
io_dev,
> >                         goto err_disable_buffers;
> >         }
> >
> > -       if (indio_dev->currentmode =3D=3D INDIO_BUFFER_TRIGGERED) {
> > +       if (iio_get_internal_mode(indio_dev) =3D=3D INDIO_BUFFER_TRIGGE=
RED) {
> >                 ret =3D iio_trigger_attach_poll_func(indio_dev->trig,
> >                                                    indio_dev->pollfunc)=
;
> >                 if (ret)
> > @@ -1120,7 +1120,7 @@ static int iio_enable_buffers(struct iio_dev *ind=
io_dev,
> >         return 0;
> >
> >  err_detach_pollfunc:
> > -       if (indio_dev->currentmode =3D=3D INDIO_BUFFER_TRIGGERED) {
> > +       if (iio_get_internal_mode(indio_dev) =3D=3D INDIO_BUFFER_TRIGGE=
RED) {
> >                 iio_trigger_detach_poll_func(indio_dev->trig,
> >                                              indio_dev->pollfunc);
> >         }
> > @@ -1162,7 +1162,7 @@ static int iio_disable_buffers(struct iio_dev *in=
dio_dev)
> >                         ret =3D ret2;
> >         }
> >
> > -       if (indio_dev->currentmode =3D=3D INDIO_BUFFER_TRIGGERED) {
> > +       if (iio_get_internal_mode(indio_dev) =3D=3D INDIO_BUFFER_TRIGGE=
RED) {
> >                 iio_trigger_detach_poll_func(indio_dev->trig,
> >                                              indio_dev->pollfunc);
> >         }
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio=
-core.c
> > index 463a63d5bf56..a1d6e30d034a 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -2057,6 +2057,17 @@ void iio_device_release_direct_mode(struct iio_d=
ev *indio_dev)
> >  }
> >  EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
> >
> > +/**
> > + * iio_get_internal_mode() - helper function providing read-only acces=
s to the
> > + *                          opaque @currentmode variable
> > + * @indio_dev:         IIO device structure for device
> > + **/
> > +int iio_get_internal_mode(struct iio_dev *indio_dev)
> > +{
> > +       return indio_dev->currentmode;
> > +}
> > +EXPORT_SYMBOL_GPL(iio_get_internal_mode);
> > +
> >  subsys_initcall(iio_init);
> >  module_exit(iio_exit);
> >
> > diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industria=
lio-trigger.c
> > index b23caa2f2aa1..71b07d6111d6 100644
> > --- a/drivers/iio/industrialio-trigger.c
> > +++ b/drivers/iio/industrialio-trigger.c
> > @@ -411,7 +411,7 @@ static ssize_t iio_trigger_write_current(struct dev=
ice *dev,
> >         int ret;
> >
> >         mutex_lock(&indio_dev->mlock);
> > -       if (indio_dev->currentmode =3D=3D INDIO_BUFFER_TRIGGERED) {
> > +       if (iio_get_internal_mode(indio_dev) =3D=3D INDIO_BUFFER_TRIGGE=
RED) {
> >                 mutex_unlock(&indio_dev->mlock);
> >                 return -EBUSY;
> >         }
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index 0312da2e83f8..dcab17f44552 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -677,15 +677,18 @@ struct iio_dev *devm_iio_device_alloc(struct devi=
ce *parent, int sizeof_priv);
> >  __printf(2, 3)
> >  struct iio_trigger *devm_iio_trigger_alloc(struct device *parent,
> >                                            const char *fmt, ...);
> > +
> > +int iio_get_internal_mode(struct iio_dev *indio_dev);
> > +
> >  /**
> >   * iio_buffer_enabled() - helper function to test if the buffer is ena=
bled
> >   * @indio_dev:         IIO device structure for device
> >   **/
> >  static inline bool iio_buffer_enabled(struct iio_dev *indio_dev)
> >  {
> > -       return indio_dev->currentmode
> > -               & (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE |
> > -                  INDIO_BUFFER_SOFTWARE);
> > +       return iio_get_internal_mode(indio_dev) &
> > +               (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE |
> > +                INDIO_BUFFER_SOFTWARE);
> >  }
> >
> >  /**
> > --
> > 2.27.0
> >
