Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9FA3D5359
	for <lists+linux-iio@lfdr.de>; Mon, 26 Jul 2021 08:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhGZGId (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jul 2021 02:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhGZGId (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jul 2021 02:08:33 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C02C061760
        for <linux-iio@vger.kernel.org>; Sun, 25 Jul 2021 23:49:01 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id f1so1802133vkk.6
        for <linux-iio@vger.kernel.org>; Sun, 25 Jul 2021 23:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1AxCO7lyw6ovOiptky8TyGkHjQtCHF4StffodwJbBJY=;
        b=iEQqyMSnvsZoIfvkVak3bNh6SavBPS+vHHKxpiyCBqqdmOnYh1TgAh9S2o/ddPsXXj
         MQUFjYYliMLO7sQeW8C2w0cS2LdMm3Calq1St0BWzshFaZ46+66VyubhQGgjArS/YEGb
         KO4LKxzrf7KaRWMtLgdvCJeaGYTgqz1Rrasz9B4JebTUPxWIaFGlEyYJzBVyylLYuaMv
         6sww6dnahmJ9VRMBJ09jq9yXI6PRXoBpd7ySeBehiFNIa2PCnZMqPRqZjYZWYTGtbIw8
         8VD8yMEaweO8LGXKYUwPgcgvcsiCKRffNvDA2kCdoT2ADgGc9vQRBYfgG3iE6xMDRF7W
         /2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1AxCO7lyw6ovOiptky8TyGkHjQtCHF4StffodwJbBJY=;
        b=FASAaqtIYjOMtqHU/oPFp6tR5SzBW7r0ZzrX5pb4nLy1dWgGxTaJ1WVpSdAcLQmeUX
         cEzfxtU8/ReGAtW/nAjuVQ8dbSwehm7bZE4Yggad7k9GkwyQm4uvwVg55D6y5y6H9kOQ
         cSqz8WhVbEumlDI44IUvY+gx7Fh0Vtg2m8Voxh29eVCGUd3ae6DwzE6Y3l5uCiKb4j7I
         +Xz0Ii8XyUWUQvEIFyp/GPL5RkBb7XIIGRmNF/5GbvywWHwSFNybWkk6S2DlBZD97Z53
         MLjCh9WnUvLdM/s0TfdQwl9zs3F8EqmHesvNRJKQyC52nkbBV8tM0zOBKR97WHkt/+v0
         cFhA==
X-Gm-Message-State: AOAM533lV6AXornYP89hhM4xlWCBa57HeOms2eSfwebGnm6JcoQAQFVw
        16rlV12M5Deoe65f80Mfd48Ixowl4sTEyjbQmVzDGQ==
X-Google-Smtp-Source: ABdhPJx1chwhnyHJqCk1+5educiUa4SgFd9MmT9lrNa3kVSy/KRJ2rTOoYnjVmC8eyYYVK9cPU6KTUeZutSQNjZ2i7s=
X-Received: by 2002:a1f:984c:: with SMTP id a73mr6666530vke.20.1627282140339;
 Sun, 25 Jul 2021 23:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210720074642.223293-1-aardelean@deviqon.com> <20210724164301.54008712@jic23-huawei>
In-Reply-To: <20210724164301.54008712@jic23-huawei>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Mon, 26 Jul 2021 09:48:49 +0300
Message-ID: <CAASAkoasKea5t_nB6JZtaPj4hrzShQh7kjeBwHieCyq4+S=O6g@mail.gmail.com>
Subject: Re: [PATCH 1/4] iio: pressure: st_pressure: use devm_iio_triggered_buffer_setup()
 for buffer
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        denis.ciocca@st.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 24 Jul 2021 at 18:40, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 20 Jul 2021 10:46:39 +0300
> Alexandru Ardelean <aardelean@deviqon.com> wrote:
>
> > The st_press_allocate_ring() function calls iio_triggered_buffer_setup() to
> > allocate a triggered buffer.
> >
> > But the same can be done with devm_iio_triggered_buffer_setup() and then
> > the st_press_common_remove() no longer needs to manually deallocate it.
> >
> > We know that the parent of the IIO device is used to manage other instances
> > of the devm unwind, so it can be used in the st_press_allocate_ring() as
> > well.
>
> This raises an interesting point.  This driver mixes and matches between
> hanging devm off the parent and off the iio_dev->dev.

iio_dev->dev.parent and the devm parent are the same reference but
coming off from different pointers

>
> That's probably not a good thing to do as it could lead to an odd unwind
> order.  I'm pretty sure the changes here are fine, but we should take
> a closer look...

hmm, let me send a follow-up series

>
> Series applied to the togreg branch of iio.git and pushed out as testing.
>

thank you :)

> You can do the same thing with the trigger with only slightly more complex
> patch, but I'd like to discuss whether there are races because of the current
> dev mix and match before that.

will send follow-up series;
i was not sure whether to send everything in one go;
maybe it would have been a good idea; but i thought this one could be
find on it's own;

>
> Thanks,
>
> Jonathan
>
>
> >
> > Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> > ---
> >  drivers/iio/pressure/st_pressure.h        | 5 -----
> >  drivers/iio/pressure/st_pressure_buffer.c | 9 ++-------
> >  drivers/iio/pressure/st_pressure_core.c   | 6 +-----
> >  3 files changed, 3 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/iio/pressure/st_pressure.h b/drivers/iio/pressure/st_pressure.h
> > index 9417b3bd7513..156e6a72dc5c 100644
> > --- a/drivers/iio/pressure/st_pressure.h
> > +++ b/drivers/iio/pressure/st_pressure.h
> > @@ -43,7 +43,6 @@ static __maybe_unused const struct st_sensors_platform_data default_press_pdata
> >
> >  #ifdef CONFIG_IIO_BUFFER
> >  int st_press_allocate_ring(struct iio_dev *indio_dev);
> > -void st_press_deallocate_ring(struct iio_dev *indio_dev);
> >  int st_press_trig_set_state(struct iio_trigger *trig, bool state);
> >  #define ST_PRESS_TRIGGER_SET_STATE (&st_press_trig_set_state)
> >  #else /* CONFIG_IIO_BUFFER */
> > @@ -51,10 +50,6 @@ static inline int st_press_allocate_ring(struct iio_dev *indio_dev)
> >  {
> >       return 0;
> >  }
> > -
> > -static inline void st_press_deallocate_ring(struct iio_dev *indio_dev)
> > -{
> > -}
> >  #define ST_PRESS_TRIGGER_SET_STATE NULL
> >  #endif /* CONFIG_IIO_BUFFER */
> >
> > diff --git a/drivers/iio/pressure/st_pressure_buffer.c b/drivers/iio/pressure/st_pressure_buffer.c
> > index b651e7c31e90..25dbd5476b26 100644
> > --- a/drivers/iio/pressure/st_pressure_buffer.c
> > +++ b/drivers/iio/pressure/st_pressure_buffer.c
> > @@ -41,13 +41,8 @@ static const struct iio_buffer_setup_ops st_press_buffer_setup_ops = {
> >
> >  int st_press_allocate_ring(struct iio_dev *indio_dev)
> >  {
> > -     return iio_triggered_buffer_setup(indio_dev, NULL,
> > -             &st_sensors_trigger_handler, &st_press_buffer_setup_ops);
> > -}
> > -
> > -void st_press_deallocate_ring(struct iio_dev *indio_dev)
> > -{
> > -     iio_triggered_buffer_cleanup(indio_dev);
> > +     return devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
> > +             NULL, &st_sensors_trigger_handler, &st_press_buffer_setup_ops);
> >  }
> >
> >  MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
> > diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> > index 4ff6d40e3670..ab1c17fac807 100644
> > --- a/drivers/iio/pressure/st_pressure_core.c
> > +++ b/drivers/iio/pressure/st_pressure_core.c
> > @@ -718,7 +718,7 @@ int st_press_common_probe(struct iio_dev *indio_dev)
> >               err = st_sensors_allocate_trigger(indio_dev,
> >                                                 ST_PRESS_TRIGGER_OPS);
> >               if (err < 0)
> > -                     goto st_press_probe_trigger_error;
> > +                     return err;
> >       }
> >
> >       err = iio_device_register(indio_dev);
> > @@ -733,8 +733,6 @@ int st_press_common_probe(struct iio_dev *indio_dev)
> >  st_press_device_register_error:
> >       if (press_data->irq > 0)
> >               st_sensors_deallocate_trigger(indio_dev);
> > -st_press_probe_trigger_error:
> > -     st_press_deallocate_ring(indio_dev);
> >       return err;
> >  }
> >  EXPORT_SYMBOL(st_press_common_probe);
> > @@ -746,8 +744,6 @@ void st_press_common_remove(struct iio_dev *indio_dev)
> >       iio_device_unregister(indio_dev);
> >       if (press_data->irq > 0)
> >               st_sensors_deallocate_trigger(indio_dev);
> > -
> > -     st_press_deallocate_ring(indio_dev);
> >  }
> >  EXPORT_SYMBOL(st_press_common_remove);
> >
>
