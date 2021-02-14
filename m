Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC53331B122
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 17:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhBNQIA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 11:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhBNQH6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Feb 2021 11:07:58 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAC9C061574;
        Sun, 14 Feb 2021 08:07:18 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id d20so3565608ilo.4;
        Sun, 14 Feb 2021 08:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j43SN5cTGwbFepjivf2mTzr9OeHytVIZCxVbFj4YgF4=;
        b=EvKocTGw8iZrVs6lBIG8cI94ofaZ3PSlqkAmvqNNZY9uxz44MEhmqsoIkZOhRDZZBl
         M3TuhsewzczthHGdLcCsNVWczoV2MIVtjRlw1ruZ27YbHg+z0GTmhOwkHo4W98qKtZqi
         u0PYa5JwCzv2hjfMCGYFIHEeGpDt5WxP9b647WXMMVzgxSXcaED8Ha3GnyINtO3rBSDG
         gdCvCBFFx/zXaKJF48pWRCdxr3vSmqzjFc7kAHh1WpVjzYojAvcDRcHpJv9ALrjlQc6G
         3H1ruxifURyrBjSjEvUfIUbSG2WQOkTSBYBGtngGi+JyPXY6EzxCYr+oWwJ4MOHgJY66
         lHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j43SN5cTGwbFepjivf2mTzr9OeHytVIZCxVbFj4YgF4=;
        b=T9Ofm5Ynef4o5T2KCBwPZynaqQ8oMoIwU6ePpA+Gh2PxGRT2k/W4iOCFntq8nKhCa/
         37+rkFM5S1t0uC4k3JTt4KhYxOd1Ht96b8usB2yUEIF+dCDLknIIn+8K3USZUYatCwVS
         k6W/odU5bIV1+GqMfqlN9Jkjsu0l43Od/FjBaAu44GJYpALMgyfsmOR7yWN7KKTufjN/
         0ONEglwxnhhVc5i/Fexf78clS47ZcaoOCnsAaR5jWcyDY7bZXBfdinezVRK4ZxDXW6XE
         6K6PqVce85GK1K11fCtpsnd5321zoOmJpZN0fRfPN0yRFUUstL7dfCM8SNy/EhI33YHG
         oYuw==
X-Gm-Message-State: AOAM531W5odE5H2rRs8WqOaHWWfdLm9IVYSVaFqBm8u2ZjJSov2uyc3x
        XUqUY+0E+NYYLco1sc99ebeIEEkz6Ngn01WZ9tY=
X-Google-Smtp-Source: ABdhPJzXvMRYDgXcy4aBJ71sb0VyX4MsIx6GlmucJLqgO9CzsU0SgPNZy7RQlEjohm+FbZ0zK0mvipsM1u5ue2r+4I8=
X-Received: by 2002:a92:ab10:: with SMTP id v16mr9964048ilh.100.1613318837938;
 Sun, 14 Feb 2021 08:07:17 -0800 (PST)
