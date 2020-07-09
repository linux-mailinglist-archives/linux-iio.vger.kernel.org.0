Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D6F2195E1
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jul 2020 04:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgGICG0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Jul 2020 22:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgGICG0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jul 2020 22:06:26 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77732C061A0B
        for <linux-iio@vger.kernel.org>; Wed,  8 Jul 2020 19:06:26 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id h16so690823ilj.11
        for <linux-iio@vger.kernel.org>; Wed, 08 Jul 2020 19:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7cx1ZJiXMV1qJBdyuszw6uGjZjsxJRlim8P7hVv6n3o=;
        b=KPi66oKCDRObbAhhPZRxKHWjUJDe4Ai1dKxf952d2Kb6LaHj4Gb1NwGtbh+2WR6Q6T
         SRW56upkl9CdwbZWmiG548V63URCRLmlHxq0DwZLoI7et1V8xMPzz89xDcNSyfzVU3bP
         dZiNCsbBf2i/AvBElZ9vzrmZbRQi3lzDoRiRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7cx1ZJiXMV1qJBdyuszw6uGjZjsxJRlim8P7hVv6n3o=;
        b=NJ4Wm5JsO/cmpg/x5HzfB3GlVWtKoNVDAm9Ele6eFueEpSuBr49IhFwEp1GEfNslNx
         sTV448ygwqVM1tUly/9GkBfiTorQQAvad/t5Au/iXR9Y7LRsc2SviwGbLHFcecQFlZdH
         StWjQWwVYyGbnMisneWKG6mPcKfd6jRmuS127/gVhYaPa6odA++0rk3Hl5OUA8P2JFA4
         AkBklhWWkjEOtpghwOQ+8CMRxxpExgtHEkJgaGfon7odmKYQyjOG4koiBeVoZUInlAu4
         CJL2AgV0ifeadJUfyQUJ0Y6xAp8LxqigPqThTqvLijeknYfmjZx8ufsOgjMZqNO33+ti
         G4mg==
X-Gm-Message-State: AOAM532GIQRBORvnSkE5tyMFe/inbKgIaxio1eqVt0GE0hO/HcFTHh6q
        4xgKaqcDUCMrOb907ipOQh4RyCbqd0/tQqeHMKT14g==
X-Google-Smtp-Source: ABdhPJwo5nGui2VSZyyP4CYyHNiLPAAOkQdSkEcGsXBuMJ9e80qgjHtCLCRJk+U/kj/n5E1GeysMft8jHrfqWmkZn28=
X-Received: by 2002:a92:5a05:: with SMTP id o5mr39117016ilb.237.1594260385707;
 Wed, 08 Jul 2020 19:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200701221055.116514-1-gwendal@chromium.org> <9f542b24-929d-fc22-14c1-10253bfae97d@collabora.com>
