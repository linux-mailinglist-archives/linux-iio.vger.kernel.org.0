Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8D2251E82
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2019 00:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfFXWo7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jun 2019 18:44:59 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37143 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfFXWo7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jun 2019 18:44:59 -0400
Received: by mail-io1-f67.google.com with SMTP id e5so717684iok.4
        for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2019 15:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=97B3X8jltSqwNDoh54dVH0F5cNhGXFSkhgdSqSMfsf4=;
        b=E28+EDWueoeICN1UA5MmtG5LL/964ewgss0FKWhsgVLx+moO21fnyp/yxrO7q63RoY
         5EmIi14ZxPGl2xUvrR0t9pYPh26OZeQJyeBKGcbo7Wk55wcO400znsMRL4O2VKzjdUtB
         jQj7AvzoUkkDlX9EFs0bEkaez2py5F94RpyQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=97B3X8jltSqwNDoh54dVH0F5cNhGXFSkhgdSqSMfsf4=;
        b=pbs9VEBTndEBaMIWTcA4w1QjpmOdyPlnen4737dhVNFQAAK/W9OSy8cQmR8PVKpkxF
         HYtQRMseXy+CU7+6cdFXOD7gTkbtfHeR+OWc0IxuwZFZuyTitKSp5itaP+JfHcOigb4L
         YOL9bMuQuD/vqf3jlhpCJias/A/OUwFTn/pkdiF5h2ct4UALDP6wPB7tIq9NCP2X8oUw
         OC4/ZswYl/UmYM3i0IZf+m25LEYqKHjLnjrxWP5sBxw9AGBo02BjJHZcZYPaQ/Jm2Tmu
         lOY07TnLwGxl7DRpgFGtAMeki0FLivVbxP17Nyc8iw5vci7pyBY9tdUS05xrzdgL292W
         uCAQ==
X-Gm-Message-State: APjAAAV2gPlDkiiDsxppip0MbbBuFTc3j7duy67AnvgBFyfEyJ4zIcqx
        nKcLJ2G3LmIseq6B5RF1V3rBoP2J2Mz9k/uaB/djlg==
X-Google-Smtp-Source: APXvYqxkcmbA/LmfmNbzl/JHx4GewVNTKeNYVlDKKsBAgc+BVZBVDDr4s6JS9wgDpy1U+59v+gZ4OLy7x0gRBCIwPZU=
X-Received: by 2002:a5e:8518:: with SMTP id i24mr19465044ioj.149.1561416298592;
 Mon, 24 Jun 2019 15:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190621024106.158589-1-gwendal@chromium.org> <20190621024106.158589-2-gwendal@chromium.org>
 <20190622095421.6b4e38e9@archlinux>
In-Reply-To: <20190622095421.6b4e38e9@archlinux>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 24 Jun 2019 15:44:47 -0700
Message-ID: <CAPUE2ut76ZoQaCA0n7=qBNh=xTuGOk4aTJ61mj2chNZHt3eQdQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: cros_ec: Add sign vector in core for backward compatibility
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jun 22, 2019 at 1:54 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 20 Jun 2019 19:41:05 -0700
> Gwendal Grignou <gwendal@chromium.org> wrote:
>
> > To allow cros_ec iio core library to be used with legacy device, add a
> > vector to rotate sensor data if necessary: legacy devices are not
> > reporting data in HTML5/Android sensor referential.
> >
> > On veyron minnie, check chrome detect tablet mode and rotate
> > screen in tablet mode.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> I'm guessing that you have a whole pile of code that isn't using
> the mounting_matrix ABI and hence need the 'fixup' in kernel?
That's correct: cros EC normally presents sensors information in the
proper HTML5 matrix so it does not need to export "mount_matrix"
attribute.
Except for legacy sensors where the EC firmware used a different
matrix, Given we don't want to release a new firmware for these
machines, I indeed fix it up in the kernel.
>
> Otherwise this is fine, but I'd like to wait for Doug to have another
> look if he wants to (and ideally give a reviewed-by)
>
> Anyone else's input also welcome of course.
>
> Jonathan
>
> > ---
> >  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 4 ++++
> >  include/linux/iio/common/cros_ec_sensors_core.h           | 1 +
> >  2 files changed, 5 insertions(+)
> >
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index 719a0df5aeeb..e8a4d78659c8 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -66,6 +66,9 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> >               }
> >               state->type = state->resp->info.type;
> >               state->loc = state->resp->info.location;
> > +
> > +             /* Set sign vector, only used for backward compatibility. */
> > +             memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
> >       }
> >
> >       return 0;
> > @@ -254,6 +257,7 @@ static int cros_ec_sensors_read_data_unsafe(struct iio_dev *indio_dev,
> >               if (ret < 0)
> >                       return ret;
> >
> > +             *data *= st->sign[i];
> >               data++;
> >       }
> >
> > diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> > index ce16445411ac..a1c85ad4df91 100644
> > --- a/include/linux/iio/common/cros_ec_sensors_core.h
> > +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> > @@ -71,6 +71,7 @@ struct cros_ec_sensors_core_state {
> >       enum motionsensor_location loc;
> >
> >       s16 calib[CROS_EC_SENSOR_MAX_AXIS];
> > +     s8 sign[CROS_EC_SENSOR_MAX_AXIS];
> >
> >       u8 samples[CROS_EC_SAMPLE_SIZE];
> >
>