MIME-Version: 1.0
References: <20210214143313.67202-1-alexandru.ardelean@analog.com> <20210214150516.785503e9@archlinux>
In-Reply-To: <20210214150516.785503e9@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sun, 14 Feb 2021 18:07:06 +0200
Message-ID: <CA+U=Dso4k3ct-DvbKQRA9LnQ1yZ6C7OccO+m+mJaoLW4jX6X=Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] iio: kfifo: define a devm_iio_kfifo_buffer_setup helper
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Feb 14, 2021 at 5:06 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 14 Feb 2021 16:33:08 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > This is a re-spin of an older set [1]:
> >  https://patchwork.kernel.org/project/linux-iio/patch/20200401125936.6398-1-alexandru.ardelean@analog.com/
> >
> > Patch 'iio: adc: ti_am335x_adc: remove omitted iio_kfifo_free()' is
> > already be present in a fixes-togreg path. It did not make it yet
> > downstream in the iio-togreg path.
> >
> > Following [1], where there was a suggestion to name this
> > 'devm_iio_device_attach_new_kfifo_buffer()', I took another look and
> > devm_iio_kfifo_buffer_setup() made more sense, since there is already a
> > '{devm_}iio_triggered_buffer_setup()' helper.
> >
> > This reduces the usage of the iio_device_attach_buffer() helper to a
> > more manage-able state.
> > This is related to comment:
> >   https://lore.kernel.org/linux-iio/CA+U=Dsp5hxd9=rNbigUMFALBpPVBqDZDRq_Pe69ggKak7p46=w@mail.gmail.com/T/#u
> This definitely reduces where we need to handle errors from iio_device_attach_buffer() which
> is good.  I guess we need a rebase of one or the other series though to make
> this all fit together.
>
> >
> > This should have gone before the multibuffer patch-set, but I was still
> > waiting on patch 'iio: adc: ti_am335x_adc: remove omitted iio_kfifo_free()'
> > to make it downstream in iio-togreg.
>
> Oops. I've been a touch slow sending things onwards recently.
>
> >
> > Regarding patch 'iio: kfifo: un-export devm_iio_kfifo_allocate() function'
> > I would have also wanted to un-export iio_kfifo_allocate() &
> > iio_kfifo_free(), but that still needs a bit of work to cleanup the IIO
> > dummy buffer.
>
> Yup. The lack of having a parent is a bit of pain.  We just need to fake one
> I guess however silly that seems.

I tried faking it, but it needs a rework of the
drivers/iio/industrialio-sw-device.c logic.
The whole IIO dummy driver is an IIO SW device, so maybe the sanest
thing, is to create platform devices or just parent devices in there,
and pass the parent to the IIO device.
I tried making the IIO dummy a standalone platform driver, but then
you end up having to probe() paths, 1 via platform_driver and one via
iio-sw-device.

>
> Mind you, I'd also like to see this go over to the triggered_buffer stuff
> if possible.
>
>
> > Related to patchset:
> >   https://lore.kernel.org/linux-iio/20201203095005.72252-1-alexandru.ardelean@analog.com/
> >
> > The IIO dummy driver seems to be one of those blockers in cleaning up
> > some IIO API.
> >
>
> Jonathan
>
> > Alexandru Ardelean (5):
> >   iio: adc: ti_am335x_adc: remove omitted iio_kfifo_free()
> >   iio: kfifo: add devm_iio_kfifo_buffer_setup() helper
> >   iio: make use of devm_iio_kfifo_buffer_setup() helper
> >   iio: accel: sca3000: use devm_iio_kfifo_buffer_setup() helper
> >   iio: kfifo: un-export devm_iio_kfifo_allocate() function
> >
> >  .../driver-api/driver-model/devres.rst        |  2 +-
> >  drivers/iio/accel/sca3000.c                   | 19 ++-------
> >  drivers/iio/accel/ssp_accel_sensor.c          | 14 +++----
> >  drivers/iio/adc/ina2xx-adc.c                  | 14 +++----
> >  drivers/iio/adc/ti_am335x_adc.c               | 24 +++--------
> >  drivers/iio/buffer/kfifo_buf.c                | 42 ++++++++++++++++++-
> >  .../cros_ec_sensors/cros_ec_sensors_core.c    | 13 +++---
> >  drivers/iio/gyro/ssp_gyro_sensor.c            | 14 +++----
> >  drivers/iio/health/max30100.c                 | 16 ++++---
> >  drivers/iio/health/max30102.c                 | 16 ++++---
> >  .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 14 +++----
> >  .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 13 +++---
> >  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 15 +++----
> >  drivers/iio/light/acpi-als.c                  | 12 +++---
> >  drivers/iio/light/apds9960.c                  | 16 ++++---
> >  .../staging/iio/impedance-analyzer/ad5933.c   | 23 ++--------
> >  include/linux/iio/kfifo_buf.h                 |  7 +++-
> >  17 files changed, 125 insertions(+), 149 deletions(-)
> >
>
