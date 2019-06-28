Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7AA45A49C
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2019 20:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfF1S4J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Jun 2019 14:56:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39217 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfF1S4J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Jun 2019 14:56:09 -0400
Received: by mail-io1-f67.google.com with SMTP id r185so14685300iod.6
        for <linux-iio@vger.kernel.org>; Fri, 28 Jun 2019 11:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k/HiXefy4UCK+iIL42XxVKE60Fm+qy4QgSjL2gOdSRI=;
        b=KXpn15c1iVMT+RJj3i5mj2KjjhuX7v7ZTGHZHmCy1Bo7+Xe70q31uHoGRO1T8TDU79
         O682eWWlZVZgP3oTUbD1GGBx9fTTCDqmpdYTccsIa8xrTYIkXJDxEn31VZch9g91Pxd7
         4D11zUYpQwEXj2qFX+1obgUDYC2QmP8MC2Ewc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/HiXefy4UCK+iIL42XxVKE60Fm+qy4QgSjL2gOdSRI=;
        b=lz6VOv5W8dIAqWqfQGz2iHSDjkKZwF+ayZhsGJn+dJvCLPNzmkKCvu049OFlV7ro0p
         9167Qo1ZBFlCYV0Hx2Y/wVoMb5jcD1+1A6c4XK9vBGRzs/b3HfFGJG0q2tK3BookX0lJ
         7fX0QsWnLia8Ii9z9NjjDUnepW/L9unoMQ/Oj6ybo9LYxKC/1G+uavSOaMWy2W2OEoMs
         SFdwowuc76OtzUpe+m73SlLrX3Aos5pCUESM+V1oSLLxDr85A6eRL6ItfmvvgAoXQHlb
         sMRGuNhlFIk3E0v9Wc+oszs347cR5/rpESHFZeOLhoxdiRRwrSHK63azI+jLAGkfftE1
         eJAg==
X-Gm-Message-State: APjAAAWGSVMoyH9q6wN6LdMwpmgmbbn1gyYcved7vOGLvjOO5Vvi90AA
        zeIotQU/MCKtO59socIYFg40f3HvFxHUS4v6aLEzZg==
X-Google-Smtp-Source: APXvYqx4NSClEBnWejaWWQQTLSf2lvG1qwp/CnDKFJN38iAIvwKQpaS96n/OVahHXdpx3LwAiYy2SUFD5TrtwTqbrvQ=
X-Received: by 2002:a02:9f84:: with SMTP id a4mr7542700jam.20.1561748168912;
 Fri, 28 Jun 2019 11:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190621024106.158589-1-gwendal@chromium.org> <20190621024106.158589-3-gwendal@chromium.org>
 <20190622100308.7d29c324@archlinux>
In-Reply-To: <20190622100308.7d29c324@archlinux>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 28 Jun 2019 11:55:57 -0700
Message-ID: <CAPUE2us4t3_mzbkLUGd+_pz0u1ZGrXmagxVL-MkT4vVZDWV-Nw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: cros_ec : Extend legacy support to ARM device
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jun 22, 2019 at 2:03 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 20 Jun 2019 19:41:06 -0700
> Gwendal Grignou <gwendal@chromium.org> wrote:
>
> > Add support to ARM based devices, that lack LPC access code.
> > Allow cros-ec-accel-legacy to use cros-ec-sensors-core, add specific
> > command to capture sensor data.
> >
> > On veyron minnie, check chrome detect tablet mode and rotate
> > screen in tablet mode.
> > Check only a subset of the attributes are presented.
>
> Superficially this looks like 2 changes to me.  One moves
> over to using the shared code. The other sounds like it's introducing
> the new device support?
That's correct.
> 2 patches perhaps?
Will do.
>
> However, looking at the code, am I interpreting the description
> correctly?  Looks to me like we are really just reducing duplicated
> code by using the cros_ec_sensors_core code to replace
> existing code in the cros-ec-accel-legacy driver?  If that's
> the main focus, then make that clear in the patch title.
The second part introduce a command to retrieve sensor data that is
applicable for veyron-minnie only, cros_ec_accel_legacy_read_cmd.
>
> One passing comment inline.
>
> Thanks,
>
> Jonathan
>
>
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> >  drivers/iio/accel/Kconfig                |   4 +-
> >  drivers/iio/accel/cros_ec_accel_legacy.c | 350 +++++------------------
> >  2 files changed, 79 insertions(+), 275 deletions(-)
> >
> > diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> > index 62a970a20219..7d0848f9ea45 100644
> > --- a/drivers/iio/accel/Kconfig
> > +++ b/drivers/iio/accel/Kconfig
> > @@ -201,9 +201,7 @@ config HID_SENSOR_ACCEL_3D
> >
> >  config IIO_CROS_EC_ACCEL_LEGACY
> >       tristate "ChromeOS EC Legacy Accelerometer Sensor"
> > -     select IIO_BUFFER
> > -     select IIO_TRIGGERED_BUFFER
> > -     select CROS_EC_LPC_REGISTER_DEVICE
> > +     depends on IIO_CROS_EC_SENSORS_CORE
> >       help
> >         Say yes here to get support for accelerometers on Chromebook using
> >         legacy EC firmware.
> > diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> > index 46bb2e421bb9..575d7e4c685c 100644
> > --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> > +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> > @@ -5,13 +5,14 @@
> >   * Copyright 2017 Google, Inc
> >   *
> >   * This driver uses the memory mapper cros-ec interface to communicate
> > - * with the Chrome OS EC about accelerometer data.
> > + * with the Chrome OS EC about accelerometer data or older commands.
...
> >  #define CROS_EC_ACCEL_LEGACY_CHAN(_axis)                             \
> >       {                                                               \
> > @@ -319,31 +140,30 @@ static const struct iio_chan_spec_ext_info cros_ec_accel_legacy_ext_info[] = {
> >               .modified = 1,                                          \
> >               .info_mask_separate =                                   \
> >                       BIT(IIO_CHAN_INFO_RAW) |                        \
> > -                     BIT(IIO_CHAN_INFO_SCALE) |                      \
>
> My first thought was you were changing the ABI, but looking closer this
> was broken anyway as we shouldn't have had both separate and shared by all
> for the same thing on the same channel.  Still presumably an ABI change
> but one fixing a broken interface so fingers crossed no one notices.
Yes, it was an error that was not documented in the ABI. I will fix
that separately.
>
> >                       BIT(IIO_CHAN_INFO_CALIBBIAS),                   \
> >               .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),    \
> > -             .ext_info = cros_ec_accel_legacy_ext_info,              \
> > +             .ext_info = cros_ec_sensors_ext_info,                   \
> >               .scan_type = {                                          \