In-Reply-To: <9f542b24-929d-fc22-14c1-10253bfae97d@collabora.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 8 Jul 2020 19:06:13 -0700
Message-ID: <CAPUE2utWj32ObjybFkWh37u=9oXk-Ysy4MWp7ee5eO8p7tQSFQ@mail.gmail.com>
Subject: Re: [PATCH] iio: cros_ec_accel_legacy: Add Read Only frequency entries
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 3, 2020 at 2:29 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Gwendal,
>
> Thank you for the patch.
>
> On 2/7/20 0:10, Gwendal Grignou wrote:
> > Report to user space that 10Hz is the sampling frequency of
> > the accelerometers in legacy mode, and it can not be changed.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> >  drivers/iio/accel/cros_ec_accel_legacy.c | 52 +++++++++++++++++++++++-
> >  1 file changed, 51 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> > index 2532b9ad33842..e924183089368 100644
> > --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> > +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> > @@ -33,6 +33,11 @@
> >   */
> >  #define ACCEL_LEGACY_NSCALE 9586168
> >
> > +/*
> > + * Sensor frequency is hard-coded to 10Hz.
> > + */
> > +#define ACCEL_LEGACY_FREQ 10
> > +
> >  static int cros_ec_accel_legacy_read_cmd(struct iio_dev *indio_dev,
> >                                 unsigned long scan_mask, s16 *data)
> >  {
> > @@ -96,6 +101,11 @@ static int cros_ec_accel_legacy_read(struct iio_dev *indio_dev,
> >               *val = 0;
> >               ret = IIO_VAL_INT;
> >               break;
> > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > +             *val = ACCEL_LEGACY_FREQ;
> > +             *val2 = 0;
> > +             ret = IIO_VAL_INT_PLUS_MICRO;
> > +             break;
> >       default:
> >               ret = cros_ec_sensors_core_read(st, chan, val, val2,
> >                               mask);
> > @@ -120,9 +130,41 @@ static int cros_ec_accel_legacy_write(struct iio_dev *indio_dev,
> >       return -EINVAL;
> >  }
> >
> > +/**
> > + * cros_ec_accel_legacy_read_avail() - get available values
> > + * @indio_dev:               pointer to state information for device
> > + * @chan:    channel specification structure table
> > + * @vals:    list of available values
> > + * @type:    type of data returned
> > + * @length:  number of data returned in the array
> > + * @mask:    specifies which values to be requested
> > + *
> > + * Return:   an error code, IIO_AVAIL_RANGE or IIO_AVAIL_LIST
>
> That's not really true, you're returning a list or an error code.
>
> > + */
> > +static int cros_ec_accel_legacy_read_avail(struct iio_dev *indio_dev,
> > +                                        struct iio_chan_spec const *chan,
> > +                                        const int **vals,
> > +                                        int *type,
> > +                                        int *length,
> > +                                        long mask)
> > +{
> > +     struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > +             *length = 2;
> > +             *vals = (const int *)&state->frequencies;
>
> I am wondering if you shouldn't just
>
> static const int cros_ec_legacy_sample_freqs[] = { 10, 0 };
>
>     *length = ARRAY_SIZE(cros_ec_legacy_sample_freqs);
>     *vals = cros_ec_legacy_sample_freqs;
>
Will do.
> > +             *type = IIO_VAL_INT_PLUS_MICRO;
> > +             return IIO_AVAIL_LIST;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> >  static const struct iio_info cros_ec_accel_legacy_info = {
> >       .read_raw = &cros_ec_accel_legacy_read,
> >       .write_raw = &cros_ec_accel_legacy_write,
> > +     .read_avail = &cros_ec_accel_legacy_read_avail,
> >  };
> >
> >  /*
> > @@ -142,7 +184,11 @@ static const struct iio_info cros_ec_accel_legacy_info = {
> >               .info_mask_separate =                                   \
> >                       BIT(IIO_CHAN_INFO_RAW) |                        \
> >                       BIT(IIO_CHAN_INFO_CALIBBIAS),                   \
> > -             .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),    \
> > +             .info_mask_shared_by_all =                              \
> > +                     BIT(IIO_CHAN_INFO_SCALE) |                      \
> > +                     BIT(IIO_CHAN_INFO_SAMP_FREQ),                   \
> > +             .info_mask_shared_by_all_available =                    \
> > +                     BIT(IIO_CHAN_INFO_SAMP_FREQ),                   \
> >               .ext_info = cros_ec_sensors_ext_info,                   \
> >               .scan_type = {                                          \
> >                       .sign = 's',                                    \
> > @@ -191,6 +237,10 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
> >               state->sign[CROS_EC_SENSOR_Z] = -1;
> >       }
> >
> > +     /* Frequency can not be changed on glimmer and is set to 10Hz. */
> > +     state->frequencies[0] = ACCEL_LEGACY_FREQ;
>
> If cannot be changed ...
>
> > +     state->frequencies[1] = 0;
>
> Why there are two values? 10Hz and 0Hz?
I returned a single IIO_VAL_INT_PLUS_MICRO, (10.000), I describe the
frequency with 2 ints.
>
> > +
> >       return devm_iio_device_register(dev, indio_dev);
> >  }
> >
> >
