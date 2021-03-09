Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB758331C01
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 02:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCIBHJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 20:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhCIBGv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2021 20:06:51 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E8BC06174A
        for <linux-iio@vger.kernel.org>; Mon,  8 Mar 2021 17:06:51 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id e7so10650111ile.7
        for <linux-iio@vger.kernel.org>; Mon, 08 Mar 2021 17:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jbhw3QwD1yZZQPwx5zRpZEmhI2VyCCn9TCarXooSYT8=;
        b=UHweiE0rKIoXdxYSmFDBpzWNH7Kh5BuDG0nq6OeXfcPQGvnGjbUxg/KOtCxMZ5vX7K
         yb9YFzqT44O2tLJL410bp5sMOEN/jaR62VUbolR4C4d/3JdAHqy1og8kbQ3vJizdfkBE
         HBy47vXDx61lRiJTd7qfI6+6mvJF6ZIt88WRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jbhw3QwD1yZZQPwx5zRpZEmhI2VyCCn9TCarXooSYT8=;
        b=AwnNz18ZiedkvkaknjGLVpKn7es/ByZvcM3Whou7AHJORhtfFIqiZV0QM83xn1U8jz
         n8s/eemFCaLUg0sZLt2EDsTu9ltzz3ICT4rEcryo79OtnNlU9aM78dXH5Znian5YEqKM
         bfqXZU3pXrzH4FXEVjcKOjiwKgFPgYQAX4QZSx6cr1UbyX6aS5nM3YIxY2SXpZFh8P/W
         yGqbqfZmEmmQ/D9Pwuc5acwkEpgjy5ctObL4+H61DF0ngdC1t4vHCmPDDhJyQCUr8ALn
         umJDEQteL6WqBG1sS3zkwbQH4NUCOPrR865kU1Y/Mq0Ye+bBiE3gz0gCSz7qB/wpXLKM
         kWkA==
X-Gm-Message-State: AOAM5329skZ0XTm1mDu2MTgkAzfSPkxRE/+uUp6cUffTm7itxfXu4drA
        rlPoVMHxGGR0YG99iFaLWJ4RDSeruNBicz79oTRdjQ==
X-Google-Smtp-Source: ABdhPJwua+OlkTK9J66snve+pZYrXXUergouM8Z9TlSHridio8pOSnjEMPvn6xqUuJOfwbf2ryUno6y1HqvJ9DbxoGk=
X-Received: by 2002:a92:c5cf:: with SMTP id s15mr22632090ilt.149.1615252010922;
 Mon, 08 Mar 2021 17:06:50 -0800 (PST)
MIME-Version: 1.0
References: <20201216042009.15233-1-gwendal@chromium.org> <20201229174029.5f59c8a8@archlinux>
In-Reply-To: <20201229174029.5f59c8a8@archlinux>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 8 Mar 2021 17:06:39 -0800
Message-ID: <CAPUE2uuaAUzHy+RP0zAwu9eURFVtSGwESLSFM1x_uRC+=EhruA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] iio: Set default trigger device parent
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I drop the ball on this one. Let me resend a v3 train that applies properly.
Gwendal.

