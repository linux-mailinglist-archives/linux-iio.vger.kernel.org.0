Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBF831B59A
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 08:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhBOH0c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 02:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhBOH0b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 02:26:31 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48257C061574;
        Sun, 14 Feb 2021 23:25:51 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id q5so4705763ilc.10;
        Sun, 14 Feb 2021 23:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AswwStmpaZFQMZVx6ZYCP7SN1B7C0Tm6foV+C+F5+ws=;
        b=iorWVZOnylPHfAiL/3VyFtapyNq+0pMZzSYj1PNb3ZI+Mmg1rGsMk0prStb5HWz29M
         W37ooWimMDhiiYosm2WhGM50xppf15xM97JcZMK2hDEliA9yZYkETK2XZVd4FGCl+MY/
         xCxufyyclktHAElkuBAUxQYbPRPw767noZD/mcaTy1oY77t/LRDikpOfi9yWxzpUG6vs
         LxkLvM6FXjOQj9lQOa1FdmN1RT4m5kCdnHMysmmVI7puz3wvy4Ao/xCCNmYpm64SgTa7
         qa0f61s359xrFh8cCYM1IeFJ1qrroN0Lp0+1SwUwI52ZThRCkalASIBEeHRBx5bMWQA8
         emXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AswwStmpaZFQMZVx6ZYCP7SN1B7C0Tm6foV+C+F5+ws=;
        b=hEFe3QjdYrL9qI9GnYuYArDaGU9BW84ga78oJANYO3yHH4UqquahgosJpFXYONU7nl
         2zKNLv0+ONI9Nzl0ZZ8CTeNZzkuxZQYEzz3s0FcxXJdqjna97BG2XoYot/EDibbJKjSX
         35Ti2eEHaBGi5xxbTECBEG2NWp8keQ9wAXrZ0JqauwVWyEkN7SAubTlMJC1Q9W6PO9IQ
         WJfa8yO7jrEXJJGM2ompkqaVCDQzmCz5lfid0GLiTSe3MN7yjoj93ypLSAq/N7enmP7L
         GKF1bpddQWYaCLpNBqf9KRrmrN+utsDse/m3TxqJF8TGcMdYnNSqAIYeMRjF/HqfYthH
         X4tw==
X-Gm-Message-State: AOAM5334AJSAaeOtsmbAOuropMfJHg5CEs4dh4RbmsnpiRYtyzljip5b
        eZxtK4DcxqQwmn3k2GdOeUez3G8oFm4Iq1NALaCG+uy+5+M=
X-Google-Smtp-Source: ABdhPJxr/OZs+hRAbjgP1qOsNi4x2pSIaVzr+jlqkS2Z7RhXT939JB3ZT32UhWomc+Sa48ompI0aj+Mlp8hKYh0A5vI=
X-Received: by 2002:a05:6e02:1c8e:: with SMTP id w14mr11619651ill.303.1613373950651;
 Sun, 14 Feb 2021 23:25:50 -0800 (PST)
MIME-Version: 1.0
References: <20210214143313.67202-1-alexandru.ardelean@analog.com> <20210214150516.785503e9@archlinux>
In-Reply-To: <20210214150516.785503e9@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 15 Feb 2021 09:25:39 +0200
Message-ID: <CA+U=Dsr2C2EOu+gnzeWJFShbh3N9iQ_YKW5Xbr68wDg-apU=gA@mail.gmail.com>
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
>
> Mind you, I'd also like to see this go over to the triggered_buffer stuff
> if possible.

Not sure what should go over the triggered_buffer stuff.
I would have happily done more cleanup there as well, but I'm trying
to defer some things to a later point.
Mostly to avoid blocking myself with too many overlapping patch-sets.

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