On Tue, Dec 29, 2020 at 9:40 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 15 Dec 2020 20:20:08 -0800
> Gwendal Grignou <gwendal@chromium.org> wrote:
>
> > [Added a new patch to rename iio_trigger_alloc argument from dev to
> > parent for clarity. Other patches remain the same.]
> >
> > Each drivers are setting trig->dev.parent to a common value - usually.
> > Move that in boiler plate code.
> >
> > The first patch set the parent pointer, the next is an automatic change
> > with spatch.
> > The remaining ones are straightforward manual changes.
> I'm not sure if it was deliberate, but I only got the cover letter
> and patch 8.  Given automated tooling (b4) isn't going to cope with that
> I had a go at manually picking the other patches but ran into some issues.
> Please rebase the lot against the testing branch of iio.git
>
> Thanks,
>
> Jonathan
>
> >
> > Few drivers remain:
> > drivers/iio/adc/at91-sama5d2_adc.c
> > drivers/iio/adc/mxs-lradc-adc.c
> > trigger parent set to iio device instead of its parent.
> >
> > drivers/iio/adc/dln2-adc.c
> > trigger parent not set.
> >
> > drivers/iio/gyro/mpu3050-core.c
> > trigger allocated for iio device but parent set to iio device parent.
> >
> > drivers/iio/imu/bmi160/bmi160_core.c
> > drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > trigger allocated for iio device but parent set to mapped register device holder. Looks like iio device parent.
> >
> > drivers/iio/trigger/stm32-lptimer-trigger.c
> > drivers/iio/trigger/stm32-timer-trigger.c
> > trigger allocated for device, but parent set to device parent.
> >
> > Gwendal Grignou (8):
> >   iio: set default trig->dev.parent
> >   iio: fix devm_iio_trigger_alloc with parent.cocci
> >   iio: adis_trigger: Remove code to set trigger parent
> >   iio: gp2ap020a00f: Remove code to set trigger parent
> >   iio: lmp91000: Remove code to set trigger parent
> >   iio: chemical: atlas: Remove code to set trigger parent
> >   iio: as3935: Remove code to set trigger parent
> >   iio: Rename iio_trigger_alloc dev argument to parent
> >
> >  drivers/iio/accel/adxl372.c                   |  2 --
> >  drivers/iio/accel/bma180.c                    |  3 +-
> >  drivers/iio/accel/bmc150-accel-core.c         |  1 -
> >  drivers/iio/accel/kxcjk-1013.c                |  2 --
> >  drivers/iio/accel/mma8452.c                   |  1 -
> >  drivers/iio/accel/mxc4005.c                   |  1 -
> >  drivers/iio/accel/stk8312.c                   |  1 -
> >  drivers/iio/accel/stk8ba50.c                  |  1 -
> >  drivers/iio/adc/ad7606.c                      |  1 -
> >  drivers/iio/adc/ad7766.c                      |  1 -
> >  drivers/iio/adc/ad7768-1.c                    |  1 -
> >  drivers/iio/adc/ad_sigma_delta.c              |  4 +--
> >  drivers/iio/adc/at91_adc.c                    |  3 +-
> >  drivers/iio/adc/max1027.c                     |  1 -
> >  drivers/iio/adc/xilinx-xadc-core.c            |  4 +--
> >  drivers/iio/chemical/atlas-sensor.c           |  1 -
> >  drivers/iio/chemical/ccs811.c                 |  1 -
> >  drivers/iio/chemical/scd30_core.c             |  1 -
> >  .../common/hid-sensors/hid-sensor-trigger.c   |  4 +--
> >  .../common/st_sensors/st_sensors_trigger.c    |  4 +--
> >  drivers/iio/gyro/adxrs290.c                   |  1 -
> >  drivers/iio/gyro/bmg160_core.c                |  2 --
> >  drivers/iio/gyro/fxas21002c_core.c            |  1 -
> >  drivers/iio/gyro/itg3200_buffer.c             |  3 +-
> >  drivers/iio/health/afe4403.c                  |  1 -
> >  drivers/iio/health/afe4404.c                  |  1 -
> >  drivers/iio/humidity/hts221_buffer.c          |  1 -
> >  drivers/iio/imu/adis_trigger.c                | 10 ++----
> >  drivers/iio/imu/kmx61.c                       |  1 -
> >  drivers/iio/industrialio-trigger.c            | 33 +++++++++++--------
> >  drivers/iio/light/gp2ap020a00f.c              |  1 -
> >  drivers/iio/light/rpr0521.c                   |  1 -
> >  drivers/iio/light/si1145.c                    |  1 -
> >  drivers/iio/light/st_uvis25_core.c            |  1 -
> >  drivers/iio/light/vcnl4000.c                  |  1 -
> >  drivers/iio/light/vcnl4035.c                  |  1 -
> >  drivers/iio/magnetometer/bmc150_magn.c        |  1 -
> >  drivers/iio/magnetometer/rm3100-core.c        |  1 -
> >  drivers/iio/potentiostat/lmp91000.c           |  3 +-
> >  drivers/iio/pressure/zpa2326.c                |  1 -
> >  drivers/iio/proximity/as3935.c                |  1 -
> >  drivers/iio/proximity/sx9310.c                |  1 -
> >  drivers/iio/proximity/sx932x.c                |  1 -
> >  drivers/iio/proximity/sx9500.c                |  1 -
> >  drivers/iio/trigger/iio-trig-hrtimer.c        |  2 +-
> >  drivers/iio/trigger/iio-trig-interrupt.c      |  2 +-
> >  drivers/iio/trigger/iio-trig-loop.c           |  2 +-
> >  drivers/iio/trigger/iio-trig-sysfs.c          |  3 +-
> >  include/linux/iio/iio.h                       |  2 +-
> >  include/linux/iio/trigger.h                   |  3 +-
> >  50 files changed, 41 insertions(+), 81 deletions(-)
> >
>
